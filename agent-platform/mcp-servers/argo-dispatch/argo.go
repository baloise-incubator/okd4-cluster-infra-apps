package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"net/http"
	"os"
	"strings"
	"time"
)

type argoClient struct {
	serverURL  string
	namespace  string
	httpClient *http.Client
}

func newArgoClient(serverURL, namespace string) *argoClient {
	return &argoClient{
		serverURL: strings.TrimRight(serverURL, "/"),
		namespace: namespace,
		httpClient: &http.Client{Timeout: 30 * time.Second},
	}
}

func (c *argoClient) bearerToken() string {
	b, _ := os.ReadFile("/var/run/secrets/kubernetes.io/serviceaccount/token")
	return strings.TrimSpace(string(b))
}

func (c *argoClient) do(method, path string, body any) ([]byte, error) {
	var r io.Reader
	if body != nil {
		b, err := json.Marshal(body)
		if err != nil {
			return nil, err
		}
		r = bytes.NewReader(b)
	}
	req, err := http.NewRequest(method, c.serverURL+path, r)
	if err != nil {
		return nil, err
	}
	req.Header.Set("Authorization", "Bearer "+c.bearerToken())
	if body != nil {
		req.Header.Set("Content-Type", "application/json")
	}
	resp, err := c.httpClient.Do(req)
	if err != nil {
		return nil, fmt.Errorf("argo server unreachable: %w", err)
	}
	defer resp.Body.Close()
	data, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	if resp.StatusCode >= 400 {
		return nil, fmt.Errorf("argo API %d: %s", resp.StatusCode, string(data))
	}
	return data, nil
}

// submitWorkflow submits a WorkflowTemplate by name with the given recipe and JSON parameters.
func (c *argoClient) submitWorkflow(recipe, parametersJSON string) (string, error) {
	payload := map[string]any{
		"resourceKind": "WorkflowTemplate",
		"resourceName": "agent-workflow",
		"namespace":    c.namespace,
		"submitOptions": map[string]any{
			"parameters": []string{
				"recipe=" + recipe,
				"parameters=" + parametersJSON,
			},
		},
	}
	data, err := c.do("POST", fmt.Sprintf("/api/v1/workflows/%s/submit", c.namespace), payload)
	if err != nil {
		return "", err
	}
	var resp struct {
		Metadata struct {
			Name string `json:"name"`
		} `json:"metadata"`
	}
	if err := json.Unmarshal(data, &resp); err != nil {
		return "", fmt.Errorf("unexpected argo response: %w", err)
	}
	return resp.Metadata.Name, nil
}

// getWorkflowStatus returns a human-readable status summary for the named workflow.
func (c *argoClient) getWorkflowStatus(name string) (string, error) {
	data, err := c.do("GET", fmt.Sprintf("/api/v1/workflows/%s/%s", c.namespace, name), nil)
	if err != nil {
		return "", err
	}
	var resp struct {
		Status struct {
			Phase      string `json:"phase"`
			Message    string `json:"message"`
			StartedAt  string `json:"startedAt"`
			FinishedAt string `json:"finishedAt"`
			Nodes      map[string]struct {
				DisplayName string `json:"displayName"`
				Phase       string `json:"phase"`
				Message     string `json:"message"`
				Type        string `json:"type"`
			} `json:"nodes"`
		} `json:"status"`
	}
	if err := json.Unmarshal(data, &resp); err != nil {
		return "", fmt.Errorf("unexpected argo response: %w", err)
	}
	s := resp.Status
	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("Workflow: %s\nPhase: %s\n", name, s.Phase))
	if s.StartedAt != "" {
		sb.WriteString(fmt.Sprintf("Started: %s\n", s.StartedAt))
	}
	if s.FinishedAt != "" {
		sb.WriteString(fmt.Sprintf("Finished: %s\n", s.FinishedAt))
	}
	if s.Message != "" {
		sb.WriteString(fmt.Sprintf("Message: %s\n", s.Message))
	}
	for _, node := range s.Nodes {
		if node.Type != "Pod" {
			continue
		}
		if node.Phase == "Running" || node.Phase == "Failed" || node.Phase == "Error" {
			sb.WriteString(fmt.Sprintf("Step %q: %s\n", node.DisplayName, node.Phase))
			if node.Message != "" {
				sb.WriteString(fmt.Sprintf("  %s\n", node.Message))
			}
		}
	}
	return sb.String(), nil
}

package main

import (
	"context"
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"github.com/modelcontextprotocol/go-sdk/mcp"
	"gopkg.in/yaml.v3"
)

type recipeParam struct {
	Key         string `yaml:"key"`
	Requirement string `yaml:"requirement"`
	Description string `yaml:"description"`
}

type recipeMeta struct {
	Title       string        `yaml:"title"`
	Description string        `yaml:"description"`
	Parameters  []recipeParam `yaml:"parameters"`
}

func textResult(text string) *mcp.CallToolResultFor[any] {
	return &mcp.CallToolResultFor[any]{
		Content: []mcp.Content{&mcp.TextContent{Text: text}},
	}
}

func errResult(text string) *mcp.CallToolResultFor[any] {
	return &mcp.CallToolResultFor[any]{
		IsError: true,
		Content: []mcp.Content{&mcp.TextContent{Text: text}},
	}
}

func registerTools(srv *mcp.Server, client *argoClient, recipesDir, argoExternalURL, argoNS string) {
	mcp.AddTool(srv, &mcp.Tool{
		Name:        "list_recipes",
		Description: "List all available agent recipes with names, descriptions, and required parameters.",
	}, func(_ context.Context, _ *mcp.ServerSession, _ *mcp.CallToolParamsFor[struct{}]) (*mcp.CallToolResultFor[any], error) {
		return listRecipes(recipesDir)
	})

	type dispatchArgs struct {
		Recipe     string         `json:"recipe" description:"Recipe name without .yaml extension, e.g. update-and-pr"`
		Parameters map[string]any `json:"parameters" description:"Key/value parameter map matching the recipe's parameter definitions"`
	}
	mcp.AddTool(srv, &mcp.Tool{
		Name:        "dispatch_recipe",
		Description: "Dispatch a named recipe as an Argo Workflow. Returns the workflow name for status tracking.",
	}, func(_ context.Context, _ *mcp.ServerSession, p *mcp.CallToolParamsFor[dispatchArgs]) (*mcp.CallToolResultFor[any], error) {
		paramsJSON, err := json.Marshal(p.Arguments.Parameters)
		if err != nil {
			return errResult(fmt.Sprintf("invalid parameters: %v", err)), nil
		}
		return dispatchRecipe(client, recipesDir, p.Arguments.Recipe, string(paramsJSON), argoExternalURL, argoNS)
	})

	type statusArgs struct {
		WorkflowName string `json:"workflow_name" description:"Workflow name returned by dispatch_recipe"`
	}
	mcp.AddTool(srv, &mcp.Tool{
		Name:        "get_task_status",
		Description: "Get the current status of a dispatched Argo Workflow.",
	}, func(_ context.Context, _ *mcp.ServerSession, p *mcp.CallToolParamsFor[statusArgs]) (*mcp.CallToolResultFor[any], error) {
		return getTaskStatus(client, p.Arguments.WorkflowName)
	})
}

func listRecipes(dir string) (*mcp.CallToolResultFor[any], error) {
	entries, err := os.ReadDir(dir)
	if err != nil {
		return errResult(fmt.Sprintf("cannot read recipes directory: %v", err)), nil
	}
	var sb strings.Builder
	sb.WriteString("Available recipes:\n\n")
	found := false
	for _, e := range entries {
		if e.IsDir() || !strings.HasSuffix(e.Name(), ".yaml") {
			continue
		}
		found = true
		name := strings.TrimSuffix(e.Name(), ".yaml")
		data, _ := os.ReadFile(filepath.Join(dir, e.Name()))
		var meta recipeMeta
		_ = yaml.Unmarshal(data, &meta)
		sb.WriteString(fmt.Sprintf("**%s** — %s\n", name, meta.Description))
		for _, p := range meta.Parameters {
			sb.WriteString(fmt.Sprintf("  - %s (%s): %s\n", p.Key, p.Requirement, p.Description))
		}
		sb.WriteString("\n")
	}
	if !found {
		sb.WriteString("(no recipes found)\n")
	}
	return textResult(sb.String()), nil
}

func dispatchRecipe(client *argoClient, recipesDir, recipe, paramsJSON, argoExternalURL, argoNS string) (*mcp.CallToolResultFor[any], error) {
	if _, err := os.Stat(filepath.Join(recipesDir, recipe+".yaml")); os.IsNotExist(err) {
		return errResult(fmt.Sprintf("unknown recipe %q — call list_recipes to see available options", recipe)), nil
	}
	wfName, err := client.submitWorkflow(recipe, paramsJSON)
	if err != nil {
		return errResult(fmt.Sprintf("workflow submission failed: %v", err)), nil
	}
	var sb strings.Builder
	sb.WriteString(fmt.Sprintf("Workflow dispatched: %s\n", wfName))
	if argoExternalURL != "" {
		sb.WriteString(fmt.Sprintf("View: %s/workflows/%s/%s\n", argoExternalURL, argoNS, wfName))
	}
	sb.WriteString(fmt.Sprintf("\nThe workflow is running in the background. Use get_task_status with workflow_name=%q to check progress.", wfName))
	return textResult(sb.String()), nil
}

func getTaskStatus(client *argoClient, workflowName string) (*mcp.CallToolResultFor[any], error) {
	status, err := client.getWorkflowStatus(workflowName)
	if err != nil {
		return errResult(fmt.Sprintf("failed to get status for %q: %v", workflowName, err)), nil
	}
	return textResult(status), nil
}

package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/modelcontextprotocol/go-sdk/mcp"
)

func main() {
	port := getEnv("PORT", "8080")
	argoURL := getEnv("ARGO_SERVER_URL", "http://argo-server.argo-workflows.svc.cluster.local:2746")
	argoNS := getEnv("ARGO_NAMESPACE", "agent-platform")
	recipesDir := getEnv("RECIPES_DIR", "/recipes")

	client := newArgoClient(argoURL, argoNS)

	srv := mcp.NewServer(&mcp.Implementation{Name: "argo-dispatch", Version: "1.0.0"}, nil)
	registerTools(srv, client, recipesDir)

	http.Handle("/mcp", mcp.NewStreamableHTTPHandler(func(_ *http.Request) *mcp.Server {
		return srv
	}, nil))
	http.HandleFunc("/healthz", func(w http.ResponseWriter, _ *http.Request) {
		w.WriteHeader(http.StatusOK)
	})

	log.Printf("argo-dispatch listening on :%s (recipes: %s, argo: %s/%s)",
		port, recipesDir, argoURL, argoNS)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}

func getEnv(key, fallback string) string {
	if v, ok := os.LookupEnv(key); ok && v != "" {
		return v
	}
	return fallback
}

# tekton-chatopshandler

In order for the chatops handler to work, you need to create a secret in the same namespace as your pipeline is running with a GitHub API token.

`kubectl create secret generic github --from-literal token=<MY_GITHUB_API_TOKEN>`

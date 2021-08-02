@Library('jenkins-library@master') _

parsedWebhookPayload = ''

pipeline {
    agent {
        label 'gitopscli'
    }

    triggers {
        GenericTrigger(
                causeString: 'Generic Cause',
                genericVariables: [[defaultValue: '', key: 'webhookPayload', regexpFilter: '', value: '$']],
                genericHeaderVariables: [[key: 'X-GitHub-Event', regexpFilter: '']],
                regexpFilterExpression: '',
                regexpFilterText: '',
                token: 'chatops-event-handler'
        )
    }

    stages {
        stage('Perform ChatOps') {
            steps {
                script {
                    parsedWebhookPayload = readJSON text: "${webhookPayload}"
                    def eventType = "$X_GitHub_Event"
                    def isCommentEvent = "issue_comment" == eventType
                    def isPrEvent = "pull_request" == eventType
                    if(isPrEvent) {
                        def prEventType = parsedWebhookPayload["action"]
                        def prOpened = "opened" == prEventType
                        if (prOpened) {
                            createPrComment payload: parsedWebhookPayload, comment: """:rocket: Welcome to Baloise ChatOps based GitOps Bot :tada:
                                
    - If you want to enable preview environments for this PullRequest, comment with \\`/preview\\`. 
    - If you want to disable the preview environment for this PR, comment with \\`/undeploy\\`. 
    - If you need help or want to see the docs, comment with \\`/help\\`. 
                                
    Make sure to refresh this page after submitting a command.
    Preview environments can be redeployed automatically if you enable the webhook for updates to the source branch. :new:
    
    Have fun building awesome apps! :hammer:  :whale2:  :truck:  :ship:
                                """
                        }
                    }
                    if (isCommentEvent) {
                        def commentText = parsedWebhookPayload["comment"]["body"]
                        if (commentText.startsWith("/help")) {
                            createPrComment payload: parsedWebhookPayload, comment: "Need help? Find the docs, examples and a F.A.Q.: [Baloise Incubator: GitOps Cli](https://baloise-incubator.github.io/gitopscli/)"
                        } else if (commentText.startsWith("/preview")) {
                            createPrPreview payload: parsedWebhookPayload
                        } else if (commentText.startsWith("/undeploy")) {
                            //if (hasPreview(parsedWebhookPayload)) {
                                deletePrPreview payload: parsedWebhookPayload
                            /*} else {
                                createPrComment payload: parsedWebhookPayload, comment: "Nothing to undeploy. Please create a peview environment with \\`/preview\\` first."
                            }*/
                        }
                    }
                }
            }
        }
    }

}


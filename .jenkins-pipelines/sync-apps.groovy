@Library('jenkins-library@master') _

pipeline {
    agent {
        label 'bdop-cli'
    }

    triggers {
        GenericTrigger(
                causeString: 'Generic Cause',
                genericVariables: [[defaultValue: '', key: 'webhookPayload', regexpFilter: '', value: '$']],
                regexpFilterExpression: '',
                regexpFilterText: '',
                token: 'sync-apps'
        )
    }

    stages {
        stage('Sync apps') {
            steps {
                script {
                    def parsedWebhookPayload = readJSON text: "${webhookPayload}"
                    currentBuild.description = parsedWebhookPayload["repository"]["full_name"]
                    syncApps payload: parsedWebhookPayload, rootOrg: "baloise-incubator", rootRepo: "okd4-apps-root-config"
                }

            }
        }
    }
}

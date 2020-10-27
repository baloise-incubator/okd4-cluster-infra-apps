### Installing the Elasticsearch Operator

If available, the Elasticsearch operator (version 4.1) should be installed from the OperatorHub.

Alternatively, to install the Elasticsearch operator manually, execute the following commands:

```
# See note below for explanation of why kubectl is used instead of oc
kubectl create ns openshift-logging # create the project for the elasticsearch operator
oc create -f https://raw.githubusercontent.com/openshift/elasticsearch-operator/release-4.1/manifests/01-service-account.yaml -n openshift-logging
oc create -f https://raw.githubusercontent.com/openshift/elasticsearch-operator/release-4.1/manifests/02-role.yaml
oc create -f https://raw.githubusercontent.com/openshift/elasticsearch-operator/release-4.1/manifests/03-role-bindings.yaml
oc create -f https://raw.githubusercontent.com/openshift/elasticsearch-operator/release-4.1/manifests/04-crd.yaml -n openshift-logging
curl https://raw.githubusercontent.com/openshift/elasticsearch-operator/release-4.1/manifests/05-deployment.yaml | sed 's/latest/4.1/g' | oc create -n openshift-logging -f -
```

NOTE: It is necessary to use `kubectl` for the creation of the openshift-logging namespace, as the `oc` command will return the following error:
```
Error from server (Forbidden): project.project.openshift.io "openshift-logging" is forbidden: cannot request a project starting with "openshift-"
```


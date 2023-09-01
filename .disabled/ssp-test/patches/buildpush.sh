#!/bin/bash
docker build . -f Dockerfile.admin-ui -t artifactory-jcr.baloise.dev/usu/admin-ui:3.0.0
docker push artifactory-jcr.baloise.dev/usu/admin-ui:3.0.0
docker build . -f Dockerfile.client -t artifactory-jcr.baloise.dev/usu/client:2-4-1
docker push artifactory-jcr.baloise.dev/usu/client:2-4-1
docker build . -f Dockerfile.profile-ui -t artifactory-jcr.baloise.dev/usu/profile-ui:3.0.0
docker push artifactory-jcr.baloise.dev/usu/profile-ui:3.0.0

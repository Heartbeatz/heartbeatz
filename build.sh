#!/bin/bash +x
echo "GIT_COMMIT: $GIT_COMMIT"
echo "GIT_USERNAME $GIT_USERNAME"
echo "BRANCH: $BRANCH"
echo "KUBE_CONTEXT: $KUBE_CONTEXT"
echo "DB_SCALE: $DB_SCALE"
echo "PROJECT_ID: $PROJECT_ID"
echo "DOCKER_REGISTRY_PATH: $DOCKER_REGISTRY_PATH"

if [[ -z $GIT_COMMIT ]] || [[ -z $GIT_USERNAME ]] || [[ -z $BRANCH ]] || [[ -z $KUBE_CONTEXT ]] || [[ -z $DB_SCALE ]] || [[ -z $PROJECT_ID ]] || [[ -z $DOCKER_REGISTRY_PATH ]]
then
  echo "Missing environment variables"
  exit 1
fi
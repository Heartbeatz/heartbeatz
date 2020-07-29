#!/bin/bash +x
echo "GIT_COMMIT: $GIT_COMMIT"
echo "GIT_USERNAME $GIT_USERNAME"
echo "GIT_BRANCH: $GIT_BRANCH"
echo "KUBE_CONTEXT: $KUBE_CONTEXT"
echo "DB_SCALE: $DB_SCALE"
echo "PROJECT_ID: $PROJECT_ID"

if [[ -z $GIT_COMMIT ]] || [[ -z $GIT_USERNAME ]] || [[ -z $GIT_BRANCH ]] || [[ -z $KUBE_CONTEXT ]] || [[ -z $DB_SCALE ]] || [[ -z $PROJECT_ID ]]
then
  echo "Missing environment variables"
  exit 1
fi
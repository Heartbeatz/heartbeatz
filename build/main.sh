#!/bin/bash
set -e

echo "GIT_COMMIT: $GIT_COMMIT"
echo "GIT_USERNAME $GIT_USERNAME"
echo "BRANCH: $BRANCH"
echo "KUBE_CONTEXT: $KUBE_CONTEXT"
echo "DB_SCALE: $DB_SCALE"
echo "PROJECT_ID: $PROJECT_ID"

if [[ -z $GIT_COMMIT ]] || [[ -z $GIT_USERNAME ]] || [[ -z $BRANCH ]] || [[ -z $KUBE_CONTEXT ]] || [[ -z $DB_SCALE ]] || [[ -z $PROJECT_ID ]]
then
  echo "Missing environment variables"
  exit 1
fi

echo "Starting server build..."
bash ./server/build.sh

echo "Starting agent build..."
bash ./agent/build.sh
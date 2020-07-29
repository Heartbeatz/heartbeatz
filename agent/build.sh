#!/bin/bash
set -e

if [[ -z $DOCKER_REGISTRY_PATH_AGENT ]]
then
  DOCKER_REGISTRY_PATH_AGENT="heartbeatz/agent"
fi

if [[ -z $BUILD_NUMBER ]]
then
  BUILD_NUMBER="master"
fi

echo "Starting agent build process..."
cd ./agent
echo "Starting docker build..."
docker build -t "$DOCKER_REGISTRY_PATH_AGENT":"$BRANCH"."$BUILD_NUMBER" .
if [ ! $? -eq 0 ];
then
  echo "Docker build failed"
  exit 2
fi
docker push "$DOCKER_REGISTRY_PATH_AGENT":"$BRANCH"."$BUILD_NUMBER"
if [ ! $? -eq 0 ];
then
  echo "Docker push failed"
  exit 2
fi
cd ../
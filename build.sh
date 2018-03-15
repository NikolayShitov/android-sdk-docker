#!/bin/sh
set -e
BASE_IMAGE_TAG="3859397-27-27.0.3"
JENKINS_SWARM_CLIENT_VERSION="3.9"
NAME="zhywang/android-sdk"
TAG="jenkins-swarm-client-$JENKINS_SWARM_CLIENT_VERSION-$BASE_IMAGE_TAG"
sed -e "s/__BASE_IMAGE_TAG__/$BASE_IMAGE_TAG/g" Dockerfile > Dockerfile.1
sed -e "s/EMAIL/$email/;s/AUTH/$auth/" templ > config.json
docker build --file Dockerfile.1 --build-arg JENKINS_SWARM_CLIENT_VERSION=$JENKINS_SWARM_CLIENT_VERSION -t "$NAME" .
docker tag $NAME $NAME:$TAG
rm -rf Dockerfile.1
docker --config=. push "$NAME:$TAG"

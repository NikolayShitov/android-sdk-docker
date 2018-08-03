#!/bin/sh
set -e
# 28 VERSION
ANDROID_SDK_VERSION="4333796"
docker build \
    --build-arg ANDROID_SDK_VERSION=$ANDROID_SDK_VERSION \
    -t dtdservices/android-sdk .

FROM ubuntu:16.04

MAINTAINER cheshir "ns@devtodev.com"

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt

# Install essantial tools
RUN apt-get -y update && apt-get -y install wget unzip

# Install Android SDK
ARG ANDROID_SDK_VERSION=4333796

RUN mkdir sdk \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-$ANDROID_SDK_VERSION.zip \
    && unzip -qq -d sdk sdk-tools-linux-$ANDROID_SDK_VERSION.zip \
    && chown -R root.root sdk/tools \
    && rm -rf sdk-tools-linux-$ANDROID_SDK_VERSION.zip

# Add android tools and platform tools to PATH
ENV ANDROID_HOME /opt/sdk
ENV ANDOIRD_BIN $ANDROID_HOME/tools/bin
ENV ANDROID_TOOLS $ANDROID_HOME/platform-tools
ENV ANDROID_EMU $ANDROID_HOME/emulator

ENV PATH $PATH:$ANDOIRD_BIN
ENV PATH $PATH:$ANDROID_TOOLS
ENV PATH $PATH:$ANDROID_EMU

RUN echo $PATH
RUN echo $ANDROID_HOME

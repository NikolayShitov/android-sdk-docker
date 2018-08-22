FROM ubuntu:16.04

MAINTAINER cheshir "ns@devtodev.com"

# Specially for SSH access and port redirection
ENV ROOTPASSWORD android

# Expose ADB, ADB control and VNC ports
EXPOSE 22
EXPOSE 5037
EXPOSE 5554
EXPOSE 5555
EXPOSE 5902
EXPOSE 80
EXPOSE 443

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /opt

# Install essantial tools
RUN dpkg --add-architecture i386 \
    && apt-get install -y default-jre default-jdk wget unzip openssh-server

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

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/default-java

RUN echo $PATH
RUN echo $ANDROID_HOME
RUN echo $JAVA_HOME

# Run sshd
RUN mkdir /var/run/sshd && \
RUN echo "root:${ROOTPASSWORD}" | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"

RUN echo "export VISIBLE=now" >> /etc/profile

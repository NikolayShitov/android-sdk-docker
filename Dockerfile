FROM zhywang/android-sdk:__BASE_IMAGE_TAG__

MAINTAINER Wang Zhiyong "zhywang@live.com"

WORKDIR /opt

# Install Jenkins remoting
ARG JENKINS_REMOTING_VERSION
RUN wget -q https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${JENKINS_REMOTING_VERSION}/remoting-${JENKINS_REMOTING_VERSION}.jar -O remoting.jar
ENTRYPOINT java -cp /opt/remoting.jar hudson.remoting.jnlp.Main -headless -workDir /opt/jenkins -url $0 $1 $2
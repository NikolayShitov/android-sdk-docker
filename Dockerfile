FROM zhywang/android-sdk:__BASE_IMAGE_TAG__

MAINTAINER Wang Zhiyong "zhywang@live.com"

WORKDIR /opt

# Install Jenkins swarm client
ARG JENKINS_SWARM_CLIENT_VERSION
RUN wget -q https://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/$JENKINS_SWARM_CLIENT_VERSION/swarm-client-$JENKINS_SWARM_CLIENT_VERSION.jar -O swarm-client.jar
ENTRYPOINT ["/usr/bin/java","-jar","/opt/swarm-client.jar","-fsroot","/opt/jenkins"]

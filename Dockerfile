FROM jenkins/jenkins:lts-alpine

USER root

RUN apk add --update zip docker nodejs npm curl

RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN /usr/local/bin/install-plugins.sh workflow-aggregator git permissive-script-security \
 blueocean pipeline-utility-steps allure-jenkins-plugin docker-workflow telegram-notifications ssh-agent ssh-slaves

# Activate Permissive Script Security Plugin
ENV JAVA_OPTS $JAVA_OPTS -Dpermissive-script-security.enabled=no_security -Djenkins.install.runSetupWizard=false

COPY admin-user.groovy /usr/share/jenkins/ref/init.groovy.d/
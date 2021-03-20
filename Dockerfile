FROM jenkins/jenkins:lts-alpine

USER root

RUN apk add --update zip docker nodejs npm python3

RUN pip3 install docker-compose

RUN /usr/local/bin/install-plugins.sh workflow-aggregator git permissive-script-security blueocean pipeline-utility-steps ssh-agent rocketchatnotifier ssh-slaves

# Activate Permissive Script Security Plugin
ENV JAVA_OPTS $JAVA_OPTS -Dpermissive-script-security.enabled=no_security -Djenkins.install.runSetupWizard=false

COPY admin-user.groovy /usr/share/jenkins/ref/init.groovy.d/

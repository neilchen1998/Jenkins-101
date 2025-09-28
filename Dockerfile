# Use the official Jenkins agent image as the base
# TODO: figure out which one is better/correct
# FROM jenkins/jenkins:2.529-jdk21
FROM jenkins/agent:latest-bookworm-jdk21

# Switch to the root user
USER root

# Update, install, and upgrade packages
# TODO: figure out if python3 is necessary
RUN apt-get update && \
    apt-get install -y  curl \
    python3 \
    python3-venv \
    ca-certificates \
    lsb-release && \
    apt-get upgrade -y

# Get the GPG key of docker and store it
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg

# Verify the key of the docker image
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI package
RUN apt-get update && \
    apt-get install -y docker-ce-cli

# Switch user to jenkins for security reasons
USER jenkins

# TODO: figure out if this step is necessary
# RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"
# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set non-interactive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y curl sudo

# Install Mattermost using the official installation script
RUN curl -o- https://raw.githubusercontent.com/mattermost/mattermost-server/master/scripts/setup/ubuntu.sh | sudo bash

# Expose the default Mattermost port
EXPOSE 8065

# Set the working directory to the Mattermost directory
WORKDIR /opt/mattermost

# Start the Mattermost server
CMD ["./bin/mattermost"]

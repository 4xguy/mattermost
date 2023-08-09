# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to non-interactive (this ensures that no prompts will interrupt the build process)
ENV DEBIAN_FRONTEND=non-interactive

# Update and install dependencies
RUN apt-get update && apt-get install -y wget curl apt-transport-https

# Download and install Mattermost
RUN wget https://releases.mattermost.com/5.38.1/mattermost-5.38.1-linux-amd64.tar.gz && \
    tar -xvzf mattermost*.gz && \
    mv mattermost /opt && \
    mkdir /opt/mattermost/data

# Set up user and permissions
RUN useradd --system --user-group mattermost && \
    chown -R mattermost:mattermost /opt/mattermost && \
    chmod -R g+w /opt/mattermost

# Set up the database driver (assuming PostgreSQL)
RUN apt-get install -y postgresql

# Expose the default Mattermost port
EXPOSE 8065

# Set the working directory
WORKDIR /opt/mattermost

# Start the Mattermost server
CMD ["bin/mattermost"]

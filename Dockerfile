# Use Ubuntu 20.04 as the base image
FROM ubuntu:20.04

# Set environment variables to non-interactive (this ensures that no prompts will interrupt the build process)
ENV DEBIAN_FRONTEND=non-interactive

# Update and install dependencies
RUN apt-get update && apt-get install -y wget curl apt-transport-https postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install Mattermost
RUN wget https://releases.mattermost.com/7.9.2/mattermost-7.9.2-linux-amd64.tar.gz && \
    tar -xvzf mattermost*.gz && \
    mv mattermost /opt && \
    rm mattermost*.gz

# Set up user and permissions
RUN useradd --system --user-group mattermost && \
    mkdir -p /opt/mattermost/data && \
    chown -R mattermost:mattermost /opt/mattermost && \
    chmod -R g+w /opt/mattermost

# Expose the default Mattermost port
EXPOSE 8065

# Set the working directory
WORKDIR /opt/mattermost

# Copy the entry script into the container
COPY entrypoint.sh /entrypoint.sh

# Make the script executable
RUN chmod +x /entrypoint.sh

# Set the entry script as the entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Start the Mattermost server
CMD ["bin/mattermost"]

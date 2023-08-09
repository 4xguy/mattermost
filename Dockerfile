# Use the official Mattermost Team Edition image from Docker Hub
FROM mattermost/mattermost-team-edition:latest

# Expose the default Mattermost port
EXPOSE 8065

# The entrypoint is already set in the official image to start the Mattermost server

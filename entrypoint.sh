#!/bin/sh

# Add the mapping to /etc/hosts
echo "127.0.0.1 mattermost.railway.internal" >> /etc/hosts

# Execute the provided CMD
exec "$@"

# Use the official Node.js image as a base image
FROM node:18

# Install curl
RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /opt/cronicle

# Download and run the Cronicle installation script
RUN curl -s https://raw.githubusercontent.com/jhuckaby/Cronicle/master/bin/install.js | node

# Expose the default port for Cronicle
EXPOSE 3012

# Add the setup and start script to the image
COPY setup_and_start.sh /setup_and_start.sh
RUN chmod +x /setup_and_start.sh

# Use the script as the entrypoint for the container
ENTRYPOINT ["/bin/bash", "/setup_and_start.sh"]

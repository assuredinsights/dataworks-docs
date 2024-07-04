# Use the official openmetadata image as a base
FROM openmetadata/server:latest

# Copy your custom UI files to the appropriate directory
# Adjust the path as necessary
COPY openmetadata-ui /app/openmetadata-ui

# Use the same entrypoint as the original image
ENTRYPOINT ["/bin/bash"]
CMD ["/openmetadata-start.sh"]

# Use the official SearxNG base image
FROM searxng/searxng:latest

# Set environment variables for SearxNG
ENV SEARXNG_BASE_URL=http://localhost:8888
ENV SEARXNG_INSTANCE_NAME=my-searxng-instance

# Set the working directory (if needed)
WORKDIR /etc/searxng

# Copy the necessary configuration files into the container
COPY settings.yml /etc/searxng/settings.yml
COPY uwsgi.ini /etc/searxng/uwsgi.ini

# Expose port 8888 for SearxNG
EXPOSE 8888

# Use the default CMD from the searxng/searxng image to start the server
CMD ["uwsgi", "--ini", "/etc/searxng/uwsgi.ini"]

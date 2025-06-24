# Use Nginx base image
FROM nginx:alpine

# Copy React build to Nginx's HTML directory
COPY ./build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Default command
CMD ["nginx", "-g", "daemon off;"]


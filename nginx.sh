#!/bin/bash

# Copy Nginx config to sites-available
sudo cp -rf jenkinscicd.conf /etc/nginx/sites-available/jenkinscicd

# Create Jenkins workspace directory if it doesn't exist
if [ ! -d /var/lib/jenkins/workspace/jenkins-cicd ]; then
    sudo mkdir -p /var/lib/jenkins/workspace/jenkins-cicd/logs
    echo "Created directory /var/lib/jenkins/workspace/jenkins-cicd/logs"
fi

# Create the error log file if it doesn't exist
if [ ! -f /var/lib/jenkins/workspace/jenkins-cicd/logs/error.log ]; then
    sudo touch /var/lib/jenkins/workspace/jenkins-cicd/logs/error.log
    sudo chmod 644 /var/lib/jenkins/workspace/jenkins-cicd/logs/error.log
    echo "Created log file /var/lib/jenkins/workspace/jenkins-cicd/logs/error.log"
fi

# Set proper permissions for Jenkins workspace
sudo chmod 710 /var/lib/jenkins/workspace/jenkins-cicd

# Remove the existing symbolic link if it already exists
if [ -L /etc/nginx/sites-enabled/jenkinscicd ]; then
    sudo rm /etc/nginx/sites-enabled/jenkinscicd
fi

# Create a new symbolic link for Nginx site config
sudo ln -s /etc/nginx/sites-available/jenkinscicd /etc/nginx/sites-enabled/

# Check Nginx configuration syntax
sudo nginx -t
if [ $? -ne 0 ]; then
    echo "Nginx configuration test failed."
    exit 1
fi

# Start and enable Nginx using systemctl
sudo systemctl start nginx
sudo systemctl enable nginx

# Display Nginx status
sudo systemctl status nginx

echo "Nginx has been started"

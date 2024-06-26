#!/bin/bash

sudo cp -rf jenkinscicd.conf /etc/nginx/sites-available/jenkinscicd
chmod 710 /var/lib/jenkins/workspace/jenkins-cicd

sudo ln -s /etc/nginx/sites-available/jenkinscicd /etc/nginx/sites-enabled
sudo nginx -t

sudo service start nginx
sudo service enable nginx

echo "Nginx has been started"

sudo service status nginx

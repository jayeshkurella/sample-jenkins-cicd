#!/bin/bash

source env/bin/activate

cd /var/lib/jenkins/workspace/jenkins-cicd/jenkinscicd

python3 manage.py makemigrations
python3 manage.py migrate

echo "Migration Done"

cd /var/lib/jenkins/workspace/jenkins-cicd

# Create Gunicorn service file for init
sudo cp gunicorn.init /etc/init.d/gunicorn
sudo chmod +x /etc/init.d/gunicorn
sudo update-rc.d gunicorn defaults

echo "$USER"
echo "$PWD"

# Start Gunicorn service using init system
sudo service gunicorn start

echo "Gunicorn has been started"

sudo service gunicorn status
sudo service gunicorn restart

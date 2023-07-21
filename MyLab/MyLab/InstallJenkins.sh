#! /bin/bash

# Install Java
yum install java-17-amazon-corretto-headless.x86_64 -y

# Download and install Jenkins
yum upgrade -y
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat/jenkins.io-2023.key
yum install jenkins -y

# Start Jenkins
#sudo service Jenkins start
systemctl start jenkins

# Enable Jenkins
systemctl enable jenkins

# Make sure Jenkins comes up/on when reboot
chkconfig jenkins on

# Install Git SCM
yum install git -y
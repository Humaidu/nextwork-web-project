#!/bin/bash

# Update package index
sudo apt update

# Install Tomcat
sudo apt install -y tomcat10

# Install Apache
sudo apt install -y apache2

# Enable required Apache modules
sudo a2enmod proxy proxy_http

# Create Apache virtual host configuration for Tomcat proxy
sudo tee /etc/apache2/sites-available/tomcat_manager.conf > /dev/null << EOF
<VirtualHost *:80>
    ServerAdmin root@localhost
    ServerName app.nextwork.com
    ProxyRequests Off
    ProxyPreserveHost On

    ProxyPass / http://localhost:8080/nextwork-web-project/
    ProxyPassReverse / http://localhost:8080/nextwork-web-project/
</VirtualHost>
EOF

# Enable the site and restart Apache
sudo a2ensite tomcat_manager.conf
sudo systemctl restart apache2



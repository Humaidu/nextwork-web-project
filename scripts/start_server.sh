#!/bin/bash

# Start and enable Tomcat service
sudo systemctl start tomcat10.service
sudo systemctl enable tomcat10.service

# Start and enable Apache service
sudo systemctl start apache2.service
sudo systemctl enable apache2.service

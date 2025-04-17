#!/bin/bash

# Stop Apache2 if it's running
isExistApp="$(pgrep apache2)"
if [[ -n $isExistApp ]]; then
  sudo systemctl stop apache2.service
fi

# Stop Tomcat (typically tomcat10) if it's running
isExistApp="$(pgrep tomcat10)"
if [[ -n $isExistApp ]]; then
  sudo systemctl stop tomcat10.service
fi

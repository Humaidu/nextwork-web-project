#!/bin/bash
set -e

echo "📦 Copying WAR file to Tomcat webapps..."

WAR_SOURCE=$(find /opt/codedeploy-agent/deployment-root -name "nextwork-web-project.war" | head -n 1)
WAR_DEST="/opt/tomcat/webapps/nextwork-web-project.war"
APP_FOLDER="/opt/tomcat/webapps/nextwork-web-project"

if [ -f "$WAR_SOURCE" ]; then
  echo "🧹 Removing old app folder (if exists)..."
  sudo rm -rf "$APP_FOLDER"

  echo "✅ Copying WAR..."
  cp "$WAR_SOURCE" "$WAR_DEST"
  chown tomcat: "$WAR_DEST"
else
  echo "❌ WAR file not found at $WAR_SOURCE"
  exit 1
fi

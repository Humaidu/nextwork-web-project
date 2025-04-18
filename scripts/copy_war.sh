#!/bin/bash
set -e

echo "📦 Copying WAR file to Tomcat webapps..."

WAR_SOURCE="target/nextwork-web-project.war"
WAR_DEST="/opt/tomcat/webapps/nextwork-web-project.war"

if [ -f "$WAR_SOURCE" ]; then
  cp "$WAR_SOURCE" "$WAR_DEST"
  chown tomcat: "$WAR_DEST"
  echo "✅ WAR copied to $WAR_DEST"
else
  echo "❌ WAR file not found at $WAR_SOURCE"
  exit 1
fi

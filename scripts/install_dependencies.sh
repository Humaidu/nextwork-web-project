#!/bin/bash
#Amazon linux 2023 config
set -e

echo "🔧 Installing Java 17..."
sudo dnf install -y java-17-amazon-corretto

echo "👤 Creating tomcat user..."
id -u tomcat &>/dev/null || sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat

echo "🧹 Cleaning previous Tomcat installation..."
sudo rm -rf /opt/tomcat
sudo mkdir -p /opt/tomcat

echo "📦 Downloading Tomcat 9..."
cd /tmp
curl -L -o tomcat.tar.gz https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.85/bin/apache-tomcat-9.0.85.tar.gz

echo "📂 Installing Tomcat to /opt/tomcat..."
sudo tar xzvf tomcat.tar.gz -C /opt/tomcat --strip-components=1

echo "🔐 Setting permissions and executable flags..."
sudo chown -R tomcat: /opt/tomcat
sudo chmod +x /opt/tomcat/bin/*.sh

echo "⚙️ Creating Tomcat systemd service..."
sudo tee /etc/systemd/system/tomcat.service > /dev/null <<EOF
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/java-17-amazon-corretto"
Environment="CATALINA_PID=/opt/tomcat/temp/tomcat.pid"
Environment="CATALINA_HOME=/opt/tomcat"
Environment="CATALINA_BASE=/opt/tomcat"

ExecStart=/bin/bash /opt/tomcat/bin/startup.sh
ExecStop=/bin/bash /opt/tomcat/bin/shutdown.sh

Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

echo "🔄 Reloading systemd and starting Tomcat..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable tomcat
sudo systemctl start tomcat

echo "✅ Tomcat installed, started, and ready to deploy WAR files!"

#Amazon linux 2 config
# sudo yum install tomcat -y
# sudo yum -y install httpd
# sudo cat << EOF > /etc/httpd/conf.d/tomcat_manager.conf
# <VirtualHost *:80>
#   ServerAdmin root@localhost
#   ServerName app.nextwork.com
#   DefaultType text/html
#   ProxyRequests off
#   ProxyPreserveHost On
#   ProxyPass / http://localhost:8080/nextwork-web-project/
#   ProxyPassReverse / http://localhost:8080/nextwork-web-project/
# </VirtualHost>
# EOF



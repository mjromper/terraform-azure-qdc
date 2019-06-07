sudo -i -u qdc cp /home/qdc/install/files/QDCinstaller.zip  /tmp/
cd /tmp
ls -laF
sudo -i -u qdc sh -c "cd /tmp;unzip ./QDCinstaller.zip"
cd QDCinstaller
sudo -i -u qdc cp /home/qdc/install/files/podium*.zip /tmp/QDCinstaller/
sudo -i -u qdc cp -f /home/qdc/install/files/QDCinstaller.properties /tmp/QDCinstaller/QDCinstaller.properties
sudo -i -u qdc -- sh -c "cd /tmp/QDCinstaller;/tmp/QDCinstaller/QDCinstaller.sh -s"

NewFile=/usr/local/qdc/server.properties
(
cat <<'EOF'
server.database.0=file://usr/local/qdc/qdc-base;textdb.cache_rows=100;textdb.cache_size=100
server.dbname.0=podium_dist
EOF
) > $NewFile
chown qdc:qdc $NewFile

NewFile=/usr/local/qdc/hsql.sh
(
cat <<'EOF'
#!/bin/bash
cd /usr/local/qdc/

/usr/bin/java -Dtextdb.allow_full_path=true -cp /usr/local/qdc/apache-tomcat-7.0.92/webapps/qdc/WEB-INF/lib/hsqldb-2.4.1.jar org.hsqldb.server.Server
EOF
) > $NewFile
chown qdc:qdc $NewFile
chmod u+x $NewFile

NewFile=/etc/systemd/system/hsql.service
(
cat <<'EOF'
[Unit]
Description=HyperSQL Database Engine
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/qdc/hsql.sh
ExecStop=/bin/kill -15 $MAINPID

User=qdc
Group=qdc

[Install]
WantedBy=multi-user.target
EOF
) > $NewFile
systemctl daemon-reload
systemctl enable hsql
systemctl restart hsql
systemctl status hsql


NewFile=/etc/systemd/system/qdc.service
(
cat <<'EOF'
# Systemd unit file for QDC
[Unit]
Description=Apache Tomcat Web Application Container with QDC
After=syslog.target network.target

[Service]
Type=forking

Environment=JAVA_HOME=/usr
Environment=TOMCAT_HOME=/usr/local/qdc/apache-tomcat-7.0.92 
Environment=CATALINA_PID=/usr/local/qdc/apache-tomcat-7.0.92/temp/tomcat.pid
Environment=CATALINA_HOME=/usr/local/qdc/apache-tomcat-7.0.92
Environment=CATALINA_BASE=/usr/local/qdc/apache-tomcat-7.0.92
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/usr/local/qdc/apache-tomcat-7.0.92/bin/startup.sh
ExecStop=/bin/kill -15 $MAINPID

User=qdc
Group=qdc
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
EOF
) > $NewFile
systemctl daemon-reload
systemctl enable qdc
systemctl restart qdc

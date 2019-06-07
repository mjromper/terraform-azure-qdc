#!/bin/bash
echo 'Configuring QDC Prereqs'

sudo yum install -y java-1.8.0-openjdk tomcat tomcat-webapps tomcat-admin-webapps unzip #hsqldb

groupadd qdc
useradd -s /bin/bash -g qdc qdc
echo "P0dium-Qlik1234
P0dium-Qlik1234"|passwd qdc

mkdir /usr/local/qdc
mkdir /usr/local/qdc/qdc-base
cd /tmp
wget --no-verbose http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.92/bin/apache-tomcat-7.0.92.tar.gz
tar -xvf apache-tomcat-7.0.92.tar.gz
mv apache-tomcat-7.0.92 /usr/local/qdc/
chown -Rf qdc:qdc /usr/local/qdc
export TOMCAT_HOME=/usr/local/qdc/apache-tomcat-7.0.92 

export qdcCompression='Connector port="8080" protocol="HTTP/1\.1"\nuseSendfile="false"\ncompression="on"\ncompressionMinSize="150"\nnoCompressionUserAgents="gozilla, traviata"\ncompressableMimeType="text/html,text/xml,text/plain,text/css,text/javascript,,application/x-javascript,application/javascript,application/json"'

export search='Connector port="8080" protocol="HTTP/1\.1"'
cp  $TOMCAT_HOME/conf/server.xml  $TOMCAT_HOME/conf/server.xml.bak
sed -i "s|$search|$qdcCompression|" $TOMCAT_HOME/conf/server.xml

sed -i 's/prefix="localhost_access_log." suffix=".txt"/prefix="localhost_access" suffix=".log"/' $TOMCAT_HOME/conf/server.xml
sed -i 's/pattern="%h %l %u %t &quot;%r&quot; %s %b"/pattern="%h %l %u %t \&quot;%r\&quot; %s %b %{podiumUser}s %{podiumSession}s \[%I\]"/' $TOMCAT_HOME/conf/server.xml
cd $TOMCAT_HOME

firewall-cmd --zone=public --permanent --add-port=8080/tcp
systemctl restart firewalld.service
#$TOMCAT_HOME/bin/shutdown.sh; sleep 10; rm -f $TOMCAT_HOME/logs/*.*
#$TOMCAT_HOME/bin/startup.sh; clear; tail -f $TOMCAT_HOME/logs/catalina.out

echo 'QDC Prereqs Completed'

#!/bin/bash
echo 'Configuring Postgres 9.6'

#Postgres 9.6
yum install -y https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm
yum -y groupinstall "PostgreSQL Database Server 9.6 PGDG"
/usr/pgsql-9.6/bin/postgresql96-setup initdb


systemctl start postgresql-9.6
systemctl enable postgresql-9.6
#sleep 5

sudo -i -u postgres cp /var/lib/pgsql/9.6/data/pg_hba.conf /var/lib/pgsql/9.6/data/pg_hba.conf.old
sudo -i -u postgres cp /var/lib/pgsql/9.6/data/postgresql.conf /var/lib/pgsql/9.6/data/postgresql.conf.old

sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/"  /var/lib/pgsql/9.6/data/postgresql.conf
sed -i "s/127\.0\.0\.1\/32/0.0.0.0\/0/" /var/lib/pgsql/9.6/data/pg_hba.conf
sed -i "s/ident/trust/" /var/lib/pgsql/9.6/data/pg_hba.conf
sed -i "s/peer/trust/" /var/lib/pgsql/9.6/data/pg_hba.conf
systemctl restart postgresql-9.6
sleep 10

sudo -i -u postgres /usr/pgsql-9.6/bin/psql --command "alter user postgres with encrypted password 'password';"
sudo -i -u postgres /usr/pgsql-9.6/bin/psql --command "create role qdc createdb login;"

echo 'Completed Postgres 9.6'
#sleep 20
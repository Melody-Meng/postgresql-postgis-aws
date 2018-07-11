#!/bin/bash
#
# Script to setup a Elastic Beanstalk AMI with geospatial libraries and postGIS
#
# sh aws_ami_prep.sh > aws_ami_prep.log 2>&1 &

# Go to ec2-user home directory
cd /home/ec2-user


cd /home/ec2-user/
mkdir postgis
cd postgis
# yum libraries
sudo yum -y install gcc gcc-c++ make cmake libtool libcurl-devel libxml2-devel rubygems swig fcgi-devel\
                    libtiff-devel freetype-devel curl-devel libpng-devel giflib-devel libjpeg-devel\
                    cairo-devel freetype-devel readline-devel openssl-devel python27 python27-devel

# Postgres
# wget  http://ftp.postgresql.org/pub/source/v9.3.3/postgresql-9.3.3.tar.gz
# tar -zxvf postgresql-9.3.3.tar.gz
# cd postgresql-9.3.3
# ./configure  --with-openssl --bindir=/usr/bin
# make
# sudo make install
# cd ..
sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs
# initiate a db
sudo service postgresql initdb
# change conf 
sudo vim /var/lib/pgsql9/data/pg_hba.conf
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             power_user      0.0.0.0/0               md5
host    all             other_user      0.0.0.0/0               md5
host    all             storageLoader   0.0.0.0/0               md5
# IPv6 local connections:
host    all             all             ::1/128                 md5


sudo vim /var/lib/pgsql9/data/postgresql.conf
#listen_addresses = 'localhost'          # what IP address(es) to listen on;
listen_addresses='*'
#port = 5432
port = 5432

sudo service postgresql start

# Log into the server:
sudo su - postgres
psql -U postgres

# make 'ec2-user' a superuser
sudo -u postgres createuser --interactive


# PROJ
wget http://download.osgeo.org/proj/proj-4.8.0.tar.gz
tar -zxvf proj-4.8.0.tar.gz
cd proj-4.8.0
./configure
make
sudo make install
cd ..

# GEOS
wget http://download.osgeo.org/geos/geos-3.4.2.tar.bz2
tar -xvf geos-3.4.2.tar.bz2
cd geos-3.4.2
./configure
make
sudo make install
cd ..

# GDAL
wget http://download.osgeo.org/gdal/1.10.1/gdal-1.10.1.tar.gz
tar -zxvf gdal-1.10.1.tar.gz
cd gdal-1.10.1
./configure
make
sudo make install
cd ..

# PostGIS
export LD_LIBRARY_PATH=/usr/local/pgsql/lib/:LD_LIBRARY_PATH
wget http://download.osgeo.org/postgis/source/postgis-2.1.0.tar.gz
tar -xvf postgis-2.1.0.tar.gz
cd postgis-2.1.0
./configure --with-geosconfig=/usr/local/bin/geos-config --with-pdconfig=/usr/bin/pd-config --with-gdalconfig=/usr/local/bin/gdal-config
make
sudo make install
cd ..


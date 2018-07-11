# install postgresql - postgis in ubuntu-16.04


# update
sudo apt update 
# install pip
sudo apt-get install python-pip

# install aws command line interface
pip install awscli --upgrade –user
# configure aws
aws configure
# then enter access key, secret access key etc.

# install postgresql  https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib

# using postgresql roles and databases
sudo -i -u postgres
psql 

# create a new role called ubuntu
createuser --interactive
# create databases
createdb test1


# install postgis https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-postgis-on-ubuntu-14-04

sudo apt-get install software-properties-common python-software-properties
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable

sudo apt-get update
sudo apt-get install postgis

# enable spatial features with PostGIS 
sudo -i -u postgres
psql -d test1
CREATE EXTENSION postgis;

# verify if everything worked correctly
SELECT PostGIS_version();

# if you see output like this
# postgis_version
# ---------------------------------------
# 2.2 USE_GEOS=1 USE_PROJ=1 USE_STATS=1
# (1 row)
#
# then you are good to go!

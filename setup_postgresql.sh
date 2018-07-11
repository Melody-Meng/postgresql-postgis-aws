sudo yum install postgresql postgresql-server postgresql-devel postgresql-contrib postgresql-docs

sudo service postgresql initdb

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


$ sudo vim /var/lib/pgsql9/data/postgresql.conf

#listen_addresses = 'localhost'          # what IP address(es) to listen on;
listen_addresses='*'
#port = 5432
port = 5432

$ sudo service postgresql start

# Log into the server:

$ sudo su - postgres
$ psql -U postgres

CREATE USER power_user SUPERUSER;

$ psql -U postgres  #enter a db

# get all users
psql=# \du 

# get all DATABASE
psql=# \l






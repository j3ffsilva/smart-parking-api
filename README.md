# Smart Parking API

## Setup

This section covers steps necessary to get the application running locally.
It assumes you're using **Ubuntu**. You may need to adapt some commands if this
is not true.

### Dependencies

- Ruby 2.3.1
- PostgreSQL

### PostgreSQL setup

#### Basic installation

```bash
# Install PostgreSQL server and client
sudo apt-get install postgresql postgresql-contrib postgresql-client pgadmin3

# Connect to PostgreSQL
sudo -u postgres psql postgres

# Inside the PostgreSQL shell, create the application user
postgres=# CREATE USER smart_parking_user WITH PASSWORD 'smart_parking_pass' CREATEDB;
postgres=# \q
```

#### Configuration of the earthdistance module

We need to install [two contrib modules](http://www.postgresql.org/docs/8.3/static/earthdistance.html) from PostgreSQL, `cube` and
`earthdistance`, that will allow us to calculate the distance between two
points on the surface of the Earth.

These extensions will be configured on a [template database](http://www.postgresql.org/docs/9.4/static/manage-ag-templatedbs.html)
so that they are already enabled whenever we run `rake db:create`.

To do that, enter the PostgreSQL shell again and run the following commands:

```bash
postgres=# CREATE DATABASE template2 TEMPLATE template1;
postgres=# \c template2;
postgres=# CREATE EXTENSION cube;
postgres=# CREATE EXTENSION earthdistance;
postgres=# UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template2';
```

### Project

- Clone the project from GitLab
- Run the following commands:

```
bundle install
overcommit --install
bundle exec rake db:create db:migrate db:seed
```

## TODO:

* How to run the test suite
* Services (job queues, cache servers, search engines, etc.)
* Deployment instructions

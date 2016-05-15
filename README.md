# Smart Parking API

## Setup

This section covers steps necessary to get the application running locally.
It assumes you're using **Ubuntu**. You may need to adapt some commands if this
is not true.

### Dependencies

- Ruby 2.3.1
- PostgreSQL

### Database

```bash
# Install Postgres server and client
sudo apt-get install postgresql postgresql-contrib postgresql-client pgadmin3

# Connect to Postgres
sudo -u postgres psql postgres

# Create application user
postgres=# CREATE USER smart_parking_user WITH PASSWORD 'smart_parking_pass' CREATEDB;
postgres=# \q
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

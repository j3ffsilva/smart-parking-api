# Smart Parking API

## Description

This repository contains the Rails application that provides a RESTful API for
gathering data regarding parking spots of the city.

The API can be consumed by any client, such as a single page application or a
native mobile application for iOS or Android.

One such client is the
[Smart Parking Maps](https://gitlab.com/smart-city-platform/smart_parking_maps)
application, so be sure to check that one too!

## Development setup

This section covers the necessary steps to get the application running on a
local development machine. It assumes you're using **Ubuntu**, so you may need
to adapt some of the commands if this is not true.

### Dependencies

- Ruby 2.3.1
- PostgreSQL

### Dependencies installation and setup

#### PostgreSQL

##### Installation

```bash
# Install PostgreSQL server and client
sudo apt-get update
sudo apt-get install postgresql postgresql-contrib postgresql-client pgadmin3

# Start the server
sudo service postgresql start

# Connect to PostgreSQL
sudo -u postgres psql postgres

# Inside the PostgreSQL shell, create the application user
postgres=# CREATE USER smart_parking_user WITH PASSWORD 'smart_parking_pass' CREATEDB;
postgres=# ALTER USER smart_parking_user WITH SUPERUSER;

# Make sure the database templates use UTF-8
postgres=# UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';
postgres=# DROP DATABASE template1;
postgres=# CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';
postgres=# UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';
postgres=# \c template1
postgres=# VACUUM FREEZE;

# Quit
postgres=# \q
```

### Project setup

Now that you have all dependencies installed, you can get the project up and
running with the following steps:

- Clone the project from GitLab
  ```bash
  # You can also clone using the SSH URL.
  git clone https://gitlab.com/smart-city-platform/smart_parking_api.git smart-city-platform/smart_parking_api
  cd smart-city-platform/smart_parking_api
  ```

- Install Rails and all other gems
  ```bash
  # This step is only necessary if you don't have Bundler installed.
  gem install bundler
  # This step is always necessary.
  bundle install
  ```

- Setup [overcommit](https://github.com/brigade/overcommit) (Git hooks for code quality)
  ```bash
  overcommit --install
  overcommit --sign
  ```
- Setup the database
  ```bash
  alias be="bundle exec"
  be rake db:create && be rake db:migrate && be rake db:seed
  ```

- Create an API client and a token
  ```bash
  be rake api_clients:create["smart-parking-api-dev"]
  ```
  **IMPORTANT:** this Rake task outputs an API token. Take note of this token,
  because you will need it to make API requests and/or to configure the
  [smart_parking_maps](https://gitlab.com/smart-city-platform/smart_parking_maps) application.

- Start the server
  ```bash
  # Port 3010 is the port convention for this application within the Smart City
  # platform. Changing the port may cause other applications to fail.
  bundle exec rails server -p 3010 -b 0.0.0.0
  ```

- Open http://localhost:3010 in your browser. You should see the welcome page.

## Testing

We use RSpec for our test suite. To run all tests, use the following command:
```
# Seeding the database is only necessary the first time you run the tests.
RAILS_ENV=test bundle exec rake db:seed
RAILS_ENV=test bundle exec rspec
```

## Project phases

### Phase 1 (due May 20)

- **Goals**:
  - Define our data model: what data do we want to collect and store about each parking spot?
  - Implement a basic (but easily extendable) API with a search endpoint (`/spots/search`)

- **Issues**: see all issues that were planned (and delivered) for this phase [here](https://gitlab.com/smart-city-platform/smart_parking_api/issues?assignee_id=&author_id=&milestone_title=Phase+1&scope=all&sort=id_desc&state=all&issue_search=&).

### Phase 2 (due June 8)

- **Goals**:
  - Integrate with [smart\_parking\_maps](https://gitlab.com/smart-city-platform/smart_parking_maps) application.
  - Begin integration with other groups from the Smart City platform

- **Issues**: see all issues that were planned (and delivered) for this phase [here](https://gitlab.com/smart-city-platform/smart_parking_api/issues?assignee_id=&author_id=&milestone_title=Phase+2&scope=all&sort=id_desc&state=all&issue_search=&).

## API Documentation

See the detailed
[API documentation](https://gitlab.com/smart-city-platform/smart_parking_api/wikis/api-docs).
This documentation will be constantly updated as the project evolves.

## UML diagrams

See the [docs](https://gitlab.com/smart-city-platform/smart_parking_api/tree/master/docs) directory.
These diagrams will be constantly updated as the project evolves.

## Wiki

See our [wiki](https://gitlab.com/smart-city-platform/smart_parking_api/wikis/home) for more specific contents.

## Contributing

See our [contributing guidelines](https://gitlab.com/smart-city-platform/smart_parking_api/wikis/contributing)

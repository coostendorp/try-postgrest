# A simple beginner project to get started with Postgrest.

# You need:

- A Bash shell
- [Latest Docker](https://docs.docker.com/get-docker/) (that supports `docker compose`)
- `make` (on linux, most likely installed with `sudo apt-get install build-essential`)
- Nice to have
    - An Intellij IDE (Webstorm, Rustrover etc)
    - An SQL client, such as DBeaver or the built-in from Intellij

# Getting started

- Create the .env: `make create-env`
- Start the servers: `make restart-server`
- Install the sql from _my_database.sql_: `make populate-db`
- View the REST API at: http://localhost:3000/
- View the Swagger at: http://localhost:8080/

# To continue on your own you can:

- 

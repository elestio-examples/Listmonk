<a href="https://elest.io">
  <img src="https://elest.io/images/elestio.svg" alt="elest.io" width="150" height="75">
</a>

[![Discord](https://img.shields.io/static/v1.svg?logo=discord&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=Discord&message=community)](https://discord.gg/4T4JGaMYrD "Get instant assistance and engage in live discussions with both the community and team through our chat feature.")
[![Elestio examples](https://img.shields.io/static/v1.svg?logo=github&color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=github&message=open%20source)](https://github.com/elestio-examples "Access the source code for all our repositories by viewing them.")
[![Blog](https://img.shields.io/static/v1.svg?color=f78A38&labelColor=083468&logoColor=ffffff&style=for-the-badge&label=elest.io&message=Blog)](https://blog.elest.io "Latest news about elestio, open source software, and DevOps techniques.")

# Listmonk, verified and packaged by Elestio

[Listmonk](https://github.com/knadh/listmonk) is a standalone, self-hosted, newsletter and mailing list manager. It is fast, feature-rich, and packed into a single binary. It uses a PostgreSQL (⩾ 12) database as its data store.

<img src="https://github.com/elestio-examples/listmonk/raw/main/listmonk.png" alt="listmonk" width="800">

[![deploy](https://github.com/elestio-examples/listmonk/raw/main/deploy-on-elestio.png)](https://dash.elest.io/deploy?source=cicd&social=dockerCompose&url=https://github.com/elestio-examples/listmonk)

Deploy a <a target="_blank" href="https://elest.io/open-source/listmonk">fully managed listmonk</a> on <a target="_blank" href="https://elest.io/">elest.io</a> if you want a free and open-source, decentralized, ActivityPub federated video platform powered by WebTorrent, that uses peer-to-peer technology to reduce load on individual servers when viewing videos.

# Why use Elestio images?

- Elestio stays in sync with updates from the original source and quickly releases new versions of this image through our automated processes.
- Elestio images provide timely access to the most recent bug fixes and features.
- Our team performs quality control checks to ensure the products we release meet our high standards.

# Usage

## Git clone

You can deploy it easily with the following command:

    git clone https://github.com/elestio-examples/listmonk.git

Copy the .env file from tests folder to the project directory

    cp ./tests/.env ./.env

Edit the .env file with your own values.

Create data folders with correct permissions

Run the project with the following command

    docker-compose up -d

You can access the Web UI at: `http://your-domain:9090`

## Docker-compose

Here are some example snippets to help you get started creating a container.

    version: "3.7"

    services:
      db:
        image: postgres:13
        ports:
          - "172.17.0.1:5432:5432"
        environment:
          - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
          - POSTGRES_USER=${POSTGRES_USER}
          - POSTGRES_DB=${POSTGRES_DB}
        restart: unless-stopped
        healthcheck:
          test: ["CMD-SHELL", "pg_isready -U listmonk"]
          interval: 10s
          timeout: 5s
          retries: 6
        container_name: listmonk_db
        volumes:
          - ./listmonk-data:/var/lib/postgresql/data

      app:
        restart: unless-stopped
        image: elestio4test/listmonk:${SOFTWARE_VERSION_TAG}
        command: [sh, -c, "yes | ./listmonk --install --config config.toml && ./listmonk --config config.toml"]
        ports:
          - "172.17.0.1:9090:9000"
        environment:
          - TZ=Etc/UTC
        container_name: listmonk_app
        depends_on:
          - db
        volumes:
          - ./config.toml:/listmonk/config.toml

### Environment variables

|       Variable       |     Value (example)     |
| :------------------: | :---------------------: |
|       ADMIN_EMAIL    |  admin email            |
|     ADMIN_PASSWORD   |  admin password         |
|   SOFTWARE_VERSION   |  latest                 |
|    POSTGRES_USER     |  postgres user          |
|   POSTGRES_PASSWORD  |  postgres password      |


# Maintenance

## Logging

The Elestio Listmonk Docker image sends the container logs to stdout. To view the logs, you can use the following command:

    docker-compose logs -f

To stop the stack you can use the following command:

    docker-compose down

## Backup and Restore with Docker Compose

To make backup and restore operations easier, we are using folder volume mounts. You can simply stop your stack with docker-compose down, then backup all the files and subfolders in the folder near the docker-compose.yml file.

Creating a ZIP Archive
For example, if you want to create a ZIP archive, navigate to the folder where you have your docker-compose.yml file and use this command:

    zip -r myarchive.zip .

Restoring from ZIP Archive
To restore from a ZIP archive, unzip the archive into the original folder using the following command:

    unzip myarchive.zip -d /path/to/original/folder

Starting Your Stack
Once your backup is complete, you can start your stack again with the following command:

    docker-compose up -d

That's it! With these simple steps, you can easily backup and restore your data volumes using Docker Compose.

# Links

- <a target="_blank" href="https://listmonk.app/docs/">Listmonk documentation</a>

- <a target="_blank" href="https://github.com/knadh/listmonk">Listmonk Github repository</a>

- <a target="_blank" href="https://github.com/elestio-examples/listmonk">Elestio/Listmonk Github repository</a>

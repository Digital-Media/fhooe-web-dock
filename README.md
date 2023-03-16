# fhooe-web-dock – A Docker Environment for Web Development Classes

This repository provides a Docker environment for web development designed for use in web development classes at the [Upper Austria University of Applied Sciences (FH Oberösterreich), Hagenberg Campus](https://www.fh-ooe.at/en/hagenberg-campus/).

This collection of Dockerfiles is based on the official Docker images for [PHP](https://hub.docker.com/_/php/) 8.1, [MariaDB](https://hub.docker.com/_/mariadb) 10.7 and [phpMyAdmin](https://hub.docker.com/_/phpmyadmin) 5.2.0, as well as additional configuration and scripts.

Not familiar with Docker containers or not sure why to use them? Have a look at the [Introduction](https://www.docker.com/resources/what-container/) first.

## Installation of Software and Prerequisites

To use this environment, you will need a few tools installed. Some, like Docker Desktop, are mandatory, and others are recommended.

### Docker Desktop

[Docker Desktop](https://www.docker.com/products/docker-desktop/) creates and runs the fhooe-web-dock containers. Download and install it for Windows, Mac OS (M1 or Intel) or Linux. 

- Windows: [Installation Instructions + Installer Download](https://docs.docker.com/desktop/install/windows-install/) | [Chocolatey](https://chocolatey.org/): `choco install docker-desktop` | [Winget](https://winget.run/): `winget install -e --id Docker.DockerDesktop`
- Mac OS X: [Installation Instruction + Installer Download](https://docs.docker.com/desktop/install/mac-install/) | [Homebrew](https://brew.sh/): `brew install --cask docker`
- Linux: [Installation Instructions + Package Download](https://docs.docker.com/desktop/install/linux-install/)

To avoid rate limit issues when downloading the underlying images from [Docker Hub](https://hub.docker.com/), please register for a [free account](https://hub.docker.com/signup) and make sure you're logged in on Docker Desktop with it.

### Git

Installing Git on your host machine is also recommended so you can easily update to the latest version of fhooe-web-dock.

- Windows: [Installer Download](https://gitforwindows.org/) | Chocolatey: `choco install git` | Winget: `winget install -e --id Git.Git`

- Mac OS X: Xcode Commandline Tools: `xcode-select –install` | Homebrew: `brew install git`

- Linux: Debian/Ubuntu: `apt-get install git`

## Running the Containers

Use a command prompt such as Windows Powershell or Terminal to enter the Docker commands. All commands must be entered in your local fhooe-web-dock directory.

### Building and Starting the Containers

```shell
docker compose up -d
```

This will create three containers:

- `webapp`: Apache web server with PHP functionality.
- `mariadb`: MariaDB database.
- `pma`: phpMyAdmin for database management.

### Stopping the Containers

```shell
docker compose stop
```

### Restarting the Containers Without Rebuilding

```shell
docker compose start
```

### Rebuilding the Containers

Should your containers malfunction or you want to rebuild them from the latest official images (due to new versions), you can use the provided `CleanInstall` script.

- Windows: Double-click `CleanReinstall.bat` or run the command in a Powershell/command prompt.
- Mac OS X/Linux: Run `./CleanReinstall.sh` from a terminal/shell. If the file is not executable, run `chmod +x CleanReinstall.sh` first.

Warning: this script assumes that you're only using fhooe-web-dock on your system. It will affect other Docker environments as well!

1. Stop all running fhooe-web-dock-containers (`docker compose down -v`).
2. Remove all unused images, containers, networks and volumes (`docker system prune --volumes -a -f`). This will also affect other Docker environments on your system!
3. Update fhooe-web-dock from GitHub (`git pull`).
4. Create and start the containers again (`docker compose up -d`).

## Working With the Containers

Once all containers have been started, you'll notice a subdirectory called `webapp` in your fhooe-web-dock directory. This directory is mapped to `/var/www/html` in the `webapp` container. Since this is Apache's document root, all files and projects you put in there will be directly available on the web server.

You can access the **web server** via HTTP or HTTPS. Be advised the HTTPS certificate is self-signed and will trigger a warning in your browser.

- Webserver: http://localhost:8080 (HTTP), https://localhost:7443 (HTTPS)
- phpMyAdmin: http://localhost:8082 (HTTP), https://localhost:8443 (HTTPS)

To access the **database**, you must differentiate between access from your host system (external) or one of the other containers (internal).

- External (e.g., connecting to the database from your IDE while developing): Host: `localhost`, port: `6033`
- Internal (e.g., connecting to the database from your web application): Host: `db`, port: `3306`

For **shell access** to your containers (in this case, the `webapp` container), use the following command:

```shell
docker exec -it webapp /bin/bash
```

To access the other containers, replace the container name `webapp` with `mariadb` (database) or `pma` (phpMyAdmin).

## Additional Information

For more details on how to install and work with fhooe-web-dock, see [INSTALL.md](INSTALL.md).

Are you having trouble with fhooe-web-dock? Check the [wiki](https://github.com/Digital-Media/fhooe-web-dock/wiki) for known solutions or open an [issue](https://github.com/Digital-Media/fhooe-web-dock/issues).

## Other fhooe Docker Environments

- MongoDB: [fhooe-mongo-dock](https://github.com/Digital-Media/fhooe-mongo-dock)
- Node.js: [fhooe-node-dock](https://github.com/Digital-Media/fhooe-node-dock)

# <img src="https://raw.githubusercontent.com/Digital-Media/fhooe-web-dock/204bfcfc1cb16a5f58bfe070f34a4d0a63462147/webapp/dashboard/views/images/fhooe-web-dock-logo.svg" height="32" alt="The fhooe-web-dock Logo: Three containers stacked above each other."> fhooe-web-dock – A Docker Environment for Web Development Classes

This repository provides a Docker environment for web development designed for use in web development classes at the [Upper Austria University of Applied Sciences (FH Oberösterreich), Hagenberg Campus](https://fh-ooe.at/en/campus-hagenberg).

This collection of Dockerfiles is based on the official Docker images for [PHP](https://hub.docker.com/_/php/) 8.4, [MariaDB](https://hub.docker.com/_/mariadb) 11.7, and [phpMyAdmin](https://hub.docker.com/_/phpmyadmin) 5.2, as well as additional configuration and scripts.

Do you need to familiarize yourself with Docker containers, or are you wondering why you should use them? Have a look at the [Introduction](https://www.docker.com/resources/what-container/) first.

## Installation of Software and Prerequisites

To use this environment, you will need to install a few tools. Some, like Docker Desktop, are mandatory, and others are recommended.

### Docker Desktop

[Docker Desktop](https://www.docker.com/products/docker-desktop/) creates and runs the *fhooe-web-dock* containers. Download and install it for Windows, macOS (M Series/Silicon or Intel) or Linux. 

- Windows: [Installation Instructions + Installer Download](https://docs.docker.com/desktop/setup/install/windows-install/) | [Chocolatey](https://chocolatey.org/): `choco install docker-desktop` | [WinGet](https://learn.microsoft.com/windows/package-manager/winget/): `winget install Docker.DockerDesktop`
- macOS: [Installation Instruction + Installer Download](https://docs.docker.com/desktop/setup/install/mac-install/) | [Homebrew](https://brew.sh/): `brew install --cask docker`
- Linux: [Installation Instructions + Package Download](https://docs.docker.com/desktop/setup/install/linux/)

To avoid rate limit issues when downloading the underlying images from [Docker Hub](https://hub.docker.com/), please register for a [free account](https://hub.docker.com/signup) and make sure you're logged in on Docker Desktop with it.

### Git

It is also recommended that you install Git on your host machine so you can easily update to the latest version of *fhooe-web-dock*.

- Windows: [Installer Download](https://gitforwindows.org/) | Chocolatey: `choco install git` | WinGet: `winget install Git.Git`
- macOS: Xcode Commandline Tools: `xcode-select –install` | Homebrew: `brew install git`
- Linux: Debian/Ubuntu: `apt-get install git`

## Running the Containers

Use a command prompt such as Windows PowerShell or Terminal to enter the Docker commands. All commands must be entered in your local *fhooe-web-dock* directory.

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

- Windows: Double-click `CleanReinstall.bat` or run the command in a PowerShell/command prompt.
- macOS/Linux: Run `./CleanReinstall.sh` from a terminal/shell. If the file is not executable, run `chmod +x CleanReinstall.sh` first.

This script does the following:

1. Stop all running *fhooe-web-dock* containers (`docker compose stop`).
2. Ask for permission to remove the *fhooe-web-dock* containers and images.
3. If permisssion is granted, remove images, containers, networks, and volumes (`docker compose down --rmi all --volumes --remove-orphans`).
4. Removes any other dangling images belonging to *fhooe-web-dock* (`docker image prune --force --filter "label=com.docker.compose.project=%COMPOSE_PROJECT_NAME%"`).
5. Update *fhooe-web-dock* from GitHub (`git pull`).
6. Build the images from scratch, ignoring cached layers (`docker compose build --no-cache`).
7. Create and start the containers again (`docker compose up -d`).

## Working With the Containers

You'll notice a subdirectory called `webapp` in your *fhooe-web-dock* directory. This directory is mapped to `/var/www/html` in the `webapp` container. Since this is Apache's document root, all files and projects you put in there will be directly available on the web server. The directory initially contains the dashboard (`index.php` and directory `/dashboard`) and a `README.md`.

You can access the **web server** via HTTP or HTTPS. Be advised the HTTPS certificate is self-signed and will trigger a warning in your browser.

- Web server: http://localhost:8080 (HTTP), https://localhost:7443 (HTTPS). This will show you the dashboard.
- phpMyAdmin: http://localhost:8082 (HTTP), https://localhost:8443 (HTTPS)

To access the **database**, you must differentiate between access from your host system (external) or one of the other containers (internal).

- External (e.g., connecting to the database from your IDE while developing): Host: `localhost`, port: `6033`
- Internal (e.g., connecting to the database from your web application): Host: `db`, port: `3306`

For **shell access** to your containers (in this case, the `webapp` container), use the following command:

```shell
docker exec -it webapp /bin/bash
```

To access the other containers, replace the container name `webapp` with `mariadb` (database) or `pma` (phpMyAdmin).

### Permissions Inside the `webapp` Directory

`webapp` is a so-called [bind mount](https://docs.docker.com/engine/storage/bind-mounts/) that allows mapping a directory from the host system into the Docker container. On Linux/macOS hosts, permissions are synced. If your local user can access the directory, so does everything within the container. Permissions cannot be synced on Windows hosts, so permission errors in the container will likely occur at some point. Even though you can create files and directories within the `webapp` directory, the web server in the container will not be able to write files or create directories. If this is the case, you need to set permissions manually:

```shell
chmod -R 777 your/directory/within/webapp
```

Be advised that 777 permissions (read/write/execute for everyone) should never be used on production systems (which *fhooe-web-dock* isn't per definition).

## Additional Information

Do you need help with *fhooe-web-dock*? Check the [wiki](https://github.com/Digital-Media/fhooe-web-dock/wiki) for known solutions or open an [issue](https://github.com/Digital-Media/fhooe-web-dock/issues).

## Thanks

Thank you for starting this project [Martin](https://github.com/martinharrer). You will always be remembered.

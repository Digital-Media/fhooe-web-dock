# fhooe-web-dock – A Docker Environment for Web Development Classes

This repository provides a Docker environment for web development designed for use in web development classes at the [Upper Austria University of Applied Sciences (FH Oberösterreich), Hagenberg Campus](https://www.fh-ooe.at/en/hagenberg-campus/).

This collection of Dockerfiles is based on the official Docker images for [PHP](https://hub.docker.com/_/php/) 8.1, [MariaDB](https://hub.docker.com/_/mariadb) 10.7 and [phpMyAdmin](https://hub.docker.com/_/phpmyadmin) 5.2.0 as well as additional configuration and scripts.

Not familiar with Docker containers or not sure, why to use them? Have a look at the [Introduction](https://www.docker.com/resources/what-container/) first.

## Installation of Software and Prerequisites

To use this environment, you will need a few tools installed. Some, like Docker Desktop are mandatory, others are recommended.

### Docker Desktop

[Docker Desktop](https://www.docker.com/products/docker-desktop/) creates and runs the fhooe-web-dock containers. Download and install it for Windows, Mac OS (M1 or Intel) or Linux. 

- Windows: [Installation Instructions + Installer Download](https://docs.docker.com/desktop/install/windows-install/) | Chocolatey: `choco install docker-desktop` | Winget: `winget install -e --id Docker.DockerDesktop`
- Mac OS X: [Installation Instruction + Installer Download](https://docs.docker.com/desktop/install/mac-install/) | Homebrew: `brew install --cask docker`
- Linux: [Installation Instructions + Package Download](https://docs.docker.com/desktop/install/linux-install/)

### Git

It is also recommended to install Git on your host machine so you can easily update to the latest version of fhooe-web-dock.

- Windows: Installer Download | Chocolatey: `choco install git` | Winget: 

- Mac OS X: Xcode Commandline Tools: `xcode-select –install` | Homebrew: `brew install git`

  

  

  For unlimited download sign up for a GitHub and a [DockerHub Account](https://hub.docker.com/). 

For more Details how to install and work with Docker see [INSTALL.md](https://github.com/Digital-Media/fhooe-web-dock/blob/main/INSTALL.md) for Details and Troubleshooting.

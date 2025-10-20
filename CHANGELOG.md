# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

## [1.2.1] - 2025/10/20

### Removed

- Removed `install-repository-tools.sh` and the calls from all Dockerfiles since it caused an error when building the images. This script installed the `software-properties-common` Debian package which was removed from current Debian Trixie versions. See https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1038747 for details.

## [1.2.0] - 2025/02/25

### Added

- Added `IgnoreCase` and `FoldersFirst` options to directory indexing.
- The ports for each of the three services are now explicitly bound to 127.0.0.1 to avoid accidental exposure to the network.

### Changed

- Switched PHP image to 8.4.
- Switched to MariaDB 11.7.
- Dashboard: Updated Twig to 3.20.
- Dashboard: Updated Bootstrap to 5.3.3.
- Optimized `configure-apache.sh` and `configure-https.sh` scripts.
- Renamed `install-apt.sh` to `install-repository-tools.sh` and optimized contents.
- Switched to `ENV key=value` syntax in `Dockerfile-php`.
- Updated `CleanReinstall.bat` and `CleanReinstall.sh` to only remove containers and images from *fhooe-web-dock* while still forcing a complete rebuild of the images (without cached layers).

### Deprecated
### Removed

- Removed deprecated `version` attribute from `compose.yaml`.

### Fixed

- Syntax cleanup in `Dockerfile-php`, `Dockerfile-mariadb`, `Dockerfile-phpmyadmin`, and `compose.yaml`.

### Security

## [1.1.2] - 2024-09-11

### Security

- Bumped `twig/twig` dependency for the `dashboard` in `composer.json` to 3.14 due to CVE-2024-45411.

## [1.1.1] - 2024-03-17

### Changed

- Changed PHP_CodeSniffer's download URL in `install-php-tools.sh` to the new URL described in the [new official repository](https://github.com/PHPCSStandards/PHP_CodeSniffer). See this [announcement](https://github.com/squizlabs/PHP_CodeSniffer/issues/3932) for more information. This allows installing the latest versions again.

## [1.1.0] - 2024-02-08

### Added

- `.env` file with database connection parameters.
- Dashboard in the `webapp` directory. It is shown when the webserver is accessed and lists all subdirectories in `webapp` and shows the most important information.
- APT cache is now cleaned after installing additional packages.
- Apache2 server configuration (`ServerName`) is also performed for the `pma` container to match witht the SSH certificate.

### Changed

- Switched PHP image to 8.3.
- Switched to Xdebug 3.3.
- Default username for the database is now "hypermedia" (was "onlineshop").
- Default database is now "default" (was "onlineshop").
- `docker-compose.yml` was renamed to `compose.yaml` (as recommended in the Docker docs).
- `compose.yaml` now uses variables from the `.env` file for shared values like database name, user, and password.
- `apt-get` calls now use the parameter `--no-install-recommends` to avoid unnecessary (recommended) package installs.

### Removed

- Helper scripts `rechte.sh` and `bs.sh` were removed due to not being in use.
- `onlineshop.sql` was removed. Exercise content is not part of this environment anymore.
- Creation of empty database "login" was removed.
- Removed `INSTALL.md`. Instructions are solely in `README.md` or the [Wiki](https://github.com/Digital-Media/fhooe-web-dock/wiki).

### Fixed

- Syntax cleanup in `compose.yaml`.
- Syntax cleanup and comments in `Dockerfile-php`, `Dockerfile-mariadb` and `Dockerfile-phpmyadmin`.

## [1.0.0] - 2023-11-30

### Added

- Initial versioned release. This release marks all previously added features as stable for now.
- Containers for PHP, MariaDB, and phpMyAdmin, based on the official images linked together in a Docker Compose environment.
- PHP 8.2
- MariaDB 11.2
- phpMyAdmin 5.2
- Additional tools and configuration for each container: Linux command line tools, Composer, PHP_CS, Xdebug, GitHub CLI
- Experimental Ubuntu container for shell exercises.

[Unreleased]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.2.1...HEAD
[1.2.1]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.2.0...1.2.1
[1.2.0]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.1.2...1.2.0
[1.1.2]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/Digital-Media/fhooe-web-dock/releases/tag/1.0.0

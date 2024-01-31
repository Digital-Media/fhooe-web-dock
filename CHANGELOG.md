# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `.env` file with database connection parameters.
- Dashboard in the `webapp` directory. It is shown when the webserver is accessed and lists all subdirectories in `webapp` and shows the most important information.
- APT cache is now cleaned after installing additional packages.

### Changed

- Switched PHP image to 8.3.
- Switched to Xdebug 3.3.
- `docker-compose.yml` was renamed to `compose.yaml` (as recommended in the Docker docs).
- `compose.yaml` now uses variables from the `.env` file for shared values like database name, user, and password.
- `apt-get` calls now use the parameter `--no-install-recommends` to avoid unnecessary (recommended) package installs.

### Deprecated

### Removed

### Fixed

- Syntax cleanup in `compose.yaml`.
- Syntax cleanup and comments in `Dockerfile-php`, `Dockerfile-mariadb` and `Dockerfile-phpmyadmin`.

### Security

## [1.0.0] - 2023-11-30

### Added

- Initial versioned release. This release marks all previously added features as stable for now.
- Containers for PHP, MariaDB, and phpMyAdmin, based on the official images linked together in a Docker Compose environment.
- PHP 8.2
- MariaDB 11.2
- phpMyAdmin 5.2
- Additional tools and configuration for each container: Linux command line tools, Composer, PHP_CS, Xdebug, GitHub CLI
- Experimental Ubuntu container for shell exercises.

[Unreleased]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.0.0...HEAD
[1.0.0]: https://github.com/Digital-Media/fhooe-web-dock/releases/tag/1.0.0


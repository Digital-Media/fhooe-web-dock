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

## [1.3.4] - 2026/05/19

### Added

- Added `exif` PHP extension to both the Apache/PHP and FrankenPHP images.

## [1.3.3] - 2026/05/03

### Added

- Installed [PHP-CS-Fixer](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer) v3 as a second linting/formatting option alongside PHP_CodeSniffer. A default config using the `@PER-CS` ruleset is placed at `/usr/local/etc/php-cs-fixer.php` and can be used with `php-cs-fixer fix --config /usr/local/etc/php-cs-fixer.php <path>`.

### Fixed

- Fixed HTTPS support in the FrankenPHP container:
  - `SERVER_NAME` in `compose.yaml` now specifies both HTTP (`:80`) and HTTPS (`localhost`) so Caddy serves both protocols simultaneously.
  - Added `auto_https disable_redirects` to the Caddyfile global block to prevent automatic HTTP→HTTPS redirects.
  - Added `header -Strict-Transport-Security` to disable HSTS on FrankenPHP responses.
  - `{$SERVER_NAME}` is now used as the Caddyfile site address instead of the hardcoded `:80`, so the value from the environment variable is respected.
  - The `Alt-Svc` header for HTTP/3 advertisement now uses `{env.FRANKENPHP_WEB_PORT_HTTPS}` instead of a hardcoded port so it stays correct when the port is changed in `.env`.
  - Caddyfile is formatted with `frankenphp fmt` after being written.

## [1.3.2] - 2026/03/12

### Fixed

- Fixed `CleanReinstall.bat` and `CleanReinstall.sh` so that they work correctly either when the *fhooe-web-dock* directory is not a git directory (e.g., when downloaded as a zip file) or when git is not available on the system. Thank you, [@oliver-krauss](https://github.com/oliver-krauss).

## [1.3.1] - 2026/03/10

### Fixed

- Fixed the database privilege script not running under macOS since execute permissions were not set automatically. Database initialization has been moved to the image and is no longer mounted as a volume.

## [1.3.0] - 2026/03/04

### Added

- Experimental [FrankenPHP](https://frankenphp.dev/) support as an alternative web server. Runs in parallel to Apache on ports 8081 (HTTP) and 7444 (HTTPS) when the containers are created with `docker compose --profile experimental up -d`
  - Multi-project routing so that each project with a `/public/index.php` (e.g. fhooe-router, Slim) is served from that folder; virtual routes and static files work without per-project config.
  - Directory listing for directories that exist but have no `index.php` (no greedy `php_server` fallback for those).
  - Caddyfile is generated inside the image by `src/configure-caddy.sh` at build time (no `Caddyfile` in the repo and no Caddyfile volume).
  - `CleanReinstall` scripts ask whether FrankenPHP should be installed as an experimental feature (the default is no).
  - Dashboard uses the correct ports (8081/7444) and directory links with a trailing slash.
  - Dashboard can now correctly detect whether it is running on Apache or Caddy/FrankenPHP.

- All external ports are configurable in the `.env` file; `compose.yaml` passes these values to the containers via environment variables.
- `CleanReinstall` scripts now ask whether the database volume should be preserved ([#15](https://github.com/Digital-Media/fhooe-web-dock/issues/15)).

### Changed

- PHP image updated to 8.5.
- MariaDB image updated to 12.2.
- Xdebug is installed via [PIE](https://github.com/php/pie) (PHP Installer for Extensions) instead of PECL ([#16](https://github.com/Digital-Media/fhooe-web-dock/issues/16)).
- All apt-get installable packages from `install-cli-tools.sh` were moved into `Dockerfile-php`.
- Dashboard: Switched from Twig to Latte 3.1.2 ([#19](https://github.com/Digital-Media/fhooe-web-dock/issues/19)).
- The database privilege script now automatically grants permissions to the user defined in .env.
- Default database username changed in `.env` ([#18](https://github.com/Digital-Media/fhooe-web-dock/issues/18)).

### Fixed

- `CleanReinstall` scripts now detect the current working directory, so they can be called with an absolute path.

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

[Unreleased]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.3.4...HEAD
[1.3.4]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.3.3...1.3.4
[1.3.3]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.3.2...1.3.3
[1.3.2]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.3.1...1.3.2
[1.3.1]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.3.0...1.3.1
[1.3.0]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.2.1...1.3.0
[1.2.1]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.2.0...1.2.1
[1.2.0]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.1.2...1.2.0
[1.1.2]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.1.1...1.1.2
[1.1.1]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.1.0...1.1.1
[1.1.0]: https://github.com/Digital-Media/fhooe-web-dock/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/Digital-Media/fhooe-web-dock/releases/tag/1.0.0

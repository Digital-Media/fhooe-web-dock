<?php

namespace Fhooe\WebDockDashboard;

use PDO;
use PDOException;
use Twig\Environment;
use Twig\Error\LoaderError;
use Twig\Error\RuntimeError;
use Twig\Error\SyntaxError;
use Twig\Loader\FilesystemLoader;

/**
 * Dashboard class to display the dashboard and query server and php information.
 * @package Fhooe\WebDockDashboard
 */
class Dashboard
{
    /**
     * @var Environment The Twig template engine.
     */
    private Environment $twig;

    /**
     * @var string The path to the webapp directory
     */
    private string $webappDirectory;

    /**
     * @var string The name of the default database.
     */
    private const string dbName = "default";

    /**
     * @var string The name of the database user.
     */
    private const string dbUser = "hypermedia";

    /**
     * @var string The password of the database user.
     */
    private const string dbPassword = "geheim";

    /**
     * @var string The internal host of the database.
     */
    private const string dbHostInternal = "db";

    /**
     * @var string The external host of the database.
     */
    private const string dbHostExternal = "localhost";

    /**
     * @var string The internal port of the database.
     */
    private const string dbPortInternal = "3306";

    /**
     * @var string The external port of the database.
     */
    private const string dbPortExternal = "6033";

    /**
     * Creates a new Dashboard instance.
     * @param string $webappDirectory The path to the webapp directory
     */
    public function __construct(string $webappDirectory = ".")
    {
        $this->twig = $this->getTemplateEngine();
        $this->webappDirectory = $webappDirectory;
    }

    /**
     * Displays the dashboard.
     * @throws RuntimeError If the template cannot be rendered.
     * @throws SyntaxError If an error occurred during compilation.
     * @throws LoaderError If an error occurred while loading the template.
     */
    public function display(): void
    {
        $this->twig->display("dashboard.html.twig", [
            "url" => $this->getUrl(),
            "directories" => $this->getWebappDirectories(),
            "databaseParameters" => [
                "name" => self::dbName,
                "user" => self::dbUser,
                "password" => self::dbPassword,
                "hostInternal" => self::dbHostInternal,
                "portInternal" => self::dbPortInternal,
                "hostExternal" => self::dbHostExternal,
                "portExternal" => self::dbPortExternal
            ],
            "webserverVersion" => $this->getServerVersion(),
            "phpVersion" => $this->getPhpVersion(),
            "debuggerVersion" => $this->getDebuggerVersion(),
            "databaseVersion" => $this->getDatabaseVersion()
        ]);
    }

    /**
     * Returns the Twig template engine.
     * @return Environment The Twig template engine.
     */
    private function getTemplateEngine(): Environment
    {
        $loader = new FilesystemLoader("dashboard/views");
        return new Environment($loader);
    }

    /**
     * Scan a directory and return all entries. Filters out . and .. per default.
     * @param string $directory The directory to scan.
     * @param array $filteredDirectories Directories to filter out (. and .. per default).
     * @return array The entries of the directory.
     */
    private function scanDirectory(string $directory, array $filteredDirectories = ['.', '..']): array
    {
        $directoryContent = scandir($directory);
        $directories = [];
        foreach ($directoryContent as $item) {
            if (is_dir($item) && !in_array($item, $filteredDirectories)) {
                $directories[] = $item;
            }
        }
        natcasesort($directories);
        return $directories;
    }

    /**
     * Returns the server host.
     * @return string The server host.
     */
    private function getServerHost(): string
    {
        return $_SERVER["HTTP_HOST"];
    }

    /**
     * Returns the server protocol.
     * @return string The server protocol.
     */
    private function getServerProtocol(): string
    {
        return $_SERVER["PROTOCOL"] = !empty($_SERVER["HTTPS"]) ? "https" : "http";
    }

    /**
     * Returns the URL of the server.
     * @return string The URL of the server.
     */
    private function getUrl(): string
    {
        $host = $this->getServerHost();
        $protocol = $this->getServerProtocol();
        return $protocol . "://" . $host;
    }

    /**
     * Returns all subdirectories in the webapp directory. Filters out some common unwanted directories.
     * @return array All directories in the webapp directory.
     */
    private function getWebappDirectories(): array
    {
        return $this->scanDirectory($this->webappDirectory, [".", "..", "dashboard", ".idea", ".vscode"]);
    }

    /**
     * Returns the server version.
     * @return string The server version.
     */
    private function getServerVersion(): string
    {
        return apache_get_version();
    }

    /**
     * Returns the PHP version.
     * @return string The PHP version.
     */
    private function getPhpVersion(): string
    {
        return "PHP " . phpversion();
    }

    /**
     * Returns the debugger version.
     * @return string The debugger version.
     */
    private function getDebuggerVersion(): string
    {
        return "Xdebug " . phpversion("xdebug");
    }

    /**
     * Returns the database version.
     * @return string The database version.
     */
    private function getDatabaseVersion(): string
    {
        $charsetAttr = "SET NAMES utf8 COLLATE utf8_general_ci";
        $dsn = "mysql:host=" . self::dbHostInternal . ";dbname=" . self::dbName . ";port=" . self::dbPortInternal;
        $options = [
            PDO::ATTR_PERSISTENT => true,
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_OBJ,
            PDO::MYSQL_ATTR_INIT_COMMAND => $charsetAttr,
            PDO::MYSQL_ATTR_MULTI_STATEMENTS => false
        ];

        try {
            $pdo = new PDO($dsn, self::dbUser, self::dbPassword, $options);

            // Get the version of the database server
            $version = $pdo->getAttribute(PDO::ATTR_SERVER_VERSION);

            // This results in something like "11.2.2-MariaDB-1:11.2.2+maria~ubu2204"
            // We only want the version number, so we use a regular expression to extract it
            if (preg_match('/\d+\.\d+\.\d+/', $version, $matches)) {
                $version = $matches[0];
            }

            return "MariaDB " . $version;
        } catch (PDOException) {
            return "MariaDB version not available. Check the connection to the database container.";
        }
    }
}

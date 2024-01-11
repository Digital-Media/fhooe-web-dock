<?php

namespace Fhooe\WebDockDashboard;

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
     * @throws RuntimeError
     * @throws SyntaxError
     * @throws LoaderError
     */
    public function display(): void
    {
        $this->twig->display("dashboard.html.twig", [
            "url" => $this->getUrl(),
            "directories" => $this->getWebappDirectories(),
            "webserver" => $this->getServerVersion(),
            "php" => $this->getPhpVersion(),
            "debugger" => $this->getDebuggerVersion()
        ]);
    }

    /**
     * Returns the Twig template engine.
     * @return Environment The Twig template engine.
     */
    private function getTemplateEngine(): Environment
    {
        $loader = new FilesystemLoader("dashboard/views");
        return new Environment($loader, [
            "cache" => "dashboard/cache",
            "auto_reload" => true
        ]);
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
}

<?php

/**
 * Scan a directory and return all entries. Filters out . and .. per default.
 * @param string $directory The directory to scan.
 * @param array $filteredDirectories Directories to filter out (. and .. per default).
 * @return array The entries of the directory.
 */
function scanDirectory(string $directory, array $filteredDirectories = ['.', '..']): array
{
    return array_values(array_diff(scandir($directory), $filteredDirectories));
}

$host = $_SERVER["HTTP_HOST"];
$protocol = $_SERVER["PROTOCOL"] = !empty($_SERVER["HTTPS"]) ? "https" : "http";
$url = $protocol . "://" . $host;

$directories = scanDirectory(".", [".", "..", "dashboard", ".idea"]);
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>fhooe-web-dock | Welcome</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="dashboard/css/bootstrap.min.css">
    <link rel="stylesheet" href="dashboard/font/bootstrap-icons.min.css">
    <style>
        ul#webappDirectory {
            list-style-type: none;
        }
    </style>
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-lg">
            <a class="navbar-brand" href="#">
                <img src="dashboard/images/fhooe.svg" alt="" height="30" class="d-inline-block align-text-top">
                fhooe-web-dock
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.php">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="dashboard/phpinfo.php" target="_blank">PHP Info</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="http://localhost:8082" target="_blank">phpMyAdmin</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
<main>
    <div class="container-lg mt-lg-4">
        <div class="row">
            <h1>fhooe-web-dock</h1>
            <p class="lead">A Docker Environment for Web Development Classes</p>
        </div>
        <div class="row">
            <div class="col-md-8 mb-4">
                <div class="card">
                    <div class="card-header">The <code>webapp</code> Directory</div>
                    <div class="card-body">
                        <h5 class="card-title"><code>webapp</code>: The Place for Your Files</h5>
                        <p class="card-text">To develop and deploy your web applications, create them in or copy them to
                            the <code>webapp</code> folder on your host machine. They will be instantly available
                            through the web server at <a href="<?= $url ?>"><?= $url ?></a>. E.g., <code>webapp/my_example_project/index.php</code>
                            is available at
                            <code><?= $url ?>/my_example_project/index.php</code>.</p>
                        <p class="card-text">These are all the subdirectories within your <code>webapp</code> directory.
                            Clicking a link will take you to it.</p>
                        <ul id="webappDirectory">
                            <?php
                            foreach ($directories as $directory) {
                                if (is_dir($directory)) {
                                    echo "<li><a href=\"$directory\" class=\"icon-link\"><i class=\"bi-folder-fill\"></i>$directory</a></li>";
                                }
                            }
                            ?>
                        </ul>

                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="accordion">
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                Important Information
                            </button>
                        </h2>
                        <div id="collapseOne" class="accordion-collapse collapse show">
                            <div class="accordion-body">
                                <h5>Docker Containers</h5>
                                <ul>
                                    <li><code>webapp</code>: Apache web server with PHP.</li>
                                    <li><code>mariadb</code>: MariaDB database.</li>
                                    <li><code>pma</code>: phpMyAdmin for database management.</li>
                                </ul>
                                <h5>Shell Access</h5>
                                <p>To access the <code>webapp</code> container, open a command prompt, terminal or
                                    Powershell
                                    and type<br><code class="user-select-all">docker exec -it webapp /bin/bash</code>.
                                </p>
                                <h5>Database Access</h5>
                                <p>Use the following credentials to connect to the database. Use the internal parameters
                                    in your web application and the external if you want to connect your IDE to the
                                    database.</p>
                                <ul>
                                    <li>User: <code class="user-select-all">onlineshop</code></li>
                                    <li>Password: <code class="user-select-all">geheim</code></li>
                                </ul>
                                <h6>Internal (from your web application)</h6>
                                <ul>
                                    <li>Host: <code class="user-select-all">db</code></li>
                                    <li>Port: <code class="user-select-all">3306</code></li>
                                </ul>
                                <h6>External (from your IDE)</h6>
                                <ul>
                                    <li>Host: <code class="user-select-all">localhost</code></li>
                                    <li>Port: <code class="user-select-all">6033</code></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                Web server and phpMyAdmin URLs
                            </button>
                        </h2>
                        <div id="collapseThree" class="accordion-collapse collapse">
                            <div class="accordion-body">
                                <p>Both the access to your web server and phpMyAdmin are possible through HTTP or HTTPS.
                                    Using HTTP is usually recommended for development as it does not involve certificate
                                    warnings.</p>
                                <h6>Web server (HTTP)</h6>
                                <p><a href="http://localhost:8080">http://localhost:8080</a></p>
                                <h6>Web server (HTTPS)</h6>
                                <p><a href="https://localhost:7443">https://localhost:7443</a></p>
                                <h6>phpMyAdmin (HTTP)</h6>
                                <p><a href="http://localhost:8082">http://localhost:8082</a></p>
                                <h6>phpMyAdmin (HTTPS)</h6>
                                <p><a href="https://localhost:8443">https://localhost:8443</a></p>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-item">
                        <h2 class="accordion-header">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                PHP Configuration
                            </button>
                        </h2>
                        <div id="collapseTwo" class="accordion-collapse collapse">
                            <div class="accordion-body">
                                <h5>Webserver</h5>
                                <p><?= apache_get_version() ?></p>
                                <h5>PHP</h5>
                                <p>PHP <?= phpversion() ?></p>
                                <h5>Debugger</h5>
                                <p>Xdebug <?= phpversion("xdebug") ?></p>
                                <p class="card-text">To check the full configuration (web server, PHP version,
                                    extensions,
                                    variables, etc.), open the PHP info page.</p>
                                <a href="dashboard/phpinfo.php" class="btn btn-primary" target="_blank">Open PHP
                                    info</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<div class="container-lg">
    <footer class="d-flex flex-wrap justify-content-between align-items-center py-3 my-4 border-top">
        <div class="col-lg-9 d-flex align-items-center">
            <img src="dashboard/images/fhooe.svg" alt="" height="24" class="me-2">
            <span class="text-muted">© FH Oberösterreich | Department of Digital Media</span>
        </div>

        <ul class="nav col-lg-3 justify-content-end list-unstyled d-flex">
            <li class="ms-3"><a class="text-muted" href="https://github.com/Digital-Media/fhooe-webdev"><i
                            class="bi-github"></i></a></li>
        </ul>
    </footer>
</div>
<script src="dashboard/js/bootstrap.bundle.min.js"></script>
</body>
</html>

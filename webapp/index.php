<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Welcome to fhooe-webdev</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="dashboard/css/bootstrap.min.css">
    <link rel="stylesheet" href="dashboard/font/bootstrap-icons.css">
</head>
<body>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-lg">
            <a class="navbar-brand" href="#">
                <img src="dashboard/images/fhooe.svg" alt="" height="30" class="d-inline-block align-text-top">
                fhooe-webdev
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
                        <a class="nav-link active" aria-current="page" href="/webapp" target="_blank">Webapp Folder</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="phpinfo.php" target="_blank">PHP Info</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="http://<?= $_SERVER["SERVER_ADDR"] ?>:81" target="_blank">Dev Host</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/phpmyadmin" target="_blank">phpMyAdmin</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
<main>
    <div class="container-lg mt-lg-4">
        <div class="row">
            <h1>fhooe-webdev</h1>
            <p class="lead">A Vagrantfile and Vagrant Box for Web Development Classes</p>
        </div>
        <div class="row">
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">The <code>webapp</code> Directory</div>
                    <div class="card-body">
                        <h5 class="card-title"><code>webapp</code>: The Place for Your Files</h5>
                        <p class="card-text">To develop and deploy your web applications, create them in or copy them to
                            the <code>webapp</code> folder on your host machine. They will be instantly available through
                            the web server at <?= $_SERVER["SERVER_ADDR"] ?>.</p>
                        <p class="card-text">E.g., <code>webapp/my_example_project/index.php</code> is available at
                            <code>https://<?= $_SERVER["SERVER_ADDR"] ?>/webapp/my_example_project/index.php</code>.</p>
                        </ul>
                        <a href="/webapp" class="btn btn-primary" target="_blank">Go to my webapp folder</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">PHP Configuration</div>
                    <div class="card-body">
                        <h5 class="card-title">Check Your Configuration</h5>
                        <p class="card-text">
                            Webserver version: <?= apache_get_version() ?><br>
                            PHP version: <?= phpversion() ?><br>
                            Debugger version: <?= phpversion("xdebug") ?></p>
                        <p class="card-text">To check the full configuration (web server, PHP version, extensions,
                            variables, etc.), open the PHP info page.</p>
                        <a href="phpinfo.php" class="btn btn-primary" target="_blank">Open PHP info</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">Development Host</div>
                    <div class="card-body">
                        <h5 class="card-title">See PHP Error Messages</h5>
                        <p class="card-text">The default configuration of this image redirects to HTTPS and has all the
                            PHP error messages disabled to simulate a production server.</p>
                        <p class="card-text">To develop without HTTPS (thus avoiding the certificate warning) and with
                            PHP error message enabled, open the pages with HTTP on port 81.</p>
                        <p class="card-text">E.g., <code>http://<?= $_SERVER["SERVER_ADDR"] ?>:81</code> for the
                            dashboard or <code>http://<?= $_SERVER["SERVER_ADDR"] ?>:81/webapp</code>
                            for the webapp directory.</p>
                        <a href="http://<?= $_SERVER["SERVER_ADDR"] ?>:81" class="btn btn-primary" target="_blank">Open
                            the dev host</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">Database Management</div>
                    <div class="card-body">
                        <h5 class="card-title">phpMyAdmin</h5>
                        <p class="card-text">Use the phpMyAdmin web interface to manage your MariaDB (MySQL)
                            databases.</p>
                        <p class="card-text">The login information is provided below on this page.</p>
                        <a href="/phpmyadmin" class="btn btn-primary" target="_blank">Open phpMyAdmin</a>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">SSH Access</div>
                    <div class="card-body">
                        <h5 class="card-title">Access Your Server via SSH</h5>
                        <p class="card-text">To access your server, select the command prompt, terminal or Powershell
                            that you used to start your Vagrant box and type <code>vagrant ssh</code>.</p>
                        <p class="card-text">Should the automatic login not work, use the provided login details on this
                            page.</p>
                        <p class="card-text">The directory <code>/vagrant</code> mirrors the folder with the Vagrantfile
                            on your host system. Therefore, <code>/vagrant/webapp</code> is the location of the webapp
                            folder.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6 mb-4">
                <div class="card">
                    <div class="card-header">Important Credentials</div>
                    <div class="card-body">
                        <h5 class="card-title">Usernames and Passwords</h5>
                        <p class="card-text">These are the usernames and passwords you need when working with
                            fhooe-webdev.</p>
                    </div>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item">Vagrant SSH: <code>vagrant</code> / <code>vagrant</code></li>
                        <li class="list-group-item">Database: <code>onlineshop</code> / <code>geheim</code></li>
                    </ul>
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
<script src="dashboard/js/bootstrap.js"></script>
</body>
</html>

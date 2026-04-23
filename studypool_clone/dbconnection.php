<?php
// dbconnection.php
// Uses environment variables (Docker) with fallback to local defaults (XAMPP)
$servername = getenv('DB_HOST') ?: "localhost";
$port = getenv('DB_PORT') ?: "3306";
$username = getenv('DB_USER') ?: "root";
$password = getenv('DB_PASSWORD') ?: "root_password";
$dbname = getenv('DB_NAME') ?: "studypool_clone";

$conn = new mysqli($servername, $username, $password, $dbname, (int)$port);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
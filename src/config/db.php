<?php
// Database configuration for SmartTax
// MariaDB connection settings

define('DB_HOST', getenv('DB_HOST') ?: 'localhost');
define('DB_PORT', getenv('DB_PORT') ?: 3306);
define('DB_NAME', getenv('DB_DATABASE') ?: 'smarttax');
define('DB_USER', getenv('DB_USERNAME') ?: 'smarttax_user');
define('DB_PASS', getenv('DB_PASSWORD') ?: 'smarttax_pass');

/**
 * Connect to MariaDB database
 * @return mysqli|false Connection object or false on error
 */
function connectDB() {
    $conn = new mysqli(DB_HOST, DB_USER, DB_PASS, DB_NAME, DB_PORT);
    
    if ($conn->connect_error) {
        return false;
    }
    
    $conn->set_charset("utf8mb4");
    return $conn;
}

/**
 * Get database status
 * @return array Database info array
 */
function getDatabaseInfo() {
    $conn = connectDB();
    
    if (!$conn) {
        return [
            'status' => 'error',
            'message' => 'Failed to connect to database'
        ];
    }
    
    $info = [
        'status' => 'connected',
        'host' => DB_HOST,
        'database' => DB_NAME,
        'version' => $conn->server_info,
        'user' => DB_USER
    ];
    
    $conn->close();
    return $info;
}

/**
 * Get list of tables in the database
 * @return array List of tables
 */
function getTables() {
    $conn = connectDB();
    
    if (!$conn) {
        return [];
    }
    
    $result = $conn->query("SHOW TABLES FROM " . DB_NAME);
    $tables = [];
    
    while ($row = $result->fetch_array()) {
        $tables[] = $row[0];
    }
    
    $conn->close();
    return $tables;
}
?>

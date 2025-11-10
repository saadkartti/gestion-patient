<?php
// Fichier: config.php (Version épurée)

require_once __DIR__ . '/vendor/autoload.php';

// --- Configuration de la base de données ---
define('DB_HOST', 'localhost');
define('DB_USER', 'root');
define('DB_PASS', '');
define('DB_NAME', 'medicore_db');
define('DB_PORT', '3306'); 

// --- Connexion à la base de données ---
try {
    $dsn = "mysql:host=" . DB_HOST . ";port=" . DB_PORT . ";dbname=" . DB_NAME . ";charset=utf8mb4";
    $options = [
        PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    ];
    $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
} catch (PDOException $e) {
    
    die("ERREUR: Impossible de se connecter à la base de données. " . $e->getMessage());
}

// --- Configuration de Smarty ---

$smarty = new Smarty\Smarty();

$smarty->setTemplateDir(__DIR__ . '/templates/');
$smarty->setCompileDir(__DIR__ . '/templates_c/');
$smarty->setCacheDir(__DIR__ . '/cache/');
$smarty->setConfigDir(__DIR__ . '/configs/');


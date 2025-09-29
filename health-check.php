<?php
header('Content-Type: application/json');

$health = [
    'status' => 'healthy',
    'timestamp' => date('Y-m-d H:i:s'),
    'version' => '1.0',
    'environment' => $_ENV['APP_ENV'] ?? 'development'
];

// Verificar que la clase Calculator esté disponible
if (class_exists('Calculator')) {
    $calc = new Calculator();
    $testResult = $calc->add(2, 3);
    $health['calculator_test'] = ($testResult === 5) ? 'pass' : 'fail';
} else {
    $health['calculator_test'] = 'class_not_found';
}

http_response_code(200);
echo json_encode($health, JSON_PRETTY_PRINT);
?>

<?php
class Calculator {
    public function add($a, $b) {
        return $a + $b;
    }
}

$calculator = new Calculator();
$result = null;
$error = null;

if ($_POST['num1'] ?? false && $_POST['num2'] ?? false) {
    $num1 = filter_var($_POST['num1'], FILTER_VALIDATE_INT);
    $num2 = filter_var($_POST['num2'], FILTER_VALIDATE_INT);
    
    if ($num1 !== false && $num2 !== false) {
        $result = $calculator->add($num1, $num2);
    } else {
        $error = "Por favor ingrese números enteros válidos";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PHP Demo - Calculadora</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 600px; margin: 50px auto; padding: 20px; }
        .container { background: #f5f5f5; padding: 30px; border-radius: 8px; }
        input[type="number"] { width: 100px; padding: 8px; margin: 5px; }
        button { background: #007cba; color: white; padding: 10px 20px; border: none; border-radius: 4px; cursor: pointer; }
        button:hover { background: #005a87; }
        .result { background: #d4edda; color: #155724; padding: 15px; margin: 15px 0; border-radius: 4px; }
        .error { background: #f8d7da; color: #721c24; padding: 15px; margin: 15px 0; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>PHP Demo - Calculadora Simple</h1>
        <p>Ingrese dos números enteros para sumarlos:</p>
        
        <form method="POST">
            <input type="number" name="num1" placeholder="Primer número" value="<?= $_POST['num1'] ?? '' ?>" required>
            +
            <input type="number" name="num2" placeholder="Segundo número" value="<?= $_POST['num2'] ?? '' ?>" required>
            <button type="submit">Calcular</button>
        </form>
        
        <?php if ($result !== null): ?>
            <div class="result">
                <strong>Resultado:</strong> <?= htmlspecialchars($_POST['num1']) ?> + <?= htmlspecialchars($_POST['num2']) ?> = <?= $result ?>
            </div>
        <?php endif; ?>
        
        <?php if ($error): ?>
            <div class="error">
                <strong>Error:</strong> <?= $error ?>
            </div>
        <?php endif; ?>
        
        <hr>
        <p><small>Environment: <?= $_ENV['APP_ENV'] ?? 'development' ?> | Version: 1.0</small></p>
    </div>
</body>
</html>

# PHP Demo - Calculadora Simple

Proyecto de demostración para pipeline CI/CD con AWS CodePipeline, CodeBuild y CodeDeploy.

## Descripción

Aplicación web simple en PHP que permite sumar dos números enteros, diseñada para demostrar:
- Desarrollo con PHP 8.x
- Tests unitarios con PHPUnit
- CI/CD automatizado con AWS
- Deployment con CodeDeploy

## Estructura del Proyecto

```
php-demo/
├── src/
│   └── Calculator.php          # Clase principal de la calculadora
├── tests/
│   └── CalculatorTest.php      # Tests unitarios
├── scripts/
│   ├── install_dependencies.sh # Instalación de dependencias
│   ├── start_application.sh    # Inicio de servicios
│   ├── stop_application.sh     # Parada de servicios
│   └── validate_service.sh     # Validación post-deployment
├── index.php                   # Página principal
├── health-check.php            # Endpoint de health check
├── composer.json               # Dependencias PHP
├── phpunit.xml                 # Configuración de tests
├── buildspec.yml               # Configuración CodeBuild
└── appspec.yml                 # Configuración CodeDeploy
```

## Funcionalidades

### Calculadora Web
- Interfaz simple para sumar dos números enteros
- Validación de entrada
- Manejo de errores
- Responsive design

### Health Check
- Endpoint `/health-check.php` para validaciones
- Retorna JSON con estado de la aplicación
- Incluye test básico de funcionalidad

### Tests Unitarios
- Test de suma: `3 + 2 = 5`
- Test con números negativos
- Test con cero
- Tests adicionales para resta y multiplicación

## Desarrollo Local

### Requisitos
- PHP 8.0+
- Composer

### Instalación
```bash
composer install
```

### Ejecutar Tests
```bash
# Tests básicos
composer test

# Tests con coverage
composer test-coverage
```

### Servidor Local
```bash
php -S localhost:8000
```

Acceder a: http://localhost:8000

## CI/CD Pipeline

### Build (CodeBuild)
1. Instalación de PHP 8.2 y Composer
2. Instalación de dependencias
3. Validación de sintaxis PHP
4. Ejecución de tests unitarios
5. Preparación de artifacts

### Deploy (CodeDeploy)
1. Parada de servicios
2. Instalación de dependencias de producción
3. Configuración de permisos
4. Inicio de servicios (Apache + PHP-FPM)
5. Validación de deployment

### Validaciones
- Health check endpoint
- Test de conectividad HTTP
- Verificación de servicios

## Endpoints

- `/` - Calculadora principal
- `/health-check.php` - Health check (JSON)

## Tests Incluidos

```php
testAddTwoPositiveNumbers()     // 3 + 2 = 5
testAddPositiveAndNegativeNumbers() // 10 + (-3) = 7
testAddTwoNegativeNumbers()     // (-5) + (-3) = -8
testAddZero()                   // 5 + 0 = 5
```

## Configuración AWS

Ver `especificaciones-tecnicas-php-demo.md` para detalles completos de:
- Infraestructura requerida
- Configuración de servicios
- Roles y permisos IAM
- Pipeline CI/CD

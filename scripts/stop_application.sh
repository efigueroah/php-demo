#!/bin/bash

echo "Stopping Apache and PHP-FPM services..."

# Stop services gracefully
systemctl stop httpd || echo "Apache was not running"
systemctl stop php-fpm || echo "PHP-FPM was not running"

echo "Services stopped"

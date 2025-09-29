#!/bin/bash
set -e

echo "Starting Apache and PHP-FPM services..."

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Start and enable PHP-FPM
systemctl start php-fpm
systemctl enable php-fpm

# Verify services are running
if systemctl is-active --quiet httpd && systemctl is-active --quiet php-fpm; then
    echo "Services started successfully"
else
    echo "Error: Services failed to start"
    exit 1
fi

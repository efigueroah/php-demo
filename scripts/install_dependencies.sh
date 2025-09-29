#!/bin/bash
set -e

echo "Installing PHP dependencies..."
cd /var/www/html

# Install Composer if not present
if ! command -v composer &> /dev/null; then
    curl -sS https://getcomposer.org/installer | php
    mv composer.phar /usr/local/bin/composer
    chmod +x /usr/local/bin/composer
fi

# Install production dependencies
composer install --no-dev --optimize-autoloader --no-interaction

# Set proper permissions
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

echo "Dependencies installed successfully"

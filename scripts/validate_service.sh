#!/bin/bash
set -e

echo "Validating application deployment..."

# Wait for services to be ready
sleep 10

# Test health check endpoint
echo "Testing health check endpoint..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/health-check.php)

if [ "$response" = "200" ]; then
    echo "Health check passed (HTTP $response)"
else
    echo "Health check failed (HTTP $response)"
    exit 1
fi

# Test main application
echo "Testing main application..."
response=$(curl -s -o /dev/null -w "%{http_code}" http://localhost/index.php)

if [ "$response" = "200" ]; then
    echo "Main application test passed (HTTP $response)"
else
    echo "Main application test failed (HTTP $response)"
    exit 1
fi

echo "All validation tests passed successfully"

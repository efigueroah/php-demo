#!/bin/bash
# User Data Script para instancia EC2 PHP Demo
# Instala PHP, Apache, PHP-FPM y CodeDeploy Agent

# Actualizar sistema
yum update -y

# Instalar Apache
yum install -y httpd

# Instalar PHP 8.2 y extensiones
amazon-linux-extras enable php8.2
yum install -y php php-fpm php-cli php-json php-mbstring php-xml php-zip php-curl

# Instalar Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# Configurar Apache para PHP-FPM
cat > /etc/httpd/conf.d/php-fpm.conf << 'EOF'
<FilesMatch \.php$>
    SetHandler "proxy:unix:/var/run/php-fpm/www.sock|fcgi://localhost"
</FilesMatch>
EOF

# Configurar PHP-FPM
sed -i 's/user = apache/user = apache/' /etc/php-fpm.d/www.conf
sed -i 's/group = apache/group = apache/' /etc/php-fpm.d/www.conf
sed -i 's/listen.owner = nobody/listen.owner = apache/' /etc/php-fpm.d/www.conf
sed -i 's/listen.group = nobody/listen.group = apache/' /etc/php-fpm.d/www.conf

# Crear directorio web y configurar permisos
mkdir -p /var/www/html
chown -R apache:apache /var/www/html
chmod -R 755 /var/www/html

# Crear pagina de prueba inicial
cat > /var/www/html/index.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>PHP Demo - Servidor Listo</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; }
        .status { background: #d4edda; color: #155724; padding: 15px; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Servidor PHP Demo</h1>
        <div class="status">
            <h3>Servidor configurado correctamente</h3>
            <p>Apache, PHP 8.2 y PHP-FPM instalados</p>
            <p>Esperando deployment de la aplicacion...</p>
        </div>
        <hr>
        <p><small>Instancia: <?php echo gethostname(); ?></small></p>
    </div>
</body>
</html>
EOF

# Instalar CodeDeploy Agent
yum install -y ruby wget
cd /home/ec2-user
wget https://aws-codedeploy-us-east-2.s3.us-east-2.amazonaws.com/latest/install
chmod +x ./install
./install auto

# Instalar CloudWatch Agent
yum install -y amazon-cloudwatch-agent

# Configurar CloudWatch Agent
cat > /opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json << 'EOF'
{
    "logs": {
        "logs_collected": {
            "files": {
                "collect_list": [
                    {
                        "file_path": "/var/log/httpd/access_log",
                        "log_group_name": "/aws/ec2/php-demo-dev/apache",
                        "log_stream_name": "{instance_id}/access.log"
                    },
                    {
                        "file_path": "/var/log/httpd/error_log",
                        "log_group_name": "/aws/ec2/php-demo-dev/apache",
                        "log_stream_name": "{instance_id}/error.log"
                    },
                    {
                        "file_path": "/var/log/php-fpm/www-error.log",
                        "log_group_name": "/aws/ec2/php-demo-dev/php",
                        "log_stream_name": "{instance_id}/php-fpm.log"
                    }
                ]
            }
        }
    }
}
EOF

# Iniciar servicios
systemctl enable httpd php-fpm codedeploy-agent amazon-cloudwatch-agent
systemctl start httpd php-fpm codedeploy-agent

# Configurar CloudWatch Agent
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c file:/opt/aws/amazon-cloudwatch-agent/etc/amazon-cloudwatch-agent.json \
    -s

# Crear tags para identificación
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
aws ec2 create-tags --region us-east-2 --resources $INSTANCE_ID --tags Key=Name,Value=php-demo-dev-instance Key=Environment,Value=development Key=Project,Value=php-demo

echo "Configuración completada - $(date)" >> /var/log/user-data.log

#!/bin/bash
yum update -y
yum install -y python3 python3-pip git

# Install MySQL client if needed
yum install -y mysql

# Create app directory
mkdir -p /home/ec2-user/fms-app
cd /home/ec2-user/fms-app

# Download app package from S3
aws s3 cp s3://${s3_bucket}/fms-app.zip fms-app.zip

# Unzip
unzip fms-app.zip

# Install dependencies
pip3 install -r requirements.txt

# Create systemd service
cat <<EOF >/etc/systemd/system/fms.service
[Unit]
Description=Freshers Management
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/home/ec2-user/fms-app
ExecStart=/usr/local/bin/gunicorn --workers 3 --bind 0.0.0.0:5000 application:application
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Start + enable
systemctl daemon-reload
systemctl start fms
systemctl enable fms

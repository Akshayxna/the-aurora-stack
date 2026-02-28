#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2 git

# Start and enable Apache
sudo systemctl start apache2
sudo systemctl enable apache2

# Grab a professional template
cd /var/www/html
sudo rm index.html
sudo git clone https://github.com/startbootstrap/startbootstrap-coming-soon.git .

# Add a small label so we know which server is talking to us
echo "<p>Provisioned by Terraform | Served from: $(hostname -f)</p>" >> index.html
#!/bin/bash
# Update and install Apache on Ubuntu
apt-get update -y
apt-get install -y apache2
systemctl start apache2
systemctl enable apache2

# Get Instance ID and AZ for display
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create a professional landing page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Portfolio | Cloud Infrastructure</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #121212; color: #e0e0e0; font-family: 'Inter', sans-serif; }
        .hero { height: 100vh; display: flex; align-items: center; justify-content: center; background: linear-gradient(45deg, #1a1a1a 30%, #2c3e50 100%); }
        .card { background: #1e1e1e; border: 1px solid #333; color: white; border-radius: 15px; }
        .status-dot { height: 10px; width: 10px; background-color: #2ecc71; border-radius: 50%; display: inline-block; margin-right: 5px; }
    </style>
</head>
<body>
    <div class="hero">
        <div class="container text-center">
            <h1 class="display-3 fw-bold mb-4">Cloud Portfolio Stack</h1>
            <p class="lead mb-5">A 3-Tier AWS Architecture deployed via Terraform.</p>
            
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card p-4 shadow-lg">
                        <h5 class="text-uppercase text-secondary mb-3">System Deployment Info</h5>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Status:</span>
                            <span><span class="status-dot"></span> Live</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Instance ID:</span>
                            <code class="text-info">$INSTANCE_ID</code>
                        </div>
                        <div class="d-flex justify-content-between">
                            <span>Availability Zone:</span>
                            <code class="text-warning">$AZ</code>
                        </div>
                        <hr>
                        <p class="small text-muted mb-0">Connected to RDS MySQL Database</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
EOF
# AWS 3-Tier Aurora Stack 🚀

An automated, highly available infrastructure-as-code project deploying a professional portfolio stack.

## 🏗️ Architecture Overview
* **Networking:** Custom VPC with Public/Private Subnets across multiple Availability Zones.
* **Compute:** Ubuntu EC2 instances running Apache2, provisioned via Terraform User Data.
* **Load Balancing:** Application Load Balancer (ALB) acting as the entry point.
* **Database:** (Work in Progress/Complete) Amazon Aurora/RDS MySQL cluster in isolated private subnets.

## 🛠️ Tech Stack
* **IaC:** Terraform
* **Cloud:** AWS
* **OS:** Ubuntu 24.04 LTS
* **Web Server:** Apache (HTTPD)

## 📸 Deployment Highlights
[Insert your "Live" Page Screenshot here]
[Insert your "Healthy Targets" Screenshot here]

## 🚀 How to Run
1. Initialize Terraform: `terraform init`
2. Plan the deployment: `terraform plan`
3. Apply changes: `terraform apply`
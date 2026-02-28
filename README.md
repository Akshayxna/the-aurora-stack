🚀 Project Overview
The goal of this project was to move away from insecure, long-lived AWS Access Keys and implement a Keyless Authentication flow using OpenID Connect (OIDC).

Key Features:
Infrastructure-as-Code: Automated provisioning of VPC, Subnets, and EC2 instances.

Secure Auth: Used GitHub's OIDC provider to assume AWS IAM Roles dynamically.

CI/CD Pipeline: Automated terraform plan on every push to the main branch.

Modular Design: Reusable Terraform modules for VPC and EC2 components.

🛠️ Tech Stack
Cloud: AWS (VPC, EC2, IAM, S3 for Backend)

IaC: Terraform

Automation: GitHub Actions

Security: OpenID Connect (OIDC)

🛡️ Security Implementation (OIDC)
Instead of storing AWS_ACCESS_KEY_ID in GitHub Secrets, this project utilizes a Trust Relationship between GitHub and AWS.

GitHub issues a temporary JWT token.

AWS validates the token against the configured Identity Provider.

The GitHub Runner assumes a specific IAM Role with least-privilege permissions.

📈 How to Run
Configure the AWS_ROLE_ARN in your GitHub Repository Secrets.

Push changes to the main branch.

Monitor the progress in the Actions tab.
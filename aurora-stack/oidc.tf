# Fetch the TLS certificate from GitHub to get the thumbprint dynamically

data "tls_certificate" "github" {
  url = "https://token.actions.githubusercontent.com/.well-known/openid-configuration"
}



# Create OIDC provider:

resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github.certificates[0].sha1_fingerprint]
}

# Creating IAM role

resource "aws_iam_role" "github_actions_role" {
  name = "github_actions_automation_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    
    Version: "2012-10-17",
    Statement: [
        {
            Effect: "Allow",
            Principal: {
                Federated: aws_iam_openid_connect_provider.github.arn
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            Condition: {
                StringLike: {
                    "token.actions.githubusercontent.com:sub": "repo:Akshayxna/the-aurora-stack:*"
                },
                StringEquals: {
                    "token.actions.githubusercontent.com:aud": "sts.amazonaws.com"
                }
        }
      }
    ]
  })
}

#  Give the Role permission to manage AWS

resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

#  Output the Role ARN (You'll need this for the GitHub YAML file)

output "github_actions_role_arn" {
  value = aws_iam_role.github_actions_role.arn
}
output "final_alb_url" {
  value = "http://${module.ec2.alb_dns_name}"
  description = "The public URL of the portfolio website"
}
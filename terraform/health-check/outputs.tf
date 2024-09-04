# outputs.tf

output "public_ip" {
  value       = aws_instance.demo_server.public_ip
  description = "Displays the Public IP of an ec2 instance"

}
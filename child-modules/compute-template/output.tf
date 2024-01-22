
# Output the id of the ec2 template
output "ec2-template" {
    value = aws_launch_template.template.id
}
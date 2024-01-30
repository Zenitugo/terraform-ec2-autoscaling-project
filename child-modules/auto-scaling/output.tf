# Output the id of the autoscaling group

output "autoscaling" {
    value = aws_autoscaling_group.ec2-autoscale.id
}


# Output the name of the autoscale group
output "scaling" {
  value = aws_autoscaling_group.ec2-autoscale.*.name
}

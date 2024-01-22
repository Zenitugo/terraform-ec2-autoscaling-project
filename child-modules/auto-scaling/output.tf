# output the id of the autoscaling group

output "autoscaling" {
    value = aws_autoscaling_group.ec2-autoscale.id
}

output "scaling" {
  value = aws_autoscaling_group.ec2-autoscale.*.name
}
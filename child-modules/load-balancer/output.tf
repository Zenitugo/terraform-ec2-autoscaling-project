
# Output the value of the application load balancer
output "alb" {
    value = aws_lb.ec2-lb.arn
}


# Output the dns name of the application load balancer
output "alb-dns-name" {
    value = aws_lb.ec2-lb.dns_name
}

# Output the zone id of the application load balancer
output "alb-zone-id" {
    value = aws_lb.ec2-lb.zone_id
}

# Output the value of the target group

output "alb-tg" {
    value = aws_lb_target_group.ec2-tg.arn
}

# Output alb security group id
output "alb-sg"{
    value = aws_security_group.alb-sg.id
}
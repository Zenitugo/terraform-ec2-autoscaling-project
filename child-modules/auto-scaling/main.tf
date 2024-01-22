
# Create autoscaling group for ec2 private servers

resource "aws_autoscaling_group" "ec2-autoscale" {
    name = "ec2-autoscale"
    vpc_zone_identifier = [var.private-subnet-a, var.private-subnet-b] 
    desired_capacity = var.desired_capacity
    max_size = var.max_size
    min_size = var.min_size

    launch_template {
      id      = var.ec2-template
      version = "$Default"
    }    
}







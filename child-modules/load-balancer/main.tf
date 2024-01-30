
# Create an application load balancer for the private servers
resource "aws_lb" "ec2-lb" {
    name               = var.name
    internal           = false
    load_balancer_type = var.elb_type
    subnets            = [var.public-subnet-a, var.public-subnet-b]
    security_groups    = [aws_security_group.alb-sg.id]
    

    

  tags = {
    Environment = var.environment
  }
}


################################################################################################################################
################################################################################################################################

# Create an alb security group

resource "aws_security_group" "alb-sg" {
    vpc_id      = var.vpc_id

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
 

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "alb-sg"
    }
}


#######################################################################################################################################
#######################################################################################################################################

# Create a target group
resource "aws_lb_target_group" "ec2-tg" {
    name          = "ec2-target-group"
    target_type   = var.target_type
    port          = 80
    protocol      = "HTTP"
    vpc_id        = var.vpc_id
}

#######################################################################################################################################
#######################################################################################################################################

# Create a target group attachement with your autoscaling group
# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "attachment" {
  autoscaling_group_name = var.autoscaling
  lb_target_group_arn    = aws_lb_target_group.ec2-tg.arn
}


#####################################################################################################################################
#####################################################################################################################################

# Create a listener for the target group 
resource "aws_lb_listener" "forward-direction" {
  load_balancer_arn = aws_lb.ec2-lb.arn
  port              = "80"
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ec2-tg.arn
  }
}

###############################################################################################################################################
###############################################################################################################################################



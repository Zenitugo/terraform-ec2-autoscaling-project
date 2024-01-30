

# Create a launch instance template for auto scaling
resource "aws_launch_template" "template" {
  name = "ec2-template"
  image_id = var.image
  instance_type = var.instance_type_template 
  key_name = data.aws_key_pair.key1.key_name
  vpc_security_group_ids = [aws_security_group.template-sg.id]

  user_data = base64encode(file("${path.module}/script.sh")) 
}

###########################################################################################################################
##########################################################################################################################

# Create Security groups for ec2 template

resource "aws_security_group" "template-sg" {
    vpc_id      = var.vpc_id
 
    ingress {
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    ingress {
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        security_groups = [var.alb-sg]
    }

    
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    tags = {
        Name = "ec2-sg"
    }
}
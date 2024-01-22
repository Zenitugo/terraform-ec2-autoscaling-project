
# Create a bastion server to make it possible to ssh into the private servers
resource "aws_instance" "bastion" {
    ami                             = var.ami
    instance_type                   = var.instance_type
    key_name                        = data.aws_key_pair.key.key_name
    subnet_id                       = var.bastion-subnet
    vpc_security_group_ids          = [aws_security_group.bastion-sg.id]

    tags = {
        Name = "bastion-server"
    }

    user_data = base64encode(file("${path.module}/file.sh"))
     
}

#########################################################################################################################################################
#########################################################################################################################################################

# Create security group for ec2 instance
resource "aws_security_group" "bastion-sg" {
    vpc_id      = var.vpc_id
 

    ingress {
        from_port        = 22
        to_port          = 22
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
        Name = "bastion-sg"
    }
}


################################################################################################################
#################################################################################################################

# Execute ansible playbook
resource "null_resource" "ansible-files" {
  provisioner "file" {
    source = "${path.module}/ansible/hosts.ini"
    destination = "/home/ubuntu/hosts.ini"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/key-folder/my-keys.pem")
      host     = aws_instance.bastion.private_ip
      bastion_host = aws_instance.bastion.public_ip
    }
  }


  provisioner "file" {
    source = "${path.module}/ansible/ansible.cfg"
    destination = "/home/ubuntu/ansible.cfg"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/key-folder/my-keys.pem")
      host     = aws_instance.bastion.private_ip
      bastion_host = aws_instance.bastion.public_ip
    }
  }


  provisioner "file" {
    source = "${path.module}/ansible/playbook.yml"
    destination = "/home/ubuntu/playbook.yml"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/key-folder/my-keys.pem")
      host     = aws_instance.bastion.private_ip
      bastion_host = aws_instance.bastion.public_ip
    }
  }


  provisioner "file" {
    source = "${path.module}/key-folder/my-keys.pem"
    destination = "/home/ubuntu/.ssh/my-keys.pem"

    connection {
      type     = "ssh"
      user     = "ubuntu"
      private_key = file("${path.module}/key-folder/my-keys.pem")
      host     = aws_instance.bastion.private_ip
      bastion_host = aws_instance.bastion.public_ip
    }
  }

  triggers = {
    bastion_ip = aws_instance.bastion.private_ip
  }

  depends_on = [aws_instance.bastion, 
    var.scaling]
    
}



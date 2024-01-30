
# Create VPC 
resource aws_vpc "ec2-vpc" {
    cidr_block = var.cidr_block
    instance_tenancy = "default"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = var.environment
    }
}

##########################################################################################################################################
##########################################################################################################################################

# Create internet gateway
resource "aws_internet_gateway" "ec2-gw" {
  vpc_id = aws_vpc.ec2-vpc.id

  tags = {
    Name = "ec2-internet-gateway"
  }
}

###########################################################################################################################################
###########################################################################################################################################

# Create private subnets
resource "aws_subnet" "private-subnet-a" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.cidr-subnet-a
    availability_zone = data.aws_availability_zones.azs.names[0]

    tags = {
        Name = "private-subnet-a"
    }
}


resource "aws_subnet" "private-subnet-b" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.cidr-subnet-b
    availability_zone = data.aws_availability_zones.azs.names[1]
    tags = {
        Name = "private-subnet-b"
    }
}


############################################################################################################################################
############################################################################################################################################

# Create public subnets
resource "aws_subnet" "public-subnet-a" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.cidr-subnet-c
    availability_zone = data.aws_availability_zones.azs.names[0]
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-a"
    }
}

resource "aws_subnet" "public-subnet-b" {
    vpc_id = aws_vpc.ec2-vpc.id
    cidr_block = var.cidr-subnet-d
    availability_zone = data.aws_availability_zones.azs.names[1]
    map_public_ip_on_launch = true

    tags = {
        Name = "public-subnet-b"
    }
}



###########################################################################################################################################
###########################################################################################################################################

# Create elastip Ips and Nat Gateway
resource "aws_eip" "elastic-ip" {
    domain = var.domain
    associate_with_private_ip  = var.cidr-subnet-c
}


resource "aws_nat_gateway" "ec2-nat-gateway" {
    allocation_id = aws_eip.elastic-ip.allocation_id
    connectivity_type = "public"
    subnet_id = aws_subnet.public-subnet-a.id
}


################################################################################################################################################
###############################################################################################################################################

# Create public route tables
resource "aws_route_table" "public-rt" {
    vpc_id = aws_vpc.ec2-vpc.id

    tags = {
        Name = "ec2-route-table"
    }
}


# Create private route tables
resource "aws_route_table" "private-rt" {
    vpc_id = aws_vpc.ec2-vpc.id

    tags = {
        Name = "ec2-route-table"
    }
}

################################################################################################################################################
################################################################################################################################################

# Associate public subnets to the route tables
resource "aws_route_table_association" "public-rt" {
    subnet_id = aws_subnet.public-subnet-a.id
    route_table_id = aws_route_table.public-rt.id

}

resource "aws_route_table_association" "public-rt-b" {
    subnet_id = aws_subnet.public-subnet-b.id
    route_table_id = aws_route_table.public-rt.id

}


###############################################################################################################################################
###############################################################################################################################################

# Associate private subnets to the route tables
resource "aws_route_table_association" "private-rt" {
    subnet_id = aws_subnet.private-subnet-a.id 
    route_table_id = aws_route_table.private-rt.id 
}

resource "aws_route_table_association" "private-rt-b" {
    subnet_id = aws_subnet.private-subnet-b.id 
    route_table_id = aws_route_table.private-rt.id 
}


#############################################################################################################################################
#############################################################################################################################################

# Edit routes of the public subnet
resource "aws_route" "public" {
    route_table_id = aws_route_table.public-rt.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2-gw.id
}


# Edit routes of the private subnet
resource "aws_route" "private" {
    route_table_id = aws_route_table.private-rt.id
    destination_cidr_block = "0.0.0.0/0" 
   
    # Route all traffic from the private network to the NAT Gateway in the public network
    nat_gateway_id = aws_nat_gateway.ec2-nat-gateway.id
}








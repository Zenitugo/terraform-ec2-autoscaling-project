# Output public-subnet-a id that will be used by the bastion server
output "bastion-subnet" {
    value = aws_subnet.public-subnet-a.id
}

#################################################################################################
#################################################################################################

# Output the id of VPC
output "vpc_id" {
    value = aws_vpc.ec2-vpc.id
}

#################################################################################################
################################################################################################

# Output the subnet ids of the private servers in the two avaiability zones
output "private-subnet-a" {
    value = aws_subnet.private-subnet-a.id
}

output "private-subnet-b" {
    value = aws_subnet.private-subnet-b.id
}

######################################################################################################
####################################################################################################

# Output the two availability zones
output "availability-zone-a" {
    value = data.aws_availability_zones.azs.names[0]
}

output "availability-zone-b" {
    value = data.aws_availability_zones.azs.names[1]
}


########################################################################################################
#########################################################################################################

# Output the oublic subnets
output "public-subnet-a" {
    value = aws_subnet.public-subnet-a.id
}

output "public-subnet-b" {
    value = aws_subnet.public-subnet-b.id
}
resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = "${var.project_name}-vpc"
    } 
}

data "aws_availability_zones" "available" {}
resource "aws_subnet" "public" {
    count = 2
    vpc_id = aws_vpc.vpc.id
    cidr_block = cidrsubnet(var.vpc_cidr, 8, count.index)
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project_name}-public-${count.index}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    
    tags = {
      Name = "${var.project_name}-igw"
    }
  
}

resource "aws_route_table" "rtb" {
    vpc_id = aws_vpc.vpc.id
    tags = {
      Name = "${var.project_name}-rtb"
    }
}

resource "aws_route" "internet_route" {
    route_table_id = aws_route_table.rtb.id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id  
}

resource "aws_route_table_association" "rtb_assoc" {
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.rtb.id
  
}
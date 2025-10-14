<<<<<<< HEAD
# 1 Create VPC
data "aws_availability_zones" "available" {}

=======
# 1️⃣ Create VPC
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "weather-vpc"
  }
}

<<<<<<< HEAD
# 2 Create Internet Gateway
=======
# 2️⃣ Create Internet Gateway
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "weather-gw"
  }
}

<<<<<<< HEAD
# 3 Public subnets
=======
# 3️⃣ Public subnets
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidrs[count.index]
<<<<<<< HEAD
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
=======
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
>>>>>>> 6d9bf85 (delete workflow)

  tags = {
    Name = "public-subnet-${count.index + 1}"
  }
}

<<<<<<< HEAD
# 4 Private subnets
=======
# 4️⃣ Private subnets
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_subnet" "private" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_cidrs[count.index]
<<<<<<< HEAD
  availability_zone       = data.aws_availability_zones.available.names[count.index]
=======
  availability_zone = data.aws_availability_zones.available.names[count.index]
>>>>>>> 6d9bf85 (delete workflow)

  tags = {
    Name = "private-subnet-${count.index + 1}"
  }
}

<<<<<<< HEAD
# 5 Public Route Table
=======
# 5️⃣ Route Table for public subnets
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "public-rt"
  }
}

<<<<<<< HEAD
# 6 Public Route to Internet
=======
# 6️⃣ Route to Internet
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

<<<<<<< HEAD
# 7 Associate public subnets with public route table
=======
# 7️⃣ Associate route table with public subnets
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_route_table_association" "public_assoc" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

<<<<<<< HEAD
# 8 NAT Gateway for private subnets
resource "aws_eip" "nat" {
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "nat-gateway"
  }
}

# 9 Private Route Table
=======
resource "aws_nat_gateway" "nat" {
  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
  
}

>>>>>>> 6d9bf85 (delete workflow)
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private-rt"
  }
}

<<<<<<< HEAD
# 10 Private Route to Internet via NAT
resource "aws_route" "private_nat" {
=======
resource "aws_route" "private_nat_access" {
>>>>>>> 6d9bf85 (delete workflow)
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

<<<<<<< HEAD
# 11 Associate private subnets with private route table
=======
>>>>>>> 6d9bf85 (delete workflow)
resource "aws_route_table_association" "private_assoc" {
  count          = length(aws_subnet.private)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
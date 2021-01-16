#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "UNZER" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "terraform-eks-UNZER-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "UNZER" {
  count = 2

  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.0.${count.index}.0/24"
  vpc_id            = aws_vpc.UNZER.id
  map_public_ip_on_launch = true

  tags = map(
    "Name", "terraform-eks-UNZER-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "UNZER" {
  vpc_id = aws_vpc.UNZER.id

  tags = {
    Name = "terraform-eks-UNZER"
  }
}

resource "aws_route_table" "UNZER" {
  vpc_id = aws_vpc.UNZER.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.UNZER.id
  }
}

resource "aws_route_table_association" "UNZER" {
  count = 2

  subnet_id      = aws_subnet.UNZER.*.id[count.index]
  route_table_id = aws_route_table.UNZER.id
}

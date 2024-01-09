provider "aws" {
  region = var.region
}


# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}



# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge(
    var.tags,
    {
      Name = "VPC-main"
    }
  )

}


# Create public subnets
resource "aws_subnet" "public" {
  count                   = var.preferred-public-subnet-count == null ? length(data.aws_availability_zones.available.names) : var.preferred-public-subnet-count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.pub_cidr, 2, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  tags = merge(
    var.tags,
    {
      Name = format("PublicSubnet-%s", count.index + 1)
    }
  )

}

### Create Private subnets
resource "aws_subnet" "private" {
  count                   = length(var.azs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.priv_cidr, 2, count.index)
  map_public_ip_on_launch = false
  availability_zone       = var.azs[count.index]

  tags = merge(
    var.tags,
    {
      Name = format("PrivateSubnet-%s", count.index + 1)
    }
  )
}


### Internet Gateway
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = format("%s-%s!", aws_vpc.main.id, "IG")
    }
  )
}


### Elastic IP
resource "aws_eip" "nat_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.ig]

  tags = merge(
    var.tags,
    {
      Name = "EIP-NAT"
    },
  )
}

### Nat Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_internet_gateway.ig]

  tags = merge(
    var.tags,
    {
      Name = "Nat-GW"
    },
  )
}





 
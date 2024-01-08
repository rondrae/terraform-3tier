provider "aws" {
  region = var.region
}

# Create VPC
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames

}


# Create public subnets
resource "aws_subnet" "public1" {
  count                   = var.preferred-public-subnet-count == null ? length(data.aws_availability_zones.available.names) : var.preferred-public-subnet-count
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index)
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

}



# Get list of availability zones
data "aws_availability_zones" "available" {
  state = "available"
}
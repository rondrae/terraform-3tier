variable "region" {
  default = "ca-central-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "enable_dns_support" {
  default = "true"
}

variable "enable_dns_hostnames" {
  default = "true"
}

variable "preferred-public-subnet-count" {
  default = null
}

variable "private-subnet-count" {
  default = 4
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "azs" {

}

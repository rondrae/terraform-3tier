variable "region" {
  default = "ca-central-1"
}

variable "vpc_cidr" {
  default = "172.16.0.0/16"
}

variable "pub_cidr" {
  default = "172.16.0.0/22"
}

variable "priv_cidr" {
  default = "172.16.6.0/22"
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

variable "ami" {
 default = "ami-0a19d6b92fc84773e" 
}

variable "keypair" {
  
}

variable "account_no" {
  type = number
}
variable "master-username" {
  
}

variable "master-password" {
  
}

variable "Environment" {
  
}
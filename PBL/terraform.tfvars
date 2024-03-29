region                        = "ca-central-1"
vpc_cidr                      = "172.16.0.0/16"
enable_dns_support            = "true"
enable_dns_hostnames          = "true"
preferred-public-subnet-count = 2
Environment = "development"

tags = {
  Enviroment      = "development"
  Owner-Email     = "xxxxxxxxxxxxx@gmail.com"
  Managed-By      = "Terraform"
  Billing-Account = "1234567890"
}

azs = ["ca-central-1a", "ca-central-1b", "ca-central-1a", "ca-central-1b"]

ami = "ami-0a19d6b92fc84773e"

keypair = "project15"


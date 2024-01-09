## Gets my current public IP

data "http" "my_public_ip" {
  url = "https://ifconfig.co/json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  myIP = jsondecode(data.http.my_public_ip.response_body)
}

output "my_ip_addr" {
  value = "${local.myIP.ip}/32"
}
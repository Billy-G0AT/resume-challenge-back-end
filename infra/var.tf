variable "domain" {
  description = "domain name and domain bucket name"
  type = string
  default = "billy-euceda.com"
}

variable "subdomain" {
  description = "subdomain name and subdomain bucket name"
  type = string
  default = "www.billy-euceda.com"
}

variable "table" {
  description = "visit count dynamodb table"
  type = string
  default = "visit-count-table"
}

variable "function" {
  description = "AWS visit count lambda function"
  type = string
  default = "visit-count-function"
}

variable "api" {
  description = "visit count api name"
  type = string
  default = "visit-count-api"
}




variable "domain" {
  description = "domain name and domain bucket name"
  type        = string
}

variable "subdomain" {
  description = "subdomain name and subdomain bucket name"
  type        = string
}

variable "table" {
  description = "visit count dynamodb table"
  type        = string
}

variable "function" {
  description = "AWS visit count lambda function"
  type        = string
}

variable "api" {
  description = "visit count api name"
  type        = string
}

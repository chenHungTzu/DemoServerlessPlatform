variable "tags" {
  default = {
    "env" : "dev"
    "platform" : "Terraform"
  }
}

variable "table0_name" {
  type    = string
  default = "table0"
}

variable "table1_name" {
  type    = string
  default = "table1"
}

variable "table2_name" {
  type    = string
  default = "table2"
}


variable "ecr_name" {
  type    = string
  default = "divider-ecr"
}

variable "lambda_name" {
  type    = string
  default = "divider-lambda"
}

variable "agw_name" {
  type    = string
  default = "divider-agw"
}


variable "mode" {
  type    = list(string)
  default = ["dev", "stress"]
}

locals {
  timestamp = replace("${timestamp()}", "/[-| |T|Z|:]/", "")
}
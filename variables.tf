variable "aws_producao_ms_elb" {
    type = string
    default = "http://aeb39d768a51740c7a9cbdb1b3532a9a-1278723748.us-east-1.elb.amazonaws.com:5003"
}

variable "aws_pedido_ms_elb" {
    type = string
    default = "http://a54f0054d2c87464ab26f694a4dbdfd2-517519713.us-east-1.elb.amazonaws.com:5001"
}

variable "aws_pagamento_ms_elb" {
    type = string
    default = "http://aeb39d768a51740c7a9cbdb1b3532a9a-1278723748.us-east-1.elb.amazonaws.com:5002"
}

variable "db_username" {
  type = string
  default = "user"
}
variable "db_password" {
  type = string
  default = "password"
}

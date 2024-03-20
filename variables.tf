variable "aws_producao_ms_elb" {
    type = string
    default = "http://a0da96152e54e4a3395b0b19a89b021b-1948155037.us-east-1.elb.amazonaws.com:5003"
}

variable "aws_pedido_ms_elb" {
    type = string
    default = "http://aeae26413971e4f47a23dd42f5993310-2039528636.us-east-1.elb.amazonaws.com:5001"
}

variable "aws_pagamento_ms_elb" {
    type = string
    default = "http://a36cd481c4e2b4d7eaacbbdd39483c0a-1580078662.us-east-1.elb.amazonaws.com:5002"
}

variable "db_username" {
  type = string
  default = "root"
}
variable "db_password" {
  type = string
  default = "challenge_password"
}

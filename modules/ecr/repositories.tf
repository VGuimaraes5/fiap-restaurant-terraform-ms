resource "aws_ecr_repository" "pedido" {
  name                 = "fiap-restaurant-pedido-ms"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags ={
    fiap = "restaurant-ms"
  }
}

resource "aws_ecr_repository" "pagamento" {
  name                 = "fiap-restaurant-pagamento-ms"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    fiap = "restaurant-ms"
  }
}

resource "aws_ecr_repository" "producao" {
  name                 = "fiap-restaurant-producao-ms"
  image_tag_mutability = "MUTABLE"
  force_delete = true
  
  image_scanning_configuration {
    scan_on_push = true
  }

  tags ={
    fiap = "restaurant-ms"
  }
}
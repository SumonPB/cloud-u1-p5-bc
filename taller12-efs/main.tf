#configuracion del proveedor (aws)

provider "aws" {
  region = var.Region #region donde se desplegaran los recursos
}

#Crear Security group 2
resource "aws_security_group" "mi_sg_efs" {
  name        = "mi-sg-efs"
  description = "Security group para la instancia de EFS"
  vpc_id      = "vpc-0d525517771575651"
  #regla entrada para SSH
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Crear Security group 1
resource "aws_security_group" "mi_sg_efs_instancia" {
  name        = "mi-sg-efs-terraform-instancia"
  description = "Security group para la instancia de EFS creada con Terraform"
  vpc_id      = "vpc-0d525517771575651"
  #regla entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #regla salida HTTP
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.mi_sg_efs_instancia.id]
}

}



resource "aws_instance" "mi_instancia_efs" { 
  ami           = var.ami_id  
  instance_type = var.tipo_instancia               
  key_name      = var.nombre_llave  
  security_groups = [aws_security_group.mi_sg_efs.name] 
  count = var.cantidad_instancias
  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}"
  }
  vpc_security_group_ids = [aws_security_group.mi_sg_efs_instancia.id] 
}


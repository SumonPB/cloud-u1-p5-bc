#configuracion del proveedor (aws)

provider "aws" {
  region = var.Region #region donde se desplegaran los recursos
}

#Crear Security group 2
resource "aws_security_group" "mi-sg-efs-14" {
  name        = "mi-sg-efs"
  description = "Security group para la instancia de EFS"
  vpc_id      = "vpc-0d525517771575651"
  #regla entrada para SSH

}

#Crear Security group 1
resource "aws_security_group" "mi-sg-efs-instancia-14" {
  name        = "mi-sg-efs-terraform-instancia"
  description = "Security group para la instancia de EFS creada con Terraform"
  vpc_id      = "vpc-0d525517771575651"
  #regla entrada para SSH

}

#Reglas Entrada SG instancias
#Entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
  security_group_id =   aws_security_group.mi-sg-efs-instancia-14.id
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  cidr_ipv4 = "0.0.0.0/0"
}
#Reglas Salida SG instancia
#salida al 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancia-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  #destino de la regla
  referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
}

#AllTrafic
resource "aws_vpc_security_group_egress_rule" "salida_internet_instancias" {
  security_group_id = aws_security_group.mi-sg-efs-instancia-14.id
  ip_protocol = -1
  #from_port = 0
  #to_port = 0
  cidr_ipv4 = "0.0.0.0/0"
}
#-------------------------------------------
#Reglas entrada ESF
resource "aws_vpc_security_group_ingress_rule" "entrada_efs" {
  security_group_id = aws_security_group.mi-sg-efs-14.id
  ip_protocol = "tcp"
  from_port = 2049
  to_port = 2049
  #origen
  referenced_security_group_id = aws_security_group.mi-sg-efs-instancia-14.id
}
#No requere de reglas de salida



 #resource "aws_instance" "mi_instancia_efs" { 
 # ami           = var.ami_id  
 # instance_type = var.tipo_instancia               
 # key_name      = var.nombre_llave  
 # security_groups = [aws_security_group.mi-sg-efs-14.name] 
 # count = var.cantidad_instancias
 # tags = {
 #   Name = "Mi instancia EFS - ${count.index + 1}"
 # }
 # vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancia-14.id] 
 #}


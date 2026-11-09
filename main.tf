#configuracion del proveedor (aws)

provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

#Crear Security group
resource "aws_security_group" "Security_group_windows" {
  name        = "mi-sg-windows"
  description = "Security group para la instancia de Windows"
  vpc_id      = "vpc-0d525517771575651"
  #regla entrada para SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #regla salida HTTP
  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#declaracion de los recursos a aprovisionar
#Primero se declara la instancia de EC2 que se aprovisionara en AWS, luego de un espacio
#se le declara el nombre de la instancia y se le asigna un AMI y un tipo de instancia, en este caso t2.micro, que es gratuita.
resource "aws_instance" "Instancia_Terraform_Windows" { #dentro de las llaves se declaran todos los atributos de la instancia
  ami           = "ami-0b5f645abc199e666"  #AMI de Amazon Windows Server
  instance_type = "t3.micro"               #tipo de instancia
  key_name      = "mi-primera-llaves-bc"   #par de llaves de cifrado
  tags = {
    Name = "Terraform-Windows-Instance" #nombre de la instancia
  }
  vpc_security_group_ids = [aws_security_group.Security_group_windows.id] #asignacion de sg a la instancia

}

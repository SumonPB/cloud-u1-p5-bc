#configuracion del proveedor (aws)

provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

#Crear Security group
resource "aws_security_group" "mi-sg" {
  name = "mi-security-group-terraform"
  description = "Security Group para instancia Terraform"
  vpc_id = "vpc-0d525517771575651"
  #regla entrada para SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #regla salida HTTP
  egress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

#declaracion de los recursos a aprovisionar
#Primero se declara la instancia de EC2 que se aprovisionara en AWS, luego de un espacio
#se le declara el nombre de la instancia y se le asigna un AMI y un tipo de instancia, en este caso t2.micro, que es gratuita.
resource "aws_instance" "mi_instancia_2" { #dentro de las llaves se declaran todos los atributos de la instancia
  ami           = "ami-0c230065b91270bc6" #AMI de Amazon Linux 2
  instance_type = "t2.micro" #tipo de instancia
  key_name = "mi-primera-llaves-bc" #par de llaves de cifrado
  tags = {
    Name = "MiInstanciaTerraform2"
  }
    vpc_security_group_ids = [aws_security_group.mi-sg.id] #asignacion de sg a la instancia
    
}

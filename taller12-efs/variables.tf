#Region donde se desplegaran los recursos de AWS
variable "Region" {
  description = "The AWS region"
  type = string
  default = "us-east-1"
}

variable "ami_id" {
  description = "Id de la AMI"
  type = string
  default = "ami-00f43ee0e98d52529" 
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type = string
  default = "t2.micro"
}

variable "nombre_llave" {
  description = "Nombre del par de llaves"
  type = string
  default = "mi-primera-llaves-bc"
}

variable "cantidad_instancias" {
  description = "Cantidad de instancias a crear"
  type = number
  default = 2
}
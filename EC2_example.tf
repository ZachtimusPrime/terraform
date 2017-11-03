variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}

provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "us-east-1"
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.terraform-example.id}"
}

resource "aws_instance" "terraform-example" {
  ami           = "ami-8c1be5f6"
  instance_type = "t2.micro"
  security_groups = ["MyWebDMZ"]
  key_name = "MyEC2KeyPair"

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      user     = "ec2-user"
      private_key = "${file("./ssh/MyEC2KeyPair.pem")}"
    }

    script = "./scripts/webserver_setup.sh"
  }

  tags {
    Name = "terraform-example"
    BUSINESS_REGION = "NORTHAMERICA"
    CLIENT = "NONE"
  }
}
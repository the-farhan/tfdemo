provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAUQFAFHJIYW3AFCGU"
  secret_key = "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"
}

resource "aws_instance" "ec2" {
    ami = "ami-0f34c5ae932e6f0e4"
    instance_type = "t2.micro"
    
    tags  = {
        Name = "ec2"
    }
}

provider "aws" {
    region = "eu-north-1"  # Set your desired AWS region
}

resource "aws_instance" "terraform" {
  ami    = "ami-0705384c0b33c194c"
  instance_type = "t3.micro"
  subnet_id =   "subnet-04a715b143211f00c"
  
}



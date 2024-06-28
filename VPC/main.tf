resource "aws_vpc" "myVPC" {
  cidr_block = var.cidr_block
}


resource "aws_subnet" "subnet1" {
  vpc_id = aws_vpc.myVPC.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = aws_vpc.myVPC.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-north-1a"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVPC.id
  
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.myVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "MainRouteTable"
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.RT.id

}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.RT.id

}


resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.myVPC.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_s3_bucket" "bucket1" {
  bucket = "MY-first-Bucket"
  
}

resource "aws_instance" "EC1" {
  ami = "ami-0705384c0b33c194c"
  instance_type = "t2-micro"
  subnet_id = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.sg.id]
}


resource "aws_instance" "EC2" {
  ami = "ami-0705384c0b33c194c"
  instance_type = "t2-micro"
  subnet_id = aws_subnet.subnet2.id
  vpc_security_group_ids = [aws_security_group.sg.id]
}


resource "aws_lb" "lb" {
  name               = "Application-Load-Balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.subnet1.id,aws_subnet.subnet2.id]
  
}


resource "aws_lb_target_group" "tg" {
  name     = "myTG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.myVPC.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}


resource "aws_lb_target_group_attachment" "tg-a1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.EC1.id
  port             = 80
}


resource "aws_lb_target_group_attachment" "tg-a2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.EC2.id
  port             = 80
}

resource "aws_lb_listener" "alb-listen" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.service_sg.id}"]
  subnets            = ["${data.aws_subnet_ids.example.ids}"]
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.test.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.service_tg.arn}"
  }
}

resource "aws_lb_target_group" "service_tg" {
  name        = "tf-example-lb-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${data.aws_vpc.selected.id}"
  target_type = "ip"

  health_check {
    matcher="200,302,301" 
  }
  depends_on = [
    "aws_lb.test",
  ]
}


resource "aws_security_group" "service_sg" {
  name        = "second sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }

  ingress {
    from_port   = 443
    to_port     = 443
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
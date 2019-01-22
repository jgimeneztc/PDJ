resource "aws_ecr_repository" "test_repository" {
  name = "test_repository"
}

resource "aws_ecs_cluster" "cluster" {
  name = "test-ecs-cluster"
}

resource "aws_ecs_service" "main" {
  name            = "test-service"
  cluster         = "${aws_ecs_cluster.cluster.id}"
  task_definition = "${aws_ecs_task_definition.test.arn}"
  desired_count   = "1"
  launch_type     = "FARGATE"
  # iam_role        = "${aws_iam_role.execution.arn}"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.service_tg.arn}"
    container_name   = "nginx-container"
    container_port   = 80
  }

  network_configuration {
    subnets = ["${data.aws_subnet_ids.example.ids}"]
    security_groups= ["${aws_security_group.container_sg.id}"]
  }

  # depends_on = ["aws_iam_role.pdat-ecs-role","aws_instance.pdat-ecs-instance"]
}

resource "aws_ecs_task_definition" "test" {
  family = "test-ecs-cluster"

  # execution_role_arn = "${aws_iam_role_policy.ecs_service.arn}"

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "2048"
  container_definitions = <<DEFINITION
[
  {
    "cpu": 0,
    "image":"nginx",
    "memory": 128,
    "network_mode" : "awsvpc",
    "name": "nginx-container",
    "portMappings": [
      {
        "containerPort": 80
      }
  ]
  }
]
DEFINITION
}

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

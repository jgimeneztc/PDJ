
resource "aws_ecs_cluster" "cluster" {
  name = "test-ecs-cluster"
}
resource "aws_security_group" "container_sg" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    security_groups= ["${aws_security_group.service_sg.id}" ]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["${data.aws_vpc.selected.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_ecs_service" "main" {
  name            = "test-service"
  cluster         = "${aws_ecs_cluster.cluster.id}"
  task_definition = "${aws_ecs_task_definition.test.arn}"
  desired_count   = "2"
  launch_type     = "FARGATE"

  # iam_role        = "${aws_iam_role.execution.arn}"

  load_balancer {
    target_group_arn = "${aws_lb_target_group.service_tg.arn}"
    container_name   = "nginx-container"
    container_port   = 80
  }
  network_configuration {
    subnets          = ["${data.aws_subnet_ids.example.ids}"]
    security_groups  = ["${aws_security_group.container_sg.id}"]
    assign_public_ip = true
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
  execution_role_arn       = "${aws_iam_role.execution.arn}"
  
  container_definitions = <<DEFINITION
[
  {
    "cpu": 0,
    "image":"922038103956.dkr.ecr.us-east-2.amazonaws.com/wordpress_repo:latest",
    "memory": 128,
    "network_mode" : "awsvpc",
    "name": "nginx-container",
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-region": "us-east-2",
        "awslogs-group": "${aws_cloudwatch_log_group.yada.name}",
        "awslogs-stream-prefix": "complete-ecs"
      }
    },
    "portMappings": [
      {
        "containerPort": 80
      }
    ],
    "mountPoints": [
                {
                    "sourceVolume": "efs",
                    "containerPath": "/var/www/html"
                }
            ]
  
  }
]
DEFINITION
volume {
    name      = "efs"
  }
}




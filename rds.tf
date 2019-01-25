resource "aws_db_instance" "database" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  name                 = "mydb"
  username             = "root"
  password             = "Toortoortoor"
  parameter_group_name = "default.mysql5.7"
  publicly_accessible= true
  vpc_security_group_ids=["${aws_security_group.sg_rds.id}"]
}
# resource "aws_db_security_group" "default" {
#   name = "rds_sg"

#   ingress {
#     security_group_name ="${aws_security_group.container_sg.name}"
#   }
# }



resource "aws_security_group" "sg_rds" {
  name        = "rds sg"
  description = "Allow all inbound traffic"
  vpc_id      = "${data.aws_vpc.selected.id}"

   ingress {
    from_port   = 3306
    to_port     = 3306
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
resource "aws_db_instance" "default" {
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
}
resource "aws_db_security_group" "default" {
  name = "rds_sg"

  ingress {
    cidr = "172.31.0.0/16"
  }
}
output "dns_rds" {
  value = "${aws_db_instance.database.endpoint}"
}
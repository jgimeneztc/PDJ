
resource "aws_cloudwatch_log_group" "yada" {
  name = "Yada"

  tags = {
    Environment = "Test"
    Application = "serviceA"
  }
}
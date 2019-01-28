
resource "aws_cloudwatch_log_group" "yada" {
  name = "Yada"

  tags = {
    Environment = "Test"
    Application = "serviceA"
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_lb_alarm" {
  alarm_name                = "terraform-test-lb"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "HealthyHostCount"
  namespace                 = "AWS/ApplicationELB"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "0"
  alarm_description         = "This metric monitors health of LB"
  insufficient_data_actions = []
}
resource "aws_cloudwatch_metric_alarm" "aws_lb_5xx_alarm" {
  alarm_name                = "terraform-test-HTTPCode_ELB_5XX_Count"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "HTTPCode_ELB_5XX_Count"
  namespace                 = "AWS/ApplicationELB"
  period                    = "120"
  statistic                 = "Average"
  threshold                 = "1"
  alarm_description         = "This metric monitors health of LB"
  insufficient_data_actions = []
}

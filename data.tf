data "aws_vpc" "selected" {
  id = "vpc-953e03fd"
}
data "aws_availability_zones" "available" {}


data "aws_subnet_ids" "example" {
  vpc_id = "${data.aws_vpc.selected.id}"
}

variable "image_version" {
  default="latest"
}

data "aws_ecr_repository" "wordpress" {
  name = "wordpress_repo"
}
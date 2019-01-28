resource "aws_efs_file_system" "ecs_efs" {
    creation_token = "wordpress_efs"


}

resource "aws_efs_mount_target" "ecs_efs_target" {
  file_system_id  = "${aws_efs_file_system.ecs_efs.id}"
  subnet_id       = "${element(data.aws_subnet_ids.example.ids, count.index)}"
  security_groups = ["${aws_security_group.efs-sg.id}"]
}
resource "aws_security_group" "efs-sg" {
  name        = "efs-mnt"
  description = "Allows NFS traffic from instances within the VPC."
  vpc_id      = "${data.aws_vpc.selected.id}"

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.selected.cidr_block}"
    ]
  }

  egress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = [
      "${data.aws_vpc.selected.cidr_block}"
    ]
  }

  tags {
    Name = "allow_nfs-ec2"
  }
}
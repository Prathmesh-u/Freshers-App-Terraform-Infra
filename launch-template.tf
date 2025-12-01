resource "aws_launch_template" "lt" {
  name_prefix   = "fms-lt-"
  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }

  user_data = base64encode(templatefile("${path.module}/user-data.sh", {
    s3_bucket = var.s3_bucket
  }))

  vpc_security_group_ids = [
    aws_security_group.ec2_sg.id
  ]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "fms-ec2"
    }
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

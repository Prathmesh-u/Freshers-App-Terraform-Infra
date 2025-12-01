resource "aws_autoscaling_group" "asg" {
  name                      = "fms-asg"
  desired_capacity          = 2
  max_size                  = 3
  min_size                  = 1
  health_check_type         = "ELB"
  vpc_zone_identifier       = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.tg.arn
  ]

  tag {
    key                 = "Name"
    value               = "fms-asg"
    propagate_at_launch = true
  }
}

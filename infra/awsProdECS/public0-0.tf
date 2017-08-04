# ========================ECS Instances=======================

resource "random_shuffle" "subnets" {
  input = [
    "${var.prod_public_sn_01_id}",
    "${var.prod_public_sn_02_id}" ]
  result_count = 1
}

resource "aws_instance" "prodECSIns" {
  depends_on = [
    "aws_ecs_cluster.prod-aws"]

  count = 3

  # ami = "${var.ecsAmi}"
  ami = "${lookup(var.ecsAmi, var.region)}"
  availability_zone = "${lookup(var.availability_zone, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${random_shuffle.subnets.result}"
  iam_instance_profile = "e2eDemoECSInstProf"
  associate_public_ip_address = true
  source_dest_check = false
  user_data = "#!/bin/bash \n echo ECS_CLUSTER=${aws_ecs_cluster.prod-aws.name} >> /etc/ecs/ecs.config"
  
  vpc_security_group_ids = [
    "${var.prod_public_sg_id}"]

  tags = {
    Name = "prodECSIns${count.index}"
  }
}

# resource "aws_alb" "ecs-prod-alb" {
#   name = "ecs-prod-alb"
#   internal = false
#   security_groups = [
#     "${var.prod_public_sg_id}"]
#   subnets = [ 
#     "${var.prod_public_sn_01_id}",
#     "${var.prod_public_sn_02_id}" ]
#   tags {
#     Environment = "production"
#   }
# 
# resource "aws_alb_target_group" "ecs-prod-tg" {
#   name = "ecs-prod-tg"
#   port = 80
#   protocol = "HTTP"
#   vpc_id = "${var.prod_vpc_id}"
# 
#   tags {
#     Environment = "production"
#   }
# 
# resource "aws_alb_target_group_attachment" "ecs-prod-tga" {
#   name = "ecs-prod-tga"
#   port = 80
#   target_group_arn = "${aws_alb_target_group.ecs-prod-tg.arn}"
#   target_id = 
# 
#   tags {
#     Environment = "production"
#   }
# }

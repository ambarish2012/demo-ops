# ========================ECS Instances=======================

resource "aws_instance" "testECSIns_01" {
  depends_on = [
    "aws_ecs_cluster.test-aws"]

  count = 1

  # ami = "${var.ecsAmi}"
  ami = "${lookup(var.ecsAmi, var.region)}"
  availability_zone = "${lookup(var.availability_zone, var.region)}"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${var.test_public_sn_01_id}"
  iam_instance_profile = "e2eDemoECSInstProf"
  associate_public_ip_address = true
  source_dest_check = false
  user_data = "#!/bin/bash \n echo ECS_CLUSTER=${aws_ecs_cluster.test-aws.name} >> /etc/ecs/ecs.config"
  
  vpc_security_group_ids = [
    "${var.test_public_sg_id}"]

  tags = {
    Name = "testECSIns_01"
  }
}

resource "aws_instance" "testECSIns_02" {
  depends_on = [
    "aws_ecs_cluster.test-aws"]

  count = 1

  # ami = "${var.ecsAmi}"
  ami = "${lookup(var.ecsAmi, var.region)}"
  availability_zone = "us-east-1b"
  instance_type = "t2.micro"
  key_name = "${var.aws_key_name}"
  subnet_id = "${var.test_public_sn_02_id}"
  iam_instance_profile = "e2eDemoECSInstProf"
  associate_public_ip_address = true
  source_dest_check = false
  user_data = "#!/bin/bash \n echo ECS_CLUSTER=${aws_ecs_cluster.test-aws.name} >> /etc/ecs/ecs.config"
  
  vpc_security_group_ids = [
    "${var.test_public_sg_id}"]

  tags = {
    Name = "testECSIns_02"
  }
}

resource "aws_alb" "ecs-test-alb" {
  name = "ecs-test-alb"
  internal = false
  security_groups = [
    "${var.test_public_sg_id}"]
  subnets = [ 
    "${var.test_public_sn_01_id}",
    "${var.test_public_sn_02_id}" ]
  tags {
    Environment = "test"
  }
}

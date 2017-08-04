output "prod_ecs_ins_0_ip" {
  value = "${aws_instance.prodECSIns_01.public_ip}"
}

output "prod_ecs_ins_1_ip" {
  value = "${aws_instance.prodECSIns_02.public_ip}"
}

output "prod_ecs_ins_2_ip" {
  value = "${aws_instance.prodECSIns_03.public_ip}"
}

output "prod_ecs_cluster_id" {
  value = "${aws_ecs_cluster.prod-aws.id}"
}

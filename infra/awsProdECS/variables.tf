# main creds for AWS connection
variable "aws_access_key_id" {
  description = "AWS access key"
}

variable "aws_secret_access_key" {
  description = "AWS secret access key"
}

variable "region" {
  description = "AWS region"
  default = "us-east-1"
}

variable "availability_zone" {
  description = "availability zone used for the demo, based on region"
  default = {
    us-east-1 = "us-east-1a"
  }
}

# AMIs optimized for use with ECS Container Service
# Note: changes occur regularly to the list of recommended AMIs.  Verify at
# http://docs.aws.amazon.com/AmazonECS/latest/developerguide/launch_container_instance.html
variable "ecsAmi" {
  description = "optimized ECS AMIs"
  default = {
    us-east-1 = "ami-1924770e"
  }
}

# this is a keyName for key pairs
variable "aws_key_name" {
  description = "Key Pair Name used to login to the box"
  default = "dr-kp-us-east"
}

# this is a PEM key for key pairs
variable "aws_key_filename" {
  description = "Key Pair FileName used to login to the box"
  default = "demo-key.pem"
}

########################### Test VPC Settings #################################
variable "prod_public_sg_id" {
  description = "Prod VPC public security group"
}

variable "prod_public_sn_01_id" {
  description = "Prod VPC public subnet"
}

variable "prod_public_sn_02_id" {
  description = "Prod VPC public subnet"
}

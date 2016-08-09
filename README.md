# terraform-microservice
Microservice terraform module

### Exmaple usage:


# Testing module
    variable "service_tags" {
      type    = "map"
      default = {
          environment = "test-env"
          name        = "fontend-test"
        }
      }


      module "test_service" {
        source                     = "../terraform-microservice/"
        service_tags               = "${var.service_tags}"
        vpc_id                     = "vpc-id-123"
        ami_id                     = "ami-id-123"
        stand_alone_instance_count = 0
        subnets_cidr_priv          = ["10.10.10.1/24","10.10.10.2/24","10.10.10.3/24"]
        subnets_cidr_pub           = ["150.150.150.1/24","150.150.150.2/24"]
        instance_type              = "t2.micro"
      }

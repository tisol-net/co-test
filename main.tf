terraform {
  required_version = ">= 1.5.7"
  backend "s3" {
    bucket               = "co-terraform"
    key                  = "poc.tfstate"
    workspace_key_prefix = "co-terraform"
    dynamodb_table       = "terraform-lockfile"
    region               = "eu-west-2"
    encrypt              = true
  }
}

provider aws {
  region                = var.region
  version               = "~> 5.37"
  allowed_account_ids   = [var.accounts[terraform.workspace]]
  assume_role {
    role_arn = "arn:aws:iam::${var.accounts[terraform.workspace]}:role/Administrator"
  }
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "etl" {
  cidr_block = "10.0.1.0/24"
  vpc_id = aws_vpc.example.id
  availability_zone = "eu-west-2"
}

resource "aws_security_group" "all_ports" {
  name_prefix = "example-sg"
  vpc_id = aws_vpc.example.id

  ingress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["10.0.1.0/24"]
  }

  egress {
    from_port = 0
    to_port = 65535
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module iam {
  source        = "./modules/iam"
}

module lambda {
  source = "./modules/lambda"
  security_group_id = aws_security_group.all_ports.id
  subnet_id = aws_subnet.etl.id
}

module glue {
  source = "./modules/glue"
}

module s3 {
  source = "./modules/s3"
  trigger_function_arn = module.lambda.trigger_function_arn
}

module eventbridge {
  source                      = "./modules/eventbridge"
  weather_retrieve_lambda_arn = modules.lambda.weather_retrieve_lambda_arn
}


provider "aws" {
  region = "us-east-1" # Replace with your desired region
}

resource "aws_db_instance" "my_database" {
  identifier           = "sourcedb"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.35"              # Replace with your desired MySQL version
  instance_class       = "db.t2.micro"         # Replace with your desired instance type
  username             = "admin"               # Replace with your desired username
  password             = "password"            # Replace with your desired password
  parameter_group_name = "default.mysql8.0" # Replace with your desired parameter group

  # Replace with your preferred settings for the following parameters if needed
  skip_final_snapshot = true
  publicly_accessible = true
}


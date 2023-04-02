#--------------------------------------------------------------
# RDS 本当はkmsからpassword取得しないといけないよ！
#--------------------------------------------------------------

resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "foo"
  password             = "foobarbaz"
  parameter_group_name = "default.mysql8.0"
}


#--------------------------------------------------------------
# Subnet group
#--------------------------------------------------------------

resource "aws_db_subnet_group" "rds-subnet-group" {
  name        = "mydb"
  description = "rds subnet group"
  subnet_ids  = [aws_subnet.private[0].id]
}

#--------------------------------------------------------------
# Security group
#--------------------------------------------------------------

resource "aws_security_group" "rds-sg" {
  name        = "rds-sg"
  description = "RDS service security group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
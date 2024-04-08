module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "${var.env}-${var.project}"

  engine                           = "aurora-mysql"
  engine_version                   = "8.0.mysql_aurora.3.03.0"
  instance_class    = "db.t3.medium"
  allocated_storage = 5

  db_name  = "demodb"
  username = "user"
  port     = "3306"
  iam_database_authentication_enabled = false
  vpc_security_group_ids = module.rds_service_sg.security_group_id
  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = false
  db_subnet_group_name                  = module.vpc.database_subnet_group_name

  # DB parameter group
  family = "mysql8.0"

  # DB option group
  major_engine_version = "8.0"

  # Database Deletion Protection
  deletion_protection = true

  parameters = [
 {
    name  = "time_zone"
    value = "Asia/Bangkok"
  },
{
    name  = "binlog_checksum"
    value = "NONE"
  },
{
    apply_method = "pending-reboot"
    name         = "binlog_format"
    value        = "ROW"
},
{
    name  = "character_set_server"
    value = "utf8mb4"
},
{
    name  = "character_set_filesystem"
    value = "utf8mb4"
},
{
    name  = "character_set_database"
    value = "utf8mb4"
},

{
    name  = "character_set_results"
    value = "utf8mb4"
},
{
    name  = "collation_connection"
    value = "utf8mb4_unicode_ci"
},

{
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
},
{
    name  = "max_allowed_packet"
    value = "1073741824"
}
]
}
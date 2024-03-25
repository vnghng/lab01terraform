# RDS PARAMETER GROUP
resource "aws_rds_cluster_parameter_group" "this" {
  name        = "${var.env}-${var.project}-pg-cluster"
  family      = "aurora-mysql8.0"
  description = "RDS cluster parameter group for sit-mifos"

  parameter {
    name  = "time_zone"
    value = "Asia/Bangkok"
  }

  parameter {
    name  = "binlog_checksum"
    value = "NONE"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "binlog_format"
    value        = "ROW"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "collation_server"
    value = "utf8mb4_unicode_ci"
  }

  parameter {
    name  = "max_allowed_packet"
    value = "1073741824"
  }
}

# RDS DB PG
resource "aws_db_parameter_group" "this" {
  name   = "${var.env}-${var.project}-pg"
  family = "aurora-mysql8.0"

  lifecycle {
    create_before_destroy = true
  }
}

# RDS CLUSTER
resource "aws_rds_cluster" "this" {
  cluster_identifier               = "${var.env}-${var.project}"
  engine                           = "aurora-mysql"
  engine_version                   = "8.0.mysql_aurora.3.03.0" # Check engine version: aws rds describe-db-engine-versions --engine aurora-mysql --query 'DBEngineVersions[?contains(SupportedEngineModes,`provisioned`)].EngineVersion'
  db_subnet_group_name             = module.vpc.database_subnet_group_name
  network_type                     = "IPV4"
  vpc_security_group_ids           = [aws_security_group.sg_rds_cs.id]
  master_username                  = "admin"
  master_password                  = "MQnlxRT6m36llU5xDNCj"
  db_cluster_parameter_group_name  = aws_rds_cluster_parameter_group.this.name
  db_instance_parameter_group_name = aws_db_parameter_group.this.name
  backup_retention_period          = 7
  preferred_backup_window          = "16:00-01:00"
  copy_tags_to_snapshot            = true
  skip_final_snapshot              = true
  deletion_protection              = true
  tags                             = {
    Name        = "${var.env}-${var.project}"
    Environment = var.env
    Project     = var.project
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# RDS INSTANCES
resource "aws_rds_cluster_instance" "instances_0" {
  identifier                            = "${var.env}-${var.project}-0"
  cluster_identifier                    = aws_rds_cluster.this.id
  instance_class                        = "db.t3.medium"
  engine                                = aws_rds_cluster.this.engine
  engine_version                        = aws_rds_cluster.this.engine_version
  publicly_accessible                   = false
  db_subnet_group_name                  = module.vpc.database_subnet_group_name
#  performance_insights_enabled          = false
#  performance_insights_retention_period = 7
  copy_tags_to_snapshot                 = true
  tags                                  = {
    Name        = "${var.env}-${var.project}-0"
    Environment = var.env
    Project     = var.project
  }
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

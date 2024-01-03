
####### Create AWS Backup Vault

resource "aws_backup_vault" "aws_backup_vault" {
  for_each    = toset(var.resource_name)
  name        = "${each.key}_backup_vault"

  tags = {
    Name = "aws_backup_vault"
  }
}

####### Create AWS Backup plan

resource "aws_backup_plan" "aws_backup" {
  for_each = toset(var.resource_name)
  name     = "${each.key}_backup_plan"

  rule {
    rule_name         = "${each.key}_backup_plan"
    target_vault_name = "${aws_backup_vault.aws_backup_vault[each.key].name}"
    schedule          = var.schedule
    lifecycle {
      delete_after = var.lifecycle_time
    }
  }

 tags = {
    Name = "aws_backup_plan"
  }
}


####### Create AWS Backup selection to assign services with Tag options


resource "aws_backup_selection" "aws_backup_selection" {
  for_each     = toset(var.resource_name)
  iam_role_arn = aws_iam_role.aws_backup_plan.arn
  name         = "${each.key}_backup_selection"
  plan_id      = aws_backup_plan.aws_backup[each.key].id

  selection_tag {
    type  = "STRINGEQUALS"
    key   = var.backup_tag_key
    value = "${each.key}-${var.backup_tag_value}" # tag value indicates service vault e.g. rds-true goes to rds vault
  }
}
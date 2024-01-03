variable "resource_name" {
  type        = list(string)
  description = "A name of the resource"
} 

variable "lifecycle_time" {
  type        = number
  description = "A time for lifecycle deletion"
}

variable "schedule" {
  type        = string
  description = "A schedule of the backup plan"
}

variable "backup_tag_value" {
  type        = string
  description = "A tag of the backup plan"
}

variable "backup_tag_key" {
  type        = string
  description = "A tag of the backup plan"
}

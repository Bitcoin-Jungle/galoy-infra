variable "name_prefix" {
  default = "galoy-pura-vida"
}
variable "tf_state_bucket_name" {
  default = "galoy-pura-vida-tf-state"
}
variable "buckets_location" {
  default = "US-EAST1"
}
variable "gcp_project" {
  default = "galoy-pura-vida"
}
variable "inception_sa" {}
variable "users" {
  type = list(object({
    id        = string
    inception = bool
    platform  = bool
    logs      = bool
  }))

  default = [
    {
      id        = "user:leesalminen@gmail.com"
      inception = true
      platform  = true
      logs      = true
    }
  ]
}

module "inception" {
  source = "git::https://github.com/GaloyMoney/galoy-infra.git//modules/inception/gcp?ref=435a0ce"
  # source = "../../../modules/inception/gcp"

  name_prefix          = var.name_prefix
  gcp_project          = var.gcp_project
  inception_sa         = var.inception_sa
  tf_state_bucket_name = var.tf_state_bucket_name
  buckets_location     = var.buckets_location

  users = var.users
}

output "bastion_ip" {
  value = module.inception.bastion_ip
}

output "bastion_name" {
  value = module.inception.bastion_name
}

output "bastion_zone" {
  value = module.inception.bastion_zone
}

output "cluster_sa" {
  value = module.inception.cluster_sa
}

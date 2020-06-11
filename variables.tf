variable "keyring" {
  type        = string
  description = "Self link to the GCP KMS Keyring"
}

variable "key" {
  type        = string
  description = "Key name"
  default     = ""
}

variable "owners" {
  type        = list(string)
  description = "List of key-custodians / super-users"
  default     = []
}

variable "encrypters" {
  type        = list(string)
  description = "List of comma-separated users for each key to be granted encrypt access."
  default     = []
}

variable "decrypters" {
  type        = list(string)
  description = "List of comma-separated users for each key to be granted decrypt access"
  default     = []
}

# cf https://cloud.google.com/kms/docs/rotating-keys
variable "key_rotation_period" {
  description = "How often to rotate the key."
  type        = string
  default     = "2592000s"
}

output "key_uri" {
  description = "GCP KMS Key Uri"
  value       = google_kms_crypto_key.key.self_link
}

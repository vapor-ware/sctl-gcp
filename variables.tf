

# cf https://cloud.google.com/kms/docs/locations
variable "location" {
  type        = string
  description = "Location for the keyring."
}

variable "keyring" {
  type        = string
  description = "Keyring name."
}

variable "keys" {
  type        = list(string)
  description = "Key names."
  default     = []
}

variable "owners" {
  type        = list(string)
  description = "List of comma-separated of super-users for each key."
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
  type    = string
  default = "100000s"
}
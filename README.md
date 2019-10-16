# Scuttle on GCP

This terraform module is intended to provide a reference configuration for keys
that can be used with [scuttle](https://github.com/vapor-ware/sctl).


### Requirements

- Terraform 0.12+
- A Google Cloud Project


### Configuration

Key | Description | default |
----|-------------|---------|
keyring | Self link to the GCP KMS Keyring | "" |
key | Key name | "" |
owners | List of key-custodians / super-users" | [] |
encrypters | List of users to grant encrypt access | [] |
decrypters | List of users to grant decrypt access | [] |
key_rotation_period | How often to generate and promote a new primary key | 30 days |

### Usage

The consumption of this module is intended to be you declare a keyring and invoke the module for each key bound in the keyring. As no project is explicitly declared, the keyring/keys will adopt the root module's GCP project configuration.


```
provider "google" {
  project = "example-project"
}


# Declare a keyring to warehouse related keys
resource "google_kms_key_ring" "sctl" {
  name     = "sctl-keyring"
  location = "us"
}


module "cloud-ops-operational-key" {
  source = "github.com/vapor-ware/sctl-gcp"

  keyring = google_kms_key_ring.sctl.self_link
  key = "infra-secrets"
  owners = [
    "admin@example.com",
  ]

  encrypters = [
    "user@example.com",
  ]
  decrypters = [
    "user@example.com",
    "ci@example.com"
  ]


}
```

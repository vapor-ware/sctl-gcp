
locals {
  keys_by_name = zipmap(var.keys, google_kms_crypto_key.key.*.self_link)
}


resource "google_kms_crypto_key" "key" {
  count           = length(var.keys)
  name            = var.keys[count.index]
  key_ring        = var.keyring
  rotation_period = var.key_rotation_period

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_binding" "owners" {
  count = length(var.keys)
  role  = "roles/owner"

  crypto_key_id = local.keys_by_name[count.index]

  members = compact(split(",", var.owners[count.index]))
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  count = length(var.keys)
  role  = "roles/cloudkms.cryptoKeyDecrypter"

  crypto_key_id = local.keys_by_name[count.index]

  members = compact(var.decrypters)
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  count = length(var.keys)
  role  = "roles/cloudkms.cryptoKeyEncrypter"

  crypto_key_id = local.keys_by_name[count.index]

  members = compact(var.encrypters)
}

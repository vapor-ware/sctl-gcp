
resource "google_kms_crypto_key" "key" {
  name            = var.key
  key_ring        = var.keyring
  rotation_period = var.key_rotation_period

  lifecycle {
    prevent_destroy = true
  }
}

resource "google_kms_crypto_key_iam_binding" "owners" {
  role  = "roles/owner"

  crypto_key_id = google_kms_crypto_key.key.self_link

  members = compact(var.owners)
}

resource "google_kms_crypto_key_iam_binding" "decrypters" {
  role  = "roles/cloudkms.cryptoKeyDecrypter"
  crypto_key_id = google_kms_crypto_key.key.self_link

  members = compact(var.decrypters)
}

resource "google_kms_crypto_key_iam_binding" "encrypters" {
  role  = "roles/cloudkms.cryptoKeyEncrypter"

  crypto_key_id = google_kms_crypto_key.key.self_link

  members = compact(var.encrypters)
}

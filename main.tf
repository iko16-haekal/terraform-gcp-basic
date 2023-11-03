terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.4.0"
    }
  }
}

provider "google" {
  # Configuration options
  project = "terraform-basic-404016"
  region  = "asia-southeast2"
}



data "google_compute_image" "debian-image" {
  family  = "debian-11"
  project = "debian-cloud"
}



resource "google_compute_instance" "iko-terraform-test" {
  name         = "iko-terraform-test"
  machine_type = "e2-small"
  zone         = "asia-southeast2-a"
  allow_stopping_for_update = true



  boot_disk {
    initialize_params {
      image = data.google_compute_image.debian-image.self_link
    }
  }


  network_interface {
    network = "default"
    access_config {
      // Ephemeral public IP
    }
  }

  # metadata_startup_script = "echo hi > /test.txt"

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    # email  = google_service_account.default.email
    scopes = ["cloud-platform"]
  }
}
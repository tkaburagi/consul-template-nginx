provider "google" {
  project = var.project

}

resource "google_compute_instance" "vm_instance" {
  name         = "nginx-plus"
  machine_type = "n1-standard-1"
  zone         = "asia-northeast1-a"
  tags         = google_compute_firewall.http-ssh.source_tags
  boot_disk {
    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/nginx-public/global/images/nginx-plus-ubuntu1804-standard-v20210519"
    }
  }

  metadata_startup_script = data.template_file.init_gcp.rendered

  network_interface {
    # A default network is created for all GCP projects
    network = "default"
    access_config {
    }
  }
}

resource "google_compute_firewall" "http-ssh" {
  name    = "http-ssh"
  network = "default"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "443", "8080"]
  }

  source_tags = ["http-ssh", "http-server"]
}

data "template_file" "init_gcp" {
  template = file("setup.sh")
  vars = {
    ct_url = var.ct_url
  }
}
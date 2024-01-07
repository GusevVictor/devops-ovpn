resource "google_compute_project_metadata" "main" {
  metadata = {
    enable-oslogin : "TRUE"
  }
}

# Create static ip
resource "google_compute_address" "static" {
  name = "ipv4-address"
}

# Create a VPC
resource "google_compute_network" "vpc" {
  name                    = "ovpn-lan"
  auto_create_subnetworks = "false"
}

# Create firewall rules
resource "google_compute_firewall" "rule_1" {
  project = var.gcp_project_name
  name    = "allow-ssh"
  network = "ovpn-lan"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  source_ranges = ["35.235.240.0/20", "10.10.0.0/24"]
}

resource "google_compute_firewall" "rule_2" {
  project = var.gcp_project_name
  name    = "allow-icmp"
  network = "ovpn-lan"

  allow {
    protocol = "icmp"
  }
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "rule_3" {
  project = var.gcp_project_name
  name    = "allow-ovpn"
  network = "default"

  allow {
    protocol = "udp"
    ports    = ["1194"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# Create a Subnet
resource "google_compute_subnetwork" "ovpn-lan-subnet" {
  name          = "ovpn-lan-custom-subnet"
  ip_cidr_range = "10.10.0.0/24"
  network       = google_compute_network.vpc.name
  region        = var.gcp_region
}

## Create Cloud Router

resource "google_compute_router" "router" {
  project = var.gcp_project_name
  name    = "nat-router"
  network = "ovpn-lan"
  region  = var.gcp_region
}

## Create Nat Gateway

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = var.gcp_region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

## Create VMs

resource "google_compute_instance" "vm_instance-4" {
  project      = var.gcp_project_name
  name         = "monitor"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  network_interface {
    network    = "ovpn-lan"
    subnetwork = google_compute_subnetwork.ovpn-lan-subnet.name
    network_ip = "10.10.0.6"
  }
}

resource "google_compute_instance" "vm_instance-2" {
  project      = var.gcp_project_name
  name         = "ovpn-maintaince"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  network_interface {
    network    = "ovpn-lan"
    subnetwork = google_compute_subnetwork.ovpn-lan-subnet.name
    network_ip = "10.10.0.4"
  }
}
resource "google_compute_instance" "vm_instance-1" {
  project      = var.gcp_project_name
  name         = "ovpn-pki"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  network_interface {
    network    = "ovpn-lan"
    subnetwork = google_compute_subnetwork.ovpn-lan-subnet.name
    network_ip = "10.10.0.3"
  }
}
resource "google_compute_instance" "vm_instance" {
  project      = var.gcp_project_name
  name         = "ovpn-srv"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static.address
    }
  }
  network_interface {
    network    = "ovpn-lan"
    subnetwork = google_compute_subnetwork.ovpn-lan-subnet.name
    network_ip = "10.10.0.2"
  }
}

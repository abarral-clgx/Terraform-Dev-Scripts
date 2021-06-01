terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("C:\\proteus-secrets\\beam-credentials\\clgx-idap-clct-app-dev-d20c-a2bd3837cc98.json")

  project = "clgx-idap-clct-app-dev-d20c"
  region  = "us-central1"
  zone    = "us-central1-c"
}

resource "google_storage_bucket" "bucket" {
  name = "proteus-dataflow-dev"
}

resource "google_storage_bucket_object" "folders" {
  bucket   = "proteus-dataflow-dev"
  name     = "DataFlowTempLocation/"
  content  = "foo" # Note that the content string isn't actually used, but is only there since the resource requires it
}

resource "google_storage_bucket_object" "proteus_bigquery" {
  bucket   = "proteus-dataflow-dev"
  name     = "proteus_bigquery/"
  content  = "foo" # Note that the content string isn't actually used, but is only there since the resource requires it
}

resource "google_bigquery_dataset" "dataset" {
  dataset_id = "proteus"
  friendly_name = "proteus"
  description = "Proteus POC"
  location = "EU"
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

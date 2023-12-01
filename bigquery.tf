/**
 * Copyright 2023 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

# Set up BigQuery resources
# # Create the BigQuery dataset
resource "google_bigquery_dataset" "dev" {
  project                    = module.project-services.project_id
  dataset_id                 = "dev-${random_id.id.hex}"
  friendly_name              = "Dev table"
  description                = "Development table"
  location                   = var.region
  labels                     = var.labels
  delete_contents_on_destroy = var.force_destroy
}

resource "google_bigquery_dataset" "stage" {
  project                    = module.project-services.project_id
  dataset_id                 = "stage-${random_id.id.hex}"
  friendly_name              = "Staging table"
  description                = "Staging table"
  location                   = var.region
  labels                     = var.labels
  delete_contents_on_destroy = var.force_destroy
}

resource "google_bigquery_dataset" "dev" {
  project                    = module.project-services.project_id
  dataset_id                 = "prod-${random_id.id.hex}"
  friendly_name              = "Prod table"
  description                = "Production table"
  location                   = var.region
  labels                     = var.labels
  delete_contents_on_destroy = var.deletion_protection
}

resource "google_bigquery_table" "dev" {
  deletion_protection = var.deletion_protection
  dataset_id          = google_bigquery_dataset.dev.dataset_id
  table_id            = "dev"
}

resource "google_bigquery_table" "stage" {
  deletion_protection = var.deletion_protection
  dataset_id          = google_bigquery_dataset.stage.dataset_id
  table_id            = "stage"
}

resource "google_bigquery_table" "prod" {
  deletion_protection = var.deletion_protection
  dataset_id          = google_bigquery_dataset.prod.dataset_id
  table_id            = "prod"
}

resource "google_bigquery_job" "dev" {
  job_id = "dev"

  labels = {
    "env" = "dev"
  }

  query {
    query = "SELECT state FROM [bigquery-public-data:chicago_taxi_trips.taxi_trips]"

    destination_table {
      project_id = google_bigquery_table.dev.project
      dataset_id = google_bigquery_table.dev.dataset_id
      table_id   = google_bigquery_table.dev.table_id
    }
  }
}

resource "google_bigquery_job" "stage" {
  job_id = "stage"

  labels = {
    "env" = "stag"
  }

  query {
    query = "SELECT * FROM [bigquery-public-data:chicago_taxi_trips.taxi_trips]"

    destination_table {
      project_id = google_bigquery_table.stage.project
      dataset_id = google_bigquery_table.stage.dataset_id
      table_id   = google_bigquery_table.stage.table_id
    }
  }
}

resource "google_bigquery_job" "prod" {
  job_id = "prod"

  labels = {
    "env" = "prod"
  }

  query {
    query = "SELECT state FROM [bigquery-public-data:chicago_taxi_trips.taxi_trips]"

    destination_table {
      project_id = google_bigquery_table.prod.project
      dataset_id = google_bigquery_table.prod.dataset_id
      table_id   = google_bigquery_table.prod.table_id
    }
  }
}
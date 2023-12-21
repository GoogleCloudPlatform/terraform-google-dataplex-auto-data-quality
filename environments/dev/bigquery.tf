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
  dataset_id                 = "${local.env}_${random_id.id.hex}"
  friendly_name              = "Dev table"
  description                = "Development table"
  location                   = var.region
  labels                     = var.labels
  delete_contents_on_destroy = var.force_destroy
}

resource "google_bigquery_table" "dev" {
  project             = module.project-services.project_id
  dataset_id          = google_bigquery_dataset.dev.dataset_id
  table_id            = local.env
  deletion_protection = var.deletion_protection
}

resource "google_bigquery_job" "dev" {
  project = module.project-services.project_id
  job_id  = "${local.env}_copy"

  labels = {
    "env" = local.env
  }

  copy {
    source_tables {
      table_id = var.source_table
    }

    destination_table {
      table_id = google_bigquery_table.dev.id
    }
  }
}
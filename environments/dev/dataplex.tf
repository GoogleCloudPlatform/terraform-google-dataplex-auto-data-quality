# Copyright 2023 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "google_dataplex_datascan" "dev" {
  location     = var.region
  data_scan_id = "${local.env}-scan"

  data {
    resource = "//bigquery.googleapis.com/${google_bigquery_table.dev.id}"
  }

  execution_spec {
    trigger {
      on_demand {}
    }
  }

  # data_quality_spec = file(var.dev_rules_file)
  data_quality_spec {
    file("rules.txt")
  }

  project = var.project_id

  depends_on = [google_bigquery_job.dev]
}
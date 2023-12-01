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
  data_scan_id = "dev-scan"

  data {
    resource = "//bigquery.googleapis.com/projects/${var.source_project}/datasets/${var.source_dataset}/tables/${var.source_table}"
  }

  execution_spec {
    trigger {
      on_demand {}
    }
  }

  data_quality_spec = file(var.dev_rules_file)
  # data_quality_spec 
  {
    rules {
      dimension   = "VALIDITY"
      name        = "rule1"
      description = "rule 1 for validity dimension"
      table_condition_expectation {
        sql_expression = "COUNT(*) > 0"
      }

    rules {



    }
    }
  }

  project = "my-project-name"
}

resource "google_dataplex_datascan" "stage" {
  location     = var.region
  data_scan_id = "stage-scan"

  data {
    resource = "//bigquery.googleapis.com/projects/${var.source_project}/datasets/${var.source_dataset}/tables/${var.source_table}"
  }

  execution_spec {
    trigger {
      on_demand {}
    }
  }

  data_quality_spec {
    rules {
      dimension   = "VALIDITY"
      name        = "rule1"
      description = "rule 1 for validity dimension"
      table_condition_expectation {
        sql_expression = "COUNT(*) > 0"
      }
    }
  }

  project = "my-project-name"
}

resource "google_dataplex_datascan" "basic_quality" {
  location     = var.region
  data_scan_id = "prod-scan"

  data {
    resource = "//bigquery.googleapis.com/projects/${var.source_project}/datasets/${var.source_dataset}/tables/${var.source_table}"
  }

  execution_spec {
    trigger {
      on_demand {}
    }
  }

  data_quality_spec {
    rules {
      dimension = "UNIQUENESS"
    }
  }

  project = "my-project-name"
}

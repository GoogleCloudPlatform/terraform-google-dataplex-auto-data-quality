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

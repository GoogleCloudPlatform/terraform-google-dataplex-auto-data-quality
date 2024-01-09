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

output "bigquery_dataset" {
  value = google_bigquery_dataset.dev.dataset_id
}

output "bigquery_table" {
  value = google_bigquery_table.dev.table_id
}

output "bucket_name" {
  description = "Name of the bucket"
  value       = google_storage_bucket.main.name
}
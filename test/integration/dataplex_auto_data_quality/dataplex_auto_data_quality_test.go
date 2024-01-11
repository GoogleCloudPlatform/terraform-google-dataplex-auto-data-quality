// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package multiple_buckets

import (
	"testing"

	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/bq"
	"github.com/GoogleCloudPlatform/cloud-foundation-toolkit/infra/blueprint-test/pkg/tft"
	"github.com/stretchr/testify/assert"
)

func TestDataQuality(t *testing.T) {
	dq := tft.NewTFBlueprintTest(t)

	dq.DefineVerify(func(assert *assert.Assertions) {
		dq.DefaultVerify(assert)

		projectID := dq.GetStringOutput("project_id")
		tables := bq.Runf(t, "--project_id=%s ls", projectID).Array()

		assert.Greater(len(tables), 0, "no tables created")
	})
	dq.Test()
}

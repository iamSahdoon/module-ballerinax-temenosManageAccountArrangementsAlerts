// Copyright (c) 2025, WSO2.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/test;
import ballerina/io;
// import ballerina/http;

configurable ApiKeysConfig apiKeyConfig = ?;
configurable string serviceUrl = "https://api.temenos.com/api/v1.1.0/holdings";


ConnectionConfig config = {
    auth: apiKeyConfig
};

final Client temenos = check new Client(config, serviceUrl);

@test:Config {
    groups: ["get_test1"]
}
isolated function testGetExternalSubscriptions() returns error? {
    ExternalSubscribersAlertRequestsResponse|error response = temenos->/arrangements/alertRequests/externalSubscriptions.get();
    if response is ExternalSubscribersAlertRequestsResponse {
        io:println("Success Response: ", response);
        test:assertTrue(response is ExternalSubscribersAlertRequestsResponse, "Response failed");
        test:assertTrue(response.header?.status == "success", "Response status is not success");
    } else {
        // io:println("Error Response: ", response.message());
        test:assertFail("Test failed with error: " + response.message());
    }
}
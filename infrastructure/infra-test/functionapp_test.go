package main

import (
	"testing"
	"os/exec"

	"github.com/stretchr/testify/assert"
)

func TestFunctionAppAndAppServicePlanExist(t *testing.T) {
	t.Parallel()

	functionAppName := "nn-dap-function-app-987654"
	appServicePlanName := "nn-dap-function-app-service-plan"
	resourceGroup := "nn-dap-resource-group"

	// Validate Function App existence
	functionAppCmd := exec.Command("az", "functionapp", "show", "--name", functionAppName, "--resource-group", resourceGroup)
	functionAppOutput, functionAppErr := functionAppCmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, functionAppErr, "Failed to execute Azure CLI command for Function App")

	// Assert that the Function App exists
	assert.Contains(t, string(functionAppOutput), `"name": "`+functionAppName+`"`, "Function App does not exist")

	// Validate App Service Plan existence
	appServicePlanCmd := exec.Command("az", "appservice", "plan", "show", "--name", appServicePlanName, "--resource-group", resourceGroup)
	appServicePlanOutput, appServicePlanErr := appServicePlanCmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, appServicePlanErr, "Failed to execute Azure CLI command for App Service Plan")

	// Assert that the App Service Plan exists
	assert.Contains(t, string(appServicePlanOutput), `"name": "`+appServicePlanName+`"`, "App Service Plan does not exist")
}

package main

import (
	"testing"
	"os/exec"

	"github.com/stretchr/testify/assert"
)

func TestACRExists(t *testing.T) {
	t.Parallel()

	acrName := "nndapacr45975"
	resourceGroup := "nn-dap-resource-group"

	cmd := exec.Command("az", "acr", "show", "--name", acrName, "--resource-group", resourceGroup)
	output, err := cmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, err, "Failed to execute Azure CLI command")

	// Assert that the ACR exists
	assert.Contains(t, string(output), `"name": "`+acrName+`"`, "ACR does not exist")
}

func TestStorageAccountExists(t *testing.T) {
	t.Parallel()

	storageAccountName := "nndapstorage45975"
	resourceGroup := "nn-dap-resource-group"

	cmd := exec.Command("az", "storage", "account", "show", "--name", storageAccountName, "--resource-group", resourceGroup)
	output, err := cmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, err, "Failed to execute Azure CLI command")

	// Assert that the storage account exists
	assert.Contains(t, string(output), `"name": "`+storageAccountName+`"`, "Storage account does not exist")
}


package main

import (
	"testing"
	"os/exec"

	"github.com/stretchr/testify/assert"
)

func TestVNetExists(t *testing.T) {
	t.Parallel()

	vnetName := "nn-dap-vnet"
	resourceGroup := "nn-dap-resource-group"

	cmd := exec.Command("az", "network", "vnet", "show", "--name", vnetName, "--resource-group", resourceGroup)
	output, err := cmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, err, "Failed to execute Azure CLI command")

	// Assert that the VNet exists
	assert.Contains(t, string(output), `"name": "`+vnetName+`"`, "VNet does not exist")
}


func TestSubnetExists(t *testing.T) {
	t.Parallel()

	vnetName := "nn-dap-vnet"
	resourceGroup := "nn-dap-resource-group"
	subnetName := "nn-dap-subnet"

	cmd := exec.Command("az", "network", "vnet", "subnet", "show", "--name", subnetName, "--vnet-name", vnetName, "--resource-group", resourceGroup)
	output, err := cmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, err, "Failed to execute Azure CLI command")

	// Assert that the subnet exists
	assert.Contains(t, string(output), `"name": "`+subnetName+`"`, "Subnet does not exist")
}

func TestPLESubnetExists(t *testing.T) {
	t.Parallel()

	vnetName := "nn-dap-vnet"
	resourceGroup := "nn-dap-resource-group"
	subnetName := "ple-subnet"

	cmd := exec.Command("az", "network", "vnet", "subnet", "show", "--name", subnetName, "--vnet-name", vnetName, "--resource-group", resourceGroup)
	output, err := cmd.CombinedOutput()

	// Check for any errors
	assert.NoError(t, err, "Failed to execute Azure CLI command")

	// Assert that the subnet exists
	assert.Contains(t, string(output), `"name": "`+subnetName+`"`, "Subnet does not exist")
}
Following are the steps that need to perform to test the terraform code

## Step 1 - Terraform Backend configurations: 
Run the script file that will create configuration and helps to create a backend-config for terraform. 
New resource group and storage account will be created that will save the terraform state file in blob container


`./script/tfstate_storage_setup.sh`

## Step 2- Terraform Deployment via Azure Devops: 

Run the azure-devops-infrastructure.yaml pipeline that will run the terraform module and deploy all the infra into azure

## Step 3- Pipeline to push the image into ACR: 

Run the azure-devops-application.yaml pipeline that will push the latest image into acr and function app will pick up the latest image from ACR


## Step 4- Test the infra using terratest: 

I have written the terraform testing using terratest in Go language.

Go inside the directory i.e ./infrastructure/infra-test and run the below command


go test -v

This will run all te test in the directory and below will be the output

--- PASS: TestACRExists (2.07s)

--- PASS: TestStorageAccountExists (2.73s)

--- PASS: TestPLESubnetExists (4.40s)

--- PASS: TestVNetExists (4.40s)

--- PASS: TestSubnetExists (4.40s)

--- PASS: TestFunctionAppAndAppServicePlanExist (5.35s)

PASS
ok      tests   5.619s



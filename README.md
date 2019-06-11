# terraform-azure-qdc
terraform scripts for deploying QDC 4.0.6 in Single Server mode on Azure (Presales)

This repo is based on original Leigh's Kennedy https://github.com/ljckennedy/terraform-azure-qdc

---
## What you need:
Create a Service Principal if you still don't have one:
```Bash
az ad sp create-for-rbac

A response like this will return
{
  "appId": "bbbbbbbbbbbbbbbbbbbbbbbbbbbb",
  "displayName": "azure-cli-2019-06-11-10-25-44",
  "name": "http://azure-cli-2019-06-11-10-25-44",
  "password": "shhhhhhhhhhhhhhhhhhhhhhh",
  "tenant": "aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
}
```

a variables file i.e. __qdc.tfvars__ containing:
```Bash
#these comes from your azure tenant
tenant_id = "aaaaaaaaaaaaaaaaaaaaaaaaaaaa"
client_id = "bbbbbbbbbbbbbbbbbbbbbbbbbbbb" #app
client_secret = "shhhhhhhhhhhhhhhhhhhhhhh"
subscription_id = "aaaaaaaaaa-bbbbbbb-ccccc"
presales_rg_name="Pre-Sales-<trigram>" #Predefined RG in Qlik Presales Azure subscription
presales_subnet_id="/subscriptions/<subscription_id>/resourceGroups/IT-Infra-Mgmt/providers/Microsoft.Network/virtualNetworks/IT-Infra-Mgmt-VNet/subnets/Pre-Sales-Subnet"

#these are up to you.
deloyment_name = "qdc" #lowercase
server_hostname="qdc-hostname" #needs to be unique within the azure_location
azure_location="East US"
administrator="qdc"
administrator_pass="Pass$SECRET-2001" # needs to meet password complexity rules
```

ssh keys set up.  It is expecting to find *~/.ssh/id_rsa.pub* & *~/.ssh/id_rsa*

And most importantly, you need the QDC installers:
- podium-4.0.6-19.zip
- QDCinstaller.zip

These are not publicly downloadable at this time and need to be obtained from your Qlik representative. 

## How to:
```Bash
cd /somedirectory
git clone https://github.com/mjromper/terraform-azure-qdc.git
cp myvarsfileicreated.tfvars ./terraform-azure-qdc/qdc.tfvars
cp /my-qdc-installers/*.zip ./terraform-azure-qdc/install/files/
cd ./terraform-azure-qdc
terraform init
terraform apply -var-file=qdc.tfvars
```
All going well this should run for about 20-30 minutes (largely dependent on the time to upload the installers) and when complete you should be able to connect to QDC at (for example)
http://qdc-hostname.eastus.cloudapp.azure.com:8080/qdc

initial credentials should be provided in your QDC documentation and you will need to aply your QDC license.

---
## Notes
This has been developed and tested from the client side on ubuntu using WSL in windows 10.  Any linux/unix environment should work, but others have not been tested.

This has been built for **_demo purposes only_**.  It should not be seen as secure, production grade nor best practice.  This was primarily done as a learning exercise for myself.  QDC 4.06 is not officially supported for single server mode at this time.  This will be updated to the supported version when it is release.

Thanks to Clint Carr's https://github.com/clintcarr/qlik-sense-azure-terraform which I used as a template and was a huge help!
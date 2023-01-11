# Deploy infrastructure in AWS with Terraform

This the final project for the Technische Berufsschule Zürich (TBZ) "Cloud-native, DevOps & Container" bootcamp.

In this project I will try to create and deploy an AWS infrastructure with Terraform.

![](./png/infrastructure-architecture.png)

I want to create 2 VMs in the same VPC but in 2 different subnets. Each VM will run a webserver. To configure the webservers, I will use an S3 bucket, which will hold the webserver configuration.
# Prerequesites
* [AWS Account](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)
* [Visual Studio Code](https://code.visualstudio.com/download)
    

# Install Terraform
1. Download the Terraform executable from the official HashiCorp website for your system:  
https://developer.hashicorp.com/terraform/downloads  

2. Create a directory for storing the terraform executable.  
I created my folder named Terraform under the following path: C:\HashiCorp\Terraform

3. Move the downloaded executable in this directory
![](./png//screenshots/terraform-dir.PNG)  

4. Add this directory path to the PATH environment variable   
![](./png/screenshots/terraform-path-var.PNG)

5. Click OK to apply all changes.

Terraform should now correctly be installed. Open Powershell or cmd.exe and check for the terraform version with `terraform version`  
![](./png/screenshots/terraform-version.PNG)

# Create an AWS Access Key

# Add Terraform extension in VS Code
# Config
## Testing
## Reflection
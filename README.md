# Deploy infrastructure in AWS with Terraform

This the final project for the Technische Berufsschule Zürich (TBZ) "Cloud-native, DevOps & Container" bootcamp.

In this project I will try to create and deploy an AWS infrastructure with Terraform.

![](./png/infrastructure-architecture.png)

I want to create 2 VMs in the same VPC but in 2 different subnets. Each VM will run a webserver. To configure the webservers, I will use a S3 bucket, which will hold the webserver configuration.
# Prerequesites
* [AWS Account](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all)
* [Visual Studio Code](https://code.visualstudio.com/download)
* Windows 10 / 11*

*This documentation was written with a computer running windows, however it can still be done with MacOS or Linux. You have to use the corresponding installer for your OS and adding the binaries and variables in your OS environment.
    
# Setup CLI Tools

## Install AWS CLI
1. Open Powershell or cmd.exe and enter the following command:  
`msiexec.exe /i https://awscli.amazonaws.com/AWSCLIV2.msi`  

An AWS Installer will appear  
![](./png/screenshots/aws-cli-installer.PNG)

2. Click **Next**

Read and accept the license agreement and follow the steps in the installer. The default settings will work.

Re-open a powershell or cmd.exe and enter the command `aws --version` to check for the current version and if the installation worked.

![](./png/screenshots/aws-cli-version.PNG)

## Install Terraform
1. Download the Terraform executable from the official HashiCorp website for your system:  
https://developer.hashicorp.com/terraform/downloads  

2. Create a directory for storing the terraform executable.  
I created my folder named Terraform under the following path: **C:\HashiCorp\Terraform**

3. Move the downloaded executable in this directory
![](./png//screenshots/terraform-dir.PNG)  

4. Add this directory path to the PATH environment variable   
![](./png/screenshots/terraform-path-var.PNG)

5. Click OK to apply all changes.

Terraform should now correctly be installed. Open Powershell or cmd.exe and check for the terraform version with the command `terraform version`  
![](./png/screenshots/terraform-version.PNG)


# Add Terraform extension in VS Code
To get help with syntax validation or code formatting it is strongly recommended to install the terraform extension for visual studio code.

The extension is called "HashiCorp Terraform" and can be found in the Visual Studio Code Marketplace through the Extensions Tab.  

![](./png/screenshots/vscode-ext.PNG)  
The extension can also be downloaded directly through this link:  
https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform


# Create an AWS Access Key
So that Terraform is able to provision things an access ID and a secret access key is required.

1. Open and login into the AWS management console
2. Navigate to the **Identity and Acces Management (IAM)** service
3. Click on **Add users**
4. Define a User name, I used terraform-demo. Also very important to  
Enable **Access key - Programmatic access**
![](./png/screenshots/aws-create-user1.png)
5. Click **Next: Permissions**
6. Choose **Attach existing policies directly** and select **Administrator Access**
7. Click **Next: Tags**
8. Click **Next: Review**
9. Click **Create user**
10. Save the credentials (Access key ID & Secret access key)
![](./png/screenshots/aws-access-key.png)

**The keys won't be reviewable after this step, so it is important to note them down and save them in a secure place!**

11. Click **Close**
# Setup AWS Profile

From now on everything will be done in the VS Code Terminal.

1. Open the VS Code Terminal
2. Enter the command `aws configure --profile <profile-name>`  
I will use the profile name "tbz-project"
3. Enter the **Access key ID & Secret access key** (see the chapter above)
4. Enter **us-east-1** for the default region
5. Press Enter to let the default output format stay on [None]  
![](./png/screenshots/aws-profile.png)

6. On Windows enter the command `$env:AWS_PROFILE="tbz-project"`  
on Linux or MacOS you can use `export AWS_PROFILE=tbz-project`

# Terraform infrastructure configuration
## Provider Registry
Terraform has a website with documentations for most cloud providers and how to deploy their resources using terraform.

![](./png/screenshots/terraform-providers.PNG)
URL: https://registry.terraform.io/

For provisioning infrastructure in AWS a provider block has to be specified in the beginning of the configuration.

In the documentation it's showing us already how to use the provider block  

![](./png/screenshots/terraform-provider-block.PNG)

this configuration block can be copy & pasted in a terraform file ending with .tf for example in a file called main.tf or provider.tf.

This can be done for all the other resources (VMs, VPCs, Subnets, Security groups etc.)  
Every resource should have a documentation with an example configuration that can be used and adjusted.

## My Configuration

I created a directory called [infrastructrue](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure) and placed all my configuration files in there.
For security reasons I also added an .gitignore file, so my local state file and my lock file won't be submitted in this repository.

### Terraform files
[providers.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/providers.tf)

[network.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/network.tf)

[instances.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/instances.tf)

[s3.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/s3.tf)

[loadbalancer.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/loadbalancer.tf)

[locals.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/locals.tf)

[variables.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/variables.tf)

[outputs.tf](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/outputs.tf)

### Website file
[/website/index.html](https://github.com/k-milic/deploy-infrastructure-with-terraform/blob/main/infrastructure/website/index.html)

# Deploying terraform infrastructure

## Terraform init
After creating a terraform directory and terraform configuration files you can run the command `terraform init` to initialize the provider plugins and the backend for the terraform state file.  
![](./png/screenshots/terraform-init.PNG)

## Terraform fmt
Running the command `terraform fmt` will format the congifuration to comply with the HCL formatting. This command is pretty much unnecessary if the HashiCorp Terraform extension for VC Code mentioned above is installed. The extension is already taking care of the formatting if the file gets saved.

## Terraform validate
The command `terraform validate` is checking if the congifuration is valid. It checks if the configuration makes sense and if all necessary informations are provided in the configuration and if the syntaxes and data types are correct.  

If ther configuration is not valid, it will show where the error was found and what the possible error might be.

Here it was looking for a string and I didn't use "" around ***tcp*** to specify it as a string.
![](./png/screenshots/terraform-validate-error.PNG)

If the configuration is valid, it should give out following message:  

![](./png/screenshots/terraform-validate-success.PNG)

## Terraform plan
If the configuration is valid then the command `terraform plan` can be run. This command will compare the state file (what terraform thinks is deployed) to what is getting deployed with the configuration.  
Because right now nothing is deployed and the state file is empty, it will show everything with a green + Symbol because everything is getting added.
![](./png/screenshots/terraform-plan.PNG)

Here is a short explanation of what the different operator mean:  

![](./png/screenshots/terraform-plan-status.PNG)


## Terraform apply
To actually deploy the configuration the command `terraform apply` must be run.  
Terraform will show the planned changes like with terraform plan but now the deployment has to be confirmed with **yes**. After that the current configuration is getting provisoned and the state file is getting updated to reflect the current state of the infrastructure.  

![](./png/screenshots/terraform-apply.PNG)

After the deployment following message should appear:

![](./png/screenshots/terraform-apply-complete.PNG)

In the outputs it's showing me the public DNS of the webserver.

After entering the URL:
http://webserver-alb-905079684.us-east-1.elb.amazonaws.com/  
I can see that the webservers are running my webserver configuration.  
![](./png/screenshots/webserver-url.PNG)

## Best practice for plan & apply

It is best practice to run the command `terraform plan -out <name>.tfplan` first, so the changes are put out in a file. This file can later be applied with the command `terraform apply <name>.tfplan`

## Terraform destroy

To tear down the whole infrastructure the command `terraform destroy` can be run. This command should never be run mindlessly in a production environment!

![](./png/screenshots/terraform-destroy.PNG)

Terraform will ask to confirm this action with a **yes** before it starts tearing down the environment.

![](./png/screenshots/terraform-destroy-yes.PNG)

After the destroy process following message should appear:

![](./png/screenshots/terraform-destroy-complete.PNG)


# Testing

The infrastructre was tested on **23.01.2022** by **Kevin Milic**.


| Test  |  Result |
|---|---|
| What operating system is used for this test?  | Windows 10  |
| Is the AWS CLI installed?  |  Yes |
| What version of the AWS CLI is installed?  | The version `aws-cli/2.9.15 Python/3.9.11 Windows/10 exe/AMD64 prompt/off` is installed  |
| Is Terraform installed? |  Yes |
| What version of Terraform is currently installed? | The version `Terraform v1.3.7 on windows_amd64` is installed  |
| Is the programmatic access to AWS possible?  | Yes  |
| Is the given permission sufficient for provisioning infrastructure?  |  Yes |
| Does the permissions follow the principle of least privilege | No  |
| What backend type is used?  | Local backend |
| Is the current Terraform configuration valid?  |  Yes |
| How was the Terraform configuration applied?  | Manually in VS Code Terminal with the command `terraform plan` and then with `terraform apply`  |
| Are the created resources visible in the AWS Management Console?| [Yes](./png/screenshots/Test/resources-aws.PNG) |
| Was a VPC with the CIDR Block **10.0.0.0/16** created? | [Yes](./png/screenshots/Test/VPC.PNG)  |
| Were 2 Subnets with the CIDR Block **10.0.0.0/24** & **10.0.1.0/24** created?| [Yes](./png/screenshots/Test/Subnets.PNG)  |
| Were 2 VMs (EC2 Instances) created? | [Yes](./png/screenshots/Test/Instances.PNG) |
| Is each VM in a different subnet? | Yes. <br> [VM1](./png/screenshots/Test/VM1-subnet-ip.PNG) , [VM2](./png/screenshots/Test/VM2-subnet-ip.PNG)|
| Do both VMs have a public IP? If so, what is their public IP address?| Yes <br> VM1's IP is **3.236.153.191** <br>VM2's IP is **44.204.235.143**|
| Is an Application Load Balancer provisioned? | [Yes](./png/screenshots/Test/ALB.PNG) |
| Is a S3 Bucket provisioned? | [Yes](./png/screenshots/Test/S3.PNG) |
| Is the S3 Bucket holding an index.html file? | [Yes](./png/screenshots/Test/S3-objects.PNG) |
| Are both VMs (EC2 Instances) running on the latest Amazon Linux 2 AMI?| [Yes](./png/screenshots/Test/AMI.PNG) |
| Are both VMs running nginx? | Yes |
| Are the webservers running the configuration from the S3 Bucket?  | [Yes](./png/screenshots/webserver-url.PNG)
| Are the webservers reachable from public? | No. <br> Not reachable by [IP](./png/screenshots/Test/Not-reachable-from-public-by-ip.PNG) nor [DNS](./png/screenshots/Test/Not-reachable-from-public-by-dns.PNG). <br> Only reachable through Application Load Balancer. |
| Is every resource using the tag "TBZ-Project" | [Yes](./png/screenshots/Test/Tags.PNG) |
| After the test, did the command `terraform destroy` remove every single resource that was created? | Yes |

# Final words / Reflection

At the beginning of the cloud-native bootcamp we got told that there will be a final project, so I had time in advance to think about a project idea. In the past 6 months I really deep dived into the topic cloud and DevOps and spent a lot of free time learning about these topics. I also went ahead and studied for 7 cloud related IT certifications and passed. I did this to improve my market value and to get a role in cloud.

This project was much harder than I expected it to be. It took a lot of time researching and documenting the whole project. I really want to thank [Wahl Network](https://www.youtube.com/@WahlnetworkPage/videos) and [Ned Bellevance](https://www.youtube.com/@NedintheCloud/videos) for covering Terraform in their videos. Also The Terraform course on Pluralsight played a big part in this. Without those resources this would not have been possible. 

This project really helped me to get more hands-on experience with GIT, IaC and Cloud. I hope this project will help me building up my resume and land a role in cloud.

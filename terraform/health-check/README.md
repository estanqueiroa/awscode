## Health Check using Terraform

# Introduction

This article explains how to use Terraform to create a health check for a web application. The health check is implemented using Terraform "check" [block](https://developer.hashicorp.com/terraform/language/checks).

The check block can validate your infrastructure outside the usual resource lifecycle. Check blocks address a gap between post-apply and functional validation of infrastructure.

Based on this [article](https://amod-kadam.medium.com/health-check-using-terraform-71248e9fb508)


# Prerequisites

* Terraform installed on your local machine
* AWS account with permissions to create the necessary resources (EC2)

## Usage

Clone the repository:
```bash
git clone https://github.com/estanqueiroa/awscode.git
``` 

Navigate to the project directory:
```bash
cd /terraform/health-check
```

Initialize the Terraform working directory:
```bash
terraform init
```

Format the Terraform working directory:
```bash
terraform fmt
``` 

Validate the Terraform working directory:
```bash
terraform validate
``` 

Review the Terraform configuration files and update the necessary variables, such as the key name of EC2 instance and tags.

Plan the Terraform configuration to create the health check resources:
```bash
terraform plan
``` 

Apply the Terraform configuration to create the health check resources:
```bash
terraform apply
``` 

Verify the creation of the resources in the AWS Management Console.

## Resources Created
The Terraform configuration creates the following resources: EC2 instance with public IP address


## Cleanup
To destroy the resources created by Terraform, run the following command:

```bash
terraform destroy
``` 

## Conclusion
This Terraform configuration provides a simple and automated way to set up a health check for your web application using Terraform.

## Troubleshooting

If you cannot access the web page URL from browser, please check:

* Status code response is 200 (that means the httpd service is running fine) 
* Security Group rules applied to the EC2 instance allows HTTP (TCP/80) access from your public IP address (you can check it here https://checkip.amazonaws.com/)
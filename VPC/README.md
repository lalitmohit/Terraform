# Terraform AWS Infrastructure

This Terraform project sets up a basic infrastructure on AWS, including a VPC, subnets, internet gateway, route tables, security groups, S3 bucket, EC2 instances, and an Application Load Balancer (ALB).

## Prerequisites

Before you begin, ensure you have the following:

- [Terraform](https://www.terraform.io/downloads.html) installed on your local machine.
- AWS CLI configured with appropriate credentials.
- An AWS account with necessary permissions.

## Project Structure

The project contains the following resources:

- VPC with two subnets.
- Internet Gateway and Route Tables.
- Security Group allowing HTTP and SSH access.
- Two EC2 instances.
- An S3 bucket.
- An Application Load Balancer (ALB) with target groups and listeners.

## Usage

### Step 1: Initialize Terraform

Navigate to the project directory and initialize the Terraform working directory.

```bash
terraform init
````
### Step 2: Plan or Review 

Review the execution plan to understand what Terraform will do.

```bash
terraform plan
````
### Step 1: Create the resources

Apply the Terraform configuration to create the resources on AWS.

```bash
terraform apply
````

### Step 1: Destroy the resources
Run the command to destroy all the resources

```bash
terraform destroy
````

![Visual Representation](https://github.com/lalitmohit/Terraform/assets/107416385/1892946e-9633-4091-b264-76bf613bf09f)




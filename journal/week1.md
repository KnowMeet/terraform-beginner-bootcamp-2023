# Terraform Beginner Bootcamp 2023 - Week 1
  
  * [Root Module Structure](#root-module-structure)
  * [Terraform and Input Variables](#terraform-and-input-variables)
    + [Terraform Cloud Variables](#terraform-cloud-variables)
    + [Loading Input Variables](#loading-input-variables)
    + [Precedence of Terraform Variables](#precedence-of-terraform-variables)
  * [Dealing With Configuration Drift](#dealing-with-configuration-drift)
    + [Terraform Import](#terraform-import)
    + [Fix Manual Configuration](#fix-manual-configuration)
    + [Terraform Refersh](#terraform-refersh)
  * [Terraform Module Directory Structure](#terraform-module-directory-structure)
    + [Passing Input Variables](#passing-input-variables)
    + [Modules Sources](#modules-sources)

## Root Module Structure

The root module in Terraform is like the top-level folder for your infrastructure project. It's where you organize your main configuration files and set the overall structure for your infrastructure. Think of it as the foundation of your project, where you define what resources you want to create, and it serves as the starting point for your Terraform deployment.

Our root module structure is as follows:

```sh
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```
Refer to this webpage for more information: [Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables
In Terraform Cloud, you can set two types of variables to configure your workspace.

- **Environment Variables:** These you would set in your bash terminal eg. AWS credentials. They are commonly used for sensitive data like API keys, and they can be encrypted to enhance security.

- **Terraform Variables:** These you would normally set in your tfvars file. These are variables that you define in your Terraform configurations and can set their values in Terraform Cloud workspaces. They are often used for non-sensitive configuration parameters. We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the Terraform UI.

### Loading Input Variables

Input variables in Terraform are like parameters for your infrastructure code. They allow you to customize your deployments by providing different values for variables, making your configurations flexible and adaptable to various scenarios. Please see below how we could load Input Variables for our project.

- **-var**: We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

- **-var-file**: The `-var-file` command-line option in Terraform is like a way to provide a file containing variable values when you run Terraform commands. It's a convenient way to set multiple variables at once, simplifying the process of configuring your infrastructure without editing the main configuration file. 

- **terraform.tfvars**: To set lots of variables, it is more convenient to specify their values in a variable definition file e.g., `terraform.tfvars` and then specify that file on the command line with `-var-file:` flag. This file simplifies the management of input values and keeps your Terraform configurations clean and flexible. 

- **auto.tfvars**: `auto.tfvars` is another file in Terraform that serves a similar purpose to `terraform.tfvars`. However, it's automatically loaded by Terraform without needing to specify it explicitly. When Terraform runs, it looks for and automatically applies the variable values defined in `auto.tfvars`. This file is useful when you want to set variables without explicitly specifying the `-var-file` command-line option, making it convenient for automation and consistency in your Terraform deployments.

*NOTE*: To learn more about Variables, visit this page: [Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Precedence of Terraform Variables

Terraform variables follow a specific precedence order when determining their values. Terraform follows this order to resolve variable values, with higher-precedence sources overruling lower-precedence ones.

- **Environment Variables**: Variables set at the environment level, like in your shell or CI/CD system, take the highest precedence.

- **Terraform Cloud Workspace Variables**: Variables set within Terraform Cloud workspaces come next.

- **Terraform Variable Definitions**: Variables defined directly in your Terraform configurations. Terraform variable definitions are like labels you create in your configuration to hold values. You can use the following variable example throughout your Terraform configuration. 

```sh
    variable "instance_count" {
    description = "The number of instances to create"
     type        = number
     default     = 2 }
```

- **`terraform.tfvars`** and **`*.auto.tfvars`** Files: Values provided in these files, where `auto.tfvars` takes precedence over `terraform.tfvars`.

- **Default Values**: If no value is set anywhere else, Terraform uses the default values defined in your configuration.

## Dealing With Configuration Drift

If you lose your **Terraform state file**, it becomes challenging to manage and update your infrastructure because Terraform relies on the state to track the existing resources. In other words, you most likley have to tear down all your cloud infrastructure manually.

Terraform import can help to some extent by allowing you to re-import existing resources into your Terraform configuration. This helps Terraform regain awareness of those resources, although it won't fully restore the historical state, so it's a recovery mechanism, but not a complete solution for state file loss.You can use terraform import but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Terraform Import

To learn more about Terraform import, refer to [Terraform import](https://developer.hashicorp.com/terraform/cli/import) webpage.

**Example**: How to recover AWS S3 bucket using following command without having the Terraform state file.

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

`Terraform Plan` can't automatically fix deleted infrastructure, but it can help recreate and restore it. When someone deletes infrastructure outside of Terraform, running a terraform plan can detect the missing resources and propose a plan to recreate them. By applying the generated plan, Terraform can reestablish the deleted resources, effectively "fixing" the manual deletion, ensuring the infrastructure matches the desired configuration in your Terraform code. This ability to recover and reconcile infrastructure state is a key benefit of Terraform.

### Terraform Refersh

The `terraform refresh` command in Terraform is like a command to query your existing infrastructure to update Terraform's state file. It doesn't make any changes to your resources; instead, it helps Terraform update its knowledge about the current state of your infrastructure. This command is useful when you want to bring Terraform's state file in sync with the real-world state of your resources.

For example: `terraform apply -refresh-only -auto-approve`

## Terraform Module Directory Structure

Terraform module directory structure is simple and flexible. It usually consists of a directory containing the module's ``.tf` configuration files. It is recommended to place modules in a **modules** directory when locally developing modules. However, you can name the directory whatever way you prefer. Here's a basic structure:

```sh
- Module Directory: Contains the module's configuration files, often named with a .tf extension.
  - README.md: To describe how to use the module.
  - variables.tf: Defines input variables for the module.
  - outputs.tf: Defines the values the module will output.
  - main.tf: The main configuration file for the module.
```
### Passing Input Variables

Passing input variables to a Terraform module within its directory structure involves defining these variables in the module and setting their values when you use the module in your main configuration. Here's a simple explanation:

```tf
  module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```
### Modules Sources

Using the source, we can import the module from various places. It tells Terraform where to find the module's configuration files. Module sources can be defined using different methods:

- **Local Paths**: You can specify the module source using a local file system path, like `./modules/path-to-module-directory`, which points to a directory on your machine.

See below example to understand how we have referenced module using local path.

```tf
  module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

- **Remote URLs**: You can use URLs to modules hosted in version control systems like Git or in module registries. For example, you can specify a module source like `git::https://github.com/user/module-repo.git`.

- **Terraform registry**: A module registry is the native way of distributing Terraform modules for use across multiple configurations, using a Terraform-specific protocol that has full support for module versioning.

To learn more about it, visit:[Modules Sources](https://developer.hashicorp.com/terraform/language/modules/sources)


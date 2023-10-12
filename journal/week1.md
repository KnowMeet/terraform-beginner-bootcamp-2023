# Terraform Beginner Bootcamp 2023 - Week 1

  * [Root Module Structure](#root-module-structure)
  * [Terraform and Input Variables](#terraform-and-input-variables)
    + [Terraform Cloud Variables](#terraform-cloud-variables)
    + [Loading Input Variables](#loading-input-variables)
    + [Precedence of Terraform Variables](#precedence-of-terraform-variables)

## Root Module Structure

The root module in Terraform is like the top-level folder for your infrastructure project. It's where you organize your main configuration files and set the overall structure for your infrastructure. Think of it as the foundation of your project, where you define what resources you want to create, and it serves as the starting point for your Terraform deployment.

Our root module structure is as follows:

```
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


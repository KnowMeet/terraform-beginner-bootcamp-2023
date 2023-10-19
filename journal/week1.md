# Terraform Beginner Bootcamp 2023 - Week 1

 ## Learning Goal for This Week
 Our focus for this week's boot camp is on **Getting Comfortable with Terraform and Terraform Cloud**.
  
- [Root Module Structure](#root-module-structure)
- [Terraform and Input Variables](#terraform-and-input-variables)
  * [Terraform Cloud Variables](#terraform-cloud-variables)
  * [Loading Input Variables](#loading-input-variables)
  * [Precedence of Terraform Variables](#precedence-of-terraform-variables)
- [Dealing With Configuration Drift](#dealing-with-configuration-drift)
  * [Terraform Import](#terraform-import)
  * [Fix Manual Configuration](#fix-manual-configuration)
  * [Terraform Refersh](#terraform-refersh)
- [Terraform Module Directory Structure](#terraform-module-directory-structure)
  * [Passing Input Variables](#passing-input-variables)
  * [Modules Sources](#modules-sources)
- [Considerations using ChatGPT](#considerations-using-chatgpt)
- [Working with Files in Terraform](#working-with-files-in-terraform)
  * [Static website hosting](#static-website-hosting)
  * [Fileexists function](#fileexists-function)
  * [Filemd5](#filemd5)
  * [Path Variable](#path-variable)
- [Terraform Locals](#terraform-locals)
- [Terraform Data Sources](#terraform-data-sources)
- [Working with JSON](#working-with-json)
- [Changing the Lifecycle of Resources](#changing-the-lifecycle-of-resources)
- [Terraform Data](#terraform-data)
- [Provisioners](#provisioners)
  * [Local-exec](#local-exec)
  * [Remote-exec](#remote-exec)
    

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

```tf
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

## Considerations using ChatGPT

LLMs such as ChatGPT may not be trained on the latest documentation or information about Terraform. It may likely produce older examples that could be deprecated. Often affecting providers. Therefore, it is recommended to always verify the code with official documentation of Terraform.

## Working with Files in Terraform

Terraform is primarily designed for managing infrastructure, but it includes some file-related functions to make certain infrastructure configurations more flexible. While it's not the best tool for handling files like a dedicated file management system, these functions can be useful for scenarios where you need to check for the existence of files or their checksums within your infrastructure code, making Terraform more versatile for specific use cases. However, for advanced file management tasks, other tools specialized for that purpose might be a better choice.


### Static website hosting

Now, we have to create files for the S3 static website. In order to d that, We have created a folder called [public](/public/) and uploaded [index.html](/public/index.html) and [error.html](/public/error.html). 


### Fileexists function

This is a built in terraform function to check the existance of a file.

In our project, we have used this `condition = fileexists(var.error_html_filepath)` code to check the file's existence. 

To learn more about it, visit [Fileexists function](https://developer.hashicorp.com/terraform/language/functions/fileexists)

### Filemd5

In Terraform, the `filemd5` function is used to compute the MD5 hash of a file's content, while the `etag` is like an entity tag, typically used to represent the version of a file or resource. In some scenarios, these two can be related, as the MD5 hash of a file's content can serve as an ETag to identify that file's version. 

In our project, we have used the following piece of code to keep the track of both `index.html` and `error.html` file

```hcl
etag = filemd5(var.index_html_filepath)
etag = filemd5(var.error_html_filepath)
```
Vist [filemd5](https://developer.hashicorp.com/terraform/language/functions/filemd5) webpage to learn more about it.

### Path Variable

In terraform there is a special variable called path that allows us to reference local path.

- **.module** = get the path for the current module
- **path.root** = get the path for the root module 

In our project, we have used the following piece of code to refernce the path of s3 object.

```hcl
resource "aws_s3_object" "index_html" { bucket = aws_s3_bucket.website_bucket.bucket key = "index.html" source = "${path.root}/public/index.html" }
```
To learn more about it, visit [Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info).

## Terraform Locals

Locals allows us to define local variables. It can be very useful when we need transform data into another format and have referenced a varaible.  In Terraform, "locals" refer to a way of defining and using values within your configuration files. They provide a more efficient and cleaner way to work with values that are used multiple times within your configuration. You can think of "locals" as variables that are used for readability and to reduce redundancy in your Terraform code.

```tf
locals {
  s3_origin_id = "MyS3Origin"
}
```
To gain further insights, take a look at this webpage: [Local Values](https://developer.hashicorp.com/terraform/language/values/locals).

## Terraform Data Sources

In Terraform, data sources are like a way to fetch information from external sources or existing infrastructure and use it in your configurations. They act as a bridge to bring external data into your Terraform code. This allows use to source data from cloud resources. This is useful when we want to reference cloud resources without importing them.

```tf
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
Plase refer to [Data Sources](https://developer.hashicorp.com/terraform/language/data-sources) webpage to learn more about it.

## Working with JSON

In Terraform, `jsondecode` is a function that helps you work with JSON data within your configuration. It takes a JSON-formatted string and converts it into a data structure that Terraform can use. We have used the `jsonencode` to create the json policy inline in the hcl.

```tf
> jsonencode({"hello"="world"})
{"hello":"world"}
```
For additional information, please check out this [jsonencode](https://developer.hashicorp.com/terraform/language/functions/jsonencode). 

## Changing the Lifecycle of Resources

Changing the lifecycle of resources in Terraform means altering how Terraform manages those resources during its execution. You can change a resource's lifecycle using the lifecycle block within a resource configuration. Checkout below how we used lifecycle block that monitors the behaviour of `index.html` file.

```tf
lifecycle {
    replace_triggered_by = [terraform_data.content_version.output]
    ignore_changes = [etag]
  }
```

To learn more about it, visit [Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle).

## Terraform Data

The `terraform_data` resource type in Terraform is not a standard resource like `aws_instance`. Instead, it's a special type used to access and retrieve data or information from your Terraform configuration. You can think of it as a way to read or query data already defined in your configuration and use it elsewhere. It's particularly helpful when you need to reference specific values or results within your Terraform code. 

Here's how we have used terraform_data resource type in our project to keep the track of version of index.html which will be triggered by the `content_version` variable.

```tf
resource "terraform_data" "content_version" {
  input = var.content_version
}
```

Explore [Terraform Data](https://developer.hashicorp.com/terraform/language/resources/terraform-data) to learn more about it.

## Provisioners


Provisioners in Terraform are like scripts or commands that you can run on resources during their creation or update. They help you set up or configure resources, making them ready for use, and can also perform tasks like software installation or configuration management. In other words, Provisioners allow you to execute commands on compute instances eg. a AWS CLI command.

They are not recommended for use by HashiCorp because configuration management tools such as **Ansible** are better solutions, but the functionality exists.

Lick on [Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax) to learn more about it.

### Local-exec

In Terraform, **local-exec** is a provisioner that allows you to run commands or scripts on your local machine, where you're running Terraform, rather than on the remote resources you're managing.

```tf
resource "aws_instance" "web" {
  # ...

  provisioner "local-exec" {
    command = "echo The server's IP address is ${self.private_ip}"
  }
}
```
Checkout [local-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/local-exec) to learn more about it.

### Remote-exec

This will execute commands on a machine which you target. You will need to provide credentials such as **ssh** to get into the machine.

```tf
resource "aws_instance" "web" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)
  connection {
    type     = "ssh"
    user     = "root"
    password = var.root_password
    host     = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "puppet apply",
      "consul join ${aws_instance.web.private_ip}",
    ]
  }
}
```

Visit [remote-exec](https://developer.hashicorp.com/terraform/language/resources/provisioners/remote-exec)
to explore more about it.

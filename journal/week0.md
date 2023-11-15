 # Terraform Beginner Bootcamp 2023 - Week 0
 
  * [Semantic Verisoning](#semantic-verisoning)
  * [Install Terraform](#install-terraform)
    + [Linux Consideration](#linux-consideration)
    + [Refactoring Into Bash Script](#refactoring-into-bash-script)
      - [Shebang](#shebang)
    + [Linux Permission](#linux-permission)
  * [Gitpod Lifecycle](#gitpod-lifecycle)
  * [Environment Variables](#environment-variables)
    + [Env Command](#env-command)
    + [Set Env Vars](#set-env-vars)
    + [Print Env Vars](#print-env-vars)
    + [Scoping Of Env Vars](#scoping-of-env-vars)
    + [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
  * [Install AWS CLI](#install-aws-cli)
  * [Terraform Basics](#terraform-basics)
    + [Basic Console commands](#basic-console-commands)
    + [Terraform Lock File](#terraform-lock-file)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
    + [Terraform Cloud](#terraform-cloud)
   

## Semantic Verisoning 

In the real world, at the workplace, it is essential to add semantic in your project. Therefore, refer to this website to learn about it in detail: [semver.org](https://semver.org/). This project is utilizing semantic versioning for its tagging.

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform

Since the Terraform CLI Installtion have changed due to gpg keyring changes, we have to verify the documentaion from [Terrafrom Website](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). Refer to the page and change the script as per your linux distribution.

 ### Linux Consideration

This project is built on a Linux distribution. Please consider checking your linux distribution and installing the Terraform CLI accordingly. Since we're using [**Gitpod CDE**](https://gitpod.io/) (**Cloud Development Enviornment**), verify linux distribution using follwing command.

```sh
$ cat /etc/*release*
```

### Refactoring Into Bash Script

During the installation of the Terraform CLI, we noticed that there are many Bash script commands to execute. Therefore, let's create a Bash script to install the Terraform CLI and reduce the time spent on manual execution of each command one by one. This will not only keep our **.gitpod.yml** minimal but also allow better portability for other projects.
#### Shebang

A shebang `#!` in a Bash script is used to specify the interpreter that should execute the script. In other words, it ensures that the script runs with the correct interpreter. Therefore, make sure to include `#!` at the top of your Bash script. To learn about it more, visit [Baeldung](https://www.baeldung.com/linux/shebang)

### Linux Permission

Make sure to add executable permission to linux user in order to execute the bash script. For this, use the following command. Visit the [Redhat](https://www.redhat.com/sysadmin/linux-file-permissions-explained#:~:text=All%20Linux%20files%20belong%20to,write%2C%20and%20x%20for%20execute.) website to learn more about it.

```sh
$ chmod u+x ./bin/install_terraform_cli
```

Now, when executing the Bash script, you can use the `./` shorthand notation. 

## Gitpod Lifecycle

Since we are using Gitpod, it is imperative to be familiar with its **Workspace Lifecycle**. Provided [.gitpod.yml](.gitpod.yml) has **init** specified. It is a codetrap setup by intructor Andrew Brown, so that we could get familiar with ephemeral developer environments such as Gitpod. Basically, we have to replace **init**  with **`before`**. We have to be careful while using **init**, as it will not return existing workspace if we restart it. Please refer to [Gitpod docs](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Environment Variables

Environment Varibales **(Env Vars)** in the bash script are like tags that hold information or setting which the script can read and use. These lables help the script undersand things like where to find certain programs, what username to use or store information safely.

### Env Command

We could list out all the **(Env Vars)** using the `env` command. To filter out certain Environment variables combine `env` with ``grep`` commad like this `env | grep HOME`

### Set Env Vars

We could set up Env Vars using various methods. Some of them are as below;

- In the terminal, we could use command such as `export PROJECT_ROOT = '/workspace/folder_name'` 
- We could also set Env Var temporarily in the terminal using `PROJECT_ROOT = '/workspace/folder_name' ./bin/script_path`
- Within a bash script, we can set up the Env Var as below;

 ```sh
#!/usr/bin/env bash
PROJECT_ROOT='/workspace/folder_name'

echo $PROJECT_ROOT
```
- To **unset** an Env Var, simply use the `unset VARIABLE_NAME` e.g., `unset PROJECT_ROOT` command.

### Print Env Vars

- We could use the **echo** command to print the env vars e.g., `echo $PROJECT_ROOT`

### Scoping of Env Vars

When you open a new Bash terminal in VSCode, it will not be aware of the environment variables you have just set up in a different terminal. Therefore, if you want to persist the environment variables across all future Bash terminals, you need to set them in your Bash profile, e.g., `bash_profile`.

### Persisting Env Vars in Gitpod

We can persist environment variables (Env Vars) in Gitpod by storing them in Gitpod's Secret Storage. By using the following command, all future workspaces in Gitpod will set up the environment variables for all Bash terminals. 

```sh
gp env PROJECT_ROOT='/workspace/folder_name'
```
**NOTE:** We can also set Env Vars into *.gitpod.yml*. However, this will only contain non-sensitive env vars. 

## Install AWS CLI

AWS CLI is installed through the bash script `./bin/install_aws_cli`. Refer to this page: [Getting Started with AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html). Apart from it, just like what we have done for the `./bin/install_terraform_cli` bash script, make sure to add Linux User Permission to execute the script. Simply run follwing command in the terminal:

```sh
$ chmod u+x ./bin/install_aws_cli
```

If you are running AWS CLI locally, you have to configure credentials by running **aws configure** method. Since we are using *Gitpod CDE*, it is essential to set up environment variables to configure the AWS CLI. Refer to this page: [Env Vars for the AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

To make the Env Vars associated with AWS credentials persistent across all the future terminals, use the follwing command in the terminal:

```sh
gp env AWS_ACCESS_KEY_ID='AMIA245B6MYXDWEUYDML'
gp env AWS_SECRET_ACCESS_KEY='emfqXlUPVyNCu7sx5Ziwp35VFxyoXpT0gWiHinv2'
gp env AWS_DEFAULT_REGION='ca-central-1'
```

"Now, verify if our AWS credentials are configured correctly by using the following AWS CLI command:"

```sh
aws sts get-caller-identity
```

If you've setup the Env Var correctly for your aws credentials, you should see a json payload that will look like this:

```json
{
    "UserId": "A7892PDB6MR123DFNTIP7",
    "Account": "798612437864",
    "Arn": "arn:aws:iam::798612437864:user/username"
}
```
## Terraform Basics

Terraform allows you to define your infrastructure as code, meaning you write code to specify how your servers, networks, and other resources should be set up and configured. With Terraform, you can create, modify, and delete infrastructure resources in a consistent and repeatable way, making it easier to manage complex systems and environments. Think of it as a way to build and manage your digital world with code.

- **Terraform Registry:** The Terraform Registry is like an online library where you can find pre-built modules and configurations for Terraform, a tool used to manage infrastructure as code. Checkout the [Terraform Registry](https://registry.terraform.io/) website.
- **Terraform Providers:** Terraform Providers are like connectors that allow Terraform to interact with specific cloud or service providers like AWS, Azure, or Google Cloud. Basically, it allows us to write resource in code. Checkout one of many examples here: [Terraform Random](https://registry.terraform.io/providers/hashicorp/random/latest/docs).
- **Terraform Modules:** They are a collection of Terraform Configuration files. In other words, they are a way of providing a template to utilize commonly used actions. They are reusable sets of configurations that define and provision specific resources or components, making it easier to create and manage complex infrastructure by organizing it into modular, reusable parts.

### Basic Console commands

 - **`terraform`:** To see a list of Terraform commands by using the `terraform` command. 
 - **`terraform init`:** It prepares your Terraform project by initializing the necessary plugins and modules, ensuring you have all the right pieces to start creating and managing your infrastructure.
 - **`terraform plan`:** Think of this like a blueprint or a preview of what Terraform is about to build. When you run terraform plan, it examines your infrastructure code and tells you what changes it intends to make without actually making them.
 - **`terraform apply`:** This is where Terraform takes your blueprint, and turns it into reality. Running terraform apply executes the changes you've specified in your code, creating, updating, or deleting resources as needed. It's like giving the green light to start building your infrastructure based on the plan. 

 **Note:** When we use `terraform apply` in the terminal, it always prompts to select from *yes* or *no*. Therefore, if we want to automatically approve an apply we could use auto approve flag e.g., `terraform apply --auto-approve` 

 - **`terraform destroy`:** Terraform Destroy is like the "undo" button for your cloud infrastructure. It's a command that tells Terraform to remove and delete all the resources it previously created, helping you tear down your infrastructure easily and cleanly. Similarly as `terraform apply` we could use auto approve flag for it as well. e.g., `terraform destroy --auto-approve`

### Terraform Lock File

The file `.terraform.lock.hcl` is an example of terraform lock file. It helps ensure that only one person or process at a time can make changes to your infrastructure code. Think of it as "stoplights" that prevent conflicts when multiple people are working on the same project, so changes are made in an orderly and safe manner. Thereofe, terraform lock file **has to be commited** into the version control system such as Github. 

### Terraform State Files

Terraform state files are like a notebook that keeps track of what your infrastructure looks like currently. They store information about the resources you've created, their current settings, and their relationships. This "notebook" helps Terraform understand your infrastructure's current state, so it can make changes or updates without starting from scratch every time you run a command.

- The `terraform.tfstate` file contains the current state of our infrastructure. Since this file contains the sensitive information, it file **should not be commited** to your version control system.  
- The `terraform.tfstate.backup` file allows you to revert to the previous state if something goes wrong during an update, helping you avoid accidental data loss or configuration errors.

### Terraform Directory

Terraform Directory contains binaries of terraform providers. A Terraform directory is like a folder where you keep all the files and code needed for your infrastructure project. It's organized to hold your Terraform configuration files, modules, and any other resources in a structured way. Think of it as a workspace where you build and manage your digital infrastructure.

*Encountered Issue 1:* While configuring the S3 bucket for the first time, we realized that the Random provider was generating a mixed-string (upper and lower characters)bucket name. In contrast, AWS S3 buckets only accept lowercase characters. 

*Workaround (Issue 1):* we had to ensure that the string generated by the Random Provider creates a bucket name with only lowercase characters. Refer to the [Terraform File](main.tf) at this [release](https://github.com/KnowMeet/terraform-beginner-bootcamp-2023/tree/0.6.0).

### Terraform Cloud

Using Terraform Cloud to store Terraform state files is like keeping your important documents in a secure vault. It ensures that your infrastructure's critical information is stored safely and centrally, making it easier to collaborate with a team, maintain consistency, and manage state locking, which can prevent conflicts when multiple people are working on the same infrastructure.

*Encountered Issue 2:* When we attempt to run `terraform login` command to login, and migrate Terraform state file to [Terraform Cloud](https://app.terraform.io/) via Gitpod terminal, it shows a wysiwyg view. However, it does not work as expected in Gitpod VsCode browser.

*Workaround (Issue 2):* Follow the belows steps to resolve this issue.

 - Generate a Terraform Cloud API token manually from [Token page](https://app.terraform.io/app/settings/tokens?source=terraform-login).

 - Since the Terraform will store the token in plain text in the `json file`, create this file manually in Gitpod terminal using below commands at this location. 

 ```sh
  touch /home/gitpod/.terraform.d/credentials.tfrc.json
  open /home/gitpod/.terraform.d/credentials.tfrc.json
 ```
- Provide the following code and replace your token in the file. 

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "your-terraform-cloud-api-token"
    }
  }
}
```
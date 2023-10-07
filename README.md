# Terraform Beginner Bootcamp 2023

Hi, everyone! Recently, I embarked on an incredible journey by enrolling in the **Terraform Beginner Bootcamp 2023** hosted on [ExamPro](https://www.exampro.co/) by the amazing [Andrew Brown](https://linkedin.com/in/andrew-wc-brown). Now, I'm absolutely thrilled to bring you along on this thrilling adventure! 🌄 I'll be sharing all the awesome technical knowledge and skills that I've been soaking up during this bootcamp.:notebook_with_decorative_cover: 

 To get in on the action, all you need to do is grab your own piece of this excitement. Start by copying the Terraform Bootcamp repository from this
[Github repository](https://github.com/Examproco/terraform-beginner-bootcamp-2023) and add it to your very own GitHub account. It's that easy! Join me on this epic journey of learning, growth, and building cool stuff with Terraform.

## Semantic Verisoning:

In the real world, at the workplace, it is essential to add semantic in your project. Therefore, refer to this website to learn about it in detail: [semver.org](https://semver.org/). This project is utilizing semantic versioning for its tagging.

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install Terraform

Since the Terraform CLI Installtion have changed due to gpg keyring changes, we have to verify the documentaion from [Terrafrom Website](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli). Refer to the page and change the script as per your linux distribution.

 ### Linux consideration

This project is built on a Linux distribution. Please consider checking your linux distribution and installing the Terraform CLI accordingly. Since we're using [**Gitpod CDE**](https://gitpod.io/) (**Cloud Development Enviornment**), verify linux distribution using follwing command.

```sh
$ cat /etc/*release*
```

### Refactoring into Bash Script

During the installation of the Terraform CLI, we noticed that there are many Bash script commands to execute. Therefore, let's create a Bash script to install the Terraform CLI and reduce the time spent on manual execution of each command one by one. This will not only keep our [.gitpod.yml](.gitpod.yml) minimal but also allow better portability for other projects.
#### Shebang

A shebang `#!` in a Bash script is used to specify the interpreter that should execute the script. In other words, it ensures that the script runs with the correct interpreter. Therefore, make sure to include `#!` at the top of your Bash script. To learn about it more, visit [Baeldung](https://www.baeldung.com/linux/shebang)

The bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

### Linux Permission

Make sure to add executable permission to linux user in order to execute the bash script. For this, use the following command. Visit the [Redhat](https://www.redhat.com/sysadmin/linux-file-permissions-explained#:~:text=All%20Linux%20files%20belong%20to,write%2C%20and%20x%20for%20execute.) website to learn more about it.

```sh
$ chmod u+x ./bin/install_terraform_cli
```

Now, when executing the Bash script, you can use the `./` shorthand notation. 

## Gitpod lifecycle (before, init, command)

Since we are using Gitpod, it is imperative to be familiar with its **Workspace Lifecycle**. Provided [.gitpod.yml](.gitpod.yml) has **init** specified. It is a codetrap setup by intructor Andrew Brown, so that we could get familiar with ephemeral developer environments such as Gitpod. Basically, we have to replace **init**  with **`before`**. We have to be careful while using **init**, as it will not return existing workspace if we restart it. Please refer to [Gitpod docs](https://www.gitpod.io/docs/configure/workspaces/tasks)

## Environment Variables

Environment Varibales **(Env Vars)** in the bash script are like tags that hold information or setting which the script can read and use. These lables help the script undersand things like where to find certain programs, what username to use or store information safely.

### Env command

We could list out all the **(Env Vars)** using the `env` command. To filter out certain Environment variables combine `env` with ``grep`` commad like this `env | grep HOME`

### How to Set/Unset **(Env Vars)**

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

### How to print Env Vars

- We could use the **echo** command to print the env vars e.g., `echo $PROJECT_ROOT`

### Scoping of Env Vars

When you open a new Bash terminal in VSCode, it will not be aware of the environment variables you have just set up in a different terminal. Therefore, if you want to persist the environment variables across all future Bash terminals, you need to set them in your Bash profile, e.g., `bash_profile`.

### Persisting Env Vars in Gitpod

We can persist environment variables (Env Vars) in Gitpod by storing them in Gitpod's Secret Storage. By using the following command, all future workspaces in Gitpod will set up the environment variables for all Bash terminals. 

```sh
gp env PROJECT_ROOT='/workspace/folder_name'
```
**NOTE:** We can also set Env Vars into *.gitpod.yml*. However, this will only contain non-sensitive env vars. 
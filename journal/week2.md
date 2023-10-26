# Terraform Beginner Bootcamp 2023 - Week 2

 Our focus for this week's boot camp is on **Launching and Connecting our Terra house to TerraTowns.**

- [project framework](#project-framework)
- [Terratowns Mock Server](#terratowns-mock-server)
- [Ruby](#ruby)
  * [Install Gems](#install-gems)
  * [Executing Ruby Scripts](#executing-ruby-scripts)
  * [Sinatra](#sinatra)
  * [Running the web server](#running-the-web-server)
- [Custom provider](#custom-provider)
  * [main.go](#maingo)
  * [.terraformrc](#terraformrc)
  * [build_provider](#build-provider)
  * [go.mod](#gomod)

## project framework

We have a custom provider that is built on golang called (terraform-provider-terratowns). Typically, the custom provider consists of four different actions (**CRUD**), namely Create, Read, Update, and Delete. It is the standard for all providers that we have to define a resource. In our case, the resource is (**Home**). Another way we can interact with our server is through the use of **CRUD** bash scripts, specifically [/bin/terratowns](/bin/terratowns/). The purpose of these bash scripts is to mock the endpoints e.g, HTTP requests. 

When you create a custom provider(**Terratowns**), it is quite difficult to test it agaist the live server. Therefore, we have two server; production server(**terratowns.cloud**), and development server(Mock), serving to localhost `localhost:4567`. So main idea is to use **CRUD** bash scripts against the mock server, then build our provider using golang, test it against mock server and finally test the provider with production server.

## Terratowns Mock Server

First of all, clone this [Mock server](https://github.com/ExamProCo/terratowns_mock_server) from Github into our repo. Use the following commands to remove the **.git** file that is present in the mock server repo.

```
cd terratowns_mock_server 
rm -rf .git
```
Now, make sure to move the **CRUD** bash scripts that are present in the [terratown_mock_server/bin/](terratown_mock_server/bin/) to the top level of [bin/terratowns](/bin/terratowns/) directory and make it executable using the following command.

```sh
chmod u+x bin/terratowns/*
```

## Ruby
The mock server is built in Ruby. Therefore, it is imperative to understand basic attributes of Ruby.

**Bundler:** In Ruby, "Bundler" is a package manager for ruby. It is the primary way to install ruby packages (known as gems) for ruby. It is a tool that helps manage the dependencies (libraries and gems) that your Ruby application needs to run.

### Install Gems
You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org" 

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```
Then you need to run the `bundle install` command.  This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules). A `Gemfile.lock` will be created to lock down the gem versions used in this project.

### Executing Ruby Scripts

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context. Therefore, in our case, in [.gitpod.yml](.gitpod.yml), we need to set the following command.

```rb
bundle exec
```

### Sinatra

Sinatra is a lightweight web framework for Ruby that is designed for creating simple web applications and APIs. It is great for mock or development servers or for very simple projects.  It provides a minimalistic and flexible structure for building web applications with minimal boilerplate code. 

Visit the [Sinatra](https://sinatrarb.com/) webpage, to learn about it more.

### Running the web server

Since we are using Gitpod, we can run the web server by placing the following commands in the [.gitpod.yml](.gitpod.yml) file. 

```rb
bundle install
bundle exec ruby server.rb
```
*Note:* All of the code for our server is stored in the server.rb file.

## Custom provider

Creating a Custom provider in Terraform is helpful because it allows you to manage resources and services that aren't natively supported by Terraform. Basically, it is a way to interact with APIs and resources. In our case, we are building a custom provider (**terraform-provider-terratowns**) for the Terraform in golang. 

### main.go 

In the **main.go** file we have built a custom provider code for our Terraform provider under [terraform-provider-terratowns](/terraform-provider-terratowns/) folder.

### .terraformrc

To override default settings, and specify where to look for custom providers we use **.terraformrc** file. In this file, we have to specify the hidden directory of **terraform.d/plugins**. Generated binary files will reside in this folder, giving custom provider to use necessary plugins for the project.  

### build_provider

This Bash script [bin/build_provider](/bin/build_provider) is designed to build and install a local Terraform provider, **terraform-provider-terratowns**. It basically does the following things:

- Defining variables for the plugin directory and name.
- Building the provider from the source code and copying it to the appropriate directories.
- Removing any existing Terraform caches and lock files, ensuring the new provider is available for use.

### go.mod

This [terraform-provider-terratowns/go.mod](/terraform-provider-terratowns/go.mod) allows the project to use the local version of the module during development, making it easier to test changes or modifications before committing them to the remote repository.

After setting up the code for the custom provider run following commands in CLI:

```go
cd terraform-provider-terratowns
go mod init 
go get github.com/hashicorp/terraform-plugin-sdk/v2/helper/schema
go get github.com/hashicorp/terraform-plugin-sdk/v2/plugin
go build -o terraform-provider-terratowns_v1.0.0
```
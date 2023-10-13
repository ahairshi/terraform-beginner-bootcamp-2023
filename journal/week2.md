# Terraform Beginner Bootcamp 2023 - Week 2

## Working with Ruby

### Bundler

Bundler is a package manager for runy.
It is the primary way to install ruby packages (known as gems) for ruby.

#### Install Gems

You need to create a Gemfile and define your gems in that file.

```rb
source "https://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```

Then you need to run the `bundle install` command

This will install the gems on the system globally (unlike nodejs which install packages in place in a folder called node_modules)

A Gemfile.lock will be created to lock down the gem versions used in this project.

#### Executing ruby scripts in the context of bundler

We have to use `bundle exec` to tell future ruby scripts to use the gems we installed. This is the way we set context.

### Sinatra

Sinatra is a micro web-framework for ruby to build web-apps.

Its great for mock or development servers or for very simple projects.

You can create a web-server in a single file.

https://sinatrarb.com/

## Terratowns Mock Server

### Running the web server

We can run the web server by executing the following commands:

```rb
bundle install
bundle exec ruby server.rb
```

All of the code for our server is stored in the `server.rb` file.

## CRUD

Terraform Provider resources utilize CRUD.

CRUD stands for Create, Read Update, and Delete

https://en.wikipedia.org/wiki/Create,_read,_update_and_delete

## How do I set terraform vairables via env vars -  ChatGPT


Terraform allows you to set input variables using environment variables. This can be useful for keeping secrets out of your Terraform code or for changing variable values without having to modify your configuration. 

Here are the steps on how to set Terraform variables via environment variables:

1. **Naming Convention**: 
   - The environment variables used by Terraform follow a specific naming pattern: `TF_VAR_name`, where `name` is the name of the Terraform variable. For example, if you have a variable in your Terraform configuration like:
     ```hcl
     variable "region" {
       description = "The AWS region"
       default     = "us-west-1"
     }
     ```
     You'd use an environment variable named `TF_VAR_region` to set its value.

2. **Setting the Environment Variable**:
   - Depending on your shell, you can set the environment variable using the `export` command (Bash, Zsh) or the `set` command (Windows CMD).
     - Bash/Zsh:
       ```bash
       export TF_VAR_region="us-east-1"
       ```
     - Windows CMD:
       ```cmd
       set TF_VAR_region=us-east-1
       ```

3. **Apply Configuration**:
   - After setting the environment variable, when you run `terraform apply`, Terraform will use the value from the environment variable for the corresponding input variable. 

4. **Verifying the Environment Variable Value**:
   - You can verify the value of a Terraform variable set by an environment variable by using the `terraform plan` command or by inspecting your infrastructure after running `terraform apply`.

5. **Tips**:
   - Remember that command line-defined variables and values defined in a `terraform.tfvars` or `*.auto.tfvars` file will override environment variable settings. This order of precedence allows for flexibility in managing variable values.
   - Environment variables are particularly useful for sensitive values that you might not want to store in source code or version control, but always be careful about where and how you set these variables, especially if they contain sensitive information.

In conclusion, by leveraging environment variables with Terraform, you can create flexible and dynamic configurations that are both manageable and secure.

## Ways of setting user-specific environment variables

- [Gitpod Env Variables](https://www.gitpod.io/docs/configure/projects/environment-variables)

gp can only interact with the persistent environment variables for this repository, not the environment variables of your terminal. If you want to set that environment variable in your terminal, you can do so using -e:

```
eval $(gp env -e foo=bar)
```

To update the current terminal session with the latest set of persistent environment variables, use:

```
eval $(gp env -e)
```

To delete a persistent environment variable use:

```gp env -u foo

# And if you want to remove it from your shell session too:
unset foo
```
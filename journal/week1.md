# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

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

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_ud="my-user_id"`

### var-file flag

- TODO: document this flag

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

- TODO: document this functionality for terraform cloud

### order of terraform variables

- TODO: document which terraform variables takes presendence.


## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift

```
aws_s3_bucket.example: Refreshing state... [id=1s74yhd0ujfy7pq1btthk6dtjgl5pmbn]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_s3_bucket.example must be replaced
-/+ resource "aws_s3_bucket" "example" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      ~ arn                         = "arn:aws:s3:::1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)
      ~ bucket                      = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" # forces replacement -> (known after apply) # forces replacement
      ~ bucket_domain_name          = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn.s3.amazonaws.com" -> (known after apply)
      + bucket_prefix               = (known after apply)
      ~ bucket_regional_domain_name = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn.s3.ap-south-1.amazonaws.com" -> (known after apply)
      + force_destroy               = false
      ~ hosted_zone_id              = "Z11RGJOFQNVJUP" -> (known after apply)
      ~ id                          = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)
      ~ object_lock_enabled         = false -> (known after apply)
      + policy                      = (known after apply)
      ~ region                      = "ap-south-1" -> (known after apply)
      ~ request_payer               = "BucketOwner" -> (known after apply)
        tags                        = {
            "UserUuid" = "50919c65-8cce-4d2a-8370-ad918bfd65b8"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
        # (1 unchanged attribute hidden)

      - grant {
          - id          = "ec672b26479961e5e74620041a4b37e634b24ca2d81617b85d8f699a1d7ef20b" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
        }

      - server_side_encryption_configuration {
          - rule {
              - bucket_key_enabled = false -> null

              - apply_server_side_encryption_by_default {
                  - sse_algorithm = "AES256" -> null
                }
            }
        }

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

  # random_string.bucket_name will be created
  + resource "random_string" "bucket_name" {
      + id          = (known after apply)
      + length      = 32
      + lower       = true
      + min_lower   = 0
      + min_numeric = 0
      + min_special = 0
      + min_upper   = 0
      + number      = true
      + numeric     = true
      + result      = (known after apply)
      + special     = false
      + upper       = false
    }

Plan: 2 to add, 0 to change, 1 to destroy.

Changes to Outputs:
  + random_bucket_name = (known after apply)

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now. 
```

```
random_string.bucket_name: Refreshing state... [id=1s74yhd0ujfy7pq1btthk6dtjgl5pmbn]
aws_s3_bucket.example: Refreshing state... [id=1s74yhd0ujfy7pq1btthk6dtjgl5pmbn]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # aws_s3_bucket.example must be replaced
-/+ resource "aws_s3_bucket" "example" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      ~ arn                         = "arn:aws:s3:::1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)
      ~ bucket                      = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" # forces replacement -> (known after apply) # forces replacement
      ~ bucket_domain_name          = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn.s3.amazonaws.com" -> (known after apply)
      + bucket_prefix               = (known after apply)
      ~ bucket_regional_domain_name = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn.s3.ap-south-1.amazonaws.com" -> (known after apply)
      + force_destroy               = false
      ~ hosted_zone_id              = "Z11RGJOFQNVJUP" -> (known after apply)
      ~ id                          = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)
      ~ object_lock_enabled         = false -> (known after apply)
      + policy                      = (known after apply)
      ~ region                      = "ap-south-1" -> (known after apply)
      ~ request_payer               = "BucketOwner" -> (known after apply)
        tags                        = {
            "UserUuid" = "50919c65-8cce-4d2a-8370-ad918bfd65b8"
        }
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
        # (1 unchanged attribute hidden)

      - grant {
          - id          = "ec672b26479961e5e74620041a4b37e634b24ca2d81617b85d8f699a1d7ef20b" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
        }

      - server_side_encryption_configuration {
          - rule {
              - bucket_key_enabled = false -> null

              - apply_server_side_encryption_by_default {
                  - sse_algorithm = "AES256" -> null
                }
            }
        }

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

  # random_string.bucket_name must be replaced
-/+ resource "random_string" "bucket_name" {
      ~ id          = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)
      ~ result      = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)
      ~ special     = true -> false # forces replacement
      ~ upper       = true -> false # forces replacement
        # (8 unchanged attributes hidden)
    }

Plan: 2 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  ~ random_bucket_name = "1s74yhd0ujfy7pq1btthk6dtjgl5pmbn" -> (known after apply)

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.

```
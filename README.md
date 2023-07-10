# Creating AWS Cost Explorer billing cloud watch with Terraform

## What is this?

Like the title says, this Terraform code can be used to create Cost Explorer
billing CloudWatch alarm, an SNS resource, and an email subscription to the
created SNS resource.

## Prerequisites

1. Configure AWS CLI. Once set up, you can list all configuration data, and 
the `profile name` using the following commands:

```
❯ aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************OEWE shared-credentials-file
secret_key     ****************Edl1 shared-credentials-file
    region           ap-southeast-2      config-file    ~/.aws/config

❯ aws configure list-profiles
default
```

2. Install `terraform` on your machine by following the [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
instruction. If you use Homebrew to install packages on a macOS machine, you
can install `terraform` by running the commands:

```
❯ brew tab hashicorp/tap
❯ brew install hashicorp/tap/terraform 
```

## Usage

1. Clone this repository to your local machine, change into the cloned directory:

```
❯ git clone https://github.com/kenno/aws-cost-billing-alarm

❯ cd aws-cost-billing-alarm

```

2. Create a file named `terraform.tfvars` with the following contents:

```
aws_profile = "default"                  # AWS CLI profile name

aws_account_id = "123456789012"          # Replace with your AWS account ID
endpoint_email = "youremail@example.com" # Email to receive notificantion
```

3. Configure the `currency` (default USD) and `monthly_billing_thresshold` (default $20) as desired in the `main.tf` file. The example
below sets `monthly_billing_thresshold` to **$300 USD**.

```
module "billing_cloudwatch_alert" {
  ...
  monthly_billing_threshold = 300
  currency = "USD"
}
```

4. You are now ready to run `terraform` to create a Cloudwatch billing alarm.

```
❯ terraform init
❯ terraform plan
❯ terraform apply
```

Note: when asked "Do you want to perform these actions?", enter 'yes' if you
want to proceed.

5. If everything works well, you should receive an email to confirm whether
your subscription to a SNS notification.

6. (Optional) To destroy all resources created by this Terraform, you can simply
run:

```
❯ terraform destroy
```

## Credits

The code depends on the [cost-billing-alarm](https://registry.terraform.io/modules/binbashar/cost-billing-alarm/aws/latest) module.

# terraform-aws-infrastructure

This repository contains Terraform code to provision AWS infrastructure for a small web application. The root module composes subfolders for networking (`vpc/`) and application resources (`web/`).

**Quick summary**: run `terraform init` at the repo root (it uses `backend.tf` + `tfstate.config`), then `terraform plan` and `terraform apply` to create the stacks. See the Usage section below for commands and examples.

**Prerequisites**
- Terraform (recommended >= 1.0)
- An AWS account and credentials available via environment variables or `~/.aws/credentials` (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, optional `AWS_PROFILE` and `AWS_REGION`)

**Repo layout**
- `backend.tf` - backend configuration for state
- `provider.tf` - provider configuration (AWS)
- `main.tf` - root module resources and module calls
- `variables.tf` - root-level variables
- `tfstate.config` - backend config used for `terraform init`
- `vpc/` - module or stack that configures VPC, subnets, routing
- `web/` - module or stack that deploys web resources (EC2, ASG, ALB, etc.)

How this project is organized: the root module wires together the `vpc` and `web` directories. Each subfolder contains its own Terraform config so you can also operate on them independently when needed.

**Files of interest**
- `vpc/main.tf`, `vpc/variables.tf`, `vpc/outputs.tf` — networking stack
- `web/main.tf`, `web/variables.tf`, `web/outputs.tf` — application stack

Usage
-----
Recommended workflow (safe and reproducible):

1. Initialize Terraform (uses `tfstate.config` to configure backend):

```bash
terraform init -backend-config="tfstate.config"
```

2. (Optional) Format and validate:

```bash
terraform fmt -check
terraform validate
```

3. Create an execution plan:

```bash
terraform plan -out="plan.tfplan"
```

4. Apply the saved plan:

```bash
terraform apply "plan.tfplan"
```

5. To destroy the infrastructure:

```bash
terraform destroy
```

Notes and options
-----------------
- To pass variable values from a file use `-var-file=secrets.tfvars`.
- If you want to operate on a specific sub-stack, `cd` into the folder and run `terraform init` and `terraform apply` there:

```bash
cd vpc
terraform init -backend-config="../tfstate.config"
terraform apply
```

- You can also use `-target` for quick, temporary targeting (not recommended for regular workflows).
- Keep secrets out of VCS. Use `-var-file` excluded via `.gitignore` or environment variables `TF_VAR_<name>`.

Best practices
--------------
- Use remote state locking (backend.tf configured).
- Review plans before apply and use saved plans for reproducible applies.
- Use workspaces or separate state files per environment (dev/stage/prod) as needed.

Next steps
----------
- Verify AWS credentials: `aws sts get-caller-identity`.
- Run `terraform init` and `terraform plan` from the repository root to preview changes.
- If you want, I can add example `secrets.tfvars`, CI pipeline snippets, or a simple `Makefile` to simplify commands.

License & Authors
-----------------
Update this section with author and license information as appropriate.

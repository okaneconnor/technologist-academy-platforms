---
marp: true
theme: default
paginate: true
backgroundColor: #ffffff
color: #333333
style: |
  section {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    padding: 60px;
  }

  h1 {
    color: #2E8B57;
    font-size: 2.8rem;
    font-weight: 700;
    text-align: center;
    margin-bottom: 1.5rem;
  }

  h2 {
    color: #1E90FF;
    font-size: 1.8rem;
    font-weight: 600;
    border-bottom: 3px solid #2E8B57;
    padding-bottom: 0.5rem;
    margin-bottom: 1rem;
  }

  h3 {
    color: #2E8B57;
    font-size: 1.4rem;
    font-weight: 600;
    margin: 1rem 0;
  }

  ul {
    list-style: none;
    padding-left: 0;
  }

  li {
    padding-left: 1.5rem;
    margin: 0.8rem 0;
    position: relative;
  }

  li::before {
    content: "●";
    color: #2E8B57;
    font-size: 1.2rem;
    position: absolute;
    left: 0;
  }

  strong {
    color: #2E8B57;
    font-weight: 600;
  }

  blockquote {
    border-left: 5px solid #2E8B57;
    padding-left: 1rem;
    margin: 1rem 0;
    font-style: italic;
    color: #555;
  }

  code {
    background: #f4f4f4;
    color: #2E8B57;
    padding: 0.2rem 0.5rem;
    border-radius: 3px;
    font-family: monospace;
  }

header: 'Kainos'
footer: 'AI-Native Academy 2026 | Platform Engineering'
---

# Terraform Core Commands

---

## You'll use these constantly

These commands form the standard workflow for provisioning and managing infrastructure. Get comfortable with them — you'll run them every day.

---

## Initialise your workspace

```bash
terraform init
```

Downloads provider plugins and sets up your backend.

Run this **once** when you start a new project, and again whenever you add new providers or change your backend configuration.

---

## Check your syntax

```bash
terraform validate
```

Validates your configuration files without connecting to Azure.

> Use this to catch syntax errors and misconfigurations before running `plan`. It's fast and costs nothing.

---

## Preview changes

```bash
terraform plan
```

Shows exactly what Terraform will create, update, or delete — without touching anything.

**Always run this before applying.** The output uses symbols:

- `+` creates a new resource
- `~` modifies an existing resource
- `-` deletes a resource
- `-/+` replaces a resource (deletes then recreates)

---

## Apply changes

```bash
terraform apply
```

Applies your configuration to Azure. Terraform shows you the plan and asks for confirmation — type `yes` to proceed.

---

## Skipping the prompt

```bash
terraform apply -auto-approve
```

Skips the confirmation step entirely.

> Use `auto-approve` only in CI/CD pipelines or when you're certain about the changes. Never use it if you haven't reviewed the plan output.

---

## Destroy resources

```bash
terraform destroy
```

Deletes **all** resources Terraform manages in the current state.

> Use this to clean up when you're done testing. Treat it with the same caution as `apply` — always review the plan output first.

---

## Format your code

```bash
terraform fmt
```

Formats all `.tf` files to match Terraform's style conventions.

Run this before committing code. In our pipeline, `terraform fmt -check` will fail the build if files aren't formatted correctly — so run it locally first.

---

## Check your version

```bash
terraform version
```

Shows your installed Terraform version. Useful when troubleshooting or confirming compatibility with a provider.

---

## The standard workflow

Here's the sequence you'll follow every time:

1. Write your configuration in `.tf` files
2. `terraform init` — once per project setup
3. `terraform validate` — catch errors early
4. `terraform plan` — review what will change
5. `terraform apply` — deploy to Azure
6. `terraform destroy` — clean up when done

> Always **validate before plan**, and always **plan before apply**.

---

## A note on state

Terraform tracks everything it manages in a **state file**. This is how it knows what exists in Azure and what needs to change.

In our pipeline, state is stored remotely in Azure Blob Storage — never commit a local `terraform.tfstate` file to your repository.

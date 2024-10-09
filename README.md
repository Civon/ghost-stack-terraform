# IaC for GhostCMS on Azure

🚧WIP

## Features
- Ghost instance with MySQL         🚧
- external cloud storage on Azure   🚧
- ~~DNS record                        🚧~~
- CDN and Cache server              🚧

## Prerequisites

- terrafrom
- export ARM credentials to environment via cloudshell/bash(credentials see notion)

## Stack(TBD)

- Cloudflare(Domain)
- Cloudfront(CDN)
- Nginx(Cache)
- Ghost
- MySQL
- Azure Storage

## Usage

in VS Code command plate:

1. Terraform: push
2. Terraform: init(once)
3. Terraform: plan, and open cloudshell via pop-up dialog
4. Terraform: apply
5. if needed, Terraform: destory 
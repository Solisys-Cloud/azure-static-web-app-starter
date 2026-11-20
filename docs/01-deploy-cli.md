# 01 - Deploy from your PC

Goal: put the `site/` folder online in a few minutes, without a pipeline.

## Prerequisites

| Tool | Check | Install (Windows) |
|---|---|---|
| Azure CLI | `az version` | `winget install Microsoft.AzureCLI` |
| Node.js LTS (for `npx`) | `node -v` | `winget install OpenJS.NodeJS.LTS` |
| An Azure subscription | `az account show` | |

## Step 1 - Create the Static Web App

Option A, with Bicep (recommended, repeatable):

```powershell
az login
az group create --name rg-demo-websites --location westeurope
az deployment group create --resource-group rg-demo-websites `
  --template-file infra/main.bicep --parameters infra/main.bicepparam
```

Option B, with the CLI only:

```powershell
az staticwebapp create --name swa-demo-cloud-site --resource-group rg-demo-websites `
  --location westeurope --sku Free
```

Both return a `defaultHostname` such as `nice-wave-0123456789.4.azurestaticapps.net`. Keep it: it is the CNAME target in [02 - Custom domain](02-custom-domain.md).

## Step 2 - Get the deployment token

```powershell
$token = az staticwebapp secrets list --name swa-demo-cloud-site `
  --resource-group rg-demo-websites --query "properties.apiKey" -o tsv
```

The token allows anyone to overwrite the site. Never commit it and never paste it in a ticket.

## Step 3 - Upload the site

Run from the repository root:

```powershell
npx.cmd @azure/static-web-apps-cli deploy ./site --deployment-token $token --env production
```

Expected result:

```text
Project deployed to https://nice-wave-0123456789.4.azurestaticapps.net
```

`npx.cmd` instead of `npx` avoids the PowerShell execution policy error. See [05 - Troubleshooting](05-troubleshooting.md).

## Update the site

Edit the files in `site/`, then run Step 3 again. The new version is live in about a minute.

## Next

- Automate the upload with GitHub Actions: [the deploy workflow](../.github/workflows/deploy-site.yml), with the token stored as the repository secret `AZURE_STATIC_WEB_APPS_API_TOKEN`.
- Add a readable address: [02 - Custom domain](02-custom-domain.md).

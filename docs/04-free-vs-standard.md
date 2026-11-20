# 04 - Free or Standard plan

Both plans serve the same site. The difference is the commitment behind it.

| | Free | Standard |
|---|---|---|
| Intended use | Personal projects | Production apps |
| SLA | None | Yes |
| Apps per subscription | 10 | 100 |
| Custom domains per app | 2 | 5 |
| Bandwidth included per month | 100 GB | 100 GB |
| Storage per environment | 250 MB | 500 MB |
| Free TLS certificates | Yes | Yes |

Source: [Hosting plans](https://learn.microsoft.com/azure/static-web-apps/plans) and [Quotas](https://learn.microsoft.com/azure/static-web-apps/quotas). Check the [pricing page](https://azure.microsoft.com/pricing/details/app-service/static/) for the current Standard price in your currency.

## Which plan when

| Situation | Plan |
|---|---|
| Demo or mockup shown to a prospect | Free |
| Personal or learning project | Free |
| Site of a paying client | Standard, for the SLA |
| More than 10 sites in one subscription | Standard |

You can move from Free to Standard at any time, without redeploying:

```powershell
az staticwebapp update --name swa-demo-cloud-site `
  --resource-group rg-demo-websites --sku Standard
```

Or set `sku = 'Standard'` in `infra/main.bicepparam` and deploy the template again.

## Other costs

- Domain name: paid to the registrar, yearly.
- No DNS zone is required in Azure when the CNAME is created at the existing DNS provider.

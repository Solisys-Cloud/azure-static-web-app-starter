# 02 - Custom domain and HTTPS

Goal: replace `nice-wave-0123456789.4.azurestaticapps.net` with an address such as `www.example.com`.

No Azure DNS zone is needed. You add one record at your current DNS provider (GoDaddy, OVH, Combell, Cloudflare...).

## Step 1 - Create the CNAME record

At your DNS provider, in the zone of `example.com`:

| Type | Name | Value | TTL |
|---|---|---|---|
| CNAME | `www` | `<defaultHostname>` | 1 hour |

Check that it resolves:

```powershell
Resolve-DnsName www.example.com -Type CNAME
```

## Step 2 - Add the domain to the Static Web App

```powershell
az staticwebapp hostname set --name swa-demo-cloud-site `
  --resource-group rg-demo-websites --hostname www.example.com
```

Azure validates the CNAME, then issues a free TLS certificate that renews automatically. The command shows `InProgress` for a few minutes: this is normal.

```powershell
az staticwebapp hostname list --name swa-demo-cloud-site `
  --resource-group rg-demo-websites -o table
```

The status must be `Ready`.

## Subdomain or apex domain

| Address | Record | Notes |
|---|---|---|
| `www.example.com`, `www.example.com` | CNAME | Simple, works with every provider |
| `example.com` (apex) | ALIAS, ANAME or A | Some registrars, GoDaddy included, do not support the record type required for an apex domain. Use `www` and a redirect, or host the zone in Azure DNS. |

Reference: [Custom domains with Azure Static Web Apps](https://learn.microsoft.com/azure/static-web-apps/custom-domain)

## Good practice

- Register client domains in the client name, so they keep their address if they change provider.
- Use a subdomain of your own company domain for demos, for example `demo.yourcompany.com`, so a demo is never mistaken for the client's official site.

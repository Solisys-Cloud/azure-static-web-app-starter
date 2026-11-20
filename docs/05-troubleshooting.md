# 05 - Troubleshooting

Real errors met while deploying this template on Windows, and how to fix them.

## `npx` is not recognized

```text
npx : The term 'npx' is not recognized as the name of a cmdlet...
```

Node.js is not installed.

```powershell
winget install OpenJS.NodeJS.LTS
# Reload PATH in the current session, so variables such as $token are kept
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
node -v
```

## `npx.ps1 cannot be loaded because running scripts is disabled`

The PowerShell execution policy blocks `npx.ps1`. Call the command file instead:

```powershell
npx.cmd @azure/static-web-apps-cli deploy ./site --deployment-token $token --env production
```

Or allow signed and local scripts for your account only:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

## `The folder "...\site" is not found`

The command runs from the wrong folder, or the archive was opened without being extracted.

```powershell
Get-ChildItem . -Recurse -Filter index.html | Select-Object FullName
```

Use the folder that contains `index.html` as the path after `deploy`.

## `Could not find StaticSitesClient local binary`

Not an error. On the first run the CLI downloads its upload client. Wait for the deployment to finish.

## `hostname set` stays `InProgress`

Azure is validating the CNAME and issuing the certificate. This usually takes a few minutes. If it lasts more than 15 minutes:

```powershell
Resolve-DnsName www.example.com -Type CNAME
```

The answer must be the `defaultHostname` of the Static Web App. Fix the record, wait for the TTL, then run `hostname set` again.

## Photos do not appear when opening `index.html` locally

The file was opened from inside the ZIP archive. Windows extracts only that file to a temporary folder, without `img/`. Extract the whole archive first, then open `index.html`.

## The link preview has no image

See [03 - Link preview](03-link-preview.md): absolute `og:image` URL, `robots.txt` not blocking, then **Scrape Again** in the Sharing Debugger.

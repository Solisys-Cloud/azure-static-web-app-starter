// Azure Static Web App for a one-page professional website.
// Deploy with:
//   az deployment group create --resource-group <rg> --template-file infra/main.bicep --parameters infra/main.bicepparam

targetScope = 'resourceGroup'

@description('Name of the Static Web App (unique in the resource group).')
@minLength(2)
@maxLength(40)
param name string

@description('Azure region for the resource metadata. Static content is served globally.')
@allowed([
  'westeurope'
  'centralus'
  'eastus2'
  'westus2'
  'eastasia'
])
param location string = 'westeurope'

@description('Hosting plan. Free for demos and personal projects, Standard for production sites (SLA).')
@allowed([
  'Free'
  'Standard'
])
param sku string = 'Free'

@description('Optional custom domain, for example www.example.com. Create the CNAME record first, then deploy.')
param customDomain string = ''

@description('Tags applied to the resource.')
param tags object = {}

resource staticSite 'Microsoft.Web/staticSites@2023-01-01' = {
  name: name
  location: location
  tags: tags
  sku: {
    name: sku
    tier: sku
  }
  properties: {
    // Content is uploaded by the SWA CLI or by GitHub Actions, not linked to a repository here.
    allowConfigFileUpdates: true
  }
}

resource domain 'Microsoft.Web/staticSites/customDomains@2023-01-01' = if (!empty(customDomain)) {
  parent: staticSite
  name: empty(customDomain) ? 'none' : customDomain
  properties: {}
}

@description('Default host name, used as the CNAME target at your DNS provider.')
output defaultHostname string = staticSite.properties.defaultHostname

@description('Resource name, used to retrieve the deployment token.')
output staticSiteName string = staticSite.name

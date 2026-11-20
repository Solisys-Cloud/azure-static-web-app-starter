using './main.bicep'

param name = 'swa-demo-cloud-site'
param location = 'westeurope'
param sku = 'Free'
param customDomain = ''
param tags = {
  project: 'cloud-consulting-website'
  environment: 'demo'
}

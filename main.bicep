param location string = 'westus3'
param storageName string = 'adamosky131313'
param namePrefix string = 'mike'

param dockerImage string = 'nginxdemos/hello'
param dockerImageTag string = 'latest'

targetScope = 'resourceGroup'

// how do we consume modules
module storage 'modules/storage.bicep' = {
  name: '${namePrefix}-storageName'
  params: {
    storageName:storageName
    location:location
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: '${namePrefix}-appPlanDeploy'
  params: {
    namePrefix:namePrefix
    location:location
  }
}

module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params: {
    location:location
    appPlanId: appPlanDeploy.outputs.planId
    dockerImage: dockerImage
    dockerImageTag: dockerImageTag
  }
}

output siteUrl string = deployWebsite.outputs.siteUrl


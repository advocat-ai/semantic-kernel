/*
Copyright (c) Microsoft. All rights reserved.
Licensed under the MIT license. See LICENSE file in the project root for full license information.

Bicep template for deploying Semantic Kernel to Azure as a web app service with an existing Azure OpenAI account.
*/

@description('Name for the deployment')
param name string = 'sk'

@description('SKU for the Azure App Service plan')
param appServiceSku string = 'B1'

@description('Location of package to deploy as the web service')
#disable-next-line no-hardcoded-env-urls // This is an arbitrary package URI
param packageUri string = 'https://skaasdeploy.blob.core.windows.net/api/skaas.zip'

@description('Model to use for chat completions')
param completionModel string = 'gpt-35-turbo'

@description('Model to use for text embeddings')
param embeddingModel string = 'text-embedding-ada-002'

@description('Completion model the task planner should use')
param plannerModel string = 'gpt-35-turbo'

@description('Azure OpenAI endpoint to use')
param endpoint string

@secure()
@description('Azure OpenAI API key')
param apiKey string


module openAI 'sk-existing-ai.bicep' = {
  name: 'openAIDeployment'
  params: {
    name: name
    appServiceSku: appServiceSku
    packageUri: packageUri
    aiService: 'AzureOpenAI'
    completionModel: completionModel
    embeddingModel: embeddingModel
    plannerModel: plannerModel
    endpoint: endpoint
    apiKey: apiKey
  }
}


output endpoint string = openAI.outputs.deployedUrl
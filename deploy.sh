#!/bin/bash
location=$2
stage=$3
serviceName=$1-$stage
resourceGroupName=$serviceName"-rg"
serviceNameToLower="$(echo $serviceName | tr '[:upper:]' '[:lower:]')"
storageAccountName="$(echo ${serviceNameToLower//"-"/""})"
echo "Creating resource group"
az group create --name $resourceGroupName --location $location
echo "Creating storage account"
az storage account create --name $storageAccountName --location $location --resource-group $resourceGroupName --sku Standard_LRS
echo "Creating function app"
az functionapp create --name $serviceName --storage-account $storageAccountName --consumption-plan-location westeurope --resource-group $resourceGroupName
echo "Publishing function locally"
dotnet build
echo "Publisihng function to Azure"
func azure functionapp publish $serviceName
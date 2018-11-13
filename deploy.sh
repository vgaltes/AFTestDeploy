#!/bin/bash
location=$2
stage=$3
serviceName=$1-$stage
resourceGroupName=$serviceName"-rg"
serviceNameToLower="$(echo $serviceName | tr '[:upper:]' '[:lower:]')"
storageAccountName="$(echo ${serviceNameToLower//"-"/""})"
az group create --name $resourceGroupName --location $location
az storage account create --name $storageAccountName --location $location --resource-group $resourceGroupName --sku Standard_LRS
az functionapp create --name $serviceName --storage-account $storageAccountName --consumption-plan-location westeurope --resource-group $resourceGroupName
func azure functionapp publish $serviceName
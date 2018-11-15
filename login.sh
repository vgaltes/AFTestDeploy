#!/bin/bash
az login --service-principal -u $azPrincipal -p $azPassword -t $azTenant

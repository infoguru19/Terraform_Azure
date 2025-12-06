#!/bin/bash

# List containers
az storage container list \
--account-name tfstate10942 \
--auth-mode key \
-o table

# List blobs inside a container
az storage blob list \
--account-name tfstate10942 \
--container-name tfstate \
--auth-mode key \
-o table

# View a blob’s content
az storage blob download \
--account-name tfstate10942 \
--container-name tfstate \
--name terraform.tfstate \
--file temp.txt \
--auth-mode key
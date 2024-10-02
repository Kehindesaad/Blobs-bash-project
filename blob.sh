#!/bin/bash

# Azure Blob Storage Upload Script
# Usage: ./blobs.sh <file_path> <container_name> <storage_account_name>

# Check if the correct number of arguments is provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <file_path> <container_name> <storage_account_name>"
    exit 1
fi

# Assign command-line arguments to variables
FILE_PATH=$1
CONTAINER_NAME=$2
STORAGE_ACCOUNT_NAME=$3
STORAGE_KEY="INPUT YOUR STORAGE KEY"

# Check if the file exists
if [ ! -f "$FILE_PATH" ]; then
    echo "Error: File '$FILE_PATH' does not exist."
    exit 1
fi

# Get the file name from the file path
FILE_NAME=$(basename "$FILE_PATH")

# Upload the file to Azure Blob Storage
echo "Uploading $FILE_NAME to container $CONTAINER_NAME in storage account $STORAGE_ACCOUNT_NAME..."

az storage blob upload \
    --account-name "$STORAGE_ACCOUNT_NAME" \
    --container-name "$CONTAINER_NAME" \
    --name "$FILE_NAME" \
    --file "$FILE_PATH" \
    --account-key $STORAGE_KEY

# Check if the upload was successful
if [ $? -eq 0 ]; then
    echo "Upload successful!"
    # Construct the URL for the uploaded file
    BLOB_URL="https://$STORAGE_ACCOUNT_NAME.blob.core.windows.net/$CONTAINER_NAME/$FILE_NAME"
    echo "File URL: $BLOB_URL"
else
    echo "Upload failed."
    exit 1
fi

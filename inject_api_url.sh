#!/bin/bash

# Script: inject_api_url.sh
# Purpose: Inject Terraform-generated API Gateway URL into weather.js frontend file.

# Path to your frontend file
FRONTEND_JS_PATH="../weatherApp/static/weather.js"

# Get the API URL from Terraform output
API_URL=$(terraform output -raw api_gateway_url)

if [[ -z "$API_URL" ]]; then
  echo "❌ API Gateway URL not found. Did you run terraform apply?"
  exit 1
fi

# Replace the existing API_BASE_URL line in weather.js
if grep -q 'const API_BASE_URL' "$FRONTEND_JS_PATH"; then
  sed -i "s|const API_BASE_URL = .*|const API_BASE_URL = \"${API_URL}\";|" "$FRONTEND_JS_PATH"
  echo "✅ API URL injected successfully: $API_URL"
else
  echo "❌ API_BASE_URL line not found in $FRONTEND_JS_PATH"
  exit 1
fi


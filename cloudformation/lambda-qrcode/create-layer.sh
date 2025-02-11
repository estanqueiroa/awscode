#!/bin/bash

# Create layer directory structure
mkdir -p nodejs/node_modules

# Create package.json in the nodejs directory
cat > nodejs/package.json << EOF
{
  "name": "qrcode-layer",
  "version": "1.0.0",
  "dependencies": {
    "qrcode": "^1.5.3",
    "@aws-sdk/client-s3": "^3.0.0",
    "@aws-sdk/client-dynamodb": "^3.0.0",
    "@aws-sdk/lib-dynamodb": "^3.0.0"
  }
}
EOF

# Install dependencies
cd nodejs
npm install
cd ..

# Create ZIP file
zip -r qrcode-layer.zip nodejs

# Publish layer
LAYER_ARN=$(aws lambda publish-layer-version \
    --layer-name qrcode-layer \
    --description "Layer for QR Code generation with AWS SDK v3" \
    --license-info "MIT" \
    --zip-file fileb://qrcode-layer.zip \
    --compatible-runtimes nodejs16.x nodejs18.x \
    --query 'LayerVersionArn' \
    --output text)

echo "Layer ARN: $LAYER_ARN"

# Clean up
rm -rf nodejs qrcode-layer.zip

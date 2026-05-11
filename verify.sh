#!/bin/bash
# ASARS Receipt Verification
# Verifies an ECDSA P-256 signed receipt using standard OpenSSL
# No proprietary tools required. No vendor access required.
#
# Usage: ./verify.sh <public_key.pem> <signature.bin> <receipt.json>
# Example: ./verify.sh trl7_ak_public.pem trl7_signature.bin receipt.json

set -e

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <public_key.pem> <signature.bin> <receipt.json>"
  exit 1
fi

PUBLIC_KEY=$1
SIGNATURE=$2
RECEIPT=$3

echo "Verifying ASARS receipt..."
echo "Public key: $PUBLIC_KEY"
echo "Signature:  $SIGNATURE"
echo "Receipt:    $RECEIPT"
echo ""

openssl dgst -sha256 \
  -verify "$PUBLIC_KEY" \
  -signature "$SIGNATURE" \
  "$RECEIPT"

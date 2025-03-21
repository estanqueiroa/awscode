
# Replace with your actual values
API_ENDPOINT="https://your-api-id.execute-api.your-region.amazonaws.com/prod"
BUCKET_NAME="your-bucket-name"
FILE_NAME="test.pdf"
FILE_PATH="./test.pdf"


# PDF file
curl -X PUT "${API_ENDPOINT}/$BUCKET_NAME/${FILE_NAME}" \
  --data-binary "@./test.pdf" \
  -H "Content-Type: application/pdf"


# # Text file
# curl -X PUT "${API_ENDPOINT}/${BUCKET_NAME}/test.txt" \
#   --data-binary "@./test.txt" \
#   -H "Content-Type: text/plain"

# # Image file
# curl -X PUT "${API_ENDPOINT}/${BUCKET_NAME}/test.jpg" \
#   --data-binary "@./test.jpg" \
#   -H "Content-Type: image/jpeg"
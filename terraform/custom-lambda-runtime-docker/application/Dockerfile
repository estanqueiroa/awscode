FROM public.ecr.aws/lambda/nodejs:16

# Copy function code
COPY app.js ${LAMBDA_TASK_ROOT}

# Command to run the Lambda function
CMD ["app.handler"]
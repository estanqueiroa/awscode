# Docker Image creation (Optional Steps)

These steps are not required because Docker Image has been built previously and pushed to Docker Hub.

Information is included here as guidance only.

## Deployment

To deploy this application, you'll need to:

Create a Dockerfile for the HTML application:

```bash
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
EXPOSE 80
```   
    
## Build and push the Docker image to AWS ECR repo:
    
* Login to ECR
```bash
aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
```

* Build the image
```bash
docker build -t days-calculator .
```

* Tag the image
```bash
docker tag days-calculator:latest <account-id>.dkr.ecr.<region>.amazonaws.com/days-calculator-repo:latest
```

* Push the image
```bash
docker push <account-id>.dkr.ecr.<region>.amazonaws.com/days-calculator-repo:latest
```

## Build and push image to Docker Hub repo:


* Build
```bash
docker build -t estanqueiroa/lifetimer:latest .
```

```bash
* Verify
docker images | grep lifetimer
```

* Login (if needed)
```bash
docker login
```

* Push
```bash
docker push estanqueiroa/lifetimer:latest
```

## To test the image locally before pushing

* Run container locally
```bash
docker run -d -p 8080:80 estanqueiroa/lifetimer:latest
```

* Check if it's running
```bash
docker ps
```

* Access http://localhost:8080 in your browser

## Docker Hub repo

[Docker image Link](https://hub.docker.com/r/estanqueiroa/lifetimer)

Docker pull command: `docker pull estanqueiroa/lifetimer`

## Test Docker image using EC2 instance

```bash
# Launch EC2 instance
aws ec2 run-instances \
    --image-id ami-0cff7528ff583bf9a \
    --instance-type t2.micro \
    --key-name your-key-pair \
    --security-groups your-sgrp \
    --user-data '#!/bin/bash
        yum update -y
        yum install -y docker
        service docker start
        systemctl enable docker
        docker run -d -p 80:80 estanqueiroa/lifetimer:latest'
```
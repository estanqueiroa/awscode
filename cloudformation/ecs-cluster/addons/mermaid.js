graph TD
    subgraph VPC
        subgraph Subnets
            ECS[ECS Cluster]
            ALB[Application Load Balancer]
        end
        SG1[ECS Service Security Group]
        SG2[ALB Security Group]
    end
    
    ECS --> ECS-Task[ECS Task Definition]
    ECS --> ECS-Service[ECS Service]
    ECS-Service --> ALB
    ALB --> ALB-Listener[ALB Listener]
    ALB-Listener --> ALB-TargetGroup[ALB Target Group]
    
    ECS-Task --> ECS-TaskRole[ECS Task Role]
    ECS-Task --> ECS-TaskExecutionRole[ECS Task Execution Role]
    
    SG1 --> ECS-Service
    SG2 --> ALB
    
    subgraph Inputs
        Container-Image[Container Image]
        VPC-ID[VPC ID]
        Subnets[Subnet IDs]
        Container-Port[Container Port]
        My-IP[My IP Address]
    end
    
    Container-Image --> ECS-Task
    VPC-ID --> SG1
    VPC-ID --> SG2
    Subnets --> ECS
    Subnets --> ALB
    Container-Port --> ECS-Task
    Container-Port --> SG1
    Container-Port --> SG2
    My-IP --> SG2
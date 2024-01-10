# Advanced Distributed Learning Initiative

The Total Learning Architecture (TLA) defines a set of policies, specifications, business rules, and standards for enabling this enterprise level learning ecosystem. It is designed to benefit from modern computing technologies, such as cloud-based deployments, microservices, and high Quality of Service (QoS) messaging services. TLA standards help organize the learning-related data required to support lifelong learning and enable defense-wide interoperability across DoD learning tools, products, and data.

## Hardware Architecture

While the TLA is platform that is independent of any specific cloud hosting environment, the TLA Reference Implementation is installed in an Amazon Web Services (AWS) virtual private cloud hosted via the ADL Initiative.

The TLA Core includes five virtual machines, which are hosted according to the dynamic load balancing that is provided as part of the AWS Virtual Private Cloud (VPC). AWS provides the back-end platform hosting, virtualization, and Domain Name Service (DNS) resolution functions.



https://adlnet.gov/guides/tla/service-definitions/TLA-Reference-Implementation.html#hardware-architecture

## Codebase

Codebase for the ADL Initiative's Total Learning Architecture (TLA) reference implementation.

https://github.com/adlnet/tla

## Deployment Status


Current resources checklist:

- ✅ adl-auth (pending: domain name)
- ❌ adl-content (missing instructions)
- ✅ adl-discovery (pending: database credentials)
- ✅ adl-kafka
- 🔨 adl-lem (This repo is here solely 👏 for 👏 reference -- these services will do nothing interesting by themselves.)
- ❌ adl-lrs-proxy (error step 4 - sudo: ./init-ssl.sh: command not found)
- ✅ adl-portal
- ✅ adl-xi (i.e. Experience Index)


## Troubleshooting

To switch to Ubuntu's default interactive shell, type "bash" to open a new interactive shell within your sh shell
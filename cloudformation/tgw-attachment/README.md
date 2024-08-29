## VPC Transit Gateway with Appliance Mode

This CloudFormation template creates the following resources:

* VPC: A new VPC with a configurable CIDR block and two subnets in different Availability Zones.
* Transit Gateway: A new Transit Gateway with DefaultRouteTableAssociation and DefaultRouteTablePropagation disabled.
* VPC Attachment: A VPC Attachment that connects the new VPC to the Transit Gateway, with Appliance Mode support enabled.

When appliance mode is chosen, traffic flow between a source and destination uses the same Availability Zone for the VPC attachment for the lifetime of that flow. By leveraging Appliance Mode, you can easily integrate network appliances into your Transit Gateway network topology, enhancing your overall security and control with an Centralized Inspection VPC.

![Alt text](../diagrams/inspection-vpc-traffic-flow-high-res.png?raw=true "Diagram Image")

## Features

* Appliance Mode Support: The key feature of this template is the enablement of Appliance Mode support on the VPC Attachment. Appliance Mode is a feature of Transit Gateways that allows you to route traffic through network appliances, such as firewalls or load balancers, before forwarding it to the final destination.
* Flexible Configuration: The template allows you to configure the VPC CIDR block and subnet CIDRs as parameters, making it easy to adapt to your specific networking requirements.
* Modular Design: The template separates the VPC, Transit Gateway, and VPC Attachment resources, making it easier to understand and modify if needed.

## Usage

To use this template, you'll need to provide the following parameters:

* VpcCidr: The CIDR block for the new VPC.
* SubnetCidrs: A comma-delimited list of subnet CIDR blocks.
* TransitGatewayName: The name of the Transit Gateway.
* VpcAttachmentName: The name of the VPC Attachment.

Once you've provided the necessary parameters, you can deploy the CloudFormation stack. The template will create the VPC, Transit Gateway, and VPC Attachment with Appliance Mode support enabled.

## Outputs

The template provides the following outputs:

* VpcId: The ID of the created VPC.
* TransitGatewayId: The ID of the created Transit Gateway.
* VpcAttachmentId: The ID of the created VPC Attachment.
* You can use these output values to reference the created resources in other parts of your infrastructure.

## Conclusion

This CloudFormation template provides a straightforward way to create a VPC, Transit Gateway, and VPC Attachment with Appliance Mode support enabled. By leveraging Appliance Mode, you can easily integrate network appliances into your Transit Gateway network topology, enhancing your overall security and control.

## References

[Amazon VPC attachments in Amazon VPC Transit Gateways](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html)

[Centralized inspection architecture with AWS Gateway Load Balancer and AWS Transit Gateway](https://aws.amazon.com/blogs/networking-and-content-delivery/centralized-inspection-architecture-with-aws-gateway-load-balancer-and-aws-transit-gateway/)

[Inspection Deployment Models with AWS Network Firewall](https://d1.awsstatic.com/architecture-diagrams/ArchitectureDiagrams/inspection-deployment-models-with-AWS-network-firewall-ra.pdf)

[Deployment models for AWS Network Firewall](https://aws.amazon.com/blogs/networking-and-content-delivery/deployment-models-for-aws-network-firewall/)
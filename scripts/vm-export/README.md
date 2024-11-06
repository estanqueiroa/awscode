## EC2 VM Export to VMware

Exporting as a VM is useful when you want to deploy a copy of an Amazon EC2 instance in your virtualization environment. 

You can export most EC2 instances to Citrix Xen, Microsoft Hyper-V, or VMware vSphere.

Check [AWS Documentation](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport.html) for all solution requirements and limitations.

# Requirements:

* Install AWS CLI

* Create an S3 bucket for storing the exported instances or choose an existing bucket. The bucket must be in the Region where you want export your VMs. 
Additionally, the bucket must belong to the AWS account where you are performing the export operation.

* Prepare your S3 bucket by attaching an access control list (ACL) containing the required grants.

* Create JSON file with export image parameters.

* Stopping EC2 instance is recommended (not mandatory).

# To create export task:

`aws ec2 create-instance-export-task --instance-id instance-id --target-environment vmware --export-to-s3-task file://C:\file.json`

# To monitor export task:

`aws ec2 describe-export-tasks --export-task-ids export-i-1234567890abcdef0`

# Pricing

When you export an instance, you are charged the standard Amazon S3 rates for the bucket where the exported VM is stored. 

In addition, there might be a small charge for the temporary use of an Amazon EBS snapshot.

# Limitations

Check all [here](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport-limits.html)



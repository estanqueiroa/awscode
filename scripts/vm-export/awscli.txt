Documentation: https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport.html

#################################

Requeriments:

Create an S3 bucket for storing the exported instances or choose an existing bucket. The bucket must be in the Region where you want export your VMs. Additionally, the bucket must belong to the AWS account where you are performing the export operation. For more information, see the Amazon Simple Storage Service User Guide.

Prepare your S3 bucket by attaching an access control list (ACL) containing the required grants.

#################################

To create export task:

aws ec2 create-instance-export-task --instance-id instance-id --target-environment vmware --export-to-s3-task file://C:\file.json

#################################

To monitor export task:

aws ec2 describe-export-tasks --export-task-ids export-i-1234567890abcdef0



# ** Querying the Current Configuration State of AWS Resources **

You can use AWS Config for inventory purpose, to query the current configuration state of AWS resources based on configuration properties for a single account and Region or across multiple accounts and Regions. You can perform ad hoc, property-based queries against current AWS resource state metadata across a list of resources that AWS Config supports.


https://docs.aws.amazon.com/config/latest/developerguide/querying-AWS-resources.html


This CFN template creates a query to generate a report that lists EC2 information containing: AWS Account ID, EC2 Name and Private IP.


After CFN template is deployed to a new stack, you can access the created query through this AWS console link (change it according the AWS region you are using):

https://sa-east-1.console.aws.amazon.com/config/home?region=sa-east-1#/queries


Query scope can be:

- this account and region only
- ConfigAggregator for multiple accounts / Organizations

Click on RUN to execute query. You can export the output as JSON or CSV file.

![Alt text](../diagrams/query-scope.jpg?raw=true "Diagram Image")
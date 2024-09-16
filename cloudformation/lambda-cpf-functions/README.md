############################
# CPF Validator / Generator
############################


This CloudFormation template creates two Lambda functions named "CPFValidator" that takes a CPF (Cadastro de Pessoas Físicas) number as input and returns a JSON response indicating whether the CPF number is valid or not, and "VPCGenerator" that generates one or more valid CPF numbers.


## Description

The CPFValidator CloudFormation template creates an AWS Lambda function that takes a CPF number as input and returns a JSON response indicating whether the CPF number is valid or not, and creates a Lambda function named "CPFGenerator" that generates one or more valid CPF numbers.

## Usage

To use this CloudFormation template, you can follow these steps:

* Save the template to a file (e.g., cpf-functions.yaml).
* Open the AWS CloudFormation console in your AWS account.
* Create a new stack and upload the lambda-cpf-functions.yaml file.
* Fill in any required parameters (e.g., the name of the Lambda function) and create the stack.
* Once the stack is created, you can invoke the Lambda function with an event that contains a cpf key with the CPF number to be validated.

Deploy using [RAIN](https://github.com/aws-cloudformation/rain) (recommended):

```bash
rain deploy lambda-cpf-functions.yaml --tags valor1=tag12345 -y
```

## CPF Validator

The Lambda function uses the following logic to validate the CPF number:

* Remove any non-digit characters from the input CPF number.
* Check if the CPF number has 11 digits.
* Check if all digits are the same (which would indicate an invalid CPF number).
* Calculate the first verification digit based on the first 9 digits.
* Calculate the second verification digit based on the first 9 digits and the first verification digit.
* Compare the calculated verification digits with the last two digits of the input CPF number.

**Testing**

* Create a test event: First, you need to create a test event that will be used to invoke the Lambda function. You can do this in the AWS Lambda console. Go to the Lambda function, and in the "Test" tab, click on "Create new test event". You can then select a template (e.g., "Hello World") and customize the event data to include a CPF number, like this:

```json
{
  "cpf": "12345678901"
}
```
* Run the test: Once you've created the test event, you can click the "Test" button to run the Lambda function with the provided event data. The function will execute, and you'll see the output in the console.

* Verify the output: The output should be a JSON response indicating whether the CPF number is valid or not, like this:

```json
{
  "valid": false,
  "message": "CPF number is invalid"
}
```

or

```json
{
  "valid": true,
  "message": "CPF number is valid"
}
```

## CPF Generator

To use this Lambda function, you can invoke it with an event that contains a quantity key with the number of CPF numbers to generate, like this:

```json
{
  "quantity": 3
}
```
**Testing**

The Lambda function will return a JSON response containing a list of the generated CPF numbers, like this:

```json
{
  "cpfs": [
    "12345678901",
    "456789012345",
    "789012345678"
  ]
}
```

## Troubleshooting

Debug the function: If the output is not as expected, you can use the CloudWatch logs to debug the function. The logs will contain information about any errors or exceptions that occurred during the function's execution.

## Cleanup

Delete stack using CloudFormation Console or RAIN:

```bash
rain rm lambda-cpf-functions
```
import aws_cdk as core
import aws_cdk.assertions as assertions

from endpoints.endpoints_stack import EndpointsStack

# example tests. To run these tests, uncomment this file along with the example
# resource in endpoints/endpoints_stack.py
def test_sqs_queue_created():
    app = core.App()
    stack = EndpointsStack(app, "endpoints")
    template = assertions.Template.from_stack(stack)

#     template.has_resource_properties("AWS::SQS::Queue", {
#         "VisibilityTimeout": 300
#     })

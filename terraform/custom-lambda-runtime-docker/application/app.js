exports.handler = async (event) => {
    // Check if the event is coming from a Lambda URL
    const response = {
        statusCode: 200,
        body: JSON.stringify({
            message: "Hello from Lambda Docker image URL!",
            requestMethod: event.requestContext.http.method,
            input: event.body ? JSON.parse(event.body) : {},
        }),
    };

    return response;
};
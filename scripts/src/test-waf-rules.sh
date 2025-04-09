#  test for WAF rules

# Example usage:
# ./test-waf-rules.sh http://waf-logging-alb-123456.us-west-2.elb.amazonaws.com

# # With verbose mode
# ./test-waf-rules.sh -v http://your-waf-url.com
# # or
# ./test-waf-rules.sh --verbose http://your-waf-url.com


#!/bin/bash
set -e

# Check if URL parameter is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [-v|--verbose] <waf-url>"
    echo "Example: $0 http://waf-logging-alb-123456.region.elb.amazonaws.com"
    echo "         $0 -v http://waf-logging-alb-123456.region.elb.amazonaws.com"
    exit 1
fi

# Parse command line arguments
VERBOSE=false
while [[ $# -gt 0 ]]; do
    case $1 in
        -v|--verbose)
            VERBOSE=true
            shift
            ;;
        *)
            BASE_URL="$1"
            shift
            ;;
    esac
done

# Configuration
DELAY="${WAF_TEST_DELAY:-1}"
TIMEOUT="${WAF_TEST_TIMEOUT:-5}"

# Validate URL format
if [[ ! $BASE_URL =~ ^https?:// ]]; then
    echo "Error: URL must start with http:// or https://"
    exit 1
fi

echo "Starting WAF tests against: $BASE_URL"
if $VERBOSE; then
    echo "Verbose mode enabled"
fi

# Helper function for requests
make_request() {
    local url="$1"
    local description="$2"
    
    echo -e "\nTesting: $description"
    echo "URL: $url"
    
    if $VERBOSE; then
        response=$(curl -v -s -w "\n%{http_code}" --max-time $TIMEOUT "$url" 2>&1)
        echo "$response"
        http_code=$(echo "$response" | tail -n1)
    else
        response=$(curl -s -w "%{http_code}" --max-time $TIMEOUT "$url")
        http_code=${response: -3}
        echo "Response code: $http_code"
    fi
    
    sleep "$DELAY"
}

# Normal traffic
make_request "$BASE_URL/" "Normal homepage request"
make_request "$BASE_URL/products.php" "Normal products page request"

# SQL Injection tests
make_request "$BASE_URL/products.php?id=1%20OR%201=1" "SQL Injection test 1"
make_request "$BASE_URL/products.php?category=electronics'%20UNION%20SELECT%20*%20FROM%20users%20--" "SQL Injection test 2"
make_request "$BASE_URL/products.php?id=1'%20OR%20'1'='1" "SQL Injection test 3"

# XSS Attack tests
make_request "$BASE_URL/products.php?search=%3Cscript%3Ealert(1)%3C/script%3E" "XSS test"

# Path traversal test
make_request "$BASE_URL/products.php?file=../../etc/passwd" "Path traversal test"

# Final normal request
make_request "$BASE_URL/products.php" "Final normal request"

echo -e "\nWAF testing completed!"


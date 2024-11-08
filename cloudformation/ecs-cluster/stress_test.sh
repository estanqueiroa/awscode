# To analyze the results, you can pipe the output to a file and use tools like awk or grep to process the data:

# ./stress_test.sh > results.txt

# # Calculate average response time
# awk '{sum+=$6} END {print "Average response time:", sum/NR, "ms"}' results.txt

# # Count HTTP status codes
# grep -oP 'HTTP \d+' results.txt | sort | uniq -c


#!/bin/bash

url="http://ecs-fa-rappl-t19yzy92krlr-1655884567.us-east-1.elb.amazonaws.com/"
num_requests=1000
concurrency=10

for i in $(seq 1 $num_requests); do
    (
        start=$(date +%s%N)
        http_code=$(curl -s -o /dev/null -w "%{http_code}" $url)
        end=$(date +%s%N)
        duration=$((($end - $start)/1000000))
        echo "Request $i: HTTP $http_code, Time: $duration ms"
    ) &

    # Limit concurrency
    if (( i % concurrency == 0 )); then
        wait
    fi
done

wait
echo "Test completed."
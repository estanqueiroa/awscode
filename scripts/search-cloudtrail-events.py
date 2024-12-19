# Here's how the script works:

# The script sets up the CloudTrail client using the boto3 library.
# It sets the time range for the search, in this case, the last 30 days.
# The search_term variable is set to the text you want to search for, in this case, "ou-ktfi-bd97v23q".
# The script initializes the next_token variable, which will be used to retrieve the next page of events if there are more than one page.
# The script then enters a loop that calls the lookup_events API to retrieve the CloudTrail events within the specified time range.
# For each event returned, the script checks if the search_term is present in the event and prints the event if it is.
# If there are more pages of events to retrieve, the script updates the next_token variable and continues the loop.

import boto3
import datetime
import sys

# Specify your AWS region
AWS_REGION = "us-east-1"  # Replace with your preferred region

# Set up the CloudTrail client with the specified region
cloudtrail = boto3.client('cloudtrail', region_name=AWS_REGION)

# Set the time range for the search
start_time = datetime.datetime.now() - datetime.timedelta(days=10)
end_time = datetime.datetime.now()

# Set the search term
search_term = "ou-ktfi-bd97v23q"
#search_term = "poc-coderepo"

# Initialize variables
next_token = None
total_events_searched = 0
matching_events_found = 0

print(f"Searching CloudTrail events from {start_time} to {end_time}")
print(f"Looking for events containing: {search_term}")

# Search CloudTrail events
while True:
    # Prepare the parameters for the LookupEvents API call
    params = {
        'StartTime': start_time,
        'EndTime': end_time
    }
    
    # Add NextToken to params only if it's not None
    if next_token:
        params['NextToken'] = next_token

    # Call the LookupEvents API
    response = cloudtrail.lookup_events(**params)

    # Update the total number of events searched
    events_in_this_batch = len(response.get('Events', []))
    total_events_searched += events_in_this_batch

    # Check if any events were found
    if 'Events' in response:
        for event in response['Events']:
            # Check if the search term is in the event
            if search_term in str(event):
                print(f"\nMatching event found:")
                print(event)
                matching_events_found += 1

    # Update progress
    sys.stdout.write(f"\rEvents searched: {total_events_searched}, Matches found: {matching_events_found}")
    sys.stdout.flush()

    # Check if there are more pages of events to retrieve
    if 'NextToken' in response:
        next_token = response['NextToken']
    else:
        break

print("\n\nSearch completed.")
print(f"Total events searched: {total_events_searched}")
print(f"Total matching events found: {matching_events_found}")
#####################################################################################
# Python script using boto3 that allows you to archive GuardDuty findings based on severity

# This script includes:

# Provides a menu to select which severity level to archive (ALL, HIGH, MEDIUM, or LOW)
# Gets the GuardDuty detector ID
# Retrieves active findings based on the selected severity
# Asks for confirmation before archiving
# Archives the findings if confirmed

# Note: GuardDuty severity levels are:

# HIGH: 8.0
# MEDIUM: 5.0
# LOW: 2.0
#####################################################################################

import boto3
import sys

def get_findings(guard_duty_client, detector_id):
    """Get all active GuardDuty findings"""
    findings = []
    paginator = guard_duty_client.get_paginator('list_findings')
    
    try:
        for page in paginator.paginate(DetectorId=detector_id, FindingCriteria={
            'Criterion': {
                'service.archived': {
                    'Eq': ['false']
                }
            }
        }):
            findings.extend(page['FindingIds'])
        return findings
    except Exception as e:
        print(f"Error getting findings: {str(e)}")
        sys.exit(1)

def get_findings_by_severity(guard_duty_client, detector_id, severity):
    """Get findings filtered by severity"""
    findings = []
    paginator = guard_duty_client.get_paginator('list_findings')
    
    try:
        for page in paginator.paginate(DetectorId=detector_id, FindingCriteria={
            'Criterion': {
                'service.archived': {
                    'Eq': ['false']
                },
                'severity': {
                    'Eq': [str(severity)]  # Convert severity to string
                }
            }
        }):
            findings.extend(page['FindingIds'])
        return findings
    except Exception as e:
        print(f"Error getting findings: {str(e)}")
        sys.exit(1)

def archive_findings(guard_duty_client, detector_id, finding_ids):
    """Archive the specified findings"""
    if not finding_ids:
        return
        
    # Process findings in batches of 50 (AWS limit)
    batch_size = 50
    for i in range(0, len(finding_ids), batch_size):
        batch = finding_ids[i:i + batch_size]
        try:
            guard_duty_client.archive_findings(
                DetectorId=detector_id,
                FindingIds=batch
            )
            print(f"Successfully archived batch of {len(batch)} findings")
        except Exception as e:
            print(f"Error archiving findings batch: {str(e)}")
            sys.exit(1)

def main():
    # Get AWS region
    region = input("Enter AWS region (e.g., us-east-1): ")
    
    # Initialize GuardDuty client with specific region
    guard_duty_client = boto3.client('guardduty', region_name=region)
    
    # Get detector ID
    try:
        detector_ids = guard_duty_client.list_detectors()['DetectorIds']
        if not detector_ids:
            print("No GuardDuty detectors found")
            sys.exit(1)
        detector_id = detector_ids[0]
    except Exception as e:
        print(f"Error getting detector ID: {str(e)}")
        sys.exit(1)

    # Menu for severity selection
    print("\nSelect severity to archive:")
    print("1. ALL findings")
    print("2. HIGH severity only")
    print("3. MEDIUM severity only")
    print("4. LOW severity only")
    print("5. Exit")

    choice = input("\nEnter your choice (1-5): ")

    findings = []
    if choice == '1':
        findings = get_findings(guard_duty_client, detector_id)
        severity_text = "ALL"
    elif choice == '2':
        findings = get_findings_by_severity(guard_duty_client, detector_id, "8.0")
        severity_text = "HIGH"
    elif choice == '3':
        findings = get_findings_by_severity(guard_duty_client, detector_id, "5.0")
        severity_text = "MEDIUM"
    elif choice == '4':
        findings = get_findings_by_severity(guard_duty_client, detector_id, "2.0")
        severity_text = "LOW"
    elif choice == '5':
        print("Exiting...")
        sys.exit(0)
    else:
        print("Invalid choice")
        sys.exit(1)

    if not findings:
        print(f"No active {severity_text} severity findings to archive")
        sys.exit(0)

    # Confirm before archiving
    confirm = input(f"\nFound {len(findings)} {severity_text} severity findings. Archive them? (y/n): ")
    
    if confirm.lower() == 'y':
        archive_findings(guard_duty_client, detector_id, findings)
        print(f"\nCompleted archiving all {severity_text} severity findings")
    else:
        print("Operation cancelled")

if __name__ == "__main__":
    main()

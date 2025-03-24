# List unused (available) EBS volumes

#!/bin/bash

#for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text); do for volumeId in $(aws ec2 describe-volumes --region "$region" --filters Name=status,Values=available --query 'Volumes[].[VolumeId]' --output text); do echo "Region: $region VolumeId $volumeId"; done; done


# for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text)
# do
#     echo "Status: Checking region $region..."
#     for volumeId in $(aws ec2 describe-volumes --region "$region" --filters Name=status,Values=available --query 'Volumes[].[VolumeId]' --output text)
#     do
#         echo "Region: $region VolumeId $volumeId"
#     done
# done


#!/bin/bash

usage() {
    echo "Usage: $0 [-a|--all] [-r|--region <region_name>]"
    echo "  -a, --all     Check all regions"
    echo "  -r, --region  Check a specific region"
    exit 1
}

check_volumes() {
    local region=$1
    echo "Status: Checking region $region..."
    for volumeId in $(aws ec2 describe-volumes --region "$region" --filters Name=status,Values=available --query 'Volumes[].[VolumeId]' --output text)
    do
        echo "Region: $region VolumeId $volumeId"
    done
}

if [[ $# -eq 0 ]]; then
    usage
fi

while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -a|--all)
            for region in $(aws ec2 describe-regions --query "Regions[].RegionName" --output text)
            do
                check_volumes "$region"
            done
            exit 0
            ;;
        -r|--region)
            if [[ -z "$2" ]]; then
                echo "Error: Region name is required with -r|--region option."
                usage
            fi
            check_volumes "$2"
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
    shift
done

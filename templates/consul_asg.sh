#!/bin/bash
aws='/usr/local/bin/aws'
MY_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | sed 's/  "region" : "\(.*\)",\?/\1/')
ASG_NAME=$($aws autoscaling describe-auto-scaling-instances --region "$REGION" --instance "$MY_INSTANCE_ID" --query 'AutoScalingInstances[0].AutoScalingGroupName' --output text)

ASG_INSTANCE_IDS=$($aws autoscaling describe-auto-scaling-groups --region "${REGION}" --auto-scaling-group-name "${ASG_NAME}" --query "AutoScalingGroups[0].Instances[].InstanceId" --output text)

ASG_INSTANCE_IPS=""
# Get private ip of each consul instance
for ASG_INSTANCE in ${ASG_INSTANCE_IDS[@]};
do
  IP=$($aws ec2 describe-instances --region "${REGION}" --instance "${ASG_INSTANCE}" --query 'Reservations[].Instances[].PrivateIpAddress' --output text)
  ASG_INSTANCE_IPS+="\"${IP}\","
done

# Remove last comma from ip list
ASG_CONSUL_IPS=$(echo ${ASG_INSTANCE_IPS%?})

# Inject new ips to consul config
sed -i "s/retry_join\"\:\[\"\"\]/retry_join\"\:\[${ASG_CONSUL_IPS}\]/g" /etc/consul/config.json

echo "CONSUL IPS: ${ASG_CONSUL_IPS}" > /var/log/consul_boot.log
# Start consul server
/etc/init.d/consul start
chkconfig --add consul

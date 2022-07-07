gcloud compute networks create managementnet --project=qwiklabs-gcp-00-303d92015d3b --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional
gcloud compute networks subnets create NAME --project=qwiklabs-gcp-00-303d92015d3b --range=IP_RANGE --stack-type=IPV4_ONLY --network=managementnet --region=REGION
gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-00-303d92015d3b --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-central1

gcloud compute firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=icmp,tcp:22,tcp:3389 --source-ranges=0.0.0.0/0

gcloud compute instances create privatenet-us-vm --zone=us-central1-f --machine-type=n1-standard-1 --subnet=privatesubnet-us

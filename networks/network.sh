gcloud compute networks create managementnet --project=qwiklabs-gcp-03-142f98f0794d --subnet-mode=custom --mtu=1460 --bgp-routing-mode=regional

gcloud compute networks subnets create managementsubnet-us --project=qwiklabs-gcp-03-142f98f0794d --range=10.130.0.0/20 --stack-type=IPV4_ONLY --network=managementnet --region=us-central1

gcloud compute networks subnets list --sort-by=NETWORK

gcloud compute --project=qwiklabs-gcp-03-142f98f0794d firewall-rules create managementnet-allow-icmp-ssh-rdp --direction=INGRESS --priority=1000 --network=managementnet --action=ALLOW --rules=tcp:22,tcp:3389 --source-ranges=0.0.0.0/0
gcloud compute firewall-rules list --sort-by=NETWORK

gcloud compute instances create privatenet-us-vm --zone=us-central1-c --machine-type=f1-micro --subnet=privatesubnet-us --image-family=debian-10 --image-project=debian-cloud --boot-disk-size=10GB --boot-disk-type=pd-standard --boot-disk-device-name=privatenet-us-vm
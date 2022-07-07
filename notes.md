# Commands GCP

* Connect to VM Instance 
gcloud compute ssh vm-internal --zone us-central1-c --tunnel-through-iap

# To acces a private bucket on GCP we'll need enable Private Google Access on provate network. 
gcloud compute instances add-access-config --network-interface=nic-internal --access-config-name=external-nat --address=    # To access the bucket we'll need to create a service account.


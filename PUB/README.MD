# GCP PUB/SUB 
Google Cloud Pub/Sub exchanges event data between apps and services. By separating senders and receivers, it enables safe, highly available communication between applications. Google Cloud Pub/Sub provides low-latency/durable communications for asynchronous workflows, event alerts, and streaming data from processes or devices.

gcloud pubsub topics create memories-topic-296
gcloud pubsub topics create Test1
gcloud pubsub topics create Test2
gcloud pubsub topics list

gcloud pubsub topics delete Test1

gcloud  pubsub subscriptions create --topic myTopic mySubscription
gcloud  pubsub subscriptions create --topic myTopic Test1
gcloud  pubsub subscriptions create --topic myTopic Test2
gcloud pubsub topics list-subscriptions myTopic

gcloud pubsub topics publish myTopic --message "Hello"
gcloud pubsub topics publish myTopic --message "Publisher's name is christian"
gcloud pubsub topics publish myTopic --message "Publisher likes to eat Hamburguesa"
gcloud pubsub topics publish myTopic --message "Publisher thinks Pub/Sub is awesome"
gcloud pubsub subscriptions pull mySubscription --auto-ack

### gcloud pubsub subscriptions pull mySubscription --auto-ack --ack-ids=<ACK_ID>
gcloud pubsub topics publish myTopic --message "Publisher is starting to get the hang of Pub/Sub"
gcloud pubsub topics publish myTopic --message "Publisher wonders if all messages will be pulled"
gcloud pubsub topics publish myTopic --message "Publisher will have to test to find out"
gcloud pubsub subscriptions pull mySubscription --auto-ack --limit=3
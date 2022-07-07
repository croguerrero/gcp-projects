mkdir gcf_hello_world
cd gcf_hello_world
nano index.js

gcloud functions deploy thumbail \
  --stage-bucket gs://memories-bucket-15801 \
  --trigger-topic memories-topic-906 \
  --runtime nodejs14

gcloud functions describe helloWorld

DATA=$(printf 'Hello World!'|base64) && gcloud functions call helloWorld --data '{"data":"'$DATA'"}'

gcloud functions logs read helloWorld
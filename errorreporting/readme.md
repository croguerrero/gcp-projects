mkdir appengine-hello
cd appengine-hello
gsutil cp gs://cloud-training/archinfra/gae-hello/* .
dev_appserver.py $(pwd)
gcloud app deploy app.yaml

sed -i -e 's/webapp2/webapp22/' main.py

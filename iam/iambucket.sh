
curl \
https://hadoop.apache.org/docs/current/\
hadoop-project-dist/hadoop-common/\
ClusterSetup.html > setup.html


gsutil acl set private gs://$BUCKET1/setup.html
gsutil acl ch -u AllUsers:R gs://$BUCKET1/setup.html

gsutil lifecycle set life.json gs://$BUCKET1 
gsutil lifecycle get gs://$BUCKET1 

gsutil versioning get gs://$BUCKET1
gsutil versioning set on gs://$BUCKET1
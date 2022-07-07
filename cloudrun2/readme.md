# Work with CLoud RUN
export PROJECT=$(gcloud config get-value project)
gcloud builds submit --tag gcr.io/$PROJECT/quickstart-image .

# Second Option 
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
ln -s ~/training-data-analyst/courses/ak8s/v1.1 ~/ak8s
cd ~/ak8s/Cloud_Build/a
gcloud builds submit --config cloudbuild.yaml .

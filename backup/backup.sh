#!/bin/bash
# Backup the database
export PROJECT=$(gcloud config get-value project)
source=""
funtion backup_folder() {
    # Backup the database
    echo "Backing up the database"
    gsutil rsync -r $source gs://$PROJECT/sql    
}

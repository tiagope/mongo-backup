#!/bin/bash
echo $(date) ' - iniciado'
echo $(date) ' - efetuando backup'
mongodump --uri $MONGO_URI --gzip --archive=/backup/backup-$(date '+%d-%m-%Y_%H-%M-%S').gz
echo $(date) ' - movendo para o s3'
aws s3 mv /backup/backup-* s3://$S3_BUCKET_BACKUP
echo $(date) ' - fim'
echo '================================================='
# Roda o backup do mongo
#
# docker run --rm -dit \#
# 	-e AWS_ACCESS_KEY_ID=<aws_acces_key> \
#   -e AWS_SECRET_ACCESS_KEY=<aws_secret_access_key> \
#   -e AWS_DEFAULT_REGION=<regiao> \
#   -e S3_BUCKET_BACKUP=<nome do bucket> \ 
#   -e MONGO_URI=<mongodb+srv://user:pass@endereco> \
#	--name mongo-backup \
#	tiagope/mongo-backup:latest

# baseado na imagem oficial do mongo
FROM mongo:7

# seta o time zone para sao paulo
ENV TZ="America/Sao_Paulo"

# instala o awscli, cron e um editor
RUN apt-get update && apt-get install -y awscli cron nano

# cria a pasta backup
RUN mkdir /backup

# copia o conteúdo do projeto para a pasta criada
COPY ./backup /backup

# permissão para o arquivo cron
RUN chmod 0644 /backup/cron/mongo-backup-cron

# Aplica o cron job
RUN crontab /backup/cron/mongo-backup-cron

# da permissão para o arquivo que será executado
RUN chmod 0700  /backup/src/job-backup.sh
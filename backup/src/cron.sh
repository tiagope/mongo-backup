#!/bin/bash

# corrige o problema das variáveis de ambiente não estarem disponíveis para o usuário cron
printenv > /etc/environment 
# inicializa o serviço do cron
cron -f
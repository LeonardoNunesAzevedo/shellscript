#!/bin/bash

# Estrutura de dados  (variaveis) 
day=`date +%d-%m-%Y`
log='/var/log'

# Algoritmo/programa  (regras de negocio)

#Recebe o e-mail de envio para o backup

clear
echo -e "\nInforme o e-mail\n"
read email

# Executa o backup de /var/log e caso tenha sucesso envia
# um email com backup com anexo, caso falhe envia email informando falha


cd $log
tar czf /backup/log-$day.tar.gz auth.log
if [ $? -eq 0 ]
     then
       echo -e "Backup do diretorio /var/log executado em $day com sucesso\nSegue backup em anexo" | mutt -s "Backup logs - $day" -a /backup/log-$day.tar.gz -- $email
else
   echo "Falha no backup de /var/log em $day" | mail -s "Falha no backup dos logs - $day" $email
fi


- SOLUÇÃO1:
Deletar o service mysql
kubectl delete service mysql -n alpha
Editar e aplicar o novo
kubectl apply -f service-editado.yaml 


- SOLUÇÃO2
Foi ajuste na targetPort do mysql, para 3306



- SOLUÇÃO3:
ajustar o selector
então o service conseguiu gerar os devidos endpoints



- SOLUÇÃO4
Editar variável via edição do Deployment:
DE:
DB_User=sql-user
PARA:
DB_User=root
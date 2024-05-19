
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


- SOLUÇÃO5
pt1
kubectl delete pod/mysql -n epsilon
ajustar password na variável MYSQL_ROOT_PASSWORD
kubectl apply -f pod-editado-mysql.yaml
pt2
vi deployment-editado-2.yaml
ajustada a variável DB_User
DB_User=root
kubectl delete -f deployment-editado-2.yaml
kubectl apply -f deployment-editado-2.yaml



- SOLUÇÃO6
pt1
ajustando variável DB_User
vi deployment-editado-3.yaml
kubectl delete -f deployment-editado-3.yaml
kubectl apply -f deployment-editado-3.yaml
pt2
possível solução, utilizar o nodeport 30081 no Service do 
web-service
kubectl edit service mysql-service -n zeta
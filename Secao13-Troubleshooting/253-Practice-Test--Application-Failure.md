#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "253. Practice Test - Application Failure."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##   253. Practice Test - Application Failure


Troubleshooting Test 1: A simple 2 tier application is deployed in the alpha namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.


Fix Issue



controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-6799fbcd5-xl2ll                   1/1     Running     0          12m
kube-system   local-path-provisioner-84db5d44d9-4b5g2   1/1     Running     0          12m
kube-system   helm-install-traefik-crd-m59l9            0/1     Completed   0          12m
kube-system   svclb-traefik-52753b44-d875f              2/2     Running     0          12m
kube-system   helm-install-traefik-htrkp                0/1     Completed   1          12m
kube-system   traefik-f4564c4f4-2vjqp                   1/1     Running     0          12m
kube-system   metrics-server-67c658944b-rjzrz           1/1     Running     0          12m
alpha         webapp-mysql-b68bb6bc8-gzzqt              1/1     Running     0          69s
alpha         mysql                                     1/1     Running     0          69s

controlplane ~ ➜  


https://30081-port-dd2c4d4a211e4cff.labs.kodekloud.com/

- ERRO

~~~~BASH
Environment Variables: DB_Host=mysql-service; DB_Database=Not Set; DB_User=root; DB_Password=paswrd; 2003: Can't connect to MySQL server on 'mysql-service:3306' (-2 Name does not resolve)

From webapp-mysql-b68bb6bc8-gzzqt!

~~~~


- Verificando services:

controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME             TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
default       kubernetes       ClusterIP      10.43.0.1      <none>        443/TCP                      13m
kube-system   kube-dns         ClusterIP      10.43.0.10     <none>        53/UDP,53/TCP,9153/TCP       13m
kube-system   metrics-server   ClusterIP      10.43.93.103   <none>        443/TCP                      13m
kube-system   traefik          LoadBalancer   10.43.211.24   192.6.194.9   80:32333/TCP,443:32374/TCP   13m
alpha         mysql            ClusterIP      10.43.29.76    <none>        3306/TCP                     2m4s
alpha         web-service      NodePort       10.43.194.6    <none>        8080:30081/TCP               2m4s

controlplane ~ ➜  


kubectl edit service mysql -n alpha

controlplane ~ ➜  kubectl edit service mysql -n alpha
A copy of your changes has been stored to "/tmp/kubectl-edit-3930516682.yaml"
error: At least one of apiVersion, kind and name was changed

controlplane ~ ✖ 




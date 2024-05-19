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


controlplane ~ ➜  kubectl get service mysql -n alpha -o yaml > service-editado.yaml

controlplane ~ ➜  vi 

controlplane ~ ➜  vi service-editado.yaml 

controlplane ~ ➜  kubectl delete service mysql -n alpha
service "mysql" deleted

controlplane ~ ➜  kubectl apply -f service-editado.yaml 
service/mysql-service created

controlplane ~ ➜  


https://30081-port-dd2c4d4a211e4cff.labs.kodekloud.com/

Environment Variables: DB_Host=mysql-service; DB_Database=Not Set; DB_User=root; DB_Password=paswrd;

From webapp-mysql-b68bb6bc8-gzzqt!

- SOLUÇÃO1:
Deletar o service mysql
kubectl delete service mysql -n alpha
Editar e aplicar o novo
kubectl apply -f service-editado.yaml 




Troubleshooting Test 2: The same 2 tier application is deployed in the beta namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue



controlplane ~ ➜  kubectl get all -n beta
NAME                               READY   STATUS    RESTARTS   AGE
pod/webapp-mysql-b68bb6bc8-2vxkw   1/1     Running   0          2m49s
pod/mysql                          1/1     Running   0          2m49s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.72.191    <none>        3306/TCP         2m49s
service/web-service     NodePort    10.43.197.220   <none>        8080:30081/TCP   2m49s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           2m49s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-b68bb6bc8   1         1         1       2m49s

controlplane ~ ➜  



https://30081-port-dd2c4d4a211e4cff.labs.kodekloud.com/
f
failed

Environment Variables: DB_Host=mysql-service; DB_Database=Not Set; DB_User=root; DB_Password=paswrd; 2003: Can't connect to MySQL server on 'mysql-service:3306' (111 Connection refused)

From webapp-mysql-b68bb6bc8-2vxkw!


controlplane ~ ➜  kubectl get pods -n beta
NAME                           READY   STATUS    RESTARTS   AGE
webapp-mysql-b68bb6bc8-2vxkw   1/1     Running   0          6m46s
mysql                          1/1     Running   0          6m46s

controlplane ~ ➜  kubectl logs webapp-mysql-b68bb6bc8-2vxkw -n beta
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)
10.42.0.1 - - [18/May/2024 18:06:45] "GET / HTTP/1.1" 200 -

controlplane ~ ➜  


controlplane ~ ➜  kubectl logs mysql -n beta
2024-05-18 18:03:12+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.6.51-1debian9 started.
2024-05-18 18:03:22 1 [Warning] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
2024-05-18 18:03:22 1 [Warning] 'proxies_priv' entry '@ root@mysql' ignored in --skip-name-resolve mode.
2024-05-18 18:03:22 1 [Note] Event Scheduler: Loaded 0 events
2024-05-18 18:03:22 1 [Note] mysqld: ready for connections.
Version: '5.6.51'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)


controlplane ~ ➜  kubectl get svc -n beta
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
mysql-service   ClusterIP   10.43.72.191    <none>        3306/TCP         9m28s
web-service     NodePort    10.43.197.220   <none>        8080:30081/TCP   9m28s

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe service mysql-service -n beta
Name:              mysql-service
Namespace:         beta
Labels:            <none>
Annotations:       <none>
Selector:          name=mysql
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.43.72.191
IPs:               10.43.72.191
Port:              <unset>  3306/TCP
TargetPort:        8080/TCP
Endpoints:         10.42.0.12:8080
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -n beta
NAME                           READY   STATUS    RESTARTS   AGE
webapp-mysql-b68bb6bc8-2vxkw   1/1     Running   0          11m
mysql                          1/1     Running   0          11m

controlplane ~ ➜  kubectl describe pod mysql -n beta
Name:             mysql
Namespace:        beta
Priority:         0
Service Account:  default
Node:             controlplane/192.6.194.9
Start Time:       Sat, 18 May 2024 18:03:09 +0000
Labels:           name=mysql
Annotations:      <none>
Status:           Running
IP:               10.42.0.12
IPs:
  IP:  10.42.0.12
Containers:
  mysql:
    Container ID:   containerd://c12ed0372dad32543804d2dda8c9d26fe95638c27c99849fb5a31b896695e437
    Image:          mysql:5.6
    Image ID:       docker.io/library/mysql@sha256:20575ecebe6216036d25dab5903808211f1e9ba63dc7825ac20cb975e34cfcae
    Port:           3306/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 18 May 2024 18:03:12 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      MYSQL_ROOT_PASSWORD:  paswrd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-5t7m6 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-5t7m6:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  11m   default-scheduler  Successfully assigned beta/mysql to controlplane
  Normal  Pulled     11m   kubelet            Container image "mysql:5.6" already present on machine
  Normal  Created    11m   kubelet            Created container mysql
  Normal  Started    11m   kubelet            Started container mysql

controlplane ~ ➜  



controlplane ~ ➜  

controlplane ~ ➜  kubectl describe pod webapp-mysql-b68bb6bc8-2vxkw -n beta
Name:             webapp-mysql-b68bb6bc8-2vxkw
Namespace:        beta
Priority:         0
Service Account:  default
Node:             controlplane/192.6.194.9
Start Time:       Sat, 18 May 2024 18:03:09 +0000
Labels:           name=webapp-mysql
                  pod-template-hash=b68bb6bc8
Annotations:      <none>
Status:           Running
IP:               10.42.0.11
IPs:
  IP:           10.42.0.11
Controlled By:  ReplicaSet/webapp-mysql-b68bb6bc8
Containers:
  webapp-mysql:
    Container ID:   containerd://b2d1898d6f67a0c167ae7ae4760286a5239a269f11cc38f82b56b1474e31255e
    Image:          mmumshad/simple-webapp-mysql
    Image ID:       docker.io/mmumshad/simple-webapp-mysql@sha256:d4d0c03fcb76cee6ae2511fa7f3f6b7090f0c5e0cb3f276687f9ddf2c689cc09
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 18 May 2024 18:03:12 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      DB_Host:      mysql-service
      DB_User:      root
      DB_Password:  paswrd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-bprqf (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-bprqf:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  12m   default-scheduler  Successfully assigned beta/webapp-mysql-b68bb6bc8-2vxkw to controlplane
  Normal  Pulling    12m   kubelet            Pulling image "mmumshad/simple-webapp-mysql"
  Normal  Pulled     12m   kubelet            Successfully pulled image "mmumshad/simple-webapp-mysql" in 281ms (281ms including waiting)
  Normal  Created    12m   kubelet            Created container webapp-mysql
  Normal  Started    12m   kubelet            Started container webapp-mysql

controlplane ~ ➜  




controlplane ~ ➜  kubectl get service mysql-service -n beta -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-18T18:03:09Z"
  name: mysql-service
  namespace: beta
  resourceVersion: "1363"
  uid: a83d9401-c363-4d36-98f0-da31fe778837
spec:
  clusterIP: 10.43.72.191
  clusterIPs:
  - 10.43.72.191
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 8080
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  



controlplane ~ ➜  kubectl edit service mysql-service -n beta 
service/mysql-service edited

controlplane ~ ➜  
controlplane ~ ✖ kubectl get svc -n beta
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
web-service     NodePort    10.43.197.220   <none>        8080:30081/TCP   15m
mysql-service   ClusterIP   10.43.72.191    <none>        3306/TCP         15m

controlplane ~ ➜  

https://30081-port-dd2c4d4a211e4cff.labs.kodekloud.com/

successs
Environment Variables: DB_Host=mysql-service; DB_Database=Not Set; DB_User=root; DB_Password=paswrd;

From webapp-mysql-b68bb6bc8-2vxkw!

- SOLUÇÃO2
Foi ajuste na targetPort do mysql, para 3306





Troubleshooting Test 3: The same 2 tier application is deployed in the gamma namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed or unresponsive. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue


controlplane ~ ➜  kubectl get all -n gamma
NAME                               READY   STATUS    RESTARTS   AGE
pod/webapp-mysql-b68bb6bc8-xn4r2   1/1     Running   0          70s
pod/mysql                          1/1     Running   0          71s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.114.129   <none>        3306/TCP         71s
service/web-service     NodePort    10.43.6.98      <none>        8080:30081/TCP   71s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           71s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-b68bb6bc8   1         1         1       71s

controlplane ~ ➜  

controlplane ~ ✖ kubectl logs pod/webapp-mysql-b68bb6bc8-xn4r2 -n gamma
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)
10.42.0.1 - - [18/May/2024 18:19:55] "GET / HTTP/1.1" 200 -
10.42.0.1 - - [18/May/2024 18:22:35] "GET / HTTP/1.1" 200 -

controlplane ~ ➜  

kubectl logs pod/mysql -n gamma
2024-05-18 18:19:42 1 [Warning] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
2024-05-18 18:19:42 1 [Warning] 'proxies_priv' entry '@ root@mysql' ignored in --skip-name-resolve mode.
2024-05-18 18:19:42 1 [Note] Event Scheduler: Loaded 0 events
2024-05-18 18:19:42 1 [Note] mysqld: ready for connections.
Version: '5.6.51'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)

controlplane ~ ➜  


controlplane ~ ✖ kubectl describe service/mysql-service -n gamma
Name:              mysql-service
Namespace:         gamma
Labels:            <none>
Annotations:       <none>
Selector:          name=sql00001
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.43.114.129
IPs:               10.43.114.129
Port:              <unset>  3306/TCP
TargetPort:        3306/TCP
Endpoints:         <none>
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  


controlplane ~ ➜  kubectl edit service/mysql-service -n gamma
service/mysql-service edited

controlplane ~ ➜  kubectl describe service/mysql-service -n gamma
Name:              mysql-service
Namespace:         gamma
Labels:            <none>
Annotations:       <none>
Selector:          name=mysql
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.43.114.129
IPs:               10.43.114.129
Port:              <unset>  3306/TCP
TargetPort:        3306/TCP
Endpoints:         10.42.0.13:3306
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  date
Sat May 18 18:25:50 UTC 2024

controlplane ~ ➜  

https://30081-port-dd2c4d4a211e4cff.labs.kodekloud.com/
Success

- SOLUÇÃO3:
ajustar o selector
então o service conseguiu gerar os devidos endpoints








Troubleshooting Test 4: The same 2 tier application is deployed in the delta namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.


https://30081-port-dd2c4d4a211e4cff.labs.kodekloud.com/
failed


controlplane ~ ➜  kubectl get all -n delta
NAME                               READY   STATUS    RESTARTS   AGE
pod/webapp-mysql-785cd8f94-796x7   1/1     Running   0          20s
pod/mysql                          1/1     Running   0          20s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.160.25   <none>        3306/TCP         20s
service/web-service     NodePort    10.43.223.78   <none>        8080:30081/TCP   20s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           20s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-785cd8f94   1         1         1       20s

controlplane ~ ➜  


controlplane ~ ➜  kubectl logs pod/webapp-mysql-785cd8f94-796x7 -n delta
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)
10.42.0.1 - - [18/May/2024 18:27:11] "GET / HTTP/1.1" 200 -

controlplane ~ ➜  


controlplane ~ ➜  kubectl logs pod/mysql -n delta
2024-05-18 18:26:47+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 5.6.51-1debian9 started.
2024-05-18 18:26:56 1 [Warning] Insecure configuration for --pid-file: Location '/var/run/mysqld' in the path is accessible to all OS users. Consider choosing a different directory.
2024-05-18 18:26:56 1 [Warning] 'proxies_priv' entry '@ root@mysql' ignored in --skip-name-resolve mode.
2024-05-18 18:26:56 1 [Note] Event Scheduler: Loaded 0 events
2024-05-18 18:26:56 1 [Note] mysqld: ready for connections.
Version: '5.6.51'  socket: '/var/run/mysqld/mysqld.sock'  port: 3306  MySQL Community Server (GPL)

controlplane ~ ➜  

controlplane ~ ✖ kubectl describe pod/webapp-mysql-785cd8f94-796x7 -n delta
Name:             webapp-mysql-785cd8f94-796x7
Namespace:        delta
Priority:         0
Service Account:  default
Node:             controlplane/192.6.194.9
Start Time:       Sat, 18 May 2024 18:26:46 +0000
Labels:           name=webapp-mysql
                  pod-template-hash=785cd8f94
Annotations:      <none>
Status:           Running
IP:               10.42.0.16
IPs:
  IP:           10.42.0.16
Controlled By:  ReplicaSet/webapp-mysql-785cd8f94
Containers:
  webapp-mysql:
    Container ID:   containerd://601270a10e005ec33c5d90907fcb50999b250f5d48b563bcc18b0428c4056fbc
    Image:          mmumshad/simple-webapp-mysql
    Image ID:       docker.io/mmumshad/simple-webapp-mysql@sha256:d4d0c03fcb76cee6ae2511fa7f3f6b7090f0c5e0cb3f276687f9ddf2c689cc09
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 18 May 2024 18:26:47 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      DB_Host:      mysql-service
      DB_User:      sql-user
      DB_Password:  paswrd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-m6vpw (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-m6vpw:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m56s  default-scheduler  Successfully assigned delta/webapp-mysql-785cd8f94-796x7 to controlplane
  Normal  Pulling    3m55s  kubelet            Pulling image "mmumshad/simple-webapp-mysql"
  Normal  Pulled     3m55s  kubelet            Successfully pulled image "mmumshad/simple-webapp-mysql" in 165ms (165ms including waiting)
  Normal  Created    3m55s  kubelet            Created container webapp-mysql
  Normal  Started    3m55s  kubelet            Started container webapp-mysql

controlplane ~ ➜  

questão 4, provavel que seja o usuario do banco nas variaveis
ajustar

controlplane ~ ➜  kubectl logs pod/webapp-mysql-785cd8f94-796x7 -n delta
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)
10.42.0.1 - - [18/May/2024 18:27:11] "GET / HTTP/1.1" 200 -

controlplane ~ ➜  
questão 4, provavel que seja o usuario do banco nas variaveis
ajustar


controlplane ~ ➜  kubectl exec -ti pod/webapp-mysql-785cd8f94-796x7 -n delta
error: you must specify at least one command for the container

controlplane ~ ✖ kubectl exec -ti pod/webapp-mysql-785cd8f94-796x7 -n delta sh
kubectl exec [POD] [COMMAND] is DEPRECATED and will be removed in a future version. Use kubectl exec [POD] -- [COMMAND] instead.
/opt/webapp-mysql # 
/opt/webapp-mysql # env | grep -i db_
DB_Host=mysql-service
DB_User=sql-user
DB_Password=paswrd
/opt/webapp-mysql # 
/opt/webapp-mysql # export DB_User=root
/opt/webapp-mysql # 
/opt/webapp-mysql # 
/opt/webapp-mysql # env | grep -i db_
DB_Host=mysql-service
DB_User=root
DB_Password=paswrd
/opt/webapp-mysql # 

não resolveu

indo editar o deployment agora


controlplane ~ ➜  kubectl get deployment webapp-mysql -o yaml
Error from server (NotFound): deployments.apps "webapp-mysql" not found

controlplane ~ ✖ kubectl get deployment webapp-mysql -o yaml -n delta
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-05-18T18:26:46Z"
  generation: 1
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: delta
  resourceVersion: "1999"
  uid: 04937238-57d5-42f2-84a4-f3b4ee6448e3
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: sql-user
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-05-18T18:26:48Z"
    lastUpdateTime: "2024-05-18T18:26:48Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-05-18T18:26:46Z"
    lastUpdateTime: "2024-05-18T18:26:48Z"
    message: ReplicaSet "webapp-mysql-785cd8f94" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  

- SOLUÇÃO4
Editar variável via edição do Deployment:
DE:
DB_User=sql-user
PARA:
DB_User=root





# ###################################################################################################################### 
# ###################################################################################################################### 
##   253. Practice Test - Application Failure - 2º TENTATIVA

Troubleshooting Test 1: A simple 2 tier application is deployed in the alpha namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue

kubectl get service mysql -n alpha
kubectl get service mysql -n alpha -o yaml

controlplane ~ ➜  kubectl get service mysql -n alpha
NAME    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
mysql   ClusterIP   10.43.131.159   <none>        3306/TCP   35s

controlplane ~ ➜  kubectl get service mysql -n alpha -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T16:59:14Z"
  name: mysql
  namespace: alpha
  resourceVersion: "931"
  uid: 071f3dc7-ab6e-4354-9828-eaf38ba22ee1
spec:
  clusterIP: 10.43.131.159
  clusterIPs:
  - 10.43.131.159
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  


- Ajustando

~~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
  namespace: alpha
spec:
  clusterIP: 10.43.131.159
  clusterIPs:
  - 10.43.131.159
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
~~~~


controlplane ~ ➜  kubectl apply -f service-editado.yaml
The Service "mysql-service" is invalid: spec.clusterIPs: Invalid value: []string{"10.43.131.159"}: failed to allocate IP 10.43.131.159: provided IP is already allocated

controlplane ~ ✖ 

controlplane ~ ✖ kubectl delete service mysql -n alpha
service "mysql" deleted

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f service-editado.yaml
service/mysql-service created

controlplane ~ ➜  kubectl get svc -A
NAMESPACE     NAME             TYPE           CLUSTER-IP      EXTERNAL-IP    PORT(S)                      AGE
default       kubernetes       ClusterIP      10.43.0.1       <none>         443/TCP                      17m
kube-system   kube-dns         ClusterIP      10.43.0.10      <none>         53/UDP,53/TCP,9153/TCP       17m
kube-system   metrics-server   ClusterIP      10.43.205.184   <none>         443/TCP                      17m
kube-system   traefik          LoadBalancer   10.43.98.187    192.25.151.6   80:31165/TCP,443:32328/TCP   16m
alpha         web-service      NodePort       10.43.7.188     <none>         8080:30081/TCP               2m47s
alpha         mysql-service    ClusterIP      10.43.131.159   <none>         3306/TCP                     7s

controlplane ~ ➜  

- SOLUÇÃO1:
Deletar o service mysql
kubectl delete service mysql -n alpha
Editar e aplicar o novo, contendo o nome correto "mysql-service"
kubectl apply -f service-editado.yaml 







Troubleshooting Test 2: The same 2 tier application is deployed in the beta namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue


controlplane ~ ➜  kubectl get svc -n beta
NAME            TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
mysql-service   ClusterIP   10.43.33.136    <none>        3306/TCP         34s
web-service     NodePort    10.43.220.151   <none>        8080:30081/TCP   34s

controlplane ~ ➜  

controlplane ~ ➜  kubectl get svc mysql-service -n beta -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T17:02:37Z"
  name: mysql-service
  namespace: beta
  resourceVersion: "1089"
  uid: cecef3d1-2d80-41b7-b152-b2764e2d1b23
spec:
  clusterIP: 10.43.33.136
  clusterIPs:
  - 10.43.33.136
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 8080
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  


kubectl edit svc mysql-service -n beta


controlplane ~ ➜  kubectl edit svc mysql-service -n beta
service/mysql-service edited

controlplane ~ ➜  kubectl get svc mysql-service -n beta -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T17:02:37Z"
  name: mysql-service
  namespace: beta
  resourceVersion: "1184"
  uid: cecef3d1-2d80-41b7-b152-b2764e2d1b23
spec:
  clusterIP: 10.43.33.136
  clusterIPs:
  - 10.43.33.136
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  

- SOLUÇÃO2
Foi ajuste na targetPort do mysql, para 3306








Troubleshooting Test 3: The same 2 tier application is deployed in the gamma namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed or unresponsive. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue

kubectl get all -n gamma

controlplane ~ ➜  kubectl get all -n gamma
NAME                               READY   STATUS    RESTARTS   AGE
pod/webapp-mysql-b68bb6bc8-7w9wm   1/1     Running   0          86s
pod/mysql                          1/1     Running   0          87s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.100.245   <none>        3306/TCP         86s
service/web-service     NodePort    10.43.70.126    <none>        8080:30081/TCP   86s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           86s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-b68bb6bc8   1         1         1       86s

controlplane ~ ➜  

kubectl get svc mysql-service -o yaml -n gamma

controlplane ~ ✖ kubectl get svc mysql-service -o yaml -n gamma
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T17:06:10Z"
  name: mysql-service
  namespace: gamma
  resourceVersion: "1245"
  uid: 01a55d93-977a-4acf-bdb9-dc48a83c7ce2
spec:
  clusterIP: 10.43.100.245
  clusterIPs:
  - 10.43.100.245
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    name: sql00001
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  

kubectl edit svc mysql-service -n gamma

kubectl get svc mysql-service -o yaml -n gamma


controlplane ~ ➜  kubectl edit svc mysql-service -n gamma
service/mysql-service edited

controlplane ~ ➜  

controlplane ~ ➜  kubectl get svc mysql-service -o yaml -n gamma
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T17:06:10Z"
  name: mysql-service
  namespace: gamma
  resourceVersion: "1466"
  uid: 01a55d93-977a-4acf-bdb9-dc48a83c7ce2
spec:
  clusterIP: 10.43.100.245
  clusterIPs:
  - 10.43.100.245
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  

- SOLUÇÃO3:
ajustar o selector
então o service conseguiu gerar os devidos endpoints








Troubleshooting Test 4: The same 2 tier application is deployed in the delta namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue

controlplane ~ ➜  kubectl get all -n delta
NAME                               READY   STATUS    RESTARTS   AGE
pod/mysql                          1/1     Running   0          5m15s
pod/webapp-mysql-785cd8f94-d2vjk   1/1     Running   0          5m15s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.8.6       <none>        3306/TCP         5m15s
service/web-service     NodePort    10.43.206.124   <none>        8080:30081/TCP   5m15s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           5m15s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-785cd8f94   1         1         1       5m15s

controlplane ~ ➜  


controlplane ~ ➜  kubectl get deployment webapp-mysql -n delta
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
webapp-mysql   1/1     1            1           5m40s

controlplane ~ ➜  kubectl get deployment webapp-mysql -n delta -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-05-19T17:16:58Z"
  generation: 1
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: delta
  resourceVersion: "1565"
  uid: 6acfe0a9-cd61-42b3-8ba2-ed13cae8fb9e
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: sql-user
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-05-19T17:17:00Z"
    lastUpdateTime: "2024-05-19T17:17:00Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-05-19T17:16:58Z"
    lastUpdateTime: "2024-05-19T17:17:00Z"
    message: ReplicaSet "webapp-mysql-785cd8f94" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  

- Ajustando

~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: delta
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: root
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30

~~~~

controlplane ~ ➜  vi deployment-editado.yaml

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
Warning: resource deployments/webapp-mysql is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
deployment.apps/webapp-mysql configured

controlplane ~ ➜  kubectl delete -f deployment-editado.yaml
deployment.apps "webapp-mysql" deleted

controlplane ~ ➜  kubectl apply -f deployment-editado.yaml
deployment.apps/webapp-mysql created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployment webapp-mysql -n delta -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"name":"webapp-mysql"},"name":"webapp-mysql","namespace":"delta"},"spec":{"progressDeadlineSeconds":600,"replicas":1,"revisionHistoryLimit":10,"selector":{"matchLabels":{"name":"webapp-mysql"}},"strategy":{"rollingUpdate":{"maxSurge":"25%","maxUnavailable":"25%"},"type":"RollingUpdate"},"template":{"metadata":{"creationTimestamp":null,"labels":{"name":"webapp-mysql"},"name":"webapp-mysql"},"spec":{"containers":[{"env":[{"name":"DB_Host","value":"mysql-service"},{"name":"DB_User","value":"root"},{"name":"DB_Password","value":"paswrd"}],"image":"mmumshad/simple-webapp-mysql","imagePullPolicy":"Always","name":"webapp-mysql","ports":[{"containerPort":8080,"protocol":"TCP"}],"resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File"}],"dnsPolicy":"ClusterFirst","restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"terminationGracePeriodSeconds":30}}}}
  creationTimestamp: "2024-05-19T17:24:19Z"
  generation: 1
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: delta
  resourceVersion: "1757"
  uid: f69ebb3a-197f-470c-bc0f-4dfc840773ec
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: root
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-05-19T17:24:21Z"
    lastUpdateTime: "2024-05-19T17:24:21Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-05-19T17:24:19Z"
    lastUpdateTime: "2024-05-19T17:24:21Z"
    message: ReplicaSet "webapp-mysql-b68bb6bc8" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  

- SOLUÇÃO4
Editar variável via edição do Deployment:
DE:
DB_User=sql-user
PARA:
DB_User=root








Troubleshooting Test 5: The same 2 tier application is deployed in the epsilon namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue

Fix Issue


controlplane ~ ➜  kubectl get all -n epsilon
NAME                               READY   STATUS    RESTARTS   AGE
pod/mysql                          1/1     Running   0          34s
pod/webapp-mysql-785cd8f94-tt4fh   1/1     Running   0          34s

NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.197.95    <none>        3306/TCP         34s
service/web-service     NodePort    10.43.121.186   <none>        8080:30081/TCP   34s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           34s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-785cd8f94   1         1         1       34s

controlplane ~ ➜  


primeiro problema identificado
senha na variável está incorreta
      MYSQL_ROOT_PASSWORD:  passwooooorrddd

controlplane ~ ➜  kubectl describe pod/mysql -n epsilon
Name:             mysql
Namespace:        epsilon
Priority:         0
Service Account:  default
Node:             controlplane/192.25.151.6
Start Time:       Sun, 19 May 2024 17:25:20 +0000
Labels:           name=mysql
Annotations:      <none>
Status:           Running
IP:               10.42.0.19
IPs:
  IP:  10.42.0.19
Containers:
  mysql:
    Container ID:   containerd://b611acc8ec1a2412d52454fe1d06cf571356e361cd7f3ac2843aeee094238941
    Image:          mysql:5.6
    Image ID:       docker.io/library/mysql@sha256:20575ecebe6216036d25dab5903808211f1e9ba63dc7825ac20cb975e34cfcae
    Port:           3306/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 19 May 2024 17:25:21 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      MYSQL_ROOT_PASSWORD:  passwooooorrddd
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-n9gxt (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-n9gxt:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age    From               Message
  ----    ------     ----   ----               -------
  Normal  Scheduled  3m40s  default-scheduler  Successfully assigned epsilon/mysql to controlplane
  Normal  Pulled     3m40s  kubelet            Container image "mysql:5.6" already present on machine
  Normal  Created    3m40s  kubelet            Created container mysql
  Normal  Started    3m39s  kubelet            Started container mysql

controlplane ~ ➜  


controlplane ~ ➜  kubectl get deploy -n epsilon
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
webapp-mysql   1/1     1            1           4m53s

controlplane ~ ➜  

kubectl edit pod/mysql -n epsilon

ajustar para
paswrd


kubectl describe pod/mysql -n epsilon


controlplane ~ ➜  kubectl edit pod/mysql -n epsilon
error: pods "mysql" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-180560423.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ 
controlplane ~ ✖ kubectl get pods -n epsilon
NAME                           READY   STATUS    RESTARTS   AGE
mysql                          1/1     Running   0          7m8s
webapp-mysql-785cd8f94-tt4fh   1/1     Running   0          7m8s

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pod/mysql -n epsilon -o yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2024-05-19T17:25:20Z"
  labels:
    name: mysql
  name: mysql
  namespace: epsilon
  resourceVersion: "1883"
  uid: 7831fda1-9466-4990-9fb4-e2265c2ef139
spec:
  containers:
  - env:
    - name: MYSQL_ROOT_PASSWORD
      value: passwooooorrddd
    image: mysql:5.6
    imagePullPolicy: IfNotPresent
    name: mysql
    ports:
    - containerPort: 3306
      protocol: TCP
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-n9gxt
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-n9gxt
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:21Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:20Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:21Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:21Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:20Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://b611acc8ec1a2412d52454fe1d06cf571356e361cd7f3ac2843aeee094238941
    image: docker.io/library/mysql:5.6
    imageID: docker.io/library/mysql@sha256:20575ecebe6216036d25dab5903808211f1e9ba63dc7825ac20cb975e34cfcae
    lastState: {}
    name: mysql
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2024-05-19T17:25:21Z"
  hostIP: 192.25.151.6
  hostIPs:
  - ip: 192.25.151.6
  phase: Running
  podIP: 10.42.0.19
  podIPs:
  - ip: 10.42.0.19
  qosClass: BestEffort
  startTime: "2024-05-19T17:25:20Z"

controlplane ~ ➜  



controlplane ~ ➜  vi pod-editado-mysql.yaml

controlplane ~ ➜  

controlplane ~ ➜  kubectl delete pod/mysql -n epsilon
pod "mysql" deleted

controlplane ~ ➜  kubectl apply -f pod-editado-mysql.yaml
pod/mysql created

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -n epsilon
NAME                           READY   STATUS    RESTARTS   AGE
webapp-mysql-785cd8f94-tt4fh   1/1     Running   0          9m36s
mysql                          1/1     Running   0          17s

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pod webapp-mysql-785cd8f94-tt4fh -n epsilon -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2024-05-19T17:25:20Z"
  generateName: webapp-mysql-785cd8f94-
  labels:
    name: webapp-mysql
    pod-template-hash: 785cd8f94
  name: webapp-mysql-785cd8f94-tt4fh
  namespace: epsilon
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: webapp-mysql-785cd8f94
    uid: 45788084-34fd-4a11-927d-c35544b12fb1
  resourceVersion: "1888"
  uid: 1201ed82-d34a-46ff-a53b-7bf256ea2f8d
spec:
  containers:
  - env:
    - name: DB_Host
      value: mysql-service
    - name: DB_User
      value: sql-user
    - name: DB_Password
      value: paswrd
    image: mmumshad/simple-webapp-mysql
    imagePullPolicy: Always
    name: webapp-mysql
    ports:
    - containerPort: 8080
      protocol: TCP
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-qhftq
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: controlplane
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: Always
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-qhftq
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:22Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:20Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:22Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:22Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-05-19T17:25:20Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://84453c6e8ccc2c42390e0ea467cfe8addde8fb653a90d9bde77a380fd60cd4a9
    image: docker.io/mmumshad/simple-webapp-mysql:latest
    imageID: docker.io/mmumshad/simple-webapp-mysql@sha256:d4d0c03fcb76cee6ae2511fa7f3f6b7090f0c5e0cb3f276687f9ddf2c689cc09
    lastState: {}
    name: webapp-mysql
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2024-05-19T17:25:21Z"
  hostIP: 192.25.151.6
  hostIPs:
  - ip: 192.25.151.6
  phase: Running
  podIP: 10.42.0.20
  podIPs:
  - ip: 10.42.0.20
  qosClass: BestEffort
  startTime: "2024-05-19T17:25:20Z"

controlplane ~ ➜  


controlplane ~ ➜  kubectl get deployment -n epsilon
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
webapp-mysql   1/1     1            1           11m

controlplane ~ ➜  

kubectl get deployment webapp-mysql -n epsilon -o yaml


controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployment webapp-mysql -n epsilon -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-05-19T17:25:20Z"
  generation: 1
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: epsilon
  resourceVersion: "1892"
  uid: 11dc9e86-cb29-48af-9303-f38638dc39dd
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: sql-user
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-05-19T17:25:22Z"
    lastUpdateTime: "2024-05-19T17:25:22Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-05-19T17:25:20Z"
    lastUpdateTime: "2024-05-19T17:25:22Z"
    message: ReplicaSet "webapp-mysql-785cd8f94" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  

ajustando variável DB_User
para root



controlplane ~ ➜  vi deployment-editado-2.yaml

controlplane ~ ➜  kubectl delete -f deployment-editado-2.yaml
deployment.apps "webapp-mysql" deleted

controlplane ~ ➜  kubectl apply -f deployment-editado-2.yaml
deployment.apps/webapp-mysql created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployment -n epsilon
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
webapp-mysql   1/1     1            1           5s

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployment webapp-mysql -n epsilon -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{},"labels":{"name":"webapp-mysql"},"name":"webapp-mysql","namespace":"epsilon"},"spec":{"progressDeadlineSeconds":600,"replicas":1,"revisionHistoryLimit":10,"selector":{"matchLabels":{"name":"webapp-mysql"}},"strategy":{"rollingUpdate":{"maxSurge":"25%","maxUnavailable":"25%"},"type":"RollingUpdate"},"template":{"metadata":{"creationTimestamp":null,"labels":{"name":"webapp-mysql"},"name":"webapp-mysql"},"spec":{"containers":[{"env":[{"name":"DB_Host","value":"mysql-service"},{"name":"DB_User","value":"root"},{"name":"DB_Password","value":"paswrd"}],"image":"mmumshad/simple-webapp-mysql","imagePullPolicy":"Always","name":"webapp-mysql","ports":[{"containerPort":8080,"protocol":"TCP"}],"resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File"}],"dnsPolicy":"ClusterFirst","restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"terminationGracePeriodSeconds":30}}}}
  creationTimestamp: "2024-05-19T17:41:56Z"
  generation: 1
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: epsilon
  resourceVersion: "2236"
  uid: 65b4b1a1-9b79-4476-8aed-0bfdb7c79135
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: root
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-05-19T17:41:58Z"
    lastUpdateTime: "2024-05-19T17:41:58Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-05-19T17:41:56Z"
    lastUpdateTime: "2024-05-19T17:41:58Z"
    message: ReplicaSet "webapp-mysql-b68bb6bc8" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  

https://30081-port-abd0753533f943c3.labs.kodekloud.com/
ok
 Environment Variables: DB_Host=mysql-service; DB_Database=Not Set; DB_User=root; DB_Password=paswrd;

From webapp-mysql-b68bb6bc8-kzgmd!

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






Troubleshooting Test 6: The same 2 tier application is deployed in the zeta namespace. It must display a green web page on success. Click on the App tab at the top of your terminal to view your application. It is currently failed. Troubleshoot and fix the issue.

Stick to the given architecture. Use the same names and port numbers as given in the below architecture diagram. Feel free to edit, delete or recreate objects as necessary.

Fix Issue

Fix Issue

Fix Issue


controlplane ~ ➜  kubectl get all -n zeta
NAME                               READY   STATUS    RESTARTS   AGE
pod/mysql                          1/1     Running   0          18s
pod/webapp-mysql-785cd8f94-tn62l   1/1     Running   0          18s

NAME                    TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/mysql-service   ClusterIP   10.43.174.25   <none>        3306/TCP         18s
service/web-service     NodePort    10.43.230.13   <none>        8080:30088/TCP   18s

NAME                           READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-mysql   1/1     1            1           18s

NAME                                     DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-mysql-785cd8f94   1         1         1       18s

controlplane ~ ➜  

https://30081-port-abd0753533f943c3.labs.kodekloud.com/

502 Bad Gateway
nginx/1.25.2

controlplane ~ ➜  kubectl get service mysql-service -n zeta
NAME            TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
mysql-service   ClusterIP   10.43.174.25   <none>        3306/TCP   89s

controlplane ~ ➜  kubectl get service mysql-service -n zeta -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T17:44:00Z"
  name: mysql-service
  namespace: zeta
  resourceVersion: "2342"
  uid: 4f9ff1b2-8209-4b82-a3e4-4f6d4140c71b
spec:
  clusterIP: 10.43.174.25
  clusterIPs:
  - 10.43.174.25
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 3306
    protocol: TCP
    targetPort: 3306
  selector:
    name: mysql
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe service mysql-service -n zeta 
Name:              mysql-service
Namespace:         zeta
Labels:            <none>
Annotations:       <none>
Selector:          name=mysql
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.43.174.25
IPs:               10.43.174.25
Port:              <unset>  3306/TCP
TargetPort:        3306/TCP
Endpoints:         10.42.0.23:3306
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  

Service do MYSQL parece OK.




controlplane ~ ➜  kubectl get service web-service -n zeta
NAME          TYPE       CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
web-service   NodePort   10.43.230.13   <none>        8080:30088/TCP   2m28s

controlplane ~ ➜  kubectl get service web-service -n zeta -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-05-19T17:44:00Z"
  name: web-service
  namespace: zeta
  resourceVersion: "2355"
  uid: 0dbfdbce-90ce-4729-8fbc-88756660dd7e
spec:
  clusterIP: 10.43.230.13
  clusterIPs:
  - 10.43.230.13
  externalTrafficPolicy: Cluster
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - nodePort: 30088
    port: 8080
    protocol: TCP
    targetPort: 8080
  selector:
    name: webapp-mysql
  sessionAffinity: None
  type: NodePort
status:
  loadBalancer: {}

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe service web-service -n zeta
Name:                     web-service
Namespace:                zeta
Labels:                   <none>
Annotations:              <none>
Selector:                 name=webapp-mysql
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.43.230.13
IPs:                      10.43.230.13
Port:                     <unset>  8080/TCP
TargetPort:               8080/TCP
NodePort:                 <unset>  30088/TCP
Endpoints:                10.42.0.24:8080
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>

controlplane ~ ➜  

Service do app parece OK também




controlplane ~ ➜  kubectl get deployment
No resources found in default namespace.

controlplane ~ ➜  kubectl get deployment -n zeta
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
webapp-mysql   1/1     1            1           4m40s

controlplane ~ ➜  kubectl get deployment -n zeta webapp-mysql -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-05-19T17:44:00Z"
  generation: 1
  labels:
    name: webapp-mysql
  name: webapp-mysql
  namespace: zeta
  resourceVersion: "2377"
  uid: 2e8f0207-0f8c-467e-a327-3c0088fccc50
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: webapp-mysql
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: webapp-mysql
      name: webapp-mysql
    spec:
      containers:
      - env:
        - name: DB_Host
          value: mysql-service
        - name: DB_User
          value: sql-user
        - name: DB_Password
          value: paswrd
        image: mmumshad/simple-webapp-mysql
        imagePullPolicy: Always
        name: webapp-mysql
        ports:
        - containerPort: 8080
          protocol: TCP
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2024-05-19T17:44:03Z"
    lastUpdateTime: "2024-05-19T17:44:03Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-05-19T17:44:00Z"
    lastUpdateTime: "2024-05-19T17:44:03Z"
    message: ReplicaSet "webapp-mysql-785cd8f94" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  


- Ajustando
variável DB_User

controlplane ~ ➜  vi deployment-editado-3.yaml

controlplane ~ ➜  kubectl delete -f deployment-editado-3.yaml
deployment.apps "webapp-mysql" deleted

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f deployment-editado-3.yaml
deployment.apps/webapp-mysql created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deployment -n zeta
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
webapp-mysql   1/1     1            1           5s

controlplane ~ ➜  date
Sun May 19 17:50:57 UTC 2024

controlplane ~ ➜  

https://30081-port-abd0753533f943c3.labs.kodekloud.com/


502 Bad Gateway
nginx/1.25.2

controlplane ~ ➜  curl https://30081-port-abd0753533f943c3.labs.kodekloud.com/
<html>
<head><title>502 Bad Gateway</title></head>
<body>
<center><h1>502 Bad Gateway</h1></center>
<hr><center>nginx/1.25.2</center>
</body>
</html>

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -n zeta
NAME                           READY   STATUS    RESTARTS   AGE
mysql                          1/1     Running   0          8m55s
webapp-mysql-b68bb6bc8-pcjkh   1/1     Running   0          2m5s

controlplane ~ ➜  kubectl logs webapp-mysql-b68bb6bc8-pcjkh -n zeta
 * Serving Flask app "app" (lazy loading)
 * Environment: production
   WARNING: Do not use the development server in a production environment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on http://0.0.0.0:8080/ (Press CTRL+C to quit)

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods --selector=name=webapp-mysql
No resources found in default namespace.

controlplane ~ ➜  kubectl get pods --selector=name=webapp-mysql -n zeta
NAME                           READY   STATUS    RESTARTS   AGE
webapp-mysql-b68bb6bc8-pcjkh   1/1     Running   0          6m48s

controlplane ~ ➜  

# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "233. Practice Test - Ingress - 1."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  233. Practice Test - Ingress - 1

We have deployed Ingress Controller, resources and applications. Explore the setup.

Note: They are in different namespaces.

controlplane ~ ➜  kubectl get ingress
No resources found in default namespace.

controlplane ~ ➜  kubectl get ingress -A
NAMESPACE   NAME                 CLASS    HOSTS   ADDRESS         PORTS   AGE
app-space   ingress-wear-watch   <none>   *       10.96.197.136   80      28s

controlplane ~ ➜  



controlplane ~ ➜  kubectl get all -A
NAMESPACE       NAME                                            READY   STATUS      RESTARTS   AGE
app-space       pod/default-backend-79755fc44c-rnx9b            1/1     Running     0          43s
app-space       pod/webapp-video-74bf8df7f5-mvn42               1/1     Running     0          43s
app-space       pod/webapp-wear-7b784f68d8-bqgjr                1/1     Running     0          44s
ingress-nginx   pod/ingress-nginx-admission-create-h2fxj        0/1     Completed   0          41s
ingress-nginx   pod/ingress-nginx-admission-patch-cdzh7         0/1     Completed   0          41s
ingress-nginx   pod/ingress-nginx-controller-7689699d9b-hskh6   1/1     Running     0          41s
kube-flannel    pod/kube-flannel-ds-8ln48                       1/1     Running     0          10m
kube-system     pod/coredns-69f9c977-2mrbp                      1/1     Running     0          10m
kube-system     pod/coredns-69f9c977-m9hn5                      1/1     Running     0          10m
kube-system     pod/etcd-controlplane                           1/1     Running     0          10m
kube-system     pod/kube-apiserver-controlplane                 1/1     Running     0          10m
kube-system     pod/kube-controller-manager-controlplane        1/1     Running     0          10m
kube-system     pod/kube-proxy-xl4w7                            1/1     Running     0          10m
kube-system     pod/kube-scheduler-controlplane                 1/1     Running     0          10m

NAMESPACE       NAME                                         TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
app-space       service/default-backend-service              ClusterIP   10.105.45.3      <none>        80/TCP                       43s
app-space       service/video-service                        ClusterIP   10.101.122.101   <none>        8080/TCP                     43s
app-space       service/wear-service                         ClusterIP   10.109.68.126    <none>        8080/TCP                     44s
default         service/kubernetes                           ClusterIP   10.96.0.1        <none>        443/TCP                      10m
ingress-nginx   service/ingress-nginx-controller             NodePort    10.96.197.136    <none>        80:30080/TCP,443:32103/TCP   41s
ingress-nginx   service/ingress-nginx-controller-admission   ClusterIP   10.106.19.171    <none>        443/TCP                      41s
kube-system     service/kube-dns                             ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP       10m

NAMESPACE      NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   10m
kube-system    daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   10m

NAMESPACE       NAME                                       READY   UP-TO-DATE   AVAILABLE   AGE
app-space       deployment.apps/default-backend            1/1     1            1           43s
app-space       deployment.apps/webapp-video               1/1     1            1           43s
app-space       deployment.apps/webapp-wear                1/1     1            1           44s
ingress-nginx   deployment.apps/ingress-nginx-controller   1/1     1            1           41s
kube-system     deployment.apps/coredns                    2/2     2            2           10m

NAMESPACE       NAME                                                  DESIRED   CURRENT   READY   AGE
app-space       replicaset.apps/default-backend-79755fc44c            1         1         1       43s
app-space       replicaset.apps/webapp-video-74bf8df7f5               1         1         1       43s
app-space       replicaset.apps/webapp-wear-7b784f68d8                1         1         1       44s
ingress-nginx   replicaset.apps/ingress-nginx-controller-7689699d9b   1         1         1       41s
kube-system     replicaset.apps/coredns-69f9c977                      2         2         2       10m

NAMESPACE       NAME                                       COMPLETIONS   DURATION   AGE
ingress-nginx   job.batch/ingress-nginx-admission-create   1/1           9s         41s
ingress-nginx   job.batch/ingress-nginx-admission-patch    1/1           9s         41s

controlplane ~ ➜  

















Which namespace is the Ingress Controller deployed in?






What is the name of the Ingress Controller Deployment?










Which namespace are the applications deployed in?




How many applications are deployed in the app-space namespace?

Count the number of deployments in this namespace.







Which namespace is the Ingress Resource deployed in?


controlplane ~ ➜  kubectl get ingress -A
NAMESPACE   NAME                 CLASS    HOSTS   ADDRESS         PORTS   AGE
app-space   ingress-wear-watch   <none>   *       10.96.197.136   80      2m39s

controlplane ~ ➜  





What is the name of the Ingress Resource?






What is the Host configured on the Ingress Resource?

The host entry defines the domain name that users use to reach the application like www.google.com












What backend is the /wear path on the Ingress configured with?


controlplane ~ ➜  kubectl describe ingress ingress-wear-watch -n app-space
Name:             ingress-wear-watch
Labels:           <none>
Namespace:        app-space
Address:          10.96.197.136
Ingress Class:    <none>
Default backend:  <default>
Rules:
  Host        Path  Backends
  ----        ----  --------
  *           
              /wear    wear-service:8080 (10.244.0.4:8080)
              /watch   video-service:8080 (10.244.0.5:8080)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:
  Type    Reason  Age                    From                      Message
  ----    ------  ----                   ----                      -------
  Normal  Sync    3m15s (x2 over 3m15s)  nginx-ingress-controller  Scheduled for sync

controlplane ~ ➜  







At what path is the video streaming application made available on the Ingress?





If the requirement does not match any of the configured paths in the Ingress, to which service are the requests forwarded?





Now view the Ingress Service using the tab at the top of the terminal. Which page do you see?

Click on the tab named Ingress.
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/





View the applications by appending /wear and /watch to the URL you opened in the previous step.

https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/wear
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/watch







You are requested to change the URLs at which the applications are made available.

Make the video application available at /stream.

Ingress: ingress-wear-watch

Path: /stream

Backend Service: video-service

Backend Service Port: 8080



controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space
NAME                 CLASS    HOSTS   ADDRESS         PORTS   AGE
ingress-wear-watch   <none>   *       10.96.197.136   80      8m5s

controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 1
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "1436"
  uid: dbd6ffc3-931d-499f-a9b4-8ca98f4fc17d
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
        pathType: Prefix
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /watch
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: 10.96.197.136

controlplane ~ ➜  


Editado:


controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 2
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "2176"
  uid: dbd6ffc3-931d-499f-a9b4-8ca98f4fc17d
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
        pathType: Prefix
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /stream
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: 10.96.197.136

controlplane ~ ➜  date
Thu Apr  4 12:13:45 AM UTC 2024

controlplane ~ ➜  









View the Video application using the /stream URL in your browser.

Click on the Ingress tab above your terminal, if its not open already, and append /stream to the URL in the browser.

https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/stream







A user is trying to view the /eat URL on the Ingress Service. Which page would he see?

If not open already, click on the Ingress tab above your terminal, and append /eat to the URL in the browser.

https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/eat

404














Due to increased demand, your business decides to take on a new venture. You acquired a food delivery company. Their applications have been migrated over to your cluster.

Inspect the new deployments in the app-space namespace.


controlplane ~ ➜  kubectl get all -n app-space
NAME                                   READY   STATUS    RESTARTS   AGE
pod/default-backend-79755fc44c-rnx9b   1/1     Running   0          10m
pod/webapp-food-786f75f797-85nnh       1/1     Running   0          17s
pod/webapp-video-74bf8df7f5-mvn42      1/1     Running   0          10m
pod/webapp-wear-7b784f68d8-bqgjr       1/1     Running   0          10m

NAME                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/default-backend-service   ClusterIP   10.105.45.3      <none>        80/TCP     10m
service/food-service              ClusterIP   10.96.161.60     <none>        8080/TCP   17s
service/video-service             ClusterIP   10.101.122.101   <none>        8080/TCP   10m
service/wear-service              ClusterIP   10.109.68.126    <none>        8080/TCP   10m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-backend   1/1     1            1           10m
deployment.apps/webapp-food       1/1     1            1           17s
deployment.apps/webapp-video      1/1     1            1           10m
deployment.apps/webapp-wear       1/1     1            1           10m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/default-backend-79755fc44c   1         1         1       10m
replicaset.apps/webapp-food-786f75f797       1         1         1       17s
replicaset.apps/webapp-video-74bf8df7f5      1         1         1       10m
replicaset.apps/webapp-wear-7b784f68d8       1         1         1       10m

controlplane ~ ➜  
















You are requested to add a new path to your ingress to make the food delivery application available to your customers.

Make the new application available at /eat.

Ingress: ingress-wear-watch

Path: /eat

Backend Service: food-service

Backend Service Port: 8080


Antes


controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 2
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "2176"
  uid: dbd6ffc3-931d-499f-a9b4-8ca98f4fc17d
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
        pathType: Prefix
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /stream
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: 10.96.197.136

controlplane ~ ➜  


Ajustando

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  name: ingress-wear-watch
  namespace: app-space
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
        pathType: Prefix
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /stream
        pathType: Prefix
      - backend:
          service:
            name: food-service
            port:
              number: 8080
        path: /eat
        pathType: Prefix


controlplane ~ ➜  kubectl edit ingress ingress-wear-watch -n app-space
ingress.networking.k8s.io/ingress-wear-watch edited

controlplane ~ ➜  date
Thu Apr  4 12:17:52 AM UTC 2024

controlplane ~ ➜  


controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 3
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "2570"
  uid: dbd6ffc3-931d-499f-a9b4-8ca98f4fc17d
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
        pathType: Prefix
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /stream
        pathType: Prefix
      - backend:
          service:
            name: food-service
            port:
              number: 8080
        path: /eat
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: 10.96.197.136

controlplane ~ ➜  
controlplane ~ ➜  kubectl get ingress -A
NAMESPACE   NAME                 CLASS    HOSTS   ADDRESS         PORTS   AGE
app-space   ingress-wear-watch   <none>   *       10.96.197.136   80      13m

controlplane ~ ➜  















View the Food delivery application using the /eat URL in your browser.

Click on the Ingress tab above your terminal, if its not open already, and append /eat to the URL in the browser.
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/eat





## PENDENTE
- Revisar a questão
    If the requirement does not match any of the configured paths in the Ingress, to which service are the requests forwarded?
pois não tem default configurado, apesar de existir o service/default-backend-service no namespace, ele nao ta setado no ingress



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











A new payment service has been introduced. Since it is critical, the new application is deployed in its own namespace.

Identify the namespace in which the new application is deployed.



controlplane ~ ➜  kubectl get ns
NAME              STATUS   AGE
app-space         Active   14m
critical-space    Active   57s
default           Active   25m
ingress-nginx     Active   14m
kube-flannel      Active   24m
kube-node-lease   Active   25m
kube-public       Active   25m
kube-system       Active   25m

controlplane ~ ➜  kubectl get all -n critical-space
NAME                              READY   STATUS    RESTARTS   AGE
pod/webapp-pay-657d677c99-2hnq4   1/1     Running   0          64s

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/pay-service   ClusterIP   10.109.140.27   <none>        8282/TCP   64s

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-pay   1/1     1            1           64s

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-pay-657d677c99   1         1         1       64s

controlplane ~ ➜  












What is the name of the deployment of the new application?










You are requested to make the new application available at /pay.

Identify and implement the best approach to making this application available on the ingress controller and test to make sure its working. Look into annotations: rewrite-target as well.


Ingress Created

Path: /pay

Configure correct backend service

Configure correct backend port


antes


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

controlplane ~ ➜  date
Thu Apr  4 12:20:54 AM UTC 2024

controlplane ~ ➜  


Ajustando


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
      - backend:
          service:
            name: pay-service
            port:
              number: 8282
        path: /pay
        pathType: Prefix


controlplane ~ ➜  kubectl edit ingress ingress-wear-watch -n app-space
ingress.networking.k8s.io/ingress-wear-watch edited

controlplane ~ ➜  

controlplane ~ ➜  date
Thu Apr  4 12:22:18 AM UTC 2024

controlplane ~ ➜  


- ERRO
503 Service Temporarily Unavailable
nginx



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
              /wear     wear-service:8080 (10.244.0.4:8080)
              /stream   video-service:8080 (10.244.0.5:8080)
              /eat      food-service:8080 (10.244.0.10:8080)
              /pay      pay-service:8282 (<error: endpoints "pay-service" not found>)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:
  Type    Reason  Age                From                      Message
  ----    ------  ----               ----                      -------
  Normal  Sync    96s (x5 over 18m)  nginx-ingress-controller  Scheduled for sync

controlplane ~ ➜  

controlplane ~ ➜  kubectl get svc -A
NAMESPACE        NAME                                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
app-space        default-backend-service              ClusterIP   10.105.45.3      <none>        80/TCP                       19m
app-space        food-service                         ClusterIP   10.96.161.60     <none>        8080/TCP                     9m12s
app-space        video-service                        ClusterIP   10.101.122.101   <none>        8080/TCP                     19m
app-space        wear-service                         ClusterIP   10.109.68.126    <none>        8080/TCP                     19m
critical-space   pay-service                          ClusterIP   10.109.140.27    <none>        8282/TCP                     5m42s
default          kubernetes                           ClusterIP   10.96.0.1        <none>        443/TCP                      29m
ingress-nginx    ingress-nginx-controller             NodePort    10.96.197.136    <none>        80:30080/TCP,443:32103/TCP   19m
ingress-nginx    ingress-nginx-controller-admission   ClusterIP   10.106.19.171    <none>        443/TCP                      19m
kube-system      kube-dns                             ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP       29m

controlplane ~ ➜  


ERRO no ingress:
              /pay      pay-service:8282 (<error: endpoints "pay-service" not found>)


controlplane ~ ➜  kubectl describe svc pay-service -n critical-space
Name:              pay-service
Namespace:         critical-space
Labels:            <none>
Annotations:       <none>
Selector:          app=webapp-pay
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.109.140.27
IPs:               10.109.140.27
Port:              <unset>  8282/TCP
TargetPort:        8080/TCP
Endpoints:         10.244.0.11:8080
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  
controlplane ~ ➜  kubectl logs webapp-pay-657d677c99-2hnq4 -n critical-space
 * Serving Flask app 'app' (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: off
 * Running on all addresses.
   WARNING: This is a development server. Do not use it in a production deployment.
 * Running on http://10.244.0.11:8080/ (Press CTRL+C to quit)

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod webapp-pay-657d677c99-2hnq4 -n critical-space
Name:             webapp-pay-657d677c99-2hnq4
Namespace:        critical-space
Priority:         0
Service Account:  default
Node:             controlplane/192.1.235.9
Start Time:       Thu, 04 Apr 2024 00:18:44 +0000
Labels:           app=webapp-pay
                  pod-template-hash=657d677c99
Annotations:      <none>
Status:           Running
IP:               10.244.0.11
IPs:
  IP:           10.244.0.11
Controlled By:  ReplicaSet/webapp-pay-657d677c99
Containers:
  webapp-pay:
    Container ID:   containerd://47afe04618a4af16b25855624dea1e582e9e3765b772323b96243395cea510c2
    Image:          kodekloud/ecommerce:pay
    Image ID:       docker.io/kodekloud/ecommerce@sha256:aca16f2d5f2305ae5d14016037f6ed17fcb8cb2da0a5c7e6a6d24435196bb5b3
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 04 Apr 2024 00:18:46 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-cr2tg (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  kube-api-access-cr2tg:
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
  Normal  Scheduled  9m57s  default-scheduler  Successfully assigned critical-space/webapp-pay-657d677c99-2hnq4 to controlplane
  Normal  Pulling    9m56s  kubelet            Pulling image "kodekloud/ecommerce:pay"
  Normal  Pulled     9m55s  kubelet            Successfully pulled image "kodekloud/ecommerce:pay" in 840ms (840ms including waiting)
  Normal  Created    9m55s  kubelet            Created container webapp-pay
  Normal  Started    9m55s  kubelet            Started container webapp-pay

controlplane ~ ➜  

controlplane ~ ➜  kubectl get endpoints -A
NAMESPACE        NAME                                 ENDPOINTS                                               AGE
app-space        default-backend-service              10.244.0.6:8080                                         26m
app-space        food-service                         10.244.0.10:8080                                        16m
app-space        video-service                        10.244.0.5:8080                                         26m
app-space        wear-service                         10.244.0.4:8080                                         26m
critical-space   pay-service                          10.244.0.11:8080                                        12m
default          kubernetes                           192.1.235.9:6443                                        37m
ingress-nginx    ingress-nginx-controller             10.244.0.9:443,10.244.0.9:80                            26m
ingress-nginx    ingress-nginx-controller-admission   10.244.0.9:8443                                         26m
kube-system      kube-dns                             10.244.0.2:53,10.244.0.3:53,10.244.0.2:53 + 3 more...   36m

controlplane ~ ➜  
controlplane ~ ➜  kubectl describe deploy webapp-pay -n critical-space
Name:                   webapp-pay
Namespace:              critical-space
CreationTimestamp:      Thu, 04 Apr 2024 00:18:44 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=webapp-pay
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=webapp-pay
  Containers:
   webapp-pay:
    Image:        kodekloud/ecommerce:pay
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   webapp-pay-657d677c99 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  14m   deployment-controller  Scaled up replica set webapp-pay-657d677c99 to 1

controlplane ~ ➜  kubectl get deploy webapp-pay -n critical-space -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-04-04T00:18:44Z"
  generation: 1
  name: webapp-pay
  namespace: critical-space
  resourceVersion: "2681"
  uid: 0c90a429-d2fd-45aa-870f-56904f359e69
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: webapp-pay
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp-pay
    spec:
      containers:
      - image: kodekloud/ecommerce:pay
        imagePullPolicy: Always
        name: webapp-pay
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
  - lastTransitionTime: "2024-04-04T00:18:47Z"
    lastUpdateTime: "2024-04-04T00:18:47Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-04-04T00:18:44Z"
    lastUpdateTime: "2024-04-04T00:18:47Z"
    message: ReplicaSet "webapp-pay-657d677c99" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  


TSHOOT ainda
endpoints OK
erro 502 segue no ingress

              /pay      pay-service:8282 (<error: endpoints "pay-service" not found>)

controlplane ~ ➜  kubectl describe svc pay-service -n critical-space
Name:              pay-service
Namespace:         critical-space
Labels:            <none>
Annotations:       <none>
Selector:          app=webapp-pay
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.109.140.27
IPs:               10.109.140.27
Port:              <unset>  8282/TCP
TargetPort:        8080/TCP
Endpoints:         10.244.0.11:8080
Session Affinity:  None
Events:            <none>

controlplane ~ ➜  


kubectl get service pay-service -n critical-space -o json


controlplane ~ ➜  kubectl get service pay-service -n critical-space -o json
{
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
        "creationTimestamp": "2024-04-04T00:18:44Z",
        "name": "pay-service",
        "namespace": "critical-space",
        "resourceVersion": "2666",
        "uid": "a8151d1e-7876-476c-b41b-188be779a6a4"
    },
    "spec": {
        "clusterIP": "10.109.140.27",
        "clusterIPs": [
            "10.109.140.27"
        ],
        "internalTrafficPolicy": "Cluster",
        "ipFamilies": [
            "IPv4"
        ],
        "ipFamilyPolicy": "SingleStack",
        "ports": [
            {
                "port": 8282,
                "protocol": "TCP",
                "targetPort": 8080
            }
        ],
        "selector": {
            "app": "webapp-pay"
        },
        "sessionAffinity": "None",
        "type": "ClusterIP"
    },
    "status": {
        "loadBalancer": {}
    }
}

controlplane ~ ➜  

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
              /wear     wear-service:8080 (10.244.0.4:8080)
              /stream   video-service:8080 (10.244.0.5:8080)
              /eat      food-service:8080 (10.244.0.10:8080)
              /pay      pay-service:8282 (<error: endpoints "pay-service" not found>)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:
  Type    Reason  Age                From                      Message
  ----    ------  ----               ----                      -------
  Normal  Sync    18m (x5 over 35m)  nginx-ingress-controller  Scheduled for sync

controlplane ~ ➜  


Pode ser porque o pay-service está em outro namespace
Pode ser porque o pay-service está em outro namespace
Pode ser porque o pay-service está em outro namespace
Pode ser porque o pay-service está em outro namespace

https://kubernetes.io/docs/concepts/services-networking/service/#dns
DNS

You can (and almost always should) set up a DNS service for your Kubernetes cluster using an add-on.

A cluster-aware DNS server, such as CoreDNS, watches the Kubernetes API for new Services and creates a set of DNS records for each one. If DNS has been enabled throughout your cluster then all Pods should automatically be able to resolve Services by their DNS name.

For example, if you have a Service called my-service in a Kubernetes namespace my-ns, the control plane and the DNS Service acting together create a DNS record for my-service.my-ns. Pods in the my-ns namespace should be able to find the service by doing a name lookup for my-service (my-service.my-ns would also work).

Pods in other namespaces must qualify the name as my-service.my-ns. These names will resolve to the cluster IP assigned for the Service.

Kubernetes also supports DNS SRV (Service) records for named ports. If the my-service.my-ns Service has a port named http with the protocol set to TCP, you can do a DNS SRV query for _http._tcp.my-service.my-ns to discover the port number for http, as well as the IP address.

The Kubernetes DNS server is the only way to access ExternalName Services. You can find more information about ExternalName resolution in DNS for Services and Pods.
Virtual IP addressing 

ANTES

controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 4
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "2980"
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
      - backend:
          service:
            name: pay-service
            port:
              number: 8282
        path: /pay
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: 10.96.197.136

controlplane ~ ➜  date
Thu Apr  4 12:45:27 AM UTC 2024

controlplane ~ ➜  


pay-service.critical-space

ajustando


apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 4
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "2980"
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
      - backend:
          service:
            name: pay-service.critical-space
            port:
              number: 8282
        path: /pay
        pathType: Prefix


- ERRO

~~~~BASH
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
# ingresses.networking.k8s.io "ingress-wear-watch" was not valid:
# * spec.rules[0].http.paths[3].backend.service.name: Invalid value: "pay-service.critical-space": a DNS-1035 label must consist of lower case alphanumeric characters or '-', start with an alphabetic character, and end with an alphanumeric character (e.g. 'my-name',  or 'abc-123', regex used for validation is '[a-z]([-a-z0-9]*[a-z0-9])?')
#
~~~~


controlplane ~ ➜  kubectl get all -n critical-space
NAME                              READY   STATUS    RESTARTS   AGE
pod/webapp-pay-657d677c99-2hnq4   1/1     Running   0          30m

NAME                  TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/pay-service   ClusterIP   10.109.140.27   <none>        8282/TCP   30m

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/webapp-pay   1/1     1            1           30m

NAME                                    DESIRED   CURRENT   READY   AGE
replicaset.apps/webapp-pay-657d677c99   1         1         1       30m

controlplane ~ ➜  


controlplane ~ ✖ kubectl get service/pay-service -n critical-space -o yaml
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: "2024-04-04T00:18:44Z"
  name: pay-service
  namespace: critical-space
  resourceVersion: "2666"
  uid: a8151d1e-7876-476c-b41b-188be779a6a4
spec:
  clusterIP: 10.109.140.27
  clusterIPs:
  - 10.109.140.27
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 8282
    protocol: TCP
    targetPort: 8080
  selector:
    app: webapp-pay
  sessionAffinity: None
  type: ClusterIP
status:
  loadBalancer: {}

controlplane ~ ➜  
controlplane ~ ➜  kubectl get deployment.apps/webapp-pay -n critical-space -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2024-04-04T00:18:44Z"
  generation: 1
  name: webapp-pay
  namespace: critical-space
  resourceVersion: "2681"
  uid: 0c90a429-d2fd-45aa-870f-56904f359e69
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: webapp-pay
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp-pay
    spec:
      containers:
      - image: kodekloud/ecommerce:pay
        imagePullPolicy: Always
        name: webapp-pay
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
  - lastTransitionTime: "2024-04-04T00:18:47Z"
    lastUpdateTime: "2024-04-04T00:18:47Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2024-04-04T00:18:44Z"
    lastUpdateTime: "2024-04-04T00:18:47Z"
    message: ReplicaSet "webapp-pay-657d677c99" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  

   47  kubectl get service/pay-service -n critical-space -o yaml
   48  kubectl get deployment.apps/webapp-pay -n critical-space -o yaml


kubectl delete service/pay-service -n critical-space
kubectl delete deployment.apps/webapp-pay -n critical-space

controlplane ~ ➜  
kubectl delete service/pay-service -n critical-space
kubectl delete deployment.apps/webapp-pay -n critical-space
service "pay-service" deleted
deployment.apps "webapp-pay" deleted

controlplane ~ ➜  


apiVersion: apps/v1
kind: Deployment
metadata:
  name: webapp-pay
  namespace: app-space
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: webapp-pay
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: webapp-pay
    spec:
      containers:
      - image: kodekloud/ecommerce:pay
        imagePullPolicy: Always
        name: webapp-pay
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




apiVersion: v1
kind: Service
metadata:
  name: pay-service
  namespace: app-space
spec:
  clusterIP: 10.109.140.27
  clusterIPs:
  - 10.109.140.27
  internalTrafficPolicy: Cluster
  ipFamilies:
  - IPv4
  ipFamilyPolicy: SingleStack
  ports:
  - port: 8282
    protocol: TCP
    targetPort: 8080
  selector:
    app: webapp-pay
  sessionAffinity: None
  type: ClusterIPcontrolplane ~ ➜  vi deploy.yaml


  

controlplane ~ ➜  vi service.yaml

controlplane ~ ➜  kubectl apply -f deploy.yaml
deployment.apps/webapp-pay created

controlplane ~ ➜  kubectl apply -f service.yaml
service/pay-service created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get ingress ingress-wear-watch -n app-space -o yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
  creationTimestamp: "2024-04-04T00:04:47Z"
  generation: 4
  name: ingress-wear-watch
  namespace: app-space
  resourceVersion: "2980"
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
      - backend:
          service:
            name: pay-service
            port:
              number: 8282
        path: /pay
        pathType: Prefix
status:
  loadBalancer:
    ingress:
    - ip: 10.96.197.136

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
              /wear     wear-service:8080 (10.244.0.4:8080)
              /stream   video-service:8080 (10.244.0.5:8080)
              /eat      food-service:8080 (10.244.0.10:8080)
              /pay      pay-service:8282 (10.244.0.12:8080)
Annotations:  nginx.ingress.kubernetes.io/rewrite-target: /
              nginx.ingress.kubernetes.io/ssl-redirect: false
Events:
  Type    Reason  Age                From                      Message
  ----    ------  ----               ----                      -------
  Normal  Sync    33m (x5 over 50m)  nginx-ingress-controller  Scheduled for sync

controlplane ~ ➜  


Resolvido!
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/pay
abrindo normalmente
Resolvido!
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/pay
abrindo normalmente
Resolvido!
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/pay
abrindo normalmente
Resolvido!
https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/pay
abrindo normalmente


questão NÃO OK



controlplane ~ ➜  vi deploy2.yaml

controlplane ~ ➜  vi service2.yaml

controlplane ~ ➜  kubectl apply -f deploy2.yaml
deployment.apps/webapp-pay created

controlplane ~ ➜  kubectl apply -f service2.yaml
The Service "pay-service" is invalid: spec.clusterIPs: Invalid value: []string{"10.109.140.27"}: failed to allocate IP 10.109.140.27: provided IP is already allocated

controlplane ~ ✖ kubectl delete -f service.yaml 
service "pay-service" deleted

controlplane ~ ➜  kubectl delete -f deploy.yaml 
deployment.apps "webapp-pay" deleted

controlplane ~ ➜  kubectl apply -f service2.yaml
service/pay-service created

controlplane ~ ➜  

kubectl get ingress ingress-wear-watch -n app-space -o yaml

kubectl get ingress ingress-wear-watch -n app-space -o yaml


controlplane ~ ➜  kubectl apply -f ingress.yaml
Error from server (BadRequest): error when creating "ingress.yaml": admission webhook "validate.nginx.ingress.kubernetes.io" denied the request: host "_" and path "/pay" is already defined in ingress app-space/ingress-wear-watch

controlplane ~ ✖ kubectl edit ingress ingress-wear-watch -n app-space 
Edit cancelled, no changes made.

controlplane ~ ➜  kubectl edit ingress ingress-wear-watch -n app-space 
ingress.networking.k8s.io/ingress-wear-watch edited

controlplane ~ ➜  

^[[A^[[A^[[A
controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f service2.yaml
service/pay-service unchanged

controlplane ~ ➜  kubectl apply -f ingress.yaml
ingress.networking.k8s.io/ingress-pay created

controlplane ~ ➜  


Solução
foi necessário deletar o deployment e service criados no ns do app original
recriar o deployment e service no ns critical-space
criar 1 ingress neste ns critical-space











View the Payment application using the /pay URL in your browser.

Click on the Ingress tab above your terminal, if its not open already, and append /pay to the URL in the browser.

https://30080-port-6c189bbec1f04c4e.labs.kodekloud.com/pay
abriu







## PENDENTE
- Revisar a questão
    If the requirement does not match any of the configured paths in the Ingress, to which service are the requests forwarded?
pois não tem default configurado, apesar de existir o service/default-backend-service no namespace, ele nao ta setado no ingress


# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 87. Practice Test - Monitor Application Logs"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status





# ##############################################################################################################################################################
#  87. Practice Test - Monitor Application Logs







We have deployed a POD hosting an application. Inspect it. Wait for it to start.

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-tmbqr                  1/1     Running     0          17m
kube-system   local-path-provisioner-5d56847996-s9vpl   1/1     Running     0          17m
kube-system   helm-install-traefik-crd-7hg9w            0/1     Completed   0          17m
kube-system   helm-install-traefik-8cffl                0/1     Completed   1          17m
kube-system   metrics-server-7b67f64457-jlfs8           1/1     Running     0          17m
kube-system   svclb-traefik-e40fd97e-tn6bc              2/2     Running     0          17m
kube-system   traefik-56b8c5fb5c-2mctp                  1/1     Running     0          17m
default       webapp-1                                  1/1     Running     0          20s

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-tmbqr                  1/1     Running     0          18m
kube-system   local-path-provisioner-5d56847996-s9vpl   1/1     Running     0          18m
kube-system   helm-install-traefik-crd-7hg9w            0/1     Completed   0          18m
kube-system   helm-install-traefik-8cffl                0/1     Completed   1          18m
kube-system   metrics-server-7b67f64457-jlfs8           1/1     Running     0          18m
kube-system   svclb-traefik-e40fd97e-tn6bc              2/2     Running     0          17m
kube-system   traefik-56b8c5fb5c-2mctp                  1/1     Running     0          17m
default       webapp-1                                  1/1     Running     0          48s

controlplane ~ ➜  














A user - USER5 - has expressed concerns accessing the application. Identify the cause of the issue.

Inspect the logs of the POD



controlplane ~ ➜  kubectl logs webapp-1
[2023-02-11 03:18:19,008] INFO in event-simulator: USER1 logged out
[2023-02-11 03:18:20,009] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:21,010] INFO in event-simulator: USER4 logged out
[2023-02-11 03:18:22,012] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:23,013] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:24,014] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:24,015] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:18:25,016] INFO in event-simulator: USER1 logged out
[2023-02-11 03:18:26,017] INFO in event-simulator: USER1 logged in
[2023-02-11 03:18:27,019] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:27,019] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:18:28,020] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:18:29,021] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:29,021] INFO in event-simulator: USER3 logged in
[2023-02-11 03:18:30,022] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:31,024] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:18:32,025] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:33,025] INFO in event-simulator: USER4 logged out
[2023-02-11 03:18:34,027] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:34,027] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:35,029] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:35,029] INFO in event-simulator: USER3 logged out
[2023-02-11 03:18:36,030] INFO in event-simulator: USER1 is viewing page2
[2023-02-11 03:18:37,031] INFO in event-simulator: USER3 logged out
[2023-02-11 03:18:38,033] INFO in event-simulator: USER2 is viewing page2
[2023-02-11 03:18:39,034] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:39,035] INFO in event-simulator: USER1 is viewing page1
[2023-02-11 03:18:40,036] INFO in event-simulator: USER1 is viewing page3
[2023-02-11 03:18:41,037] INFO in event-simulator: USER1 is viewing page2
[2023-02-11 03:18:42,038] INFO in event-simulator: USER4 is viewing page3
[2023-02-11 03:18:43,040] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:43,040] INFO in event-simulator: USER1 logged in
[2023-02-11 03:18:44,041] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:44,042] INFO in event-simulator: USER1 logged out
[2023-02-11 03:18:45,043] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:18:46,045] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:47,047] INFO in event-simulator: USER1 logged in
[2023-02-11 03:18:48,048] INFO in event-simulator: USER2 is viewing page3
[2023-02-11 03:18:49,049] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:49,049] INFO in event-simulator: USER4 logged in
[2023-02-11 03:18:50,050] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:51,052] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:51,052] INFO in event-simulator: USER3 logged in
[2023-02-11 03:18:52,053] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:53,054] INFO in event-simulator: USER2 is viewing page2
[2023-02-11 03:18:54,056] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:54,056] INFO in event-simulator: USER4 logged out
[2023-02-11 03:18:55,058] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:18:56,059] INFO in event-simulator: USER2 logged out
[2023-02-11 03:18:57,061] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:18:58,062] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:18:59,063] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:18:59,064] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:18:59,064] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:19:00,065] INFO in event-simulator: USER1 is viewing page3
[2023-02-11 03:19:01,067] INFO in event-simulator: USER4 logged out
[2023-02-11 03:19:02,068] INFO in event-simulator: USER1 is viewing page2
[2023-02-11 03:19:03,070] INFO in event-simulator: USER3 logged in
[2023-02-11 03:19:04,071] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:04,072] INFO in event-simulator: USER2 logged in
[2023-02-11 03:19:05,073] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:19:06,075] INFO in event-simulator: USER2 is viewing page1
[2023-02-11 03:19:07,076] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:19:07,077] INFO in event-simulator: USER4 logged out
[2023-02-11 03:19:08,078] INFO in event-simulator: USER2 is viewing page2
[2023-02-11 03:19:09,079] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:09,079] INFO in event-simulator: USER1 logged in
[2023-02-11 03:19:10,081] INFO in event-simulator: USER4 logged out
[2023-02-11 03:19:11,083] INFO in event-simulator: USER2 logged in
[2023-02-11 03:19:12,084] INFO in event-simulator: USER2 is viewing page3
[2023-02-11 03:19:13,085] INFO in event-simulator: USER3 logged out
[2023-02-11 03:19:14,087] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:14,087] INFO in event-simulator: USER3 logged in
[2023-02-11 03:19:15,088] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:19:15,089] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:19:16,090] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:19:17,091] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:19:18,093] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:19:19,094] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:19:19,094] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:19:20,096] INFO in event-simulator: USER1 logged out
[2023-02-11 03:19:21,097] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:19:22,098] INFO in event-simulator: USER3 logged out

controlplane ~ ➜  




- RESPOSTA
USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.

[2023-02-11 03:18:29,021] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.














We have deployed a new POD - webapp-2 - hosting an application. Inspect it. Wait for it to start.


controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-tmbqr                  1/1     Running     0          20m
kube-system   local-path-provisioner-5d56847996-s9vpl   1/1     Running     0          20m
kube-system   helm-install-traefik-crd-7hg9w            0/1     Completed   0          20m
kube-system   helm-install-traefik-8cffl                0/1     Completed   1          20m
kube-system   metrics-server-7b67f64457-jlfs8           1/1     Running     0          20m
kube-system   svclb-traefik-e40fd97e-tn6bc              2/2     Running     0          19m
kube-system   traefik-56b8c5fb5c-2mctp                  1/1     Running     0          19m
default       webapp-1                                  1/1     Running     0          2m49s
default       webapp-2                                  2/2     Running     0          13s

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl logs webapp-2
Defaulted container "simple-webapp" out of: simple-webapp, db
[2023-02-11 03:20:52,514] INFO in event-simulator: USER4 is viewing page2
[2023-02-11 03:20:53,516] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:20:54,517] INFO in event-simulator: USER3 is viewing page3
[2023-02-11 03:20:55,519] INFO in event-simulator: USER1 logged in
[2023-02-11 03:20:56,520] INFO in event-simulator: USER4 logged in
[2023-02-11 03:20:57,522] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:20:57,522] INFO in event-simulator: USER4 is viewing page1
[2023-02-11 03:20:58,524] INFO in event-simulator: USER1 logged in
[2023-02-11 03:20:59,525] INFO in event-simulator: USER3 is viewing page2
[2023-02-11 03:21:00,526] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:21:00,527] INFO in event-simulator: USER4 logged in
[2023-02-11 03:21:01,528] INFO in event-simulator: USER3 logged in
[2023-02-11 03:21:02,529] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:21:02,529] INFO in event-simulator: USER2 is viewing page1
[2023-02-11 03:21:03,531] INFO in event-simulator: USER2 logged in
[2023-02-11 03:21:04,532] INFO in event-simulator: USER3 is viewing page1
[2023-02-11 03:21:05,533] INFO in event-simulator: USER1 is viewing page1
[2023-02-11 03:21:06,535] INFO in event-simulator: USER3 logged in
[2023-02-11 03:21:07,536] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-11 03:21:07,536] INFO in event-simulator: USER4 is viewing page3
[2023-02-11 03:21:08,537] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
[2023-02-11 03:21:08,537] INFO in event-simulator: USER3 logged out
[2023-02-11 03:21:09,538] INFO in event-simulator: USER3 is viewing page3

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod webapp-2
Name:             webapp-2
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/172.25.0.20
Start Time:       Sat, 11 Feb 2023 03:20:50 +0000
Labels:           name=webapp-2
Annotations:      <none>
Status:           Running
IP:               10.42.0.10
IPs:
  IP:  10.42.0.10
Containers:
  simple-webapp:
    Container ID:   containerd://99a85f34c6a90f9f515869c0740d12f862534aff8801eb10e854813d1ecc19e3
    Image:          kodekloud/event-simulator
    Image ID:       docker.io/kodekloud/event-simulator@sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sat, 11 Feb 2023 03:20:52 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      OVERRIDE_USER:  USER30
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-cnchb (ro)
  db:
    Container ID:  containerd://e9ebf08b507baea1cd653d630eae96c44049e2a8af13eb3a062114f5374e3543
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:7b3ccabffc97de872a30dfd234fd972a66d247c8cfc69b0550f276481852627c
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      5000
    State:          Running
      Started:      Sat, 11 Feb 2023 03:20:54 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-cnchb (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-cnchb:
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
  Normal  Scheduled  39s   default-scheduler  Successfully assigned default/webapp-2 to controlplane
  Normal  Pulling    39s   kubelet            Pulling image "kodekloud/event-simulator"
  Normal  Pulled     39s   kubelet            Successfully pulled image "kodekloud/event-simulator" in 454.723572ms (454.741156ms including waiting)
  Normal  Created    38s   kubelet            Created container simple-webapp
  Normal  Started    38s   kubelet            Started container simple-webapp
  Normal  Pulling    38s   kubelet            Pulling image "busybox"
  Normal  Pulled     36s   kubelet            Successfully pulled image "busybox" in 1.759835105s (1.759857084s including waiting)
  Normal  Created    36s   kubelet            Created container db
  Normal  Started    36s   kubelet            Started container db

controlplane ~ ➜  















A user is reporting issues while trying to purchase an item. Identify the user and the cause of the issue.

Inspect the logs of the webapp in the POD



[2023-02-11 03:27:41,140] WARNING in event-simulator: USER30 Order failed as the item is OUT OF STOCK.
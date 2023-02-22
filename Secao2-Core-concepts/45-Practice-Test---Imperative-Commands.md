

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 45. Practice Test - Imperative Commands"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 45. Practice Test - Imperative Commands




# Deploy a pod named nginx-pod using the nginx:alpine image.

Use imperative commands only.

    Name: nginx-pod

    Image: nginx:alpine

kubectl run nginx-pod --image=nginx:alpine





# Deploy a redis pod using the redis:alpine image with the labels set to tier=db.

Either use imperative commands to create the pod with the labels. Or else use imperative commands to generate the pod definition file, then add the labels before creating the pod using the file.

    Pod Name: redis

    Image: redis:alpine

    Labels: tier=db

- Resposta:
kubectl run redis --image=redis:alpine --labels tier=db


- Exemplo adicional
  # Start a hazelcast pod and set labels "app=hazelcast" and "env=prod" in the container
  kubectl run hazelcast --image=hazelcast/hazelcast --labels="app=hazelcast,env=prod"






controlplane ~ ➜  kubectl run nginx-pod --image=nginx:alpine
pod/nginx-pod created

controlplane ~ ➜  

controlplane ~ ➜  kubectl run redis --image=redis:alpine --labels tier=db
pod/redis created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS              RESTARTS   AGE
kube-system   coredns-b96499967-92sxl                   1/1     Running             0          21m
kube-system   local-path-provisioner-7b7dc8d6f5-kn679   1/1     Running             0          21m
kube-system   helm-install-traefik-crd-cbjgc            0/1     Completed           0          21m
kube-system   metrics-server-668d979685-l87jh           1/1     Running             0          21m
kube-system   helm-install-traefik-ql4wb                0/1     Completed           2          21m
kube-system   svclb-traefik-xvbsg                       2/2     Running             0          20m
kube-system   traefik-7cd4fcff68-phdp7                  1/1     Running             0          20m
default       nginx-pod                                 1/1     Running             0          3m13s
default       redis                                     0/1     ContainerCreating   0          4s

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-b96499967-92sxl                   1/1     Running     0          21m
kube-system   local-path-provisioner-7b7dc8d6f5-kn679   1/1     Running     0          21m
kube-system   helm-install-traefik-crd-cbjgc            0/1     Completed   0          21m
kube-system   metrics-server-668d979685-l87jh           1/1     Running     0          21m
kube-system   helm-install-traefik-ql4wb                0/1     Completed   2          21m
kube-system   svclb-traefik-xvbsg                       2/2     Running     0          20m
kube-system   traefik-7cd4fcff68-phdp7                  1/1     Running     0          20m
default       nginx-pod                                 1/1     Running     0          3m17s
default       redis                                     1/1     Running     0          8s

controlplane ~ ➜  kubectl describe pod redis
Name:         redis
Namespace:    default
Priority:     0
Node:         controlplane/172.25.0.32
Start Time:   Tue, 25 Oct 2022 01:36:53 +0000
Labels:       tier=db
Annotations:  <none>
Status:       Running
IP:           10.42.0.10
IPs:
  IP:  10.42.0.10
Containers:
  redis:
    Container ID:   containerd://52cd384d98187d483141391a8db98e39e101c18c4055cc624252651ba92822b4
    Image:          redis:alpine
    Image ID:       docker.io/library/redis@sha256:cbb77cfe5c69b1d5aba8750d428624b7fe2cbe0d7761838e81f3caa82b852e0f
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Tue, 25 Oct 2022 01:36:57 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-2bxhl (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-2bxhl:
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
  Normal  Scheduled  25s   default-scheduler  Successfully assigned default/redis to controlplane
  Normal  Pulling    24s   kubelet            Pulling image "redis:alpine"
  Normal  Pulled     22s   kubelet            Successfully pulled image "redis:alpine" in 2.683314913s
  Normal  Created    22s   kubelet            Created container redis
  Normal  Started    21s   kubelet            Started container redis

controlplane ~ ➜  











# Create a service redis-service to expose the redis application within the cluster on port 6379.

Use imperative commands.

    Service: redis-service

    Port: 6379

    Type: ClusterIP

kubectl expose pod redis --port=6379 --name redis-service

(This will automatically use the pod's labels as selectors)
(This will automatically use the pod's labels as selectors)
(This will automatically use the pod's labels as selectors)

OBS: O Comando expose detecta os labels automaticamente!
OBS: O Comando expose detecta os labels automaticamente!
OBS: O Comando expose detecta os labels automaticamente!






# Create a deployment named webapp using the image kodekloud/webapp-color with 3 replicas.

Try to use imperative commands only. Do not create definition files.

    Name: webapp

    Image: kodekloud/webapp-color

    Replicas: 3



kubectl create deployment webapp --image=kodekloud/webapp-color --replicas=3










# Create a new pod called custom-nginx using the nginx image and expose it on container port 8080.

    Pod created correctly?

kubectl run custom-nginx --image=nginx --port=8080







# Create a new namespace called dev-ns.

Use imperative commands.

    Namespace created?

kubectl create ns dev-ns





# Create a new deployment called redis-deploy in the dev-ns namespace with the redis image. It should have 2 replicas.

Use imperative commands.

    'redis-deploy' created in the 'dev-ns' namespace?

    replicas: 2


kubectl create deployment --image=redis redis-deploy --replicas=2 -n dev-ns






# Create a pod called httpd using the image httpd:alpine in the default namespace. Next, create a service of type ClusterIP by the same name (httpd). The target port for the service should be 80.

Try to do this with as few steps as possible.

    'httpd' pod created with the correct image?

    'httpd' service is of type 'ClusterIP'?

    'httpd' service uses correct target port 80?

    'httpd' service exposes the 'httpd' pod?

kubectl run httpd --image=httpd:alpine -n default
kubectl expose pod httpd --type=ClusterIP --port=80 --name=httpd


- Opção que faz tudo em 1 comando
adicionar a opção "--expose=true" ao primeiro comando
kubectl run httpd --image=httpd:alpine -n default --expose=true
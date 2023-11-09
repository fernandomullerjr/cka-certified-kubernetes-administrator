

# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "168. Practice Test Service Accounts."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 168. Practice Test Service Accounts



How many Service Accounts exist in the default namespace?
                                

controlplane ~ ➜  kubectl get sa
NAME      SECRETS   AGE
default   0         16m
dev       0         2m47s

controlplane ~ ➜  








What is the secret token used by the default service account?



controlplane ~ ➜  kubectl describe sa default
Name:                default
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   <none>
Tokens:              <none>
Events:              <none>

controlplane ~ ➜  













We just deployed the Dashboard application. Inspect the deployment. What is the image used by the deployment?


controlplane ~ ➜  kubectl get deployment -A
NAMESPACE     NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   local-path-provisioner   1/1     1            1           17m
kube-system   coredns                  1/1     1            1           17m
kube-system   traefik                  1/1     1            1           17m
kube-system   metrics-server           1/1     1            1           17m
default       web-dashboard            1/1     1            1           15s

controlplane ~ ➜  




controlplane ~ ➜  kubectl get deployment web-dashboard -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2023-11-09T02:52:53Z"
  generation: 1
  name: web-dashboard
  namespace: default
  resourceVersion: "944"
  uid: 578003a5-c179-4a12-b97f-65984258fc0a
spec:
  progressDeadlineSeconds: 600
  replicas: 1
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      name: web-dashboard
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: web-dashboard
    spec:
      containers:
      - env:
        - name: PYTHONUNBUFFERED
          value: "1"
        image: gcr.io/kodekloud/customimage/my-kubernetes-dashboard
        imagePullPolicy: Always
        name: web-dashboard
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
  - lastTransitionTime: "2023-11-09T02:52:58Z"
    lastUpdateTime: "2023-11-09T02:52:58Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2023-11-09T02:52:53Z"
    lastUpdateTime: "2023-11-09T02:52:58Z"
    message: ReplicaSet "web-dashboard-97c9c59f6" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  











Wait for the deployment to be ready. Access the custom-dashboard by clicking on the link to dashboard portal.

https://30080-port-61616da2991745a5.labs.kodekloud.com/#!/view1 
<https://30080-port-61616da2991745a5.labs.kodekloud.com/#!/view1 >

My Kubernetes Dashboard
Token
Name 	State 	Containers 	Service Account 	IP
pods is forbidden: User "system:serviceaccount:default:default" cannot list resource "pods" in API group "" in the namespace "default" 





What is the state of the dashboard? Have the pod details loaded successfully?




What type of account does the Dashboard application use to query the Kubernetes API?






Which account does the Dashboard application use to query the Kubernetes API?

Default




Inspect the Dashboard Application POD and identify the Service Account mounted on it.


controlplane ~ ➜  kubectl get pods 
NAME                            READY   STATUS    RESTARTS   AGE
web-dashboard-97c9c59f6-pm9dv   1/1     Running   0          3m30s

controlplane ~ ➜  
controlplane ~ ➜  kubectl describe pod web-dashboard-97c9c59f6-pm9dv
Name:             web-dashboard-97c9c59f6-pm9dv
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.4.168.8
Start Time:       Thu, 09 Nov 2023 02:52:53 +0000
Labels:           name=web-dashboard
                  pod-template-hash=97c9c59f6
Annotations:      <none>
Status:           Running
IP:               10.42.0.9
IPs:
  IP:           10.42.0.9
Controlled By:  ReplicaSet/web-dashboard-97c9c59f6
Containers:
  web-dashboard:
    Container ID:   containerd://c520135e80ffa73383d5412638edeadeb7e314884334f41d5e8f1f43584300d4
    Image:          gcr.io/kodekloud/customimage/my-kubernetes-dashboard
    Image ID:       gcr.io/kodekloud/customimage/my-kubernetes-dashboard@sha256:7d70abe342b13ff1c4242dc83271ad73e4eedb04e2be0dd30ae7ac8852193069
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Thu, 09 Nov 2023 02:52:57 +0000
    Ready:          True
    Restart Count:  0
    Environment:
      PYTHONUNBUFFERED:  1
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zz78s (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-zz78s:
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
  Normal  Scheduled  3m43s  default-scheduler  Successfully assigned default/web-dashboard-97c9c59f6-pm9dv to controlplane
  Normal  Pulling    3m42s  kubelet            Pulling image "gcr.io/kodekloud/customimage/my-kubernetes-dashboard"
  Normal  Pulled     3m39s  kubelet            Successfully pulled image "gcr.io/kodekloud/customimage/my-kubernetes-dashboard" in 3.096713778s (3.096728453s including waiting)
  Normal  Created    3m39s  kubelet            Created container web-dashboard
  Normal  Started    3m39s  kubelet            Started container web-dashboard

controlplane ~ ➜  
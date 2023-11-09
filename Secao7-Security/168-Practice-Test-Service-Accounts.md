

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











At what location is the ServiceAccount credentials available within the pod?

/var/run/secrets







The application needs a ServiceAccount with the Right permissions to be created to authenticate to Kubernetes. The default ServiceAccount has limited access. Create a new ServiceAccount named dashboard-sa.

    Service Account Name: dashboard-sa


controlplane ~ ➜  kubectl describe sa default
Name:                default
Namespace:           default
Labels:              <none>
Annotations:         <none>
Image pull secrets:  <none>
Mountable secrets:   <none>
Tokens:              <none>
Events:              <none>

controlplane ~ ➜  kubectl get sa default -o yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  creationTimestamp: "2023-11-09T02:35:30Z"
  name: default
  namespace: default
  resourceVersion: "348"
  uid: 3ad31b47-3c8b-4fae-8ddd-10545385c883

controlplane ~ ➜  


https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions
<https://kubernetes.io/docs/reference/access-authn-authz/rbac/#service-account-permissions>


kubectl create role dashboard-sa --verb=get --verb=list --verb=watch --resource=pods

Examples:
  # Create a new service account named my-service-account
  kubectl create serviceaccount dashboard-sa

kubectl create rolebinding dashboard-sa \
  --clusterrole=dashboard-sa \
  --serviceaccount=default:dashboard-sa \
  --namespace=default



controlplane ~ ➜  
kubectl create role dashboard-sa --verb=get --verb=list --verb=watch --resource=pods
role.rbac.authorization.k8s.io/dashboard-sa created

controlplane ~ ➜  

controlplane ~ ➜  kubectl create serviceaccount dashboard-sa
serviceaccount/dashboard-sa created

controlplane ~ ➜  
kubectl create rolebinding dashboard-sa \
  --clusterrole=dashboard-sa \
  --serviceaccount=default:dashboard-sa \
  --namespace=default
rolebinding.rbac.authorization.k8s.io/dashboard-sa created

controlplane ~ ➜  



kubectl describe pod web-dashboard-97c9c59f6-pm9dv


kubectl edit pod web-dashboard-97c9c59f6-pm9dv


kubectl describe pod web-dashboard-97c9c59f6-pm9dv


controlplane ~ ➜  kubectl edit pod web-dashboard-97c9c59f6-pm9dv
pod/web-dashboard-97c9c59f6-pm9dv edited

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod web-dashboard-97c9c59f6-pm9dv | grep -i service 
Service Account:  default
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zz78s (ro)

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
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  13m   default-scheduler  Successfully assigned default/web-dashboard-97c9c59f6-pm9dv to controlplane
  Normal  Pulling    13m   kubelet            Pulling image "gcr.io/kodekloud/customimage/my-kubernetes-dashboard"
  Normal  Pulled     13m   kubelet            Successfully pulled image "gcr.io/kodekloud/customimage/my-kubernetes-dashboard" in 3.096713778s (3.096728453s including waiting)
  Normal  Created    13m   kubelet            Created container web-dashboard
  Normal  Started    13m   kubelet            Started container web-dashboard

controlplane ~ ➜  



https://kubernetes.io/docs/concepts/security/service-accounts/#assign-to-pod


controlplane ~ ✖ kubectl get pod web-dashboard-97c9c59f6-pm9dv -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-11-09T02:52:53Z"
  generateName: web-dashboard-97c9c59f6-
  labels:
    name: web-dashboard
    pod-template-hash: 97c9c59f6
  name: web-dashboard-97c9c59f6-pm9dv
  namespace: default
  ownerReferences:
  - apiVersion: apps/v1
    blockOwnerDeletion: true
    controller: true
    kind: ReplicaSet
    name: web-dashboard-97c9c59f6
    uid: 41b1355b-2966-43be-9dc5-07aa4493eec1
  resourceVersion: "940"
  uid: 7322c6d8-dace-4231-8758-70a716c29fbc
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
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-zz78s
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
  - name: kube-api-access-zz78s
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
    lastTransitionTime: "2023-11-09T02:52:53Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-11-09T02:52:58Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-11-09T02:52:58Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-11-09T02:52:53Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://c520135e80ffa73383d5412638edeadeb7e314884334f41d5e8f1f43584300d4
    image: gcr.io/kodekloud/customimage/my-kubernetes-dashboard:latest
    imageID: gcr.io/kodekloud/customimage/my-kubernetes-dashboard@sha256:7d70abe342b13ff1c4242dc83271ad73e4eedb04e2be0dd30ae7ac8852193069
    lastState: {}
    name: web-dashboard
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-11-09T02:52:57Z"
  hostIP: 192.4.168.8
  phase: Running
  podIP: 10.42.0.9
  podIPs:
  - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-11-09T02:52:53Z"

controlplane ~ ➜  



controlplane ~ ➜  kubectl apply -f pod-edicao.yaml
The Pod "web-dashboard-97c9c59f6-pm9dv" is invalid: metadata.ownerReferences.uid: Invalid value: "": uid must not be empty

controlplane ~ ✖ vi pod-edicao.yaml

controlplane ~ ➜  kubectl apply -f pod-edicao.yaml
pod/web-dashboard-97c9c59f6-pm9dv created

controlplane ~ ➜  
controlplane ~ ➜  kubectl describe pod web-dashboard-97c9c59f6-pm9dv | grep -i service 
Service Account:           dashboard-sa
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-zz78s (ro)

controlplane ~ ➜  date
Thu Nov  9 03:14:06 UTC 2023

controlplane ~ ➜  













We just added additional permissions for the newly created dashboard-sa account using RBAC.

If you are interested checkout the files used to configure RBAC at /var/rbac. We will discuss RBAC in a separate section.

controlplane ~ ➜  ls /var/rbac
dashboard-sa-role-binding.yaml  pod-reader-role.yaml

controlplane ~ ➜  cat /var/rbac/dashboard-sa-role-binding.yaml 
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: ServiceAccount
  name: dashboard-sa # Name is case sensitive
  namespace: default
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cat /var/rbac/pod-reader-role.yaml 
---
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups:
  - ''
  resources:
  - pods
  verbs:
  - get
  - watch
  - list

controlplane ~ ➜  


















Enter the access token in the UI of the dashboard application. Click Load Dashboard button to load Dashboard

Create an authorization token for the newly created service account, copy the generated token and paste it into the token field of the UI.

To do this, run kubectl create token dashboard-sa for the dashboard-sa service account, copy the token and paste it in the UI.


controlplane ~ ➜  kubectl create token dashboard-sa 
eyJhbGciOiJSUzI1NiIsImtpZCI6 

controlplane ~ ➜  

















You shouldn't have to copy and paste the token each time. The Dashboard application is programmed to read token from the secret mount location. However currently, the default service account is mounted. Update the deployment to use the newly created ServiceAccount

Edit the deployment to change ServiceAccount from default to dashboard-sa.

    Deployment name: web-dashboard

    Service Account: dashboard-sa

    Deployment Ready

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
  resourceVersion: "1358"
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
  - lastTransitionTime: "2023-11-09T02:52:53Z"
    lastUpdateTime: "2023-11-09T02:52:58Z"
    message: ReplicaSet "web-dashboard-97c9c59f6" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  - lastTransitionTime: "2023-11-09T03:12:35Z"
    lastUpdateTime: "2023-11-09T03:12:35Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  



Adicionar

  serviceAccount: default
  serviceAccountName: default


controlplane ~ ➜  vi deployment.yaml

controlplane ~ ➜  kubectl apply -f deployment.yaml
Warning: resource deployments/web-dashboard is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
The request is invalid: patch: Invalid value: "map[metadata:map[annotations:map[kubectl.kubernetes.io/last-applied-configuration:{\"apiVersion\":\"apps/v1\",\"kind\":\"Deployment\",\"metadata\":{\"annotations\":{\"deployment.kubernetes.io/revision\":\"1\"},\"name\":\"web-dashboard\",\"namespace\":\"default\"},\"spec\":{\"progressDeadlineSeconds\":600,\"replicas\":1,\"revisionHistoryLimit\":10,\"selector\":{\"matchLabels\":{\"name\":\"web-dashboard\"}},\"serviceAccount\":\"dashboard-sa\",\"serviceAccountName\":\"dashboard-sa\",\"strategy\":{\"rollingUpdate\":{\"maxSurge\":\"25%\",\"maxUnavailable\":\"25%\"},\"type\":\"RollingUpdate\"},\"template\":{\"metadata\":{\"creationTimestamp\":null,\"labels\":{\"name\":\"web-dashboard\"}},\"spec\":{\"containers\":[{\"env\":[{\"name\":\"PYTHONUNBUFFERED\",\"value\":\"1\"}],\"image\":\"gcr.io/kodekloud/customimage/my-kubernetes-dashboard\",\"imagePullPolicy\":\"Always\",\"name\":\"web-dashboard\",\"ports\":[{\"containerPort\":8080,\"protocol\":\"TCP\"}],\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\"}],\"dnsPolicy\":\"ClusterFirst\",\"restartPolicy\":\"Always\",\"schedulerName\":\"default-scheduler\",\"securityContext\":{},\"terminationGracePeriodSeconds\":30}}}}\n]] spec:map[serviceAccount:dashboard-sa serviceAccountName:dashboard-sa]]": strict decoding error: unknown field "spec.serviceAccount", unknown field "spec.serviceAccountName"

controlplane ~ ✖ 


controlplane ~ ✖ kubectl delete -f deployment.yaml
deployment.apps "web-dashboard" deleted

controlplane ~ ➜  kubectl apply -f deployment.yaml
Error from server (BadRequest): error when creating "deployment.yaml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "spec.serviceAccount", unknown field "spec.serviceAccountName"

controlplane ~ ✖ 



controlplane ~ ✖ kubectl delete -f deployment.yaml
Error from server (NotFound): error when deleting "deployment.yaml": deployments.apps "web-dashboard" not found

controlplane ~ ✖ vi deployment.yaml

controlplane ~ ➜  kubectl apply -f deployment.yaml
Error from server (BadRequest): error when creating "deployment.yaml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "spec.template.serviceAccount", unknown field "spec.template.serviceAccountName"

controlplane ~ ✖ 





## PENDENTE
- Ver como editar Deployment para que ele informe o ServiceAccount, ao invés de direto no Pod.





controlplane ~ ✖ vi deployment.yaml

controlplane ~ ➜  kubectl apply -f deployment.yaml
deployment.apps/web-dashboard created

controlplane ~ ➜  



controlplane ~ ➜  kubectl get deployment
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
web-dashboard   1/1     1            1           24s

controlplane ~ ➜  kubectl get deployment web-dashboard -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"apps/v1","kind":"Deployment","metadata":{"annotations":{"deployment.kubernetes.io/revision":"1"},"name":"web-dashboard","namespace":"default"},"spec":{"progressDeadlineSeconds":600,"replicas":1,"revisionHistoryLimit":10,"selector":{"matchLabels":{"name":"web-dashboard"}},"strategy":{"rollingUpdate":{"maxSurge":"25%","maxUnavailable":"25%"},"type":"RollingUpdate"},"template":{"metadata":{"creationTimestamp":null,"labels":{"name":"web-dashboard"}},"spec":{"containers":[{"env":[{"name":"PYTHONUNBUFFERED","value":"1"}],"image":"gcr.io/kodekloud/customimage/my-kubernetes-dashboard","imagePullPolicy":"Always","name":"web-dashboard","ports":[{"containerPort":8080,"protocol":"TCP"}],"resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File"}],"dnsPolicy":"ClusterFirst","restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"serviceAccount":"dashboard-sa","serviceAccountName":"dashboard-sa","terminationGracePeriodSeconds":30}}}}
  creationTimestamp: "2023-11-09T03:33:05Z"
  generation: 1
  name: web-dashboard
  namespace: default
  resourceVersion: "1824"
  uid: a870ddeb-8198-42fe-b539-596d58425437
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
      serviceAccount: dashboard-sa
      serviceAccountName: dashboard-sa
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2023-11-09T03:33:08Z"
    lastUpdateTime: "2023-11-09T03:33:08Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2023-11-09T03:33:05Z"
    lastUpdateTime: "2023-11-09T03:33:08Z"
    message: ReplicaSet "web-dashboard-598c6cb6d" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  date
Thu Nov  9 03:33:35 UTC 2023

controlplane ~ ➜  









Refresh the Dashboard application UI and you should now see the PODs listed automatically.

This time you shouldn't have to put in the token manually.

https://30080-port-61616da2991745a5.labs.kodekloud.com/#!/view1
<https://30080-port-61616da2991745a5.labs.kodekloud.com/#!/view1>
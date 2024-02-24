
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 196. Practice Test - Storage Class."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 196. Practice Test - Storage Class


How many StorageClasses exist in the cluster right now?

              

controlplane ~ ➜  kubectl get sc
NAME                   PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  27m

controlplane ~ ➜  kubectl get sc -A
NAME                   PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  27m

controlplane ~ ➜  date
Fri Feb 23 23:42:36 UTC 2024

controlplane ~ ➜  






How about now? How many Storage Classes exist in the cluster?

We just created a few new Storage Classes. Inspect them.

controlplane ~ ➜  kubectl get sc -A
NAME                        PROVISIONER                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)        rancher.io/local-path           Delete          WaitForFirstConsumer   false                  27m
local-storage               kubernetes.io/no-provisioner    Delete          WaitForFirstConsumer   false                  12s
portworx-io-priority-high   kubernetes.io/portworx-volume   Delete          Immediate              false                  12s

controlplane ~ ➜  date
Fri Feb 23 23:43:12 UTC 2024

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe sc local-storage
Name:            local-storage
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"local-storage"},"provisioner":"kubernetes.io/no-provisioner","volumeBindingMode":"WaitForFirstConsumer"}

Provisioner:           kubernetes.io/no-provisioner
Parameters:            <none>
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     WaitForFirstConsumer
Events:                <none>

controlplane ~ ➜  kubectl describe sc portworx-io-priority-high
Name:            portworx-io-priority-high
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"portworx-io-priority-high"},"parameters":{"priority_io":"high","repl":"1","snap_interval":"70"},"provisioner":"kubernetes.io/portworx-volume"}

Provisioner:           kubernetes.io/portworx-volume
Parameters:            priority_io=high,repl=1,snap_interval=70
AllowVolumeExpansion:  <unset>
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     Immediate
Events:                <none>

controlplane ~ ➜  









What is the name of the Storage Class that does not support dynamic volume provisioning?

- RESPOSTA
local-storage










What is the Volume Binding Mode used for this storage class (the one identified in the previous question)?







What is the Provisioner used for the storage class called portworx-io-priority-high?



Is there a PersistentVolumeClaim that is consuming the PersistentVolume called local-pv?

controlplane ~ ➜  kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
local-pv   500Mi      RWO            Retain           Available           local-storage   <unset>                          3m38s

controlplane ~ ➜  kubectl get pv -A
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
local-pv   500Mi      RWO            Retain           Available           local-storage   <unset>                          3m40s

controlplane ~ ➜  kubectl get pvc
No resources found in default namespace.

controlplane ~ ➜  kubectl get pvc -A
No resources found

controlplane ~ ➜  









Let's fix that. Create a new PersistentVolumeClaim by the name of local-pvc that should bind to the volume local-pv.

Inspect the pv local-pv for the specs.

PVC: local-pvc

Correct Access Mode?

Correct StorageClass Used?

PVC requests volume size = 500Mi?


- Criando pvc

~~~~yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc
spec:
  accessModes:
    - ReadWriteOnce
#  volumeMode: Filesystem
  resources:
    requests:
      storage: 500Mi
#  storageClassName: slow
~~~~


controlplane ~ ➜  vi pvc.yaml

controlplane ~ ➜  kubectl apply -f pvc.yaml
persistentvolumeclaim/local-pvc created

controlplane ~ ➜  kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Pending                                      local-path     <unset>                 6s

controlplane ~ ➜  date
Fri Feb 23 23:51:26 UTC 2024

controlplane ~ ➜  

acusou incorreto
Correct StorageClass Used?


controlplane ~ ➜  kubectl get sc
NAME                        PROVISIONER                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)        rancher.io/local-path           Delete          WaitForFirstConsumer   false                  36m
local-storage               kubernetes.io/no-provisioner    Delete          WaitForFirstConsumer   false                  9m9s
portworx-io-priority-high   kubernetes.io/portworx-volume   Delete          Immediate              false                  9m9s

controlplane ~ ➜  

- Ajustando:

~~~~yaml

~~~~apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: local-pvc
spec:
  accessModes:
    - ReadWriteOnce
#  volumeMode: Filesystem
  resources:
    requests:
      storage: 500Mi
  storageClassName: local-storage
~~~~


- Problemas para deletar


controlplane ~ ➜  vi pvc.yaml 

controlplane ~ ➜  kubectl delete pvc.yaml
error: the server doesn't have a resource type "pvc"

controlplane ~ ✖ kubectl apply -f pvc.yaml
The PersistentVolumeClaim "local-pvc" is invalid: spec: Forbidden: spec is immutable after creation except resources.requests and volumeAttributesClassName for bound claims
  core.PersistentVolumeClaimSpec{
        ... // 2 identical fields
        Resources:        {Requests: {s"storage": {i: {...}, s: "500Mi", Format: "BinarySI"}}},
        VolumeName:       "",
-       StorageClassName: &"local-path",
+       StorageClassName: &"local-storage",
        VolumeMode:       &"Filesystem",
        DataSource:       nil,
        ... // 2 identical fields
  }


controlplane ~ ✖ kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Pending                                      local-path     <unset>                 2m2s

controlplane ~ ➜  kubectl delete pvc local-vc
Error from server (NotFound): persistentvolumeclaims "local-vc" not found

controlplane ~ ✖ kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Pending                                      local-path     <unset>                 2m18s



- ERRO via kubectl edit

~~~~bash

# persistentvolumeclaims "local-pvc" was not valid:
# * spec: Forbidden: spec is immutable after creation except resources.requests and volumeAttributesClassName for bound claims
#   core.PersistentVolumeClaimSpec{
#       ... // 2 identical fields



controlplane ~ ✖ kubectl edit pvc local-pvc
error: persistentvolumeclaims "local-pvc" is invalid
A copy of your changes has been stored to "/tmp/kubectl-edit-417286040.yaml"
error: Edit cancelled, no valid changes were saved.

controlplane ~ ✖ kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Pending                                      local-path     <unset>                 4m25s

controlplane ~ ➜  
~~~~






controlplane ~ ➜  kubectl delete -f pvc.yaml 
persistentvolumeclaim "local-pvc" deleted

controlplane ~ ➜  kubectl get pvc
No resources found in default namespace.

controlplane ~ ➜  


controlplane ~ ➜  kubectl apply -f pvc.yaml 
persistentvolumeclaim/local-pvc created

controlplane ~ ➜  kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS    VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Pending                                      local-storage   <unset>                 3s

controlplane ~ ➜  date
Fri Feb 23 23:56:41 UTC 2024

controlplane ~ ➜  






What is the status of the newly created Persistent Volume Claim?


Why is the PVC in a pending state despite making a valid request to claim the volume called local-pv?

Inspect the PVC events.

controlplane ~ ➜  kubectl get pvc
NAME        STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS    VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Pending                                      local-storage   <unset>                 29s

controlplane ~ ➜  kubectl describe pvc local-pvc
Name:          local-pvc
Namespace:     default
StorageClass:  local-storage
Status:        Pending
Volume:        
Labels:        <none>
Annotations:   <none>
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      
Access Modes:  
VolumeMode:    Filesystem
Used By:       <none>
Events:
  Type    Reason                Age               From                         Message
  ----    ------                ----              ----                         -------
  Normal  WaitForFirstConsumer  8s (x4 over 50s)  persistentvolume-controller  waiting for first consumer to be created before binding

controlplane ~ ➜  










The Storage Class called local-storage makes use of VolumeBindingMode set to WaitForFirstConsumer. This will delay the binding and provisioning of a PersistentVolume until a Pod using the PersistentVolumeClaim is created.





Create a new pod called nginx with the image nginx:alpine. The Pod should make use of the PVC local-pvc and mount the volume at the path /var/www/html.

The PV local-pv should be in a bound state.
Pod created with the correct Image?

Pod uses PVC called local-pvc?

local-pv bound?

nginx pod running?

Volume mounted at the correct path?


https://kubernetes.io/docs/concepts/storage/storage-classes/#default-storageclass

https://kubernetes.io/docs/concepts/storage/storage-classes/#default-storageclass

apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
  nodeSelector:
    kubernetes.io/hostname: kube-01
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: task-pv-claim
  containers:
    - name: task-pv-container
      image: nginx
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/usr/share/nginx/html"
          name: task-pv-storage

- Editado

apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: local-pvc
  containers:
    - name: task-pv-container
      image: nginx:alpine
      ports:
        - containerPort: 80
          name: "http-server"
      volumeMounts:
        - mountPath: "/var/www/html"
          name: task-pv-storage




controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl apply -f pod.yaml
pod/nginx created

controlplane ~ ➜  kubectl get pods
NAME    READY   STATUS              RESTARTS   AGE
nginx   0/1     ContainerCreating   0          4s

controlplane ~ ➜  kubectl get pods
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          6s

controlplane ~ ➜  date
Sat Feb 24 00:01:06 UTC 2024

controlplane ~ ➜  







What is the status of the local-pvc Persistent Volume Claim now?

controlplane ~ ➜  kubectl get pv
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM               STORAGECLASS    VOLUMEATTRIBUTESCLASS   REASON   AGE
local-pv   500Mi      RWO            Retain           Bound    default/local-pvc   local-storage   <unset>                          17m

controlplane ~ ➜  kubectl get pvc
NAME        STATUS   VOLUME     CAPACITY   ACCESS MODES   STORAGECLASS    VOLUMEATTRIBUTESCLASS   AGE
local-pvc   Bound    local-pv   500Mi      RWO            local-storage   <unset>                 4m57s

controlplane ~ ➜  date
Sat Feb 24 00:01:38 UTC 2024

controlplane ~ ➜  











Create a new Storage Class called delayed-volume-sc that makes use of the below specs:

provisioner: kubernetes.io/no-provisioner

volumeBindingMode: WaitForFirstConsumer


Storage Class uses: kubernetes.io/no-provisioner ?

Storage Class volumeBindingMode set to WaitForFirstConsumer ?


https://kubernetes.io/docs/concepts/storage/storage-classes/#default-storageclass
Local

apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer

Local volumes do not support dynamic provisioning in Kubernetes 1.29; however a StorageClass should still be created to delay volume binding until a Pod is actually scheduled to the appropriate node. This is specified by the WaitForFirstConsumer volume binding mode.

Delaying volume binding allows the scheduler to consider all of a Pod's scheduling constraints when choosing an appropriate PersistentVolume for a PersistentVolumeClaim.


~~~~yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-storage
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
~~~~


controlplane ~ ➜  vi sc.yaml

controlplane ~ ➜  kubectl apply -f sc.yaml
storageclass.storage.k8s.io/delayed-volume-sc created

controlplane ~ ➜  kubectl get sc
NAME                        PROVISIONER                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)        rancher.io/local-path           Delete          WaitForFirstConsumer   false                  48m
local-storage               kubernetes.io/no-provisioner    Delete          WaitForFirstConsumer   false                  20m
portworx-io-priority-high   kubernetes.io/portworx-volume   Delete          Immediate              false                  20m
delayed-volume-sc           kubernetes.io/no-provisioner    Delete          WaitForFirstConsumer   false                  4s

controlplane ~ ➜  date
Sat Feb 24 00:03:57 UTC 2024

controlplane ~ ➜  
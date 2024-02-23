
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


# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 191. Practice Test - Persistent Volumes and Persistent Volume Claims."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  191. Practice Test - Persistent Volumes and Persistent Volume Claims

We have deployed a POD. Inspect the POD and wait for it to start running.

In the current(default) namespace.

controlplane ~ ➜  kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          64s

controlplane ~ ➜  




The application stores logs at location /log/app.log. View the logs.


You can exec in to the container and open the file:

kubectl exec webapp -- cat /log/app.log


controlplane ~ ➜  kubectl exec webapp -- cat /log/app.log
[2024-02-03 17:14:49,472] INFO in event-simulator: USER3 is viewing page2
[2024-02-03 17:14:50,473] INFO in event-simulator: USER1 is viewing page1
[2024-02-03 17:14:51,474] INFO in event-simulator: USER1 is viewing page2
[2024-02-03 17:14:52,475] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:14:53,477] INFO in event-simulator: USER3 is viewing page3
[2024-02-03 17:14:54,478] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:14:54,478] INFO in event-simulator: USER4 is viewing page3
[2024-02-03 17:14:55,479] INFO in event-simulator: USER4 is viewing page1
[2024-02-03 17:14:56,480] INFO in event-simulator: USER3 logged out
[2024-02-03 17:14:57,482] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:14:57,482] INFO in event-simulator: USER3 logged in
[2024-02-03 17:14:58,483] INFO in event-simulator: USER1 is viewing page2
[2024-02-03 17:14:59,484] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:14:59,484] INFO in event-simulator: USER1 is viewing page1
[2024-02-03 17:15:00,485] INFO in event-simulator: USER3 logged out
[2024-02-03 17:15:01,487] INFO in event-simulator: USER3 logged in
[2024-02-03 17:15:02,488] INFO in event-simulator: USER2 logged out
[2024-02-03 17:15:03,489] INFO in event-simulator: USER3 logged out
[2024-02-03 17:15:04,491] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:04,491] INFO in event-simulator: USER2 is viewing page2
[2024-02-03 17:15:05,491] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:05,492] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:06,493] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:07,494] INFO in event-simulator: USER4 is viewing page1
[2024-02-03 17:15:08,495] INFO in event-simulator: USER2 is viewing page3
[2024-02-03 17:15:09,496] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:09,496] INFO in event-simulator: USER3 logged out
[2024-02-03 17:15:10,497] INFO in event-simulator: USER2 logged in
[2024-02-03 17:15:11,498] INFO in event-simulator: USER3 logged in
[2024-02-03 17:15:12,499] INFO in event-simulator: USER1 is viewing page1
[2024-02-03 17:15:13,499] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:13,499] INFO in event-simulator: USER4 is viewing page2
[2024-02-03 17:15:14,500] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:14,501] INFO in event-simulator: USER2 logged out
[2024-02-03 17:15:15,501] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:15:16,502] INFO in event-simulator: USER4 logged in
[2024-02-03 17:15:17,524] INFO in event-simulator: USER1 is viewing page1
[2024-02-03 17:15:18,525] INFO in event-simulator: USER2 logged in
[2024-02-03 17:15:19,525] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:19,526] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:20,527] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:21,527] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:21,527] INFO in event-simulator: USER4 logged out
[2024-02-03 17:15:22,528] INFO in event-simulator: USER4 is viewing page2
[2024-02-03 17:15:23,530] INFO in event-simulator: USER4 is viewing page3
[2024-02-03 17:15:24,531] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:24,531] INFO in event-simulator: USER2 logged in
[2024-02-03 17:15:25,532] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:26,532] INFO in event-simulator: USER2 is viewing page2
[2024-02-03 17:15:27,534] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:15:28,553] INFO in event-simulator: USER3 logged out
[2024-02-03 17:15:29,554] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:29,555] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:29,555] INFO in event-simulator: USER3 is viewing page1
[2024-02-03 17:15:30,556] INFO in event-simulator: USER2 is viewing page2
[2024-02-03 17:15:31,557] INFO in event-simulator: USER2 is viewing page3
[2024-02-03 17:15:32,559] INFO in event-simulator: USER2 logged in
[2024-02-03 17:15:33,560] INFO in event-simulator: USER1 logged in
[2024-02-03 17:15:34,561] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:34,562] INFO in event-simulator: USER3 logged out
[2024-02-03 17:15:35,563] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:36,563] INFO in event-simulator: USER3 logged out
[2024-02-03 17:15:37,564] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:37,565] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:15:38,566] INFO in event-simulator: USER4 is viewing page1
[2024-02-03 17:15:39,567] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:39,567] INFO in event-simulator: USER4 logged in
[2024-02-03 17:15:40,568] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:15:41,569] INFO in event-simulator: USER3 is viewing page3
[2024-02-03 17:15:42,571] INFO in event-simulator: USER3 is viewing page3
[2024-02-03 17:15:43,572] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:44,573] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:44,573] INFO in event-simulator: USER3 is viewing page3
[2024-02-03 17:15:45,575] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:45,575] INFO in event-simulator: USER2 logged out
[2024-02-03 17:15:46,576] INFO in event-simulator: USER4 logged out
[2024-02-03 17:15:47,577] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:48,578] INFO in event-simulator: USER4 logged out
[2024-02-03 17:15:49,579] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:49,579] INFO in event-simulator: USER1 logged in
[2024-02-03 17:15:50,579] INFO in event-simulator: USER3 logged in
[2024-02-03 17:15:51,581] INFO in event-simulator: USER4 is viewing page3
[2024-02-03 17:15:52,582] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:15:53,583] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:15:53,584] INFO in event-simulator: USER2 is viewing page1
[2024-02-03 17:15:54,585] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:54,585] INFO in event-simulator: USER1 is viewing page2
[2024-02-03 17:15:55,586] INFO in event-simulator: USER2 logged out
[2024-02-03 17:15:56,587] INFO in event-simulator: USER1 logged out
[2024-02-03 17:15:57,588] INFO in event-simulator: USER2 logged out
[2024-02-03 17:15:58,589] INFO in event-simulator: USER3 is viewing page3
[2024-02-03 17:15:59,590] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:15:59,590] INFO in event-simulator: USER2 logged in
[2024-02-03 17:16:00,592] INFO in event-simulator: USER2 is viewing page2
[2024-02-03 17:16:01,593] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:16:01,593] INFO in event-simulator: USER2 is viewing page3
[2024-02-03 17:16:02,594] INFO in event-simulator: USER2 is viewing page3
[2024-02-03 17:16:03,595] INFO in event-simulator: USER3 is viewing page2
[2024-02-03 17:16:04,596] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:16:04,597] INFO in event-simulator: USER1 is viewing page1
[2024-02-03 17:16:05,598] INFO in event-simulator: USER4 is viewing page2
[2024-02-03 17:16:06,599] INFO in event-simulator: USER1 logged out
[2024-02-03 17:16:07,600] INFO in event-simulator: USER3 is viewing page2
[2024-02-03 17:16:08,601] INFO in event-simulator: USER1 is viewing page1
[2024-02-03 17:16:09,603] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2024-02-03 17:16:09,603] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2024-02-03 17:16:09,603] INFO in event-simulator: USER3 is viewing page2
[2024-02-03 17:16:10,603] INFO in event-simulator: USER1 is viewing page3
[2024-02-03 17:16:11,604] INFO in event-simulator: USER2 logged in

controlplane ~ ➜  












If the POD was to get deleted now, would you be able to view these logs.


controlplane ~ ➜  kubectl get pv
No resources found

controlplane ~ ➜  kubectl get pvc
No resources found in default namespace.

controlplane ~ ➜  

- RESPOSTA
NO








Configure a volume to store these logs at /var/log/webapp on the host.

Use the spec provided below.

Name: webapp

Image Name: kodekloud/event-simulator

Volume HostPath: /var/log/webapp

Volume Mount: /log

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

- Exemplo:

apiVersion: v1
kind: PersistentVolume
metadata:
  name: task-pv-volume
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/mnt/data"


- Ajustado:

~~~~bash
apiVersion: v1
kind: PersistentVolume
metadata:
  name: webapp
  labels:
    type: local
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: "/var/log/webapp"
~~~~

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao8-Storage/191-pv.yaml

controlplane ~ ➜  kubectl apply -f pv.yaml
persistentvolume/webapp created

controlplane ~ ➜  



- Exemplo:

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: task-pv-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi

- Editado

~~~~bash
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: webapp
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 3Gi
~~~~

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao8-Storage/191-pvc.yaml

controlplane ~ ✖ vi pvc.yaml

controlplane ~ ➜  kubectl apply -f pvc.yaml
persistentvolumeclaim/webapp created

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE
webapp   10Gi       RWO            Retain           Bound    default/webapp   manual                  88s

controlplane ~ ➜  kubectl get pvc
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
webapp   Bound    webapp   10Gi       RWO            manual         40s

controlplane ~ ➜  


- Exemplo:

apiVersion: v1
kind: Pod
metadata:
  name: task-pv-pod
spec:
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

- Editado:

~~~~bash
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  volumes:
    - name: webapp
      persistentVolumeClaim:
        claimName: webapp
  containers:
    - name: webapp
      image: kodekloud/event-simulator
      volumeMounts:
        - mountPath: "/log"
          name: webapp
~~~~


controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl apply -f pod.yaml
Warning: resource pods/webapp is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
The Pod "webapp" is invalid: spec.containers: Forbidden: pod updates may not add or remove containers

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          12m

controlplane ~ ➜  date
Sat 03 Feb 2024 12:27:18 PM EST

controlplane ~ ➜  
controlplane ~ ➜  kubectl delete pod webapp
pod "webapp" deleted

controlplane ~ ➜  kubectl apply -f pod.yaml
pod/webapp created

controlplane ~ ➜  
controlplane ~ ➜  kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          11s

controlplane ~ ➜  
controlplane ~ ➜  kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   REASON   AGE
webapp   10Gi       RWO            Retain           Bound    default/webapp   manual                  5m35s

controlplane ~ ➜  kubectl get pvc
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
webapp   Bound    webapp   10Gi       RWO            manual         4m48s

controlplane ~ ➜  


Questão acusa que a parte "Volume HostPath: /var/log/webapp" não está ok.
Verificando.

- Ajustando o pod:
nova versão
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao8-Storage/191-pod-v2.yaml

~~~~bash
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  volumes:
    - name: log-volume
      hostPath:
        path: "/var/log/webapp"
  containers:
    - name: webapp
      image: kodekloud/event-simulator
      volumeMounts:
        - mountPath: "/log"
          name: webapp
~~~~


controlplane ~ ✖ kubectl delete -f pod.yaml 
pod "webapp" deleted


controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod.yaml 
The Pod "webapp" is invalid: spec.containers[0].volumeMounts[0].name: Not found: "webapp"

controlplane ~ ✖ 

- Ajustando

~~~~bash
apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  volumes:
    - name: log-volume
      hostPath:
        path: "/var/log/webapp"
  containers:
    - name: webapp
      image: kodekloud/event-simulator
      volumeMounts:
        - mountPath: "/log"
          name: log-volume
~~~~


controlplane ~ ➜  kubectl apply -f pod.yaml 
pod/webapp created

controlplane ~ ➜  kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          4s

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod webapp
Name:             webapp
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.27.216.6
Start Time:       Sat, 03 Feb 2024 12:41:41 -0500
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.0.6
IPs:
  IP:  10.244.0.6
Containers:
  webapp:
    Container ID:   containerd://d09b02c50e16e16c548b3e6c3675f729373e895e55712d44df38ad35eb5f80a5
    Image:          kodekloud/event-simulator
    Image ID:       docker.io/kodekloud/event-simulator@sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sat, 03 Feb 2024 12:41:43 -0500
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /log from log-volume (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-shjjv (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  log-volume:
    Type:          HostPath (bare host directory volume)
    Path:          /var/log/webapp
    HostPathType:  
  kube-api-access-shjjv:
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
  Normal  Scheduled  19s   default-scheduler  Successfully assigned default/webapp to controlplane
  Normal  Pulling    18s   kubelet            Pulling image "kodekloud/event-simulator"
  Normal  Pulled     18s   kubelet            Successfully pulled image "kodekloud/event-simulator" in 327.938553ms (327.953747ms including waiting)
  Normal  Created    17s   kubelet            Created container webapp
  Normal  Started    17s   kubelet            Started container webapp

controlplane ~ ➜  











Create a Persistent Volume with the given specification.

Volume Name: pv-log

Storage: 100Mi

Access Modes: ReadWriteMany

Host Path: /pv/log

Reclaim Policy: Retain

- Criando pv:

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao8-Storage/191-pv-questo5.yaml

~~~~bash
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-log
  labels:
    type: local
spec:
  storageClassName: manual
  persistentVolumeReclaimPolicy: Retain
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: "/pv/log"
~~~~

controlplane ~ ➜  vi pv-questao5.yaml

controlplane ~ ➜  kubectl apply -f pv-questao5.yaml
persistentvolume/pv-log created

controlplane ~ ➜  kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM            STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Available                    manual                  3s
webapp   10Gi       RWO            Retain           Bound       default/webapp   manual                  22m

controlplane ~ ➜  date
Sat 03 Feb 2024 12:45:10 PM EST

controlplane ~ ➜  








Let us claim some of that storage for our application. Create a Persistent Volume Claim with the given specification.

Volume Name: claim-log-1

Storage Request: 50Mi

Access Modes: ReadWriteOnce

- Criando pvc:

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao8-Storage/191-pvc-questao6.yaml

~~~~bash
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: claim-log-1
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 50Mi
~~~~
controlplane ~ ➜  vi pvc-questao6.yaml

controlplane ~ ➜  kubectl apply -f pvc-questao6.yaml
persistentvolumeclaim/claim-log-1 created

controlplane ~ ➜  






What is the state of the Persistent Volume Claim?
controlplane ~ ➜  kubectl get pvc
NAME          STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
claim-log-1   Pending                                      manual         8m1s
webapp        Bound     webapp   10Gi       RWO            manual         31m

controlplane ~ ➜  




What is the state of the Persistent Volume?

controlplane ~ ✖ kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM            STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Available                    manual                  10m
webapp   10Gi       RWO            Retain           Bound       default/webapp   manual                  32m

controlplane ~ ➜  









Why is the claim not bound to the available Persistent Volume?

Access mode mismatch








Update the Access Mode on the claim to bind it to the PV.

Delete and recreate the claim-log-1.

Volume Name: claim-log-1

Storage Request: 50Mi

PVol: pv-log

Status: Bound


controlplane ~ ➜  vi pvc-questao10.yaml 

controlplane ~ ➜  kubectl apply -f pvc-questao10.yaml 
The PersistentVolumeClaim "claim-log-1" is invalid: spec: Forbidden: spec is immutable after creation except resources.requests for bound claims
  core.PersistentVolumeClaimSpec{
-       AccessModes: []core.PersistentVolumeAccessMode{"ReadWriteOnce"},
+       AccessModes: []core.PersistentVolumeAccessMode{"ReadWriteMany"},
        Selector:    nil,
        Resources:   {Requests: {s"storage": {i: {...}, s: "50Mi", Format: "BinarySI"}}},
        ... // 5 identical fields
  }


controlplane ~ ✖ kubectl delete -f pvc-questao10.yaml 
persistentvolumeclaim "claim-log-1" deleted

controlplane ~ ➜  kubectl apply -f pvc-questao10.yaml 
persistentvolumeclaim/claim-log-1 created

controlplane ~ ➜  kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Bound    default/claim-log-1   manual                  13m
webapp   10Gi       RWO            Retain           Bound    default/webapp        manual                  35m

controlplane ~ ➜  kubectl get pvc
NAME          STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
claim-log-1   Bound    pv-log   100Mi      RWX            manual         5s
webapp        Bound    webapp   10Gi       RWO            manual         34m

controlplane ~ ➜  date
Sat 03 Feb 2024 12:58:19 PM EST

controlplane ~ ➜  







You requested for 50Mi, how much capacity is now available to the PVC?


controlplane ~ ➜  kubectl describe pv pv-log
Name:            pv-log
Labels:          type=local
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    manual
Status:          Bound
Claim:           default/claim-log-1
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        100Mi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /pv/log
    HostPathType:  
Events:            <none>

controlplane ~ ➜  kubectl describe pvc claim-log-1
Name:          claim-log-1
Namespace:     default
StorageClass:  manual
Status:        Bound
Volume:        pv-log
Labels:        <none>
Annotations:   pv.kubernetes.io/bind-completed: yes
               pv.kubernetes.io/bound-by-controller: yes
Finalizers:    [kubernetes.io/pvc-protection]
Capacity:      100Mi
Access Modes:  RWX
VolumeMode:    Filesystem
Used By:       <none>
Events:        <none>

controlplane ~ ➜  date
Sat 03 Feb 2024 12:59:30 PM EST

controlplane ~ ➜  












Update the webapp pod to use the persistent volume claim as its storage.

Replace hostPath configured earlier with the newly created PersistentVolumeClaim.

Name: webapp

Image Name: kodekloud/event-simulator

Volume: PersistentVolumeClaim=claim-log-1

Volume Mount: /log


apiVersion: v1
kind: Pod
metadata:
  name: webapp
spec:
  volumes:
    - name: log-volume
      persistentVolumeClaim:
        claimName: claim-log-1
  containers:
    - name: webapp
      image: kodekloud/event-simulator
      volumeMounts:
        - mountPath: "/log"
          name: log-volume


controlplane ~ ➜  vi pod-v3.yaml

controlplane ~ ➜  kubectl delete -f pod-v3.yaml
pod "webapp" deleted


controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod-v3.yaml
pod/webapp created

controlplane ~ ➜  kubectl get pods
NAME     READY   STATUS    RESTARTS   AGE
webapp   1/1     Running   0          3s

controlplane ~ ➜  kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM                 STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Bound    default/claim-log-1   manual                  17m
webapp   10Gi       RWO            Retain           Bound    default/webapp        manual                  39m

controlplane ~ ➜  kubectl get pvc
NAME          STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
claim-log-1   Bound    pv-log   100Mi      RWX            manual         3m57s
webapp        Bound    webapp   10Gi       RWO            manual         38m

controlplane ~ ➜  date
Sat 03 Feb 2024 01:02:10 PM EST

controlplane ~ ➜  










What is the Reclaim Policy set on the Persistent Volume pv-log?


controlplane ~ ➜  kubectl describe pv pv-log
Name:            pv-log
Labels:          type=local
Annotations:     pv.kubernetes.io/bound-by-controller: yes
Finalizers:      [kubernetes.io/pv-protection]
StorageClass:    manual
Status:          Bound
Claim:           default/claim-log-1
Reclaim Policy:  Retain
Access Modes:    RWX
VolumeMode:      Filesystem
Capacity:        100Mi
Node Affinity:   <none>
Message:         
Source:
    Type:          HostPath (bare host directory volume)
    Path:          /pv/log
    HostPathType:  
Events:            <none>

controlplane ~ ➜  








What would happen to the PV if the PVC was destroyed?

- RESPOSTA
NOT DELETED, BUT NOT AVAILABLE.









Try deleting the PVC and notice what happens.

If the command hangs, you can use CTRL + C to get back to the bash prompt OR check the status of the pvc from another terminal

controlplane ~ ➜  kubectl delete pvc claim-log-1
persistentvolumeclaim "claim-log-1" deleted



- RESPOSTA
STUCK ON TERMINATE







Why is the PVC stuck in Terminating state?

- RESPOSTA
USING BY A POD








Let us now delete the webapp Pod.

Once deleted, wait for the pod to fully terminate.

Name: webapp

controlplane ~ ✖ kubectl delete pod webapp
pod "webapp" deleted



controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  







What is the state of the PVC now?
controlplane ~ ➜  kubectl get pvc
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
webapp   Bound    webapp   10Gi       RWO            manual         44m

controlplane ~ ➜  date
Sat 03 Feb 2024 01:08:39 PM EST

controlplane ~ ➜  

-resposta
deleted





What is the state of the Persistent Volume now?


controlplane ~ ➜  kubectl get pv
NAME     CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS     CLAIM                 STORAGECLASS   REASON   AGE
pv-log   100Mi      RWX            Retain           Released   default/claim-log-1   manual                  24m
webapp   10Gi       RWO            Retain           Bound      default/webapp        manual                  46m

controlplane ~ ➜  date
Sat 03 Feb 2024 01:09:06 PM EST

controlplane ~ ➜  




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
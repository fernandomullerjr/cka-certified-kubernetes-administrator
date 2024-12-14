#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "271. Mock Exam - 2."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
## 271. Mock Exam - 2


### 1 / 8
Weight: 10

Take a backup of the etcd cluster and save it to /opt/etcd-backup.db.

Backup Completed


ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save snapshot.db

ETCDCTL_API=3 etcdctl --endpoints $ENDPOINT snapshot save /opt/etcd-backup.db


controlplane ~ ✖ ETCDCTL_API=3 etcdctl snapshot save /opt/etcd-backup.db
Error: rpc error: code = Unavailable desc = transport is closing

controlplane ~ ✖ 


ETCDCTL_API=3 etcdctl --endpoints=https://127.0.0.1:2379 \
  snapshot save /opt/etcd-backup.db


ETCDCTL_API=3 etcdctl snapshot save mysnapshot.db --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key

ETCDCTL_API=3 etcdctl snapshot save /opt/etcd-backup.db --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key





### 2 / 8
Weight: 10

Create a Pod called redis-storage with image: redis:alpine with a Volume of type emptyDir that lasts for the life of the Pod.

Specs on the below.

Pod named 'redis-storage' created

Pod 'redis-storage' uses Volume type of emptyDir

Pod 'redis-storage' uses volumeMount with mountPath = /data/redis



https://kubernetes.io/docs/concepts/storage/volumes/

emptyDir configuration example

apiVersion: v1
kind: Pod
metadata:
  name: test-pd
spec:
  containers:
  - image: registry.k8s.io/test-webserver
    name: test-container
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir:
      sizeLimit: 500Mi


- Ajustado

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis-storage
spec:
  containers:
  - image: redis:alpine
    name: redis-storage
    volumeMounts:
    - mountPath: /data/redis
      name: redis-storage-volume
  volumes:
  - name: redis-storage-volume
    emptyDir:
      sizeLimit: 500Mi

~~~~



controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl apply -f  pod.yaml
pod/redis-storage created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
NAME            READY   STATUS              RESTARTS   AGE
redis-storage   0/1     ContainerCreating   0          4s





### 3 / 8
Weight: 8

Create a new pod called super-user-pod with image busybox:1.28. Allow the pod to be able to set system_time.

The container should sleep for 4800 seconds.

Pod: super-user-pod

Container Image: busybox:1.28

Is SYS_TIME capability set for the container?


https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

Set the security context for a Pod

To specify security settings for a Pod, include the securityContext field in the Pod specification. The securityContext field is a PodSecurityContext object. The security settings that you specify for a Pod apply to all Containers in the Pod. Here is a configuration file for a Pod that has a securityContext and an emptyDir volume:
pods/security/security-context.yaml [Copy pods/security/security-context.yaml to clipboard]

apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    supplementalGroups: [4000]
  volumes:
  - name: sec-ctx-vol
    emptyDir: {}
  containers:
  - name: sec-ctx-demo
    image: busybox:1.28
    command: [ "sh", "-c", "sleep 1h" ]
    volumeMounts:
    - name: sec-ctx-vol
      mountPath: /data/demo
    securityContext:
      allowPrivilegeEscalation: false


https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

Here is the configuration file for a Pod that runs one Container. The configuration adds the CAP_NET_ADMIN and CAP_SYS_TIME capabilities:
pods/security/security-context-4.yaml [Copy pods/security/security-context-4.yaml to clipboard]

apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/hello-app:2.0
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]

- Ajustado:

~~~~yaml

apiVersion: v1
kind: Pod
metadata:
  name: super-user-pod
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 3000
    fsGroup: 2000
    supplementalGroups: [4000]
  volumes:
  - name: super-user-pod-ctx-vol
    emptyDir: {}
  containers:
  - name: super-user-pod
    image: busybox:1.28
    command: [ "sh", "-c", "sleep 4800" ]
    volumeMounts:
    - name: super-user-pod-ctx-vol
      mountPath: /data/demo
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]

~~~~


controlplane ~ ➜  vi pod-security.yaml

controlplane ~ ➜  kubectl apply -f pod-security.yaml
pod/super-user-pod created

controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
redis-storage    1/1     Running   0          4m15s
super-user-pod   1/1     Running   0          3s

controlplane ~ ➜  
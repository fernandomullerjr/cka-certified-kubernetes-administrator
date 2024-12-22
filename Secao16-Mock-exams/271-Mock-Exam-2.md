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

- OK
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






### 4 / 8
Weight: 12

A pod definition file is created at /root/CKA/use-pv.yaml. Make use of this manifest file and mount the persistent volume called pv-1. Ensure the pod is running and the PV is bound.

mountPath: /data

persistentVolumeClaim Name: my-pvc

persistentVolume Claim configured correctly

pod using the correct mountPath

pod using the persistent volume claim?


controlplane ~ ➜  

controlplane ~ ➜  kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-1   10Mi       RWO            Retain           Available                          <unset>                          22s

controlplane ~ ➜  kubectl get pvc
No resources found in default namespace.

controlplane ~ ➜  date
Sat Dec 14 04:12:57 PM UTC 2024

controlplane ~ ➜  kubectl get pvc -A
No resources found

controlplane ~ ➜  


controlplane ~ ➜  cat /root/CKA/use-pv.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: use-pv
  name: use-pv
spec:
  containers:
  - image: nginx
    name: use-pv
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  


https://kubernetes.io/docs/concepts/storage/persistent-volumes/#provisioning

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: foo-pvc
  namespace: foo
spec:
  storageClassName: "" # Empty string must be explicitly set otherwise default StorageClass will be set
  volumeName: foo-pv

Claims As Volumes

Pods access storage by using the claim as a volume. Claims must exist in the same namespace as the Pod using the claim. The cluster finds the claim in the Pod's namespace and uses it to get the PersistentVolume backing the claim. The volume is then mounted to the host and into the Pod.

apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: myfrontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: mypd
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: myclaim


- Criando o pvc

~~~~yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  storageClassName: "" # Empty string must be explicitly set otherwise default StorageClass will be set
  volumeName: pv-1
~~~~

- ERRO:

controlplane ~ ➜  vi pvc.yaml

controlplane ~ ➜  kubectl apply -f pvc.yaml
The PersistentVolumeClaim "my-pvc" is invalid: 
* spec.accessModes: Required value: at least 1 access mode is required
* spec.resources[storage]: Required value

controlplane ~ ✖ 


- Pegando exemplo mais completo

PersistentVolumeClaims

Each PVC contains a spec and status, which is the specification and status of the claim. The name of a PersistentVolumeClaim object must be a valid DNS subdomain name.

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 8Gi
  storageClassName: slow
  selector:
    matchLabels:
      release: "stable"
    matchExpressions:
      - {key: environment, operator: In, values: [dev]}

- Ajustado:

~~~~yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Mi
  storageClassName: "" # Empty string must be explicitly set otherwise default StorageClass will be set
  volumeName: pv-1
~~~~


controlplane ~ ➜  kubectl apply -f pvc.yaml
persistentvolumeclaim/my-pvc created

controlplane ~ ➜  kubectl get pvc -A
NAMESPACE   NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
default     my-pvc   Bound    pv-1     10Mi       RWO                           <unset>                 5s

controlplane ~ ➜  date
Sat Dec 14 04:26:37 PM UTC 2024

controlplane ~ ➜  

- Criando Pod com PVC:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: use-pv
  name: use-pv
spec:
  containers:
    - name: use-pv
      image: nginx
      volumeMounts:
      - mountPath: "/data"
        name: mypd
  dnsPolicy: ClusterFirst
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: my-pvc
~~~~



controlplane ~ ➜  kubectl get pv
NAME   CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS   CLAIM            STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
pv-1   10Mi       RWO            Retain           Bound    default/my-pvc                  <unset>                          58s

controlplane ~ ➜  kubectl get pvc
NAME     STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
my-pvc   Bound    pv-1     10Mi       RWO                           <unset>                 39s

controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
redis-storage    1/1     Running   0          99s
super-user-pod   1/1     Running   0          68s
use-pv           1/1     Running   0          11s

controlplane ~ ➜  date
Sat Dec 14 04:41:29 PM UTC 2024

controlplane ~ ➜  






### 5 / 8
Weight: 15

Create a new deployment called nginx-deploy, with image nginx:1.16 and 1 replica. Next upgrade the deployment to version 1.17 using rolling update.

Deployment : nginx-deploy. Image: nginx:1.16

Image: nginx:1.16

Task: Upgrade the version of the deployment to 1:17

Task: Record the changes for the image upgrade


https://kubernetes.io/docs/concepts/workloads/controllers/deployment/

Creating a Deployment

The following is an example of a Deployment. It creates a ReplicaSet to bring up three nginx Pods:
controllers/nginx-deployment.yaml [Copy controllers/nginx-deployment.yaml to clipboard]

apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.14.2
        ports:
        - containerPort: 80


- Ajustado:

~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.16
        ports:
        - containerPort: 80
~~~~


controlplane ~ ➜  vi deployment.yaml

controlplane ~ ➜  kubectl apply -f  deployment.yaml
deployment.apps/nginx-deploy created

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   0/1     1            0           5s

controlplane ~ ➜  date
Sat Dec 14 04:44:39 PM UTC 2024

controlplane ~ ➜  


https://kubernetes.io/docs/tutorials/kubernetes-basics/update/update-intro/


kubectl set image deployments/nginx-deploy nginx:1.17


controlplane ~ ➜  kubectl set image deployments/nginx-deploy nginx:1.17
error: there is no need to specify a resource type as a separate argument when passing arguments in resource/name form (e.g. 'kubectl get resource/<resource_name>' instead of 'kubectl get resource resource/<resource_name>'

controlplane ~ ✖ kubectl set image nginx-deploy nginx:1.17
error: the server doesn't have a resource type "nginx-deploy"

controlplane ~ ✖ kubectl set image deployment/nginx-deploy nginx:1.17
error: there is no need to specify a resource type as a separate argument when passing arguments in resource/name form (e.g. 'kubectl get resource/<resource_name>' instead of 'kubectl get resource resource/<resource_name>'


controlplane ~ ➜  kubectl set image deployments/nginx-deploy nginx:1.17
error: there is no need to specify a resource type as a separate argument when passing arguments in resource/name form (e.g. 'kubectl get resource/<resource_name>' instead of 'kubectl get resource resource/<resource_name>'

controlplane ~ ✖ kubectl set image nginx-deploy nginx:1.17
error: the server doesn't have a resource type "nginx-deploy"

controlplane ~ ✖ kubectl set image deployment/nginx-deploy nginx:1.17
error: there is no need to specify a resource type as a separate argument when passing arguments in resource/name form (e.g. 'kubectl get resource/<resource_name>' instead of 'kubectl get resource resource/<resource_name>'

Examples:
  # Set a deployment's nginx container image to 'nginx:1.9.1', and its busybox container image to 'busybox'
  kubectl set image deployment/nginx busybox=busybox nginx=nginx:1.9.1
  
  # Update all deployments' and rc's nginx container's image to 'nginx:1.9.1'
  kubectl set image deployments,rc nginx=nginx:1.9.1 --all
  
  # Update image of all containers of daemonset abc to 'nginx:1.9.1'
  kubectl set image daemonset abc *=nginx:1.9.1
  
  # Print result (in yaml format) of updating nginx container image from local file, without hitting the server
  kubectl set image -f path/to/file.yaml nginx=nginx:1.9.1 --local -o yaml



kubectl set image deployment/nginx-deploy nginx=nginx:1.17


controlplane ~ ✖ kubectl set image deployment/nginx-deploy nginx=nginx:1.17
deployment.apps/nginx-deploy image updated

controlplane ~ ➜  date
Sat Dec 14 04:48:56 PM UTC 2024

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/1     1            1           4m27s

controlplane ~ ➜  date
Sat Dec 14 04:49:02 PM UTC 2024

controlplane ~ ➜  




### 6 / 8
Weight: 15

Create a new user called john. Grant him access to the cluster. John should have permission to create, list, get, update and delete pods in the development namespace . The private key exists in the location: /root/CKA/john.key and csr at /root/CKA/john.csr.

Important Note: As of kubernetes 1.19, the CertificateSigningRequest object expects a signerName.

Please refer the documentation to see an example. The documentation tab is available at the top right of terminal.

CSR: john-developer Status:Approved

Role Name: developer, namespace: development, Resource: Pods

Access: User 'john' has appropriate permissions


https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#create-certificatesigningrequest
Certificate signing authorization

To allow creating a CertificateSigningRequest and retrieving any CertificateSigningRequest:

    Verbs: create, get, list, watch, group: certificates.k8s.io, resource: certificatesigningrequests

For example:
access/certificate-signing-request/clusterrole-create.yaml [Copy access/certificate-signing-request/clusterrole-create.yaml to clipboard]

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: csr-creator
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - create
  - get
  - list
  - watch

To allow approving a CertificateSigningRequest:

    Verbs: get, list, watch, group: certificates.k8s.io, resource: certificatesigningrequests
    Verbs: update, group: certificates.k8s.io, resource: certificatesigningrequests/approval
    Verbs: approve, group: certificates.k8s.io, resource: signers, resourceName: <signerNameDomain>/<signerNamePath> or <signerNameDomain>/*

For example:
access/certificate-signing-request/clusterrole-approve.yaml [Copy access/certificate-signing-request/clusterrole-approve.yaml to clipboard]

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: csr-approver
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests/approval
  verbs:
  - update
- apiGroups:
  - certificates.k8s.io
  resources:
  - signers
  resourceNames:
  - example.com/my-signer-name # example.com/* can be used to authorize for all signers in the 'example.com' domain
  verbs:
  - approve

To allow signing a CertificateSigningRequest:

    Verbs: get, list, watch, group: certificates.k8s.io, resource: certificatesigningrequests
    Verbs: update, group: certificates.k8s.io, resource: certificatesigningrequests/status
    Verbs: sign, group: certificates.k8s.io, resource: signers, resourceName: <signerNameDomain>/<signerNamePath> or <signerNameDomain>/*

access/certificate-signing-request/clusterrole-sign.yaml [Copy access/certificate-signing-request/clusterrole-sign.yaml to clipboard]

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: csr-signer
rules:
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests
  verbs:
  - get
  - list
  - watch
- apiGroups:
  - certificates.k8s.io
  resources:
  - certificatesigningrequests/status
  verbs:
  - update
- apiGroups:
  - certificates.k8s.io
  resources:
  - signers
  resourceNames:
  - example.com/my-signer-name # example.com/* can be used to authorize for all signers in the 'example.com' domain
  verbs:
  - sign

Signers



Create a CertificateSigningRequest

Create a CertificateSigningRequest and submit it to a Kubernetes Cluster via kubectl. Below is a script to generate the CertificateSigningRequest.

cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: myuser
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZVzVuWld4aE1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQTByczhJTHRHdTYxakx2dHhWTTJSVlRWMDNHWlJTWWw0dWluVWo4RElaWjBOCnR2MUZtRVFSd3VoaUZsOFEzcWl0Qm0wMUFSMkNJVXBGd2ZzSjZ4MXF3ckJzVkhZbGlBNVhwRVpZM3ExcGswSDQKM3Z3aGJlK1o2MVNrVHF5SVBYUUwrTWM5T1Nsbm0xb0R2N0NtSkZNMUlMRVI3QTVGZnZKOEdFRjJ6dHBoaUlFMwpub1dtdHNZb3JuT2wzc2lHQ2ZGZzR4Zmd4eW8ybmlneFNVekl1bXNnVm9PM2ttT0x1RVF6cXpkakJ3TFJXbWlECklmMXBMWnoyalVnald4UkhCM1gyWnVVV1d1T09PZnpXM01LaE8ybHEvZi9DdS8wYk83c0x0MCt3U2ZMSU91TFcKcW90blZtRmxMMytqTy82WDNDKzBERHk5aUtwbXJjVDBnWGZLemE1dHJRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBR05WdmVIOGR4ZzNvK21VeVRkbmFjVmQ1N24zSkExdnZEU1JWREkyQTZ1eXN3ZFp1L1BVCkkwZXpZWFV0RVNnSk1IRmQycVVNMjNuNVJsSXJ3R0xuUXFISUh5VStWWHhsdnZsRnpNOVpEWllSTmU3QlJvYXgKQVlEdUI5STZXT3FYbkFvczFqRmxNUG5NbFpqdU5kSGxpT1BjTU1oNndLaTZzZFhpVStHYTJ2RUVLY01jSVUyRgpvU2djUWdMYTk0aEpacGk3ZnNMdm1OQUxoT045UHdNMGM1dVJVejV4T0dGMUtCbWRSeEgvbUNOS2JKYjFRQm1HCkkwYitEUEdaTktXTU0xMzhIQXdoV0tkNjVoVHdYOWl4V3ZHMkh4TG1WQzg0L1BHT0tWQW9FNkpsYWFHdTlQVmkKdjlOSjVaZlZrcXdCd0hKbzZXdk9xVlA3SVFjZmg3d0drWm89Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
EOF

Some points to note:

    usages has to be 'client auth'

    expirationSeconds could be made longer (i.e. 864000 for ten days) or shorter (i.e. 3600 for one hour)

    request is the base64 encoded value of the CSR file content. You can get the content using this command:

    cat myuser.csr | base64 | tr -d "\n"

Approve the CertificateSigningRequest

Use kubectl to create a CSR and approve it.

Get the list of CSRs:

kubectl get csr

Approve the CSR:

kubectl certificate approve myuser

Get the certificate

Retrieve the certificate from the CSR:

kubectl get csr/myuser -o yaml

The certificate value is in Base64-encoded format under status.certificate.

Export the issued certificate from the CertificateSigningRequest.

kubectl get csr myuser -o jsonpath='{.status.certificate}'| base64 -d > myuser.crt

Create Role and RoleBinding

With the certificate created it is time to define the Role and RoleBinding for this user to access Kubernetes cluster resources.

This is a sample command to create a Role for this new user:

kubectl create role developer --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods

This is a sample command to create a RoleBinding for this new user:

kubectl create rolebinding developer-binding-myuser --role=developer --user=myuser




cat /root/CKA/john.csr | base64 | tr -d "\n"


controlplane ~ ➜  date
Sat Dec 14 04:49:02 PM UTC 2024

controlplane ~ ➜  vi 271-clusterrole-create

controlplane ~ ➜  mv 271-clusterrole-create 271-clusterrole-create.yaml

controlplane ~ ➜  vi 271-clusterrole-approve.yaml

controlplane ~ ➜  vi 271-clusterrole-sign.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cat /root/CKA/john.csr | base64 | tr -d "\n"
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQU10MnJqWlhsYm80bmhTdUd3QnZvWmxxN21tc1A5Vm9vSjRFVTZIVDFReENKU293CnBXN0M4cUxnOE1oS3dQMkM5bG1UdzNldHhHek14b3FTU2pxNlpkRjZLNUxmM2tWRjJyc1hXbG8weVZDNVUwSlkKY2ErSHZmU1hPVVVzUjIrTWZHNkoybkwwelp3NDBPdjljSVRqQjN4aHNsQjlzbXFFcDBlZkxlb0RpclhIUmkwRQplenA4V2IzQ0lrdkEwWXBjcFhDVnJlcCtwVlkyZHBtbWU3S3B6bFlPTjZzSlQ2c3BoNXRMWWNWQ0h4ZWxOWU9aCmVldlU0MjliQVRRL21MZzBxMzcrNG1GWTZHbzBxWU51ZEdqTDlaNHIrY3BDZC9LZmpHbEV0KzRBMGIyUWlXQ2cKR2hpN2k5Qnd6MWZTSk9QL1lRWlpBdGNWNzRFUEZSbmxtVndxdUFFQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQ0NKT3pHSitLMmxIUXNVNnlzbnRLOWZ1RG1OMHFqR3d5SXBXWDI1cEpvNUxXWm5KSFdSa0xyClJJOG53Q1hrM3NsM1Q0S1Y1TTNWRDIrVlYxR3ZBWTFnUi9kdFM4VUFJbmI4bkt0RFBRU0Y2cEZJU0xodWxaSHQKWDVuajNqMGFDY210M3AvSU9EZVVZNmErYXVYbUZWUWt5YzJaaEloR0txZTFIVUZFWjhWT1A5QnBWK09Bc3NNbQpnOEgxWkhnYWFnaW5jN3lsRUhGQUlQejJYVEYydGEzc3cwWHhlNjQ2VkY5bkR0dFdoNDhjY0JpY3lubVJGSkNJCmFKdnFBUHQ0a0xyM3Jkd29ydThXWjVoakxGVWJqUmtocUVkNTIwQjJMamV0NWhyRVJpSDA0cWpHbzlYU2JVZFEKdjlsWUFVeGcvTUdHTEtSRVMrSnpGSG5VS0RqaDZzbGEKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
controlplane ~ ➜  


- CSR ajustado

~~~~yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQU10MnJqWlhsYm80bmhTdUd3QnZvWmxxN21tc1A5Vm9vSjRFVTZIVDFReENKU293CnBXN0M4cUxnOE1oS3dQMkM5bG1UdzNldHhHek14b3FTU2pxNlpkRjZLNUxmM2tWRjJyc1hXbG8weVZDNVUwSlkKY2ErSHZmU1hPVVVzUjIrTWZHNkoybkwwelp3NDBPdjljSVRqQjN4aHNsQjlzbXFFcDBlZkxlb0RpclhIUmkwRQplenA4V2IzQ0lrdkEwWXBjcFhDVnJlcCtwVlkyZHBtbWU3S3B6bFlPTjZzSlQ2c3BoNXRMWWNWQ0h4ZWxOWU9aCmVldlU0MjliQVRRL21MZzBxMzcrNG1GWTZHbzBxWU51ZEdqTDlaNHIrY3BDZC9LZmpHbEV0KzRBMGIyUWlXQ2cKR2hpN2k5Qnd6MWZTSk9QL1lRWlpBdGNWNzRFUEZSbmxtVndxdUFFQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQ0NKT3pHSitLMmxIUXNVNnlzbnRLOWZ1RG1OMHFqR3d5SXBXWDI1cEpvNUxXWm5KSFdSa0xyClJJOG53Q1hrM3NsM1Q0S1Y1TTNWRDIrVlYxR3ZBWTFnUi9kdFM4VUFJbmI4bkt0RFBRU0Y2cEZJU0xodWxaSHQKWDVuajNqMGFDY210M3AvSU9EZVVZNmErYXVYbUZWUWt5YzJaaEloR0txZTFIVUZFWjhWT1A5QnBWK09Bc3NNbQpnOEgxWkhnYWFnaW5jN3lsRUhGQUlQejJYVEYydGEzc3cwWHhlNjQ2VkY5bkR0dFdoNDhjY0JpY3lubVJGSkNJCmFKdnFBUHQ0a0xyM3Jkd29ydThXWjVoakxGVWJqUmtocUVkNTIwQjJMamV0NWhyRVJpSDA0cWpHbzlYU2JVZFEKdjlsWUFVeGcvTUdHTEtSRVMrSnpGSG5VS0RqaDZzbGEKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
  signerName: example.com/john-developer
  expirationSeconds: 86400  # one day
  usages:
  - client auth
~~~~



controlplane ~ ➜  cat /root/CKA/john.csr | base64 | tr -d "\n"
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQU10MnJqWlhsYm80bmhTdUd3QnZvWmxxN21tc1A5Vm9vSjRFVTZIVDFReENKU293CnBXN0M4cUxnOE1oS3dQMkM5bG1UdzNldHhHek14b3FTU2pxNlpkRjZLNUxmM2tWRjJyc1hXbG8weVZDNVUwSlkKY2ErSHZmU1hPVVVzUjIrTWZHNkoybkwwelp3NDBPdjljSVRqQjN4aHNsQjlzbXFFcDBlZkxlb0RpclhIUmkwRQplenA4V2IzQ0lrdkEwWXBjcFhDVnJlcCtwVlkyZHBtbWU3S3B6bFlPTjZzSlQ2c3BoNXRMWWNWQ0h4ZWxOWU9aCmVldlU0MjliQVRRL21MZzBxMzcrNG1GWTZHbzBxWU51ZEdqTDlaNHIrY3BDZC9LZmpHbEV0KzRBMGIyUWlXQ2cKR2hpN2k5Qnd6MWZTSk9QL1lRWlpBdGNWNzRFUEZSbmxtVndxdUFFQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQ0NKT3pHSitLMmxIUXNVNnlzbnRLOWZ1RG1OMHFqR3d5SXBXWDI1cEpvNUxXWm5KSFdSa0xyClJJOG53Q1hrM3NsM1Q0S1Y1TTNWRDIrVlYxR3ZBWTFnUi9kdFM4VUFJbmI4bkt0RFBRU0Y2cEZJU0xodWxaSHQKWDVuajNqMGFDY210M3AvSU9EZVVZNmErYXVYbUZWUWt5YzJaaEloR0txZTFIVUZFWjhWT1A5QnBWK09Bc3NNbQpnOEgxWkhnYWFnaW5jN3lsRUhGQUlQejJYVEYydGEzc3cwWHhlNjQ2VkY5bkR0dFdoNDhjY0JpY3lubVJGSkNJCmFKdnFBUHQ0a0xyM3Jkd29ydThXWjVoakxGVWJqUmtocUVkNTIwQjJMamV0NWhyRVJpSDA0cWpHbzlYU2JVZFEKdjlsWUFVeGcvTUdHTEtSRVMrSnpGSG5VS0RqaDZzbGEKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
controlplane ~ ➜  vi 271-csr.yaml

controlplane ~ ➜  kubectl get csr
NAME        AGE   SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
csr-wv7gb   31m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued
csr-xmcm5   30m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:c0b5zg    <none>              Approved,Issued

controlplane ~ ➜  kubectl get csr -A
NAME        AGE   SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
csr-wv7gb   31m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued
csr-xmcm5   30m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:c0b5zg    <none>              Approved,Issued

controlplane ~ ➜  


controlplane ~ ➜  kubectl apply 271-clusterrole-create.yaml 
error: Unexpected args: [271-clusterrole-create.yaml]
See 'kubectl apply -h' for help and examples

controlplane ~ ✖ kubectl apply -f 271-clusterrole-create.yaml 
clusterrole.rbac.authorization.k8s.io/john-developer created

controlplane ~ ➜  kubectl apply -f 271-clusterrole-approve.yaml 
clusterrole.rbac.authorization.k8s.io/csr-approver created

controlplane ~ ➜  kubectl apply -f 271-clusterrole-sign.yaml 
clusterrole.rbac.authorization.k8s.io/csr-signer created

controlplane ~ ➜  kubectl apply -f 271-csr.yaml 
certificatesigningrequest.certificates.k8s.io/john created

controlplane ~ ➜  date
Sat Dec 14 05:05:09 PM UTC 2024

controlplane ~ ➜  kubectl get csr
NAME        AGE   SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
csr-wv7gb   32m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued
csr-xmcm5   31m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:c0b5zg    <none>              Approved,Issued
john        4s    example.com/john-developer                    kubernetes-admin           24h                 Pending

controlplane ~ ➜  date
Sat Dec 14 05:05:19 PM UTC 2024

controlplane ~ ➜  



Approve the CSR:

kubectl certificate approve john


controlplane ~ ➜  kubectl certificate approve john
certificatesigningrequest.certificates.k8s.io/john approved

controlplane ~ ➜  kubectl get csr
NAME        AGE   SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
csr-wv7gb   32m   kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued
csr-xmcm5   32m   kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:c0b5zg    <none>              Approved,Issued
john        33s   example.com/john-developer                    kubernetes-admin           24h                 Approved

controlplane ~ ➜  



Create Role and RoleBinding

With the certificate created it is time to define the Role and RoleBinding for this user to access Kubernetes cluster resources.

This is a sample command to create a Role for this new user:

kubectl create role developer -n development --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods

This is a sample command to create a RoleBinding for this new user:

kubectl create rolebinding developer-binding-john -n development --role=developer --user=john



controlplane ~ ➜  kubectl create role developer -n development --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
role.rbac.authorization.k8s.io/developer created

controlplane ~ ➜  kubectl create rolebinding developer-binding-john -n development --role=developer --user=john
rolebinding.rbac.authorization.k8s.io/developer-binding-john created

controlplane ~ ➜  kubectl get role
No resources found in default namespace.

controlplane ~ ➜  kubectl get role -n development

NAME        CREATED AT
developer   2024-12-14T17:06:52Z

controlplane ~ ➜  kubectl get rolebind -n development
error: the server doesn't have a resource type "rolebind"

controlplane ~ ✖ kubectl get rolebinding -n development
NAME                     ROLE             AGE
developer-binding-john   Role/developer   17s

controlplane ~ ➜  date
Sat Dec 14 05:07:41 PM UTC 2024

controlplane ~ ➜  



- Nova tentativa

cat /root/CKA/john.csr | base64 | tr -d "\n"
kubectl apply -f 271-csr.yaml
kubectl certificate approve john-developer
kubectl get csr john-developer -o jsonpath='{.status.certificate}' | base64 -d > /root/CKA/john.crt
kubectl apply -f 271-role-developer.yaml
kubectl apply -f 271-rolebinding-john.yaml
kubectl apply -f 271-clusterrole-create.yaml 
kubectl apply -f 271-clusterrole-approve.yaml 
kubectl apply -f 271-clusterrole-sign.yaml
kubectl get csr
kubectl certificate approve john
kubectl get csr

controlplane ~ ➜  cat /root/CKA/john.csr | base64 | tr -d "\n"
LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQU1CMEc0ZEJYZUdpRUgyaXVvWmp2VEtwaGZaaHVLSzJFaS9SU2RZWWlYTldwQTRNCjV1OG81T3BrYnIrWlBwWVUvd3FDMkJZalVMUGdCYzVGTTFqcElvYmdXd1IydGtlWXFCL2tGQlRGb0RQODQ0RWIKNUlJdk1nVmt4MjY1SGtub2RyRGpyZVZVZVZVdnoyMDlvRHN2akpTUzBROXBvMzlldHY3Qm1UUlFnK0dZYzlqbApJaU9sSm9wbHlHWE5FN3ZReHdEZnVqTzdhTXY3ZUhreWpRcEdOU1NaMXJqaHNDbmIyRTBBZjFwVW5lK1E1cEYvCkJ6dnJlNjlPWnBpaVRDaDFQYzZNQ3FnQzNMNnZYNFJHOTE2MEFpd2pEeENkRkFQMnlCUVVHODl2VGdtRkJMRC8KVFNkYng2cWY5R1RLTFU4QTJ4Vmoxb0N4VDJzeHR1NHFyb3FVQ1ZjQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQVRPNFZDREpxYVVWbFR3MGR1Z2kzMm5tcndNOUNDVlg2c1FaVU1RNFBKYngwWGxQMG42c3RMCmxxcFhSZ1hNZUN5TGxWeXdTOTRCWnp4Q3hyaE1zRER5cUthbUdqVUlER2d6R2FPRkVtMWd4bnQ4ZWJOTlhGR3IKU3pzMlpJa0hYNU02emxnSkxobG1ObHVJczE4NlpjRVlYZUpjOW4zNHVCZE00cFZ5NXpISkIvcUxiWk1vNCtLdwpSSEZPeDBrdFdkWjBCSkREcDFYbTZSV1ZjSzVJL1JZWEhuWGhyc0hmMlZ1ZUN0OU1FZnZIVk1tZHdmYUJUK1VYCnlWaFdGZzNvTWJ4V2dKZFhPc0MyeVFUd2k4SUlDYVhvMnBST2dkSVphTmN2VVVSYmg4SHNJK1NFNld1TXY1YSsKMXVId3V2a1RiTDNjTXpNcDh4azBXWW1pV0E2SEtXRlUKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
controlplane ~ ➜  vi 271-csr.yaml 

controlplane ~ ➜  kubectl apply -f 271-csr.yaml
certificatesigningrequest.certificates.k8s.io/john-developer created

controlplane ~ ➜  kubectl certificate approve john-developer
certificatesigningrequest.certificates.k8s.io/john-developer approved

controlplane ~ ➜  kubectl get csr john-developer -o jsonpath='{.status.certificate}' | base64 -d > /root/CKA/john.crt

controlplane ~ ➜  cat /root/CKA/john.crt 
-----BEGIN CERTIFICATE-----
[omitido]
-----END CERTIFICATE-----

controlplane ~ ➜  

controlplane ~ ➜  vi 271-role-developer.yaml

controlplane ~ ➜  kubectl apply -f 271-role-developer.yaml
role.rbac.authorization.k8s.io/developer created

controlplane ~ ➜  vi 271-rolebinding-john.yaml

controlplane ~ ➜  kubectl apply -f 271-rolebinding-john.yaml
rolebinding.rbac.authorization.k8s.io/john-developer-binding created

controlplane ~ ➜  vi 271-clusterrole-create.yaml 

controlplane ~ ➜  kubectl apply -f 271-clusterrole-create.yaml 
clusterrole.rbac.authorization.k8s.io/john-developer created

controlplane ~ ➜  vi 271-clusterrole-approve.yaml 

controlplane ~ ➜  kubectl apply -f 271-clusterrole-approve.yaml 
clusterrole.rbac.authorization.k8s.io/csr-approver created

controlplane ~ ➜  vi 271-clusterrole-sign.yaml

controlplane ~ ➜  kubectl apply -f 271-clusterrole-sign.yaml
clusterrole.rbac.authorization.k8s.io/csr-signer created

controlplane ~ ➜  kubectl get csr
NAME             AGE    SIGNERNAME                                    REQUESTOR                  REQUESTEDDURATION   CONDITION
csr-g2swn        17m    kubernetes.io/kube-apiserver-client-kubelet   system:node:controlplane   <none>              Approved,Issued
csr-jkhd7        16m    kubernetes.io/kube-apiserver-client-kubelet   system:bootstrap:sadorn    <none>              Approved,Issued
john-developer   4m2s   kubernetes.io/kube-apiserver-client           kubernetes-admin           24h                 Approved,Issued

controlplane ~ ➜  



### 7 / 8
Weight: 15

Create a nginx pod called nginx-resolver using image nginx, expose it internally with a service called nginx-resolver-service. Test that you are able to look up the service and pod names from within the cluster. Use the image: busybox:1.28 for dns lookup. Record results in /root/CKA/nginx.svc and /root/CKA/nginx.pod

Pod: nginx-resolver created

Service DNS Resolution recorded correctly

Pod DNS resolution recorded correctly




apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80



- Service

apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app.kubernetes.io/name: MyApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9376




controlplane ~ ➜  vi pod-resolver.yaml

controlplane ~ ➜  ^C

controlplane ~ ✖ kubectl apply -f pod-resolver.yaml
pod/nginx-resolver created

controlplane ~ ➜  kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
nginx-deploy-678c6b9b69-wm2kd   1/1     Running   0          24m
nginx-resolver                  1/1     Running   0          3s
redis-storage                   1/1     Running   0          33m
super-user-pod                  1/1     Running   0          33m
use-pv                          1/1     Running   0          32m

controlplane ~ ➜  kubectl get pod nginx-resolver
NAME             READY   STATUS    RESTARTS   AGE
nginx-resolver   1/1     Running   0          9s


controlplane ~ ➜  vi service.yaml

controlplane ~ ➜  kubectl apply -f service.yaml
service/nginx-resolver-service created

controlplane ~ ➜  kubectl get svc
NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes               ClusterIP   10.96.0.1      <none>        443/TCP   42m
nginx-resolver-service   ClusterIP   10.98.34.111   <none>        80/TCP    6s

controlplane ~ ➜  date
Sat Dec 14 05:15:06 PM UTC 2024

controlplane ~ ➜  

https://kubernetes.io/docs/concepts/services-networking/service/#discovering-services

A cluster-aware DNS server, such as CoreDNS, watches the Kubernetes API for new Services and creates a set of DNS records for each one. If DNS has been enabled throughout your cluster then all Pods should automatically be able to resolve Services by their DNS name.

For example, if you have a Service called my-service in a Kubernetes namespace my-ns, the control plane and the DNS Service acting together create a DNS record for my-service.my-ns. Pods in the my-ns namespace should be able to find the service by doing a name lookup for my-service (my-service.my-ns would also work).

Pods in other namespaces must qualify the name as my-service.my-ns. These names will resolve to the cluster IP assigned for the Service.

Kubernetes also supports DNS SRV (Service) records for named ports. If the my-service.my-ns Service has a port named http with the protocol set to TCP, you can do a DNS SRV query for _http._tcp.my-service.my-ns to discover the port number for http, as well as the IP address.

The Kubernetes DNS server is the only way to access ExternalName Services. You can find more information about ExternalName resolution in DNS for Services and Pods.



controlplane ~ ➜  nslookup nginx-resolver-service.default
Server:         172.25.0.1
Address:        172.25.0.1#53

** server can't find nginx-resolver-service.default: NXDOMAIN


controlplane ~ ✖ vi pod-busybox.yaml

controlplane ~ ➜  kubectl apply -f pod-busybox.yaml
pod/busybox created

controlplane ~ ➜  kubectl get pods
NAME                            READY   STATUS      RESTARTS   AGE
busybox                         0/1     Completed   0          3s
nginx-deploy-678c6b9b69-wm2kd   1/1     Running     0          28m
nginx-resolver                  1/1     Running     0          4m13s
redis-storage                   1/1     Running     0          38m
super-user-pod                  1/1     Running     0          37m
use-pv                          1/1     Running     0          36m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods
NAME                            READY   STATUS             RESTARTS      AGE
busybox                         0/1     CrashLoopBackOff   1 (11s ago)   13s


https://discuss.kubernetes.io/t/deployment-with-image-busybox-always-fails-but-deos-work-with-any-others/28639

fox-md
Jun 15

Hi,

Busybox has no entrypoint/cmd by default. You need to tell busybox to do smth (ex: sleep 1d). Otherwise it will keep failing with exit code 0.


https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/

kubectl run -i --tty busybox --image=busybox:1.28 -- sh  # Executa pod como shell interativo


controlplane ~ ➜  kubectl run -i --tty busybox --image=busybox:1.28 -- sh  # Executa pod como shell interativo
Error from server (AlreadyExists): pods "busybox" already exists

controlplane ~ ✖ kubectl run -i --tty busybox2 --image=busybox:1.28 -- sh  # Executa pod como shell interativo
If you don't see a command prompt, try pressing enter.
/ # 
/ # 
/ # 
/ # nslookup nginx-resolver.default
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

nslookup: can't resolve 'nginx-resolver.default'
/ # 


controlplane ~ ➜  kubectl run -i --tty busybox --image=busybox:1.28 -- sh  # Executa pod como shell interativo
Error from server (AlreadyExists): pods "busybox" already exists

controlplane ~ ✖ kubectl run -i --tty busybox2 --image=busybox:1.28 -- sh  # Executa pod como shell interativo
If you don't see a command prompt, try pressing enter.
/ # 
/ # 
/ # 
/ # nslookup nginx-resolver.default
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

nslookup: can't resolve 'nginx-resolver.default'
/ # nslookup nginx-resolver.default.pod.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

nslookup: can't resolve 'nginx-resolver.default.pod.cluster.local'
/ # nslookup nginx-resolver-service.default.svc.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-resolver-service.default.svc.cluster.local
Address 1: 10.98.34.111 nginx-resolver-service.default.svc.cluster.local
/ # 
/ # 
/ # 
/ # 
/ # 
/ # 
/ # 
/ # 
/ # 
/ # 
/ # nslookup nginx-resolver-service.default.svc.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-resolver-service.default.svc.cluster.local
Address 1: 10.98.34.111 nginx-resolver-service.default.svc.cluster.local
/ # 



https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/

Services
A/AAAA records

"Normal" (not headless) Services are assigned DNS A and/or AAAA records, depending on the IP family or families of the Service, with a name of the form my-svc.my-namespace.svc.cluster-domain.example. This resolves to the cluster IP of the Service.

Headless Services (without a cluster IP) Services are also assigned DNS A and/or AAAA records, with a name of the form my-svc.my-namespace.svc.cluster-domain.example. Unlike normal Services, this resolves to the set of IPs of all of the Pods selected by the Service. Clients are expected to consume the set or else use standard round-robin selection from the set.
 

Pods
A/AAAA records

Kube-DNS versions, prior to the implementation of the DNS specification, had the following DNS resolution:

pod-ipv4-address.my-namespace.pod.cluster-domain.example.

For example, if a Pod in the default namespace has the IP address 172.17.0.3, and the domain name for your cluster is cluster.local, then the Pod has a DNS name:

172-17-0-3.default.pod.cluster.local.

Any Pods exposed by a Service have the following DNS resolution available:

pod-ipv4-address.service-name.my-namespace.svc.cluster-domain.example.



nslookup nginx-resolver-service.default.svc.cluster.local


controlplane ~ ➜  kubectl get pod
NAME                            READY   STATUS             RESTARTS      AGE
busybox                         0/1     CrashLoopBackOff   6 (59s ago)   6m38s
busybox2                        1/1     Running            0             4m6s
nginx-deploy-678c6b9b69-wm2kd   1/1     Running            0             35m
nginx-resolver                  1/1     Running            0             10m
redis-storage                   1/1     Running            0             44m
super-user-pod                  1/1     Running            0             44m
use-pv                          1/1     Running            0             43m

controlplane ~ ➜  kubectl get pod -o wide
NAME                            READY   STATUS             RESTARTS      AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         0/1     CrashLoopBackOff   6 (61s ago)   6m40s   10.244.192.6   node01   <none>           <none>
busybox2                        1/1     Running            0             4m8s    10.244.192.7   node01   <none>           <none>
nginx-deploy-678c6b9b69-wm2kd   1/1     Running            0             35m     10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running            0             10m     10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running            0             44m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running            0             44m     10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running            0             43m     10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  






nslookup 10-244-192-4.nginx-resolver-service.default.svc.cluster.local


/ # 
/ # nslookup 10-244-192-4.nginx-resolver-service.default.svc.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

nslookup: can't resolve '10-244-192-4.nginx-resolver-service.default.svc.cluster.local'
/ # 


nslookup 10-244-192-4.default.pod.cluster.local


/ # 
/ # nslookup 10-244-192-4.default.pod.cluster.local
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      10-244-192-4.default.pod.cluster.local
Address 1: 10.244.192.4
/ # 



kubectl run -i --tty busybox --image=busybox:1.28 -- sh


https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/

kubectl exec my-pod -- ls /                         # Executa comando no pod existente (1 contêiner)


kubectl exec busybox2 -- nslookup 10-244-192-4.nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc




controlplane ~ ➜  kubectl exec busybox2 -- nslookup 10-244-192-4.nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc
nslookup: can't resolve '10-244-192-4.nginx-resolver-service.default.svc.cluster.local'
command terminated with exit code 1

controlplane ~ ✖ date
Sat Dec 14 05:32:35 PM UTC 2024

controlplane ~ ➜  



nslookup nginx-resolver-service.default.svc.cluster.local

kubectl exec busybox2 -- nslookup nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc


controlplane ~ ➜  kubectl exec busybox2 -- nslookup nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc

controlplane ~ ➜  cat ^C

controlplane ~ ✖ cat /root/CKA/
john.csr     john.key     nginx.svc    use-pv.yaml  

controlplane ~ ✖ cat /root/CKA/nginx.svc 
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-resolver-service.default.svc.cluster.local
Address 1: 10.98.34.111 nginx-resolver-service.default.svc.cluster.local

controlplane ~ ➜  



nslookup 10-244-192-4.default.pod.cluster.local

kubectl exec busybox2 -- nslookup 10-244-192-4.default.pod.cluster.local > /root/CKA/nginx.svc


- Nova tentativa

kubectl apply -f 271-pod-pra-expor.yaml
kubectl apply -f 271-service.yaml

kubectl run -i --tty busybox --image=busybox:1.28 -- sh
kubectl exec busybox -- nslookup nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc
AJUSTAR O ENDEREÇO IP DO POD:
kubectl exec busybox -- nslookup 10-244-192-4.default.pod.cluster.local > /root/CKA/nginx.pod



controlplane ~ ➜  kubectl exec busybox -- nslookup nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc

controlplane ~ ➜  cat /root/CKA/nginx.svc 
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      nginx-resolver-service.default.svc.cluster.local
Address 1: 10.103.113.147 nginx-resolver-service.default.svc.cluster.local

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         1/1     Running   0          37s     10.244.192.6   node01   <none>           <none>
nginx-deploy-678c6b9b69-nwlms   1/1     Running   0          8m27s   10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running   0          74s     10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running   0          10m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running   0          9m41s   10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running   0          8m59s   10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  




controlplane ~ ➜  vi 271-pod-pra-expor.yaml

controlplane ~ ➜  kubectl apply -f 271-pod-pra-expor.yaml
pod/nginx-resolver created

controlplane ~ ➜  vi 271-service.yaml

controlplane ~ ➜  kubectl apply -f 271-service.yaml
service/nginx-resolver-service created

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         1/1     Running   0          37s     10.244.192.6   node01   <none>           <none>
nginx-deploy-678c6b9b69-nwlms   1/1     Running   0          8m27s   10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running   0          74s     10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running   0          10m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running   0          9m41s   10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running   0          8m59s   10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  
kubectl exec busybox -- nslookup 10-244-192-4.default.pod.cluster.local > /root/CKA/nginx.pod

controlplane ~ ➜  cat /root/CKA/nginx.pod
Server:    10.96.0.10
Address 1: 10.96.0.10 kube-dns.kube-system.svc.cluster.local

Name:      10-244-192-4.default.pod.cluster.local
Address 1: 10.244.192.4

controlplane ~ ➜  




- Questão 6:

REPROVADO NESTA TASK:
CSR: john-developer Status:Approved

APROVADO NESTAS TASKS:
Role Name: developer, namespace: development, Resource: Pods
Access: User 'john' has appropriate permissions


- Questão 7:

APROVADO NESTAS TASKS:
Pod: nginx-resolver created
Service DNS Resolution recorded correctly

REPROVADO NESTA TASK, FALTOU A RESOLUÇÃO:
Pod DNS resolution recorded correctly




# ###################################################################################################################### 
# ###################################################################################################################### 
## PENDENTE

- Organizar respostas OK.

- Questões 6 e 7, revisar.

- Refazer o teste.





# ###################################################################################################################### 
# ###################################################################################################################### 
## dia 15/12/2024

- Organizar respostas OK.



8 / 8
Weight: 15

Create a static pod on node01 called nginx-critical with image nginx and make sure that it is recreated/restarted automatically in case of a failure.

Use /etc/kubernetes/manifests as the Static Pod path for example.

static pod configured under /etc/kubernetes/manifests ?

Pod nginx-critical-node01 is up and running


# Run this command on the node where kubelet is running
mkdir -p /etc/kubernetes/manifests/
cat <<EOF >/etc/kubernetes/manifests/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  labels:
    role: myrole
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF


- Ajustado

# Run this command on the node where kubelet is running
mkdir -p /etc/kubernetes/manifests/
cat <<EOF >/etc/kubernetes/manifests/nginx-critical.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-critical
  labels:
    role: myrole
spec:
  containers:
    - name: nginx-critical
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF


controlplane ~ ✖ ssh node01
Welcome to Ubuntu 22.04.4 LTS (GNU/Linux 5.4.0-1106-gcp x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro

This system has been minimized by removing packages and content that are
not required on a system that users do not log into.

To restore this content, you can run the 'unminimize' command.

node01 ~ ➜  

node01 ~ ➜  

node01 ~ ➜  



node01 ~ ➜  ls /etc/kubernetes/manifests/

node01 ~ ➜  

criando:

cat <<EOF >/etc/kubernetes/manifests/nginx-critical.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-critical
  labels:
    role: myrole
spec:
  containers:
    - name: nginx-critical
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF


controlplane ~ ➜  kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         1/1     Running   0          6m57s   10.244.192.6   node01   <none>           <none>
nginx-deploy-678c6b9b69-nwlms   1/1     Running   0          14m     10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running   0          7m34s   10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running   0          16m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running   0          16m     10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running   0          15m     10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         1/1     Running   0          7m34s   10.244.192.6   node01   <none>           <none>
nginx-critical-node01           1/1     Running   0          10s     10.244.192.7   node01   <none>           <none>
nginx-deploy-678c6b9b69-nwlms   1/1     Running   0          15m     10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running   0          8m11s   10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running   0          17m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running   0          16m     10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running   0          15m     10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  



controlplane ~ ✖ kubectl delete pod nginx-critical-node01
pod "nginx-critical-node01" deleted

controlplane ~ ➜  kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         1/1     Running   0          8m27s   10.244.192.6   node01   <none>           <none>
nginx-critical-node01           0/1     Pending   0          3s      <none>         node01   <none>           <none>
nginx-deploy-678c6b9b69-nwlms   1/1     Running   0          16m     10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running   0          9m4s    10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running   0          18m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running   0          17m     10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running   0          16m     10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  kubectl get pods -o wide
NAME                            READY   STATUS    RESTARTS   AGE     IP             NODE     NOMINATED NODE   READINESS GATES
busybox                         1/1     Running   0          8m30s   10.244.192.6   node01   <none>           <none>
nginx-critical-node01           1/1     Running   0          6s      10.244.192.7   node01   <none>           <none>
nginx-deploy-678c6b9b69-nwlms   1/1     Running   0          16m     10.244.192.5   node01   <none>           <none>
nginx-resolver                  1/1     Running   0          9m7s    10.244.192.4   node01   <none>           <none>
redis-storage                   1/1     Running   0          18m     10.244.192.1   node01   <none>           <none>
super-user-pod                  1/1     Running   0          17m     10.244.192.2   node01   <none>           <none>
use-pv                          1/1     Running   0          16m     10.244.192.3   node01   <none>           <none>

controlplane ~ ➜  



- ok

Your score
100%
Pass Percentage - 74% 




# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## RESPOSTAS ORGANIZADAS


### 1 / 8
ETCDCTL_API=3 etcdctl snapshot save /opt/etcd-backup.db --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key



### 2 / 8

- Ajustado, Pod com EmptyDir:

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



### 3 / 8

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



### 4 / 8

- PVC Ajustado:

~~~~yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Mi
  storageClassName: "" # Empty string must be explicitly set otherwise default StorageClass will be set
  volumeName: pv-1
~~~~

- Criando Pod com PVC:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: use-pv
  name: use-pv
spec:
  containers:
    - name: use-pv
      image: nginx
      volumeMounts:
      - mountPath: "/data"
        name: mypd
  dnsPolicy: ClusterFirst
  volumes:
    - name: mypd
      persistentVolumeClaim:
        claimName: my-pvc
~~~~



### 5 / 8

- Deployment Ajustado:

~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deploy
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.16
        ports:
        - containerPort: 80
~~~~

- Setando nova imagem:
 kubectl set image deployment/nginx-deploy nginx=nginx:1.17




### 6 / 8

cat /root/CKA/john.csr | base64 | tr -d "\n"
kubectl apply -f 271-csr.yaml 
kubectl certificate approve john-developer
kubectl get csr john-developer -o jsonpath='{.status.certificate}' | base64 -d > /root/CKA/john.crt
kubectl apply -f 271-role-developer.yaml
kubectl apply -f 271-rolebinding-john.yaml
kubectl apply -f 271-clusterrole-create.yaml 
kubectl apply -f 271-clusterrole-approve.yaml 
kubectl apply -f 271-clusterrole-sign.yaml 
kubectl get csr
kubectl certificate approve john
kubectl get csr

old
kubectl create role developer -n development --verb=create --verb=get --verb=list --verb=update --verb=delete --resource=pods
kubectl create rolebinding developer-binding-john -n development --role=developer --user=john
kubectl get role -n development
kubectl get rolebinding -n development


### 7 / 8

kubectl apply -f 271-pod-pra-expor.yaml
kubectl apply -f 271-service.yaml

kubectl run -i --tty busybox --image=busybox:1.28 -- sh
kubectl exec busybox -- nslookup nginx-resolver-service.default.svc.cluster.local > /root/CKA/nginx.svc
AJUSTAR O ENDEREÇO IP DO POD:
kubectl exec busybox -- nslookup 10-244-192-4.default.pod.cluster.local > /root/CKA/nginx.pod


### 8 / 8

- Criando:

cat <<EOF >/etc/kubernetes/manifests/nginx-critical.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-critical
  labels:
    role: myrole
spec:
  containers:
    - name: nginx-critical
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF

- Testando:
kubectl delete pod nginx-critical-node01
#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "269. Mock Exam - 1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  269. Mock Exam - 1


### 1 / 12
Weight: 6

Deploy a pod named nginx-pod using the nginx:alpine image.

Once done, click on the Next Question button in the top right corner of this panel. You may navigate back and forth freely between all questions. Once done with all questions, click on End Exam. Your work will be validated at the end and score shown. Good Luck!

Name: nginx-pod

Image: nginx:alpine


~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
spec:
  containers:
  - name: nginx
    image: nginx:alpine
    ports:
    - containerPort: 80
~~~~

controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl apply -f pod.yaml
pod/nginx-pod created

controlplane ~ ➜  







### 2 / 12
Weight: 8

Deploy a messaging pod using the redis:alpine image with the labels set to tier=msg.

Pod Name: messaging

Image: redis:alpine

Labels: tier=msg


Exemplo

For example, here's a manifest for a Pod that has two labels environment: production and app: nginx:
~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: label-demo
  labels:
    environment: production
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.14.2
    ports:
    - containerPort: 80
~~~~

- Ajustado:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: messaging
  labels:
    tier: msg
spec:
  containers:
  - name: redis
    image: redis:alpine
~~~~

controlplane ~ ➜  vi pod2.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod2.yaml
pod/messaging created

controlplane ~ ➜  
controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        messaging                              1/1     Running   0          12s
default        nginx-pod                              1/1     Running   0          4m1s
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running   0          60m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running   0          60m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running   0          60m
kube-system    etcd-controlplane                      1/1     Running   0          60m
kube-system    kube-apiserver-controlplane            1/1     Running   0          60m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          60m
kube-system    kube-proxy-784nm                       1/1     Running   0          60m
kube-system    kube-scheduler-controlplane            1/1     Running   0          60m

controlplane ~ ➜  









### 3 / 12
Weight: 4

Create a namespace named apx-x9984574.

Namespace: apx-x9984574


kubectl create ns apx-x9984574


controlplane ~ ➜  kubectl create ns apx-x9984574
namespace/apx-x9984574 created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get ns
NAME              STATUS   AGE
apx-x9984574      Active   4s
default           Active   62m
kube-flannel      Active   62m
kube-node-lease   Active   62m
kube-public       Active   62m
kube-system       Active   62m

controlplane ~ ➜  






### 4 / 12
Weight: 7

Get the list of nodes in JSON format and store it in a file at /opt/outputs/nodes-z3444kd9.json.

Task completed


kubectl get nodes -o json > /opt/outputs/nodes-z3444kd9.json


controlplane ~ ➜  kubectl get nodes -o json > /opt/outputs/nodes-z3444kd9.json

controlplane ~ ➜  






### 5 / 12
Weight: 12

Create a service messaging-service to expose the messaging application within the cluster on port 6379.

Use imperative commands.

Service: messaging-service

Port: 6379

Type: ClusterIp

Use the right labels


Exemplo:

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

- Ajustado:

~~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: messaging-service
spec:
  selector:
    tier: msg
  ports:
    - protocol: TCP
      port: 6379
      targetPort: 6379
~~~~



controlplane ~ ➜  vi service.yaml

controlplane ~ ➜  kubectl apply -f service.yaml
service/messaging-service created

controlplane ~ ➜  








### 6 / 12
Weight: 11

Create a deployment named hr-web-app using the image kodekloud/webapp-color with 2 replicas.

Name: hr-web-app

Image: kodekloud/webapp-color

Replicas: 2


Exemplo:

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
  name: hr-web-app
  labels:
    app: hr-web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hr-web
  template:
    metadata:
      labels:
        app: hr-web
    spec:
      containers:
      - name: hr-web
        image: kodekloud/webapp-color
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
          requests:
            memory: "256Mi"
            cpu: "250m"

~~~~

controlplane ~ ➜  vi deployment.yaml

controlplane ~ ➜  kubectl apply -f deployment.yaml
deployment.apps/hr-web-app created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        hr-web-app-7db4688c6c-22jt9            1/1     Running   0          6s
default        hr-web-app-7db4688c6c-vlg45            1/1     Running   0          6s
default        messaging                              1/1     Running   0          9m27s
default        nginx-pod                              1/1     Running   0          13m
kube-flannel   kube-flannel-ds-m5kjn                  1/1     Running   0          69m
kube-system    coredns-77d6fd4654-65pnt               1/1     Running   0          69m
kube-system    coredns-77d6fd4654-vst2t               1/1     Running   0          69m
kube-system    etcd-controlplane                      1/1     Running   0          69m
kube-system    kube-apiserver-controlplane            1/1     Running   0          70m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          69m
kube-system    kube-proxy-784nm                       1/1     Running   0          69m
kube-system    kube-scheduler-controlplane            1/1     Running   0          70m

controlplane ~ ➜  date
Fri Nov  1 12:48:50 AM UTC 2024

controlplane ~ ➜  








### 7 / 12
Weight: 8

Create a static pod named static-busybox on the controlplane node that uses the busybox image and the command sleep 1000.

Name: static-busybox

Image: busybox


<https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/>
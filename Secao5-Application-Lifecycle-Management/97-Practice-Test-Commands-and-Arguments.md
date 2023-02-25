







# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 97. Practice Test - Commands and Arguments."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

#  97. Practice Test - Commands and Arguments



How many PODs exist on the system?

In the current(default) namespace

controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          4m38s

controlplane ~ ➜  



















What is the command used to run the pod ubuntu-sleeper?


controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          5m8s

controlplane ~ ➜  kubectl describe pod ubuntu-sleeper
Name:             ubuntu-sleeper
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/172.25.0.4
Start Time:       Sat, 25 Feb 2023 01:18:02 +0000
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.42.0.9
IPs:
  IP:  10.42.0.9
Containers:
  ubuntu:
    Container ID:  containerd://e6a6d3e0ad4daf5beaa49c1502f6b399d41e614280b1b142c49ee61ae08cc354
    Image:         ubuntu
    Image ID:      docker.io/library/ubuntu@sha256:9a0bdde4188b896a372804be2384015e90e3f84906b750c1a53539b585fbbe7f
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      4800
    State:          Running
      Started:      Sat, 25 Feb 2023 01:18:08 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-rsmdn (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-rsmdn:
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
  Normal  Scheduled  5m26s  default-scheduler  Successfully assigned default/ubuntu-sleeper to controlplane
  Normal  Pulling    5m26s  kubelet            Pulling image "ubuntu"
  Normal  Pulled     5m22s  kubelet            Successfully pulled image "ubuntu" in 4.008476906s (4.008500707s including waiting)
  Normal  Created    5m21s  kubelet            Created container ubuntu
  Normal  Started    5m21s  kubelet            Started container ubuntu

controlplane ~ ➜  

controlplane ~ ➜  


controlplane ~ ➜  




# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-02-25T01:18:02Z"
  name: ubuntu-sleeper
  namespace: default
  resourceVersion: "989"
  uid: 313f8538-269b-41b8-8394-b824693c0324
spec:
  containers:
  - command:
    - sleep
    - "4800"
    image: ubuntu
    imagePullPolicy: Always
    name: ubuntu
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-rsmdn
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
  - name: kube-api-access-rsmdn
    projected:
      defaultMode: 420
"/tmp/kubectl-edit-3583541583.yaml" 103L, 2797B                                                                                            1,1           Top





controlplane ~ ➜  kubectl edit pod ubuntu-sleeper
Edit cancelled, no changes made.

controlplane ~ ➜  

























Create a pod with the ubuntu image to run a container to sleep for 5000 seconds. Modify the file ubuntu-sleeper-2.yaml.

Note: Only make the necessary changes. Do not modify the name.

    Pod Name: ubuntu-sleeper-2

    Command: sleep 5000


controlplane ~ ➜  ls
sample.yaml            ubuntu-sleeper-2.yaml  ubuntu-sleeper-3.yaml  webapp-color           webapp-color-2         webapp-color-3

controlplane ~ ➜  cat ubuntu-sleeper-2.yaml
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu

controlplane ~ ➜  



- Editado:

~~~~YAML
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
  - command:
    - sleep
    - "5000"
~~~~


controlplane ~ ✖ kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-qz5mw                  1/1     Running     0          37m
kube-system   local-path-provisioner-5d56847996-xqqkz   1/1     Running     0          37m
kube-system   helm-install-traefik-crd-xgnzn            0/1     Completed   0          37m
kube-system   helm-install-traefik-xtzht                0/1     Completed   1          37m
kube-system   svclb-traefik-5d205092-hxrx6              2/2     Running     0          36m
kube-system   metrics-server-7b67f64457-lkqb4           1/1     Running     0          37m
kube-system   traefik-56b8c5fb5c-lxl7c                  1/1     Running     0          36m
default       ubuntu-sleeper                            1/1     Running     0          16m

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f ubuntu-sleeper-2.yaml
The Pod "ubuntu-sleeper-2" is invalid: 
* spec.containers[1].name: Required value
* spec.containers[1].image: Required value

controlplane ~ ✖ 





- Editado novamente:

~~~~YAML
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
  - command:
    - sleep
    - "5000"
~~~~



controlplane ~ ✖ vi ubuntu-sleeper-2.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f ubuntu-sleeper-2.yaml
pod/ubuntu-sleeper-2 created

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-qz5mw                  1/1     Running     0          39m
kube-system   local-path-provisioner-5d56847996-xqqkz   1/1     Running     0          39m
kube-system   helm-install-traefik-crd-xgnzn            0/1     Completed   0          39m
kube-system   helm-install-traefik-xtzht                0/1     Completed   1          39m
kube-system   svclb-traefik-5d205092-hxrx6              2/2     Running     0          39m
kube-system   metrics-server-7b67f64457-lkqb4           1/1     Running     0          39m
kube-system   traefik-56b8c5fb5c-lxl7c                  1/1     Running     0          39m
default       ubuntu-sleeper                            1/1     Running     0          19m
default       ubuntu-sleeper-2                          1/1     Running     0          34s

controlplane ~ ➜  













Create a pod using the file named ubuntu-sleeper-3.yaml. There is something wrong with it. Try to fix it!

Note: Only make the necessary changes. Do not modify the name.

    Pod Name: ubuntu-sleeper-3

    Command: sleep 1200


controlplane ~ ➜  ls
sample.yaml            ubuntu-sleeper-2.yaml  ubuntu-sleeper-3.yaml  webapp-color           webapp-color-2         webapp-color-3

controlplane ~ ➜  cat ubuntu-sleeper-3.yaml
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-3 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command:
      - "sleep"
      - 1200

controlplane ~ ➜  


controlplane ~ ➜  vi ubuntu-sleeper-3.yaml

controlplane ~ ➜  kubectl apply -f ubuntu-sleeper-3.yaml
pod/ubuntu-sleeper-3 created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-qz5mw                  1/1     Running     0          45m
kube-system   local-path-provisioner-5d56847996-xqqkz   1/1     Running     0          45m
kube-system   helm-install-traefik-crd-xgnzn            0/1     Completed   0          45m
kube-system   helm-install-traefik-xtzht                0/1     Completed   1          45m
kube-system   svclb-traefik-5d205092-hxrx6              2/2     Running     0          45m
kube-system   metrics-server-7b67f64457-lkqb4           1/1     Running     0          45m
kube-system   traefik-56b8c5fb5c-lxl7c                  1/1     Running     0          45m
default       ubuntu-sleeper                            1/1     Running     0          25m
default       ubuntu-sleeper-2                          1/1     Running     0          6m10s
default       ubuntu-sleeper-3                          1/1     Running     0          5s

controlplane ~ ➜  













Update pod ubuntu-sleeper-3 to sleep for 2000 seconds.

Note: Only make the necessary changes. Do not modify the name of the pod. Delete and recreate the pod if necessary.

    Pod Name: ubuntu-sleeper-3

    Command: sleep 2000



controlplane ~ ➜  ls
sample.yaml            ubuntu-sleeper-2.yaml  ubuntu-sleeper-3.yaml  webapp-color           webapp-color-2         webapp-color-3

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-qz5mw                  1/1     Running     0          46m
kube-system   local-path-provisioner-5d56847996-xqqkz   1/1     Running     0          46m
kube-system   helm-install-traefik-crd-xgnzn            0/1     Completed   0          46m
kube-system   helm-install-traefik-xtzht                0/1     Completed   1          46m
kube-system   svclb-traefik-5d205092-hxrx6              2/2     Running     0          45m
kube-system   metrics-server-7b67f64457-lkqb4           1/1     Running     0          46m
kube-system   traefik-56b8c5fb5c-lxl7c                  1/1     Running     0          45m
default       ubuntu-sleeper                            1/1     Running     0          25m
default       ubuntu-sleeper-2                          1/1     Running     0          6m43s
default       ubuntu-sleeper-3                          1/1     Running     0          38s

controlplane ~ ➜  


controlplane ~ ➜  vi ubuntu-sleeper-3.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f ubuntu-sleeper-3.yaml
The Pod "ubuntu-sleeper-3" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes:        {{Name: "kube-api-access-j4dgc", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}}},
        InitContainers: nil,
        Containers: []core.Container{
                {
                        Name:  "ubuntu",
                        Image: "ubuntu",
                        Command: []string{
                                "sleep",
-                               "1200",
+                               "2000",
                        },
                        Args:       nil,
                        WorkingDir: "",
                        ... // 17 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 28 identical fields
  }


controlplane ~ ✖ 


controlplane ~ ✖ kubectl delete pod ubuntu-sleeper-3
pod "ubuntu-sleeper-3" deleted


controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f ubuntu-sleeper-3.yaml
pod/ubuntu-sleeper-3 created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-qz5mw                  1/1     Running     0          48m
kube-system   local-path-provisioner-5d56847996-xqqkz   1/1     Running     0          48m
kube-system   helm-install-traefik-crd-xgnzn            0/1     Completed   0          48m
kube-system   helm-install-traefik-xtzht                0/1     Completed   1          48m
kube-system   svclb-traefik-5d205092-hxrx6              2/2     Running     0          47m
kube-system   metrics-server-7b67f64457-lkqb4           1/1     Running     0          48m
kube-system   traefik-56b8c5fb5c-lxl7c                  1/1     Running     0          47m
default       ubuntu-sleeper                            1/1     Running     0          28m
default       ubuntu-sleeper-2                          1/1     Running     0          9m2s
default       ubuntu-sleeper-3                          1/1     Running     0          15s

controlplane ~ ➜  















Inspect the file Dockerfile given at /root/webapp-color directory. What command is run at container startup?


controlplane ~ ➜  ls /root
sample.yaml            ubuntu-sleeper-2.yaml  ubuntu-sleeper-3.yaml  webapp-color           webapp-color-2         webapp-color-3

controlplane ~ ➜  cat /root/webapp-color
webapp-color/   webapp-color-2/ webapp-color-3/ 

controlplane ~ ➜  cat /root/webapp-color/Dockerfile
FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

controlplane ~ ➜  










Inspect the file Dockerfile2 given at /root/webapp-color directory. What command is run at container startup?

controlplane ~ ➜  cat /root/webapp-color/Dockerfile
Dockerfile   Dockerfile2  

controlplane ~ ➜  cat /root/webapp-color/Dockerfile
Dockerfile   Dockerfile2  

controlplane ~ ➜  cat /root/webapp-color/Dockerfile2
FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]

controlplane ~ ➜  



- RESPOSTA:
python app.py --color red









Inspect the two files under directory webapp-color-2. What command is run at container startup?

Assume the image was created from the Dockerfile in this directory.

controlplane ~ ➜  cat /root/webapp-color-2/
Dockerfile2            webapp-color-pod.yaml  

controlplane ~ ➜  cat /root/webapp-color-2/webapp-color-pod.yaml 
apiVersion: v1 
kind: Pod 
metadata:
  name: webapp-green
  labels:
      name: webapp-green 
spec:
  containers:
  - name: simple-webapp
    image: kodekloud/webapp-color
    command: ["--color","green"]

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cat /root/webapp-color-2/Dockerfile2 
FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]

controlplane ~ ➜  



- RESPOSTA:
--color red










Inspect the two files under directory webapp-color-3. What command is run at container startup?

Assume the image was created from the Dockerfile in this directory.


controlplane ~ ➜  cat /root/webapp-color
webapp-color/   webapp-color-2/ webapp-color-3/ 

controlplane ~ ➜  cat /root/webapp-color-3/
Dockerfile2              webapp-color-pod-2.yaml  

controlplane ~ ➜  cat /root/webapp-color-3/webapp-color-pod-2.yaml 
apiVersion: v1 
kind: Pod 
metadata:
  name: webapp-green
  labels:
      name: webapp-green 
spec:
  containers:
  - name: simple-webapp
    image: kodekloud/webapp-color
    command: ["python", "app.py"]
    args: ["--color", "pink"]

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cat /root/webapp-color-3/Dockerfile2 
FROM python:3.6-alpine

RUN pip install flask

COPY . /opt/

EXPOSE 8080

WORKDIR /opt

ENTRYPOINT ["python", "app.py"]

CMD ["--color", "red"]

controlplane ~ ➜  


- RESPOSTA:
python app.py --color pink
















Create a pod with the given specifications. By default it displays a blue background. Set the given command line arguments to change it to green.

    Pod Name: webapp-green

    Image: kodekloud/webapp-color

    Command line arguments: --color=green


- Exemplo:

~~~~YAML
apiVersion: v1 
kind: Pod 
metadata:
  name: ubuntu-sleeper-2 
spec:
  containers:
  - name: ubuntu
    image: ubuntu
    command: ["sleep"]
    args: ["5000"]
~~~~


- Editado:

~~~~YAML
apiVersion: v1 
kind: Pod 
metadata:
  name: webapp-green
spec:
  containers:
  - name: webapp-green
    image: kodekloud/webapp-color
    args: ["--color=green"]
~~~~


controlplane ~ ➜  vi pod-green.yaml

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod-green.yaml
pod/webapp-green created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   coredns-5c6b6c5476-qz5mw                  1/1     Running     0          57m
kube-system   local-path-provisioner-5d56847996-xqqkz   1/1     Running     0          57m
kube-system   helm-install-traefik-crd-xgnzn            0/1     Completed   0          57m
kube-system   helm-install-traefik-xtzht                0/1     Completed   1          57m
kube-system   svclb-traefik-5d205092-hxrx6              2/2     Running     0          57m
kube-system   metrics-server-7b67f64457-lkqb4           1/1     Running     0          57m
kube-system   traefik-56b8c5fb5c-lxl7c                  1/1     Running     0          57m
default       ubuntu-sleeper                            1/1     Running     0          37m
default       ubuntu-sleeper-2                          1/1     Running     0          18m
default       ubuntu-sleeper-3                          1/1     Running     0          9m19s
default       webapp-green                              1/1     Running     0          6s

controlplane ~ ➜  
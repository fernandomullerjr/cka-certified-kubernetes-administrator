
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "111. Practice Test - Multi Container Pods"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 111. Practice Test - Multi Container Pods



## Identify the number of containers created in the red pod.


controlplane ~ ➜  kubectl get pods -A
NAMESPACE       NAME                                   READY   STATUS              RESTARTS   AGE
default         app                                    0/1     ContainerCreating   0          24s
default         fluent-ui                              0/1     ContainerCreating   0          24s
default         red                                    0/3     ContainerCreating   0          14s
elastic-stack   app                                    0/1     ContainerCreating   0          24s
elastic-stack   elastic-search                         1/1     Running             0          24s
elastic-stack   kibana                                 0/1     ContainerCreating   0          24s
kube-flannel    kube-flannel-ds-c8tb2                  1/1     Running             0          6m53s
kube-system     coredns-787d4945fb-669d2               1/1     Running             0          6m53s
kube-system     coredns-787d4945fb-nlnmp               1/1     Running             0          6m53s
kube-system     etcd-controlplane                      1/1     Running             0          7m6s
kube-system     kube-apiserver-controlplane            1/1     Running             0          7m3s
kube-system     kube-controller-manager-controlplane   1/1     Running             0          7m3s
kube-system     kube-proxy-5rjlp                       1/1     Running             0          6m53s
kube-system     kube-scheduler-controlplane            1/1     Running             0          7m3s

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods -A
NAMESPACE       NAME                                   READY   STATUS    RESTARTS   AGE
default         app                                    1/1     Running   0          99s
default         fluent-ui                              1/1     Running   0          99s
default         red                                    3/3     Running   0          89s
elastic-stack   app                                    1/1     Running   0          99s
elastic-stack   elastic-search                         1/1     Running   0          99s
elastic-stack   kibana                                 1/1     Running   0          99s
kube-flannel    kube-flannel-ds-c8tb2                  1/1     Running   0          8m8s
kube-system     coredns-787d4945fb-669d2               1/1     Running   0          8m8s
kube-system     coredns-787d4945fb-nlnmp               1/1     Running   0          8m8s
kube-system     etcd-controlplane                      1/1     Running   0          8m21s
kube-system     kube-apiserver-controlplane            1/1     Running   0          8m18s
kube-system     kube-controller-manager-controlplane   1/1     Running   0          8m18s
kube-system     kube-proxy-5rjlp                       1/1     Running   0          8m8s
kube-system     kube-scheduler-controlplane            1/1     Running   0          8m18s

controlplane ~ ➜  DATE
-bash: DATE: command not found

controlplane ~ ✖ date
Wed 19 Apr 2023 07:23:14 PM EDT

controlplane ~ ➜  



- RESPOSTA
3









## Identify the name of the containers running in the blue pod.

controlplane ~ ➜  kubectl get pods -A
NAMESPACE       NAME                                   READY   STATUS    RESTARTS   AGE
default         app                                    1/1     Running   0          2m23s
default         blue                                   2/2     Running   0          17s
default         fluent-ui                              1/1     Running   0          2m23s
default         red                                    3/3     Running   0          2m13s
elastic-stack   app                                    1/1     Running   0          2m23s
elastic-stack   elastic-search                         1/1     Running   0          2m23s
elastic-stack   kibana                                 1/1     Running   0          2m23s
kube-flannel    kube-flannel-ds-c8tb2                  1/1     Running   0          8m52s
kube-system     coredns-787d4945fb-669d2               1/1     Running   0          8m52s
kube-system     coredns-787d4945fb-nlnmp               1/1     Running   0          8m52s
kube-system     etcd-controlplane                      1/1     Running   0          9m5s
kube-system     kube-apiserver-controlplane            1/1     Running   0          9m2s
kube-system     kube-controller-manager-controlplane   1/1     Running   0          9m2s
kube-system     kube-proxy-5rjlp                       1/1     Running   0          8m52s
kube-system     kube-scheduler-controlplane            1/1     Running   0          9m2s

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe pod blue
Name:             blue
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/192.1.110.6
Start Time:       Wed, 19 Apr 2023 19:23:33 -0400
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.244.0.10
IPs:
  IP:  10.244.0.10
Containers:
  teal:
    Container ID:  containerd://24f245c280a93b3371126f6690b36d9b51aae9eb950ee375a859686eb76226b8
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      4500
    State:          Running
      Started:      Wed, 19 Apr 2023 19:23:35 -0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-499gw (ro)
  navy:
    Container ID:  containerd://0575e3fe856d9572db03a1063e8708ceaf9e81f7244dd50fd40fc5879bdc5deb
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    Port:          <none>
    Host Port:     <none>
    Command:
      sleep
      4500
    State:          Running
      Started:      Wed, 19 Apr 2023 19:23:36 -0400
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-499gw (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-499gw:
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
  Normal  Scheduled  101s  default-scheduler  Successfully assigned default/blue to controlplane
  Normal  Pulling    100s  kubelet            Pulling image "busybox"
  Normal  Pulled     100s  kubelet            Successfully pulled image "busybox" in 322.260621ms (322.279004ms including waiting)
  Normal  Created    99s   kubelet            Created container teal
  Normal  Started    99s   kubelet            Started container teal
  Normal  Pulling    99s   kubelet            Pulling image "busybox"
  Normal  Pulled     99s   kubelet            Successfully pulled image "busybox" in 307.675883ms (307.689961ms including waiting)
  Normal  Created    98s   kubelet            Created container navy
  Normal  Started    98s   kubelet            Started container navy

controlplane ~ ➜  


- RESPOSTA:
teal & navy













## Create a multi-container pod with 2 containers.

Use the spec given below.

If the pod goes into the crashloopbackoff then add the command sleep 1000 in the lemon container.

    Name: yellow

    Container 1 Name: lemon

    Container 1 Image: busybox

    Container 2 Name: gold

    Container 2 Image: redis





controlplane ~ ➜  kubectl get pod blue -o yaml > pod-multiplos.yaml

controlplane ~ ➜  cat pod-multiplos.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-04-19T23:23:33Z"
  name: blue
  namespace: default
  resourceVersion: "1223"
  uid: 5ec0d6de-9d13-48b0-8cf2-65413cd46cc2
spec:
  containers:
  - command:
    - sleep
    - "4500"
    image: busybox
    imagePullPolicy: Always
    name: teal
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-499gw
      readOnly: true
  - command:
    - sleep
    - "4500"
    image: busybox
    imagePullPolicy: Always
    name: navy
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-499gw
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
  - name: kube-api-access-499gw
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
    lastTransitionTime: "2023-04-19T23:23:33Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-04-19T23:23:37Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-04-19T23:23:37Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-04-19T23:23:33Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://0575e3fe856d9572db03a1063e8708ceaf9e81f7244dd50fd40fc5879bdc5deb
    image: docker.io/library/busybox:latest
    imageID: docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    lastState: {}
    name: navy
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-04-19T23:23:36Z"
  - containerID: containerd://24f245c280a93b3371126f6690b36d9b51aae9eb950ee375a859686eb76226b8
    image: docker.io/library/busybox:latest
    imageID: docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    lastState: {}
    name: teal
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-04-19T23:23:35Z"
  hostIP: 192.1.110.6
  phase: Running
  podIP: 10.244.0.10
  podIPs:
  - ip: 10.244.0.10
  qosClass: BestEffort
  startTime: "2023-04-19T23:23:33Z"

controlplane ~ ➜  




/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao5-Application-Lifecycle-Management/111-pod-multi-container.yaml

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: yellow
  namespace: default
spec:
  containers:
  - command:
    - sleep
    - "4500"
    image: busybox
    imagePullPolicy: Always
    name: lemon
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-499gw
      readOnly: true
  - command:
    - sleep
    - "4500"
    image: redis
    imagePullPolicy: Always
    name: gold
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-499gw
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
  - name: kube-api-access-499gw
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
~~~~









controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod-editado.yaml
pod/multiplos created

controlplane ~ ➜  kubectl apply -f pod-editado.yaml^C

controlplane ~ ✖ vi pod-editado.yaml

controlplane ~ ➜  kubectl apply -f pod-editado.yaml
pod/yellow created

controlplane ~ ➜  kubectl get pods -A
NAMESPACE       NAME                                   READY   STATUS    RESTARTS   AGE
default         app                                    1/1     Running   0          11m
default         blue                                   2/2     Running   0          9m5s
default         fluent-ui                              1/1     Running   0          11m
default         multiplos                              2/2     Running   0          41s
default         red                                    3/3     Running   0          11m
default         yellow                                 2/2     Running   0          5s
elastic-stack   app                                    1/1     Running   0          11m
elastic-stack   elastic-search                         1/1     Running   0          11m
elastic-stack   kibana                                 1/1     Running   0          11m
kube-flannel    kube-flannel-ds-c8tb2                  1/1     Running   0          17m
kube-system     coredns-787d4945fb-669d2               1/1     Running   0          17m
kube-system     coredns-787d4945fb-nlnmp               1/1     Running   0          17m
kube-system     etcd-controlplane                      1/1     Running   0          17m
kube-system     kube-apiserver-controlplane            1/1     Running   0          17m
kube-system     kube-controller-manager-controlplane   1/1     Running   0          17m
kube-system     kube-proxy-5rjlp                       1/1     Running   0          17m
kube-system     kube-scheduler-controlplane            1/1     Running   0          17m

controlplane ~ ➜  kubectl delete pod multiplos
pod "multiplos" deleted



controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE       NAME                                   READY   STATUS    RESTARTS   AGE
default         app                                    1/1     Running   0          12m
default         blue                                   2/2     Running   0          9m58s
default         fluent-ui                              1/1     Running   0          12m
default         red                                    3/3     Running   0          11m
default         yellow                                 2/2     Running   0          58s
elastic-stack   app                                    1/1     Running   0          12m
elastic-stack   elastic-search                         1/1     Running   0          12m
elastic-stack   kibana                                 1/1     Running   0          12m
kube-flannel    kube-flannel-ds-c8tb2                  1/1     Running   0          18m
kube-system     coredns-787d4945fb-669d2               1/1     Running   0          18m
kube-system     coredns-787d4945fb-nlnmp               1/1     Running   0          18m
kube-system     etcd-controlplane                      1/1     Running   0          18m
kube-system     kube-apiserver-controlplane            1/1     Running   0          18m
kube-system     kube-controller-manager-controlplane   1/1     Running   0          18m
kube-system     kube-proxy-5rjlp                       1/1     Running   0          18m
kube-system     kube-scheduler-controlplane            1/1     Running   0          18m

controlplane ~ ➜  














## We have deployed an application logging stack in the elastic-stack namespace. Inspect it.

Before proceeding with the next set of questions, please wait for all the pods in the elastic-stack namespace to be ready. This can take a few minutes.

controlplane ~ ➜  kubectl get pods -n elastic-stack
NAME             READY   STATUS    RESTARTS   AGE
app              1/1     Running   0          13m
elastic-search   1/1     Running   0          13m
kibana           1/1     Running   0          13m

controlplane ~ ➜  










## Once the pod is in a ready state, inspect the Kibana UI using the link above your terminal. There shouldn't be any logs for now.

We will configure a sidecar container for the application to send logs to Elastic Search.

NOTE: It can take a couple of minutes for the Kibana UI to be ready after the Kibana pod is ready.

You can inspect the Kibana logs by running:

kubectl -n elastic-stack logs kibana



controlplane ~ ➜  kubectl -n elastic-stack logs kibana
{"type":"log","@timestamp":"2023-04-19T23:23:13Z","tags":["status","plugin:kibana@6.4.2","info"],"pid":1,"state":"green","message":"Status changed from uninitialized to green - Ready","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2023-04-19T23:23:13Z","tags":["status","plugin:elasticsearch@6.4.2","info"],"pid":1,"state":"yellow","message":"Status changed from uninitialized to yellow - Waiting for Elasticsearch","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2023-04-19T23:23:13Z","tags":["status","plugin:xpack_main@6.4.2","info"],"pid":1,"state":"yellow","message":"Status changed from uninitialized to yellow - Waiting for Elasticsearch","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2023-04-19T23:23:13Z","tags":["status","plugin:searchprofiler@6.4.2","info"],"pid":1,"state":"yellow","message":"Status changed from uninitialized to yellow - Waiting for Elasticsearch","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2023-04-19T23:23:13Z","tags":["status","plugin:ml@6.4.2","info"],"pid":1,"state":"yellow","message":"Status changed from uninitialized to yellow - Waiting for Elasticsearch","prevState":"uninitialized","prevMsg":"uninitialized"}
{"type":"log","@timestamp":"2023-04-19T23:23:13Z","tags":["status","plugin:tilemap@6.4.2","info"],"pid":1,"state":"yellow","message":"Status changed from uninitialized to yellow - Waiting for Elasticsearch","prevState":"uninitialized","prevMsg":"uninitialized"}











## Inspect the app pod and identify the number of containers in it.

It is deployed in the elastic-stack namespace.

controlplane ~ ➜  kubectl get pods -n elastic-stack
NAME             READY   STATUS    RESTARTS   AGE
app              1/1     Running   0          16m
elastic-search   1/1     Running   0          16m
kibana           1/1     Running   0          16m

controlplane ~ ➜  


- RESPOSTA
1












## The application outputs logs to the file /log/app.log. View the logs and try to identify the user having issues with Login.

Inspect the log file inside the pod.



controlplane ~ ➜  kubectl logs app -n elastic-stack
[2023-04-19 23:38:56,231] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:38:56,231] INFO in event-simulator: USER4 is viewing page1
[2023-04-19 23:38:57,232] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-04-19 23:38:57,233] INFO in event-simulator: USER1 logged out
[2023-04-19 23:38:58,234] INFO in event-simulator: USER1 is viewing page1
[2023-04-19 23:38:59,235] INFO in event-simulator: USER3 is viewing page3
[2023-04-19 23:39:00,236] INFO in event-simulator: USER1 logged out
[2023-04-19 23:39:01,237] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:39:01,237] INFO in event-simulator: USER4 logged in
[2023-04-19 23:39:02,238] INFO in event-simulator: USER3 is viewing page3
[2023-04-19 23:39:03,239] INFO in event-simulator: USER3 is viewing page2
[2023-04-19 23:39:04,240] INFO in event-simulator: USER1 is viewing page1
[2023-04-19 23:39:05,241] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-04-19 23:39:05,242] INFO in event-simulator: USER3 is viewing page3
[2023-04-19 23:39:06,242] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:39:06,243] INFO in event-simulator: USER3 logged in
[2023-04-19 23:39:07,244] INFO in event-simulator: USER3 is viewing page1
[2023-04-19 23:39:08,245] INFO in event-simulator: USER2 is viewing page2
[2023-04-19 23:39:09,246] INFO in event-simulator: USER2 is viewing page1
[2023-04-19 23:39:10,248] INFO in event-simulator: USER1 is viewing page1
[2023-04-19 23:39:11,249] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:39:11,249] INFO in event-simulator: USER4 logged out
[2023-04-19 23:39:12,250] INFO in event-simulator: USER1 is viewing page3
[2023-04-19 23:39:13,252] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-04-19 23:39:13,252] INFO in event-simulator: USER1 is viewing page1
[2023-04-19 23:39:14,253] INFO in event-simulator: USER2 logged in
[2023-04-19 23:39:15,254] INFO in event-simulator: USER3 is viewing page3
[2023-04-19 23:39:16,256] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:39:16,256] INFO in event-simulator: USER4 logged out
[2023-04-19 23:39:17,257] INFO in event-simulator: USER3 is viewing page1
[2023-04-19 23:39:18,258] INFO in event-simulator: USER4 logged in
[2023-04-19 23:39:19,260] INFO in event-simulator: USER2 is viewing page3
[2023-04-19 23:39:20,261] INFO in event-simulator: USER1 is viewing page3
[2023-04-19 23:39:21,262] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:39:21,282] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-04-19 23:39:21,282] INFO in event-simulator: USER3 logged in
[2023-04-19 23:39:22,284] INFO in event-simulator: USER3 logged out
[2023-04-19 23:39:23,285] INFO in event-simulator: USER4 is viewing page1
[2023-04-19 23:39:24,286] INFO in event-simulator: USER1 logged out
[2023-04-19 23:39:25,288] INFO in event-simulator: USER1 is viewing page1
[2023-04-19 23:39:26,288] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-04-19 23:39:26,289] INFO in event-simulator: USER2 logged out

controlplane ~ ➜  


- RESPOSTA
USER5


















## Edit the pod to add a sidecar container to send logs to Elastic Search. Mount the log volume to the sidecar container.

Only add a new container. Do not modify anything else. Use the spec provided below.

    Note: State persistence concepts are discussed in detail later in this course. For now please make use of the below documentation link for updating the concerning pod.

https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/

    Name: app

    Container Name: sidecar

    Container Image: kodekloud/filebeat-configured

    Volume Mount: log-volume

    Mount Path: /var/log/event-simulator/

    Existing Container Name: app

    Existing Container Image: kodekloud/event-simulator



controlplane ~ ➜  kubectl get pods -n elastic-stack
NAME             READY   STATUS    RESTARTS   AGE
app              1/1     Running   0          22m
elastic-search   1/1     Running   0          22m
kibana           1/1     Running   0          22m

controlplane ~ ➜  date
Wed 19 Apr 2023 07:43:54 PM EDT

controlplane ~ ➜  
controlplane ~ ➜  

controlplane ~ ➜  kubectl get pod app -n elastic-stack -o yaml > app-pod.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cat app-pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-04-19T23:21:27Z"
  labels:
    name: app
  name: app
  namespace: elastic-stack
  resourceVersion: "1056"
  uid: 28c30c1f-ec98-4165-8cbf-cc00d167edb8
spec:
  containers:
  - image: kodekloud/event-simulator
    imagePullPolicy: Always
    name: app
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /log
      name: log-volume
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-w59ff
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
  - hostPath:
      path: /var/log/webapp
      type: DirectoryOrCreate
    name: log-volume
  - name: kube-api-access-w59ff
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
    lastTransitionTime: "2023-04-19T23:21:27Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-04-19T23:21:59Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-04-19T23:21:59Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-04-19T23:21:27Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://7f92324351d1109d136e579fde98402de27bdee2fd92b1f2adc1ef1405709b6c
    image: docker.io/kodekloud/event-simulator:latest
    imageID: docker.io/kodekloud/event-simulator@sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
    lastState: {}
    name: app
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-04-19T23:21:58Z"
  hostIP: 192.1.110.6
  phase: Running
  podIP: 10.244.0.5
  podIPs:
  - ip: 10.244.0.5
  qosClass: BestEffort
  startTime: "2023-04-19T23:21:27Z"

controlplane ~ ➜  




- EXEMPLO
https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/
<https://kubernetes.io/docs/tasks/access-application-cluster/communicate-containers-same-pod-shared-volume/>
Creating a Pod that runs two Containers
In this exercise, you create a Pod that runs two Containers. The two containers share a Volume that they can use to communicate. Here is the configuration file for the Pod:

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: two-containers
spec:

  restartPolicy: Never

  volumes:
  - name: shared-data
    emptyDir: {}

  containers:

  - name: nginx-container
    image: nginx
    volumeMounts:
    - name: shared-data
      mountPath: /usr/share/nginx/html

  - name: debian-container
    image: debian
    volumeMounts:
    - name: shared-data
      mountPath: /pod-data
    command: ["/bin/sh"]
    args: ["-c", "echo Hello from the debian container > /pod-data/index.html"]
~~~~







- EDITADO

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: app
  name: app
  namespace: elastic-stack
spec:
  containers:
  - image: kodekloud/event-simulator
    imagePullPolicy: Always
    name: app
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /log
      name: log-volume
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-w59ff
      readOnly: true
  - name: sidecar
    image: kodekloud/filebeat-configured
    volumeMounts:
    - name: log-volume
      mountPath: /var/log/event-simulator/
#    command: ["/bin/sh"]
#    args: ["-c", "echo Hello from the debian container > /pod-data/index.html"]
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
  - hostPath:
      path: /var/log/webapp
      type: DirectoryOrCreate
    name: log-volume
  - name: kube-api-access-w59ff
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

~~~~


controlplane ~ ➜  vi app-editado.yaml

controlplane ~ ➜  kubectl apply -f app-editado.yaml
Warning: resource pods/app is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
The Pod "app" is invalid: spec.containers: Forbidden: pod updates may not add or remove containers

controlplane ~ ✖ kubectl delete -f app-editado.yaml
pod "app" deleted


controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f app-editado.yaml
pod/app created

controlplane ~ ➜  
















## Inspect the Kibana UI. You should now see logs appearing in the Discover section.

You might have to wait for a couple of minutes for the logs to populate. You might have to create an index pattern to list the logs. If not sure check this video: https://bit.ly/2EXYdHf




- No Kibana em "Discover", trouxe os logs:

April 19th 2023, 21:08:13.826

@timestamp:
    April 19th 2023, 21:08:13.826
host.name:
    alpha-n2-worker3
source:
    /var/log/event-simulator/app.log
offset:
    282,598
message:
    [2023-04-19 23:43:51,640] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
prospector.type:
    log
input.type:
    log
beat.name:
    alpha-n2-worker3
beat.hostname:
    alpha-n2-worker3
beat.version:
    6.4.2
_id:
    IH_9m4cBzsTfkN5jkqod
_type:
    doc
_index:
    filebeat-6.4.2-2023.04.20
_score:
    2

April 19th 2023, 21:08:13.826

@timestamp:
    April 19th 2023, 21:08:13.826
source:
    /var/log/event-simulator/app.log
offset:
    283,979
message:
    [2023-04-19 23:43:58,647] INFO in event-simulator: USER1 logged in
prospector.type:
    log
input.type:
    log
beat.name:
    alpha-n2-worker3
beat.hostname:
    alpha-n2-worker3
beat.version:
    6.4.2
host.name:
    alpha-n2-worker3
_id:
    MX_9m4cBzsTfkN5jkqod
_type:
    doc
_index:
    filebeat-6.4.2-2023.04.20
_score:
    2

April 19th 2023, 21:08:13.826

@timestamp:
    April 19th 2023, 21:08:13.826
source:
    /var/log/event-simulator/app.log
offset:
    284,046
message:
    [2023-04-19 23:43:58,650] INFO in event-simulator: USER2 is viewing page1
input.type:
    log
prospector.type:
    log
beat.version:
    6.4.2
beat.name:
    alpha-n2-worker3
beat.hostname:
    alpha-n2-worker3
host.name:
    alpha-n2-worker3
_id:
    Mn_9m4cBzsTfkN5jkqod
_type:
    doc
_index:
    filebeat-6.4.2-2023.04.20
_score:
    2 

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "115. Practice Test - Init Containers"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
#  115. Practice Test - Init Containers

Identify the pod that has an initContainer configured.


controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-5d56847996-b8l9f   1/1     Running     0          24m
kube-system   coredns-5c6b6c5476-xtqr5                  1/1     Running     0          24m
kube-system   helm-install-traefik-crd-4ml9q            0/1     Completed   0          24m
kube-system   helm-install-traefik-zxwmv                0/1     Completed   1          24m
kube-system   svclb-traefik-9fd7bcad-2cw6g              2/2     Running     0          24m
kube-system   metrics-server-7b67f64457-k5tdm           1/1     Running     0          24m
kube-system   traefik-56b8c5fb5c-sknl6                  1/1     Running     0          24m
default       red                                       1/1     Running     0          2m9s
default       green                                     2/2     Running     0          2m9s
default       blue                                      1/1     Running     0          2m9s

controlplane ~ ➜  date
Tue May  2 23:44:25 UTC 2023

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pod red -o yaml | grep init

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get pod green -o yaml | grep init

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ 

controlplane ~ ✖ kubectl get pod blue -o yaml | grep init
  initContainers:
    name: init-myservice
  initContainerStatuses:
    name: init-myservice

controlplane ~ ➜  date
Tue May  2 23:46:05 UTC 2023

controlplane ~ ➜  



- RESPOSTA:?
Blue












What is the image used by the initContainer on the blue pod?



controlplane ~ ➜  kubectl get pod blue -o yaml | grep image
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    image: busybox
    imagePullPolicy: Always
    image: docker.io/library/busybox:1.28
    imageID: docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    image: docker.io/library/busybox:latest
    imageID: docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16

controlplane ~ ➜  kubectl get pod blue -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-05-02T23:42:13Z"
  name: blue
  namespace: default
  resourceVersion: "1062"
  uid: 24bc49eb-5b3e-413c-b020-ef53e2e36adb
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: green-container-1
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-qs6hx
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  initContainers:
  - command:
    - sh
    - -c
    - sleep 5
    image: busybox
    imagePullPolicy: Always
    name: init-myservice
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-qs6hx
      readOnly: true
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
  - name: kube-api-access-qs6hx
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
    lastTransitionTime: "2023-05-02T23:42:21Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-05-02T23:42:22Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-05-02T23:42:22Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-05-02T23:42:13Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://62a922aacc2fb2ca416521fc7faee0b55b38ec342268631b0cd91a0c4d08933f
    image: docker.io/library/busybox:1.28
    imageID: docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    lastState: {}
    name: green-container-1
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-05-02T23:42:22Z"
  hostIP: 172.25.0.50
  initContainerStatuses:
  - containerID: containerd://b3ae7adad494d18d1aeeba5e10fdf963f1619f5150ca51d4ac85f55b9ed35093
    image: docker.io/library/busybox:latest
    imageID: docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    lastState: {}
    name: init-myservice
    ready: true
    restartCount: 0
    state:
      terminated:
        containerID: containerd://b3ae7adad494d18d1aeeba5e10fdf963f1619f5150ca51d4ac85f55b9ed35093
        exitCode: 0
        finishedAt: "2023-05-02T23:42:21Z"
        reason: Completed
        startedAt: "2023-05-02T23:42:16Z"
  phase: Running
  podIP: 10.42.0.11
  podIPs:
  - ip: 10.42.0.11
  qosClass: BestEffort
  startTime: "2023-05-02T23:42:13Z"

controlplane ~ ➜  



- Resposta:
busybox











What is the state of the initContainer on pod blue?

controlplane ~ ➜  kubectl describe pod blue
Name:             blue
Namespace:        default
Priority:         0
Service Account:  default
Node:             controlplane/172.25.0.50
Start Time:       Tue, 02 May 2023 23:42:13 +0000
Labels:           <none>
Annotations:      <none>
Status:           Running
IP:               10.42.0.11
IPs:
  IP:  10.42.0.11
Init Containers:
  init-myservice:
    Container ID:  containerd://b3ae7adad494d18d1aeeba5e10fdf963f1619f5150ca51d4ac85f55b9ed35093
    Image:         busybox
    Image ID:      docker.io/library/busybox@sha256:b5d6fe0712636ceb7430189de28819e195e8966372edfc2d9409d79402a0dc16
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      sleep 5
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Tue, 02 May 2023 23:42:16 +0000
      Finished:     Tue, 02 May 2023 23:42:21 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-qs6hx (ro)
Containers:
  green-container-1:
    Container ID:  containerd://62a922aacc2fb2ca416521fc7faee0b55b38ec342268631b0cd91a0c4d08933f
    Image:         busybox:1.28
    Image ID:      docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      echo The app is running! && sleep 3600
    State:          Running
      Started:      Tue, 02 May 2023 23:42:22 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-qs6hx (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  kube-api-access-qs6hx:
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
  Normal  Scheduled  7m22s  default-scheduler  Successfully assigned default/blue to controlplane
  Normal  Pulling    7m21s  kubelet            Pulling image "busybox"
  Normal  Pulled     7m19s  kubelet            Successfully pulled image "busybox" in 1.693766474s (1.693788315s including waiting)
  Normal  Created    7m19s  kubelet            Created container init-myservice
  Normal  Started    7m19s  kubelet            Started container init-myservice
  Normal  Pulled     7m14s  kubelet            Container image "busybox:1.28" already present on machine
  Normal  Created    7m14s  kubelet            Created container green-container-1
  Normal  Started    7m13s  kubelet            Started container green-container-1

controlplane ~ ➜  













Why is the initContainer terminated? What is the reason?


- RESPOSTA:
The process completed successfuly!















We just created a new app named purple. How many initContainers does it have?



controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-5d56847996-b8l9f   1/1     Running     0          31m
kube-system   coredns-5c6b6c5476-xtqr5                  1/1     Running     0          31m
kube-system   helm-install-traefik-crd-4ml9q            0/1     Completed   0          31m
kube-system   helm-install-traefik-zxwmv                0/1     Completed   1          31m
kube-system   svclb-traefik-9fd7bcad-2cw6g              2/2     Running     0          30m
kube-system   metrics-server-7b67f64457-k5tdm           1/1     Running     0          31m
kube-system   traefik-56b8c5fb5c-sknl6                  1/1     Running     0          30m
default       red                                       1/1     Running     0          8m38s
default       green                                     2/2     Running     0          8m38s
default       blue                                      1/1     Running     0          8m38s
default       purple                  



controlplane ~ ✖ kubectl get pod purple -o yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-05-02T23:50:33Z"
  name: purple
  namespace: default
  resourceVersion: "1217"
  uid: 187c6651-b914-4b6e-adc4-5fc1d963998f
spec:
  containers:
  - command:
    - sh
    - -c
    - echo The app is running! && sleep 3600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: purple-container
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-rx42t
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  initContainers:
  - command:
    - sh
    - -c
    - sleep 600
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: warm-up-1
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-rx42t
      readOnly: true
  - command:
    - sh
    - -c
    - sleep 1200
    image: busybox:1.28
    imagePullPolicy: IfNotPresent
    name: warm-up-2
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-rx42t
      readOnly: true
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
  - name: kube-api-access-rx42t
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
    lastTransitionTime: "2023-05-02T23:50:33Z"
    message: 'containers with incomplete status: [warm-up-1 warm-up-2]'
    reason: ContainersNotInitialized
    status: "False"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-05-02T23:50:33Z"
    message: 'containers with unready status: [purple-container]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-05-02T23:50:33Z"
    message: 'containers with unready status: [purple-container]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-05-02T23:50:33Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - image: busybox:1.28
    imageID: ""
    lastState: {}
    name: purple-container
    ready: false
    restartCount: 0
    started: false
    state:
      waiting:
        reason: PodInitializing
  hostIP: 172.25.0.50
  initContainerStatuses:
  - containerID: containerd://1b2ed82586b44adb46231769a45b919cfb4ef617f79e38ecea4715898aec8b1f
    image: docker.io/library/busybox:1.28
    imageID: docker.io/library/busybox@sha256:141c253bc4c3fd0a201d32dc1f493bcf3fff003b6df416dea4f41046e0f37d47
    lastState: {}
    name: warm-up-1
    ready: false
    restartCount: 0
    state:
      running:
        startedAt: "2023-05-02T23:50:34Z"
  - image: busybox:1.28
    imageID: ""
    lastState: {}
    name: warm-up-2
    ready: false
    restartCount: 0
    state:
      waiting:
        reason: PodInitializing
  phase: Pending
  podIP: 10.42.0.12
  podIPs:
  - ip: 10.42.0.12
  qosClass: BestEffort
  startTime: "2023-05-02T23:50:33Z"

controlplane ~ ➜  


- RESPOSTA:
2













What is the state of the POD?

- RESPOSTA:
Pending










How long after the creation of the POD will the application come up and be available to users?

resposta errada:
20minutos

600 segundos também está errado
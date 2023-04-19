
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
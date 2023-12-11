
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# push

git status
git add .
git commit -m "175. Practice Test - Security Contexts."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 175. Practice Test - Security Contexts

What is the user used to execute the sleep process within the ubuntu-sleeper pod?

In the current(default) namespace.



controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          31s

controlplane ~ ➜  

controlplane ~ ✖ kubectl get pod ubuntu-sleeper -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-12-11T00:20:53Z"
  name: ubuntu-sleeper
  namespace: default
  resourceVersion: "969"
  uid: 75f28913-721a-4596-b462-c7677265eef2
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
      name: kube-api-access-gqm4d
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
  - name: kube-api-access-gqm4d
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
    lastTransitionTime: "2023-12-11T00:20:53Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-12-11T00:20:57Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-12-11T00:20:57Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-12-11T00:20:53Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://f69cf15f70ebdec4002df67e447f1b34de69bf9344bad7a7f36fdb55ccb7cc7f
    image: docker.io/library/ubuntu:latest
    imageID: docker.io/library/ubuntu@sha256:8eab65df33a6de2844c9aefd19efe8ddb87b7df5e9185a4ab73af936225685bb
    lastState: {}
    name: ubuntu
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-12-11T00:20:56Z"
  hostIP: 192.2.40.9
  phase: Running
  podIP: 10.42.0.9
  podIPs:
  - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-12-11T00:20:53Z"

controlplane ~ ➜  











Edit the pod ubuntu-sleeper to run the sleep process with user ID 1010.

Note: Only make the necessary changes. Do not modify the name or image of the pod.
Pod Name: ubuntu-sleeper

Image Name: ubuntu

SecurityContext: User 1010



- Exemplo de conf

apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-2
spec:
  securityContext:
    runAsUser: 1000
  containers:
  - name: sec-ctx-demo-2
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      runAsUser: 2000
      allowPrivilegeEscalation: false










    securityContext:
      runAsUser: 1010



controlplane ~ ✖ kubectl edit pod ubuntu-sleeper
Edit cancelled, no changes made.

controlplane ~ ➜  





  securityContext:
    runAsUser: 1010




controlplane ~ ➜  kubectl edit pod ubuntu-sleeper
Edit cancelled, no changes made.

controlplane ~ ➜  




/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/175-pod-editado.yaml


apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
spec:
  securityContext:
    runAsUser: 1010
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
      name: kube-api-access-gqm4d
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
  - name: kube-api-access-gqm4d
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


controlplane ~ ➜  vi pod-editado.yaml

controlplane ~ ➜  kubectl delete -f pod-editado.yaml
pod "ubuntu-sleeper" deleted


controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod-editado.yaml
pod/ubuntu-sleeper created

controlplane ~ ➜  date
Mon Dec 11 00:30:30 UTC 2023

controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          4s

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pod ubuntu-sleeper -o yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"ubuntu-sleeper","namespace":"default"},"spec":{"containers":[{"command":["sleep","4800"],"image":"ubuntu","imagePullPolicy":"Always","name":"ubuntu","resources":{},"terminationMessagePath":"/dev/termination-log","terminationMessagePolicy":"File","volumeMounts":[{"mountPath":"/var/run/secrets/kubernetes.io/serviceaccount","name":"kube-api-access-gqm4d","readOnly":true}]}],"dnsPolicy":"ClusterFirst","enableServiceLinks":true,"nodeName":"controlplane","preemptionPolicy":"PreemptLowerPriority","priority":0,"restartPolicy":"Always","schedulerName":"default-scheduler","securityContext":{},"serviceAccount":"default","serviceAccountName":"default","terminationGracePeriodSeconds":30,"tolerations":[{"effect":"NoExecute","key":"node.kubernetes.io/not-ready","operator":"Exists","tolerationSeconds":300},{"effect":"NoExecute","key":"node.kubernetes.io/unreachable","operator":"Exists","tolerationSeconds":300}],"volumes":[{"name":"kube-api-access-gqm4d","projected":{"defaultMode":420,"sources":[{"serviceAccountToken":{"expirationSeconds":3607,"path":"token"}},{"configMap":{"items":[{"key":"ca.crt","path":"ca.crt"}],"name":"kube-root-ca.crt"}},{"downwardAPI":{"items":[{"fieldRef":{"apiVersion":"v1","fieldPath":"metadata.namespace"},"path":"namespace"}]}}]}}]}}
  creationTimestamp: "2023-12-11T00:30:28Z"
  name: ubuntu-sleeper
  namespace: default
  resourceVersion: "1153"
  uid: 581b7ccd-844b-45e8-9510-52d54e2a487d
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
      name: kube-api-access-gqm4d
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
  - name: kube-api-access-gqm4d
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
    lastTransitionTime: "2023-12-11T00:30:28Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-12-11T00:30:30Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-12-11T00:30:30Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-12-11T00:30:28Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://f45ce695dd5c85e4f3f708bf56c124262bc81c65ff08d23dc91d6b4c31dfa2de
    image: docker.io/library/ubuntu:latest
    imageID: docker.io/library/ubuntu@sha256:8eab65df33a6de2844c9aefd19efe8ddb87b7df5e9185a4ab73af936225685bb
    lastState: {}
    name: ubuntu
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-12-11T00:30:29Z"
  hostIP: 192.2.40.9
  phase: Running
  podIP: 10.42.0.10
  podIPs:
  - ip: 10.42.0.10
  qosClass: BestEffort
  startTime: "2023-12-11T00:30:28Z"

controlplane ~ ➜  





ajustado novamente
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/175-pod-editado.yaml


apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
spec:
  securityContext:
    runAsUser: 1010
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
      name: kube-api-access-gqm4d
      readOnly: true
    securityContext:
      runAsUser: 1010
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
  - name: kube-api-access-gqm4d
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



controlplane ~ ➜  kubectl delete -f pod-editado.yaml
pod "ubuntu-sleeper" deleted




controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod-editado.yaml
pod/ubuntu-sleeper created

controlplane ~ ➜  kubectl get pdos
error: the server doesn't have a resource type "pdos"

controlplane ~ ✖ kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          15s

controlplane ~ ➜  


OK,
agora aceitou.





















A Pod definition file named multi-pod.yaml is given. With what user are the processes in the web container started?

The pod is created with multiple containers and security contexts defined at the Pod and Container level.




controlplane ~ ➜  cat multi-pod.yaml 
apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  securityContext:
    runAsUser: 1001
  containers:
  -  image: ubuntu
     name: web
     command: ["sleep", "5000"]
     securityContext:
      runAsUser: 1002

  -  image: ubuntu
     name: sidecar
     command: ["sleep", "5000"]


controlplane ~ ➜  

















With what user are the processes in the sidecar container started?

The pod is created with multiple containers and security contexts defined at the Pod and Container level.

1001
















Update pod ubuntu-sleeper to run as Root user and with the SYS_TIME capability.

Note: Only make the necessary changes. Do not modify the name of the pod.

    Pod Name: ubuntu-sleeper

    Image Name: ubuntu

    SecurityContext: Capability SYS_TIME

    Is run as a root user?



- Exemplo

<https://kubernetes.io/docs/tasks/configure-pod-container/security-context/>

apiVersion: v1
kind: Pod
metadata:
  name: security-context-demo-4
spec:
  containers:
  - name: sec-ctx-4
    image: gcr.io/google-samples/node-hello:1.0
    securityContext:
      capabilities:
        add: ["NET_ADMIN", "SYS_TIME"]


- Ajustado

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao7-Security/175-pod-editado-v2.yaml

apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
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
      name: kube-api-access-gqm4d
      readOnly: true
    securityContext:
      capabilities:
        add: ["SYS_TIME"]
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
  - name: kube-api-access-gqm4d
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



controlplane ~ ➜  vi pod2.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod2.yaml
The Pod "ubuntu-sleeper" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`,`spec.initContainers[*].image`,`spec.activeDeadlineSeconds`,`spec.tolerations` (only additions to existing tolerations),`spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes:        {{Name: "kube-api-access-gqm4d", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}}},
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 17 identical fields
                        TerminationMessagePolicy: "File",
                        ImagePullPolicy:          "Always",
                        SecurityContext: &core.SecurityContext{
-                               Capabilities:   nil,
+                               Capabilities:   &core.Capabilities{Add: []core.Capability{"SYS_TIME"}},
                                Privileged:     nil,
                                SELinuxOptions: nil,
                                WindowsOptions: nil,
-                               RunAsUser:      &1010,
+                               RunAsUser:      nil,
                                RunAsGroup:     nil,
                                RunAsNonRoot:   nil,
                                ... // 4 identical fields
                        },
                        Stdin:     false,
                        StdinOnce: false,
                        TTY:       false,
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 28 identical fields
  }


controlplane ~ ✖ kubectl delete -f pod2.yaml
pod "ubuntu-sleeper" deleted



controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod2.yaml
pod/ubuntu-sleeper created

controlplane ~ ➜  
controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          16s

controlplane ~ ➜  









Now update the pod to also make use of the NET_ADMIN capability.

Note: Only make the necessary changes. Do not modify the name of the pod.

    Pod Name: ubuntu-sleeper

    Image Name: ubuntu

    SecurityContext: Capability SYS_TIME

    SecurityContext: Capability 


- Ajustado


apiVersion: v1
kind: Pod
metadata:
  name: ubuntu-sleeper
  namespace: default
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
      name: kube-api-access-gqm4d
      readOnly: true
    securityContext:
      capabilities:
        add: ["SYS_TIME", "NET_ADMIN"]
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
  - name: kube-api-access-gqm4d
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




controlplane ~ ➜  kubectl delete -f pod2.yaml
pod "ubuntu-sleeper" deleted
^[[A^[[A





controlplane ~ ➜  vi pod2.yaml

controlplane ~ ➜  kubectl apply -f pod2.yaml
pod/ubuntu-sleeper created

controlplane ~ ➜  kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
ubuntu-sleeper   1/1     Running   0          4s

controlplane ~ ➜  
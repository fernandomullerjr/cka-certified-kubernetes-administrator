
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





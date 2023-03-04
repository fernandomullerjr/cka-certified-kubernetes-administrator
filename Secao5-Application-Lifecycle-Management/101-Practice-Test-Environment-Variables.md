
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "Aula 101. Practice Test: Environment Variables"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 101. Practice Test: Environment Variables




How many PODs exist on the system?

in the current(default) namespace


controlplane ~ ➜  kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          22s

controlplane ~ ➜  











What is the environment variable name set on the container in the pod?


controlplane ~ ➜  

controlplane ~ ➜  kubectl get pod webapp-color -o yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-03-01T23:37:15Z"
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
  resourceVersion: "902"
  uid: e02f4e28-9fa4-4a6e-8d35-46b99d45a166
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: pink
    image: kodekloud/webapp-color
    imagePullPolicy: Always
    name: webapp-color
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-4wq6t
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
  - name: kube-api-access-4wq6t
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
    lastTransitionTime: "2023-03-01T23:37:15Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-03-01T23:37:21Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-03-01T23:37:21Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-03-01T23:37:15Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://0df8e232bea7d42b650728d2004a828ecb2bd3067de8e97bb0686d5b8bae2de4
    image: docker.io/kodekloud/webapp-color:latest
    imageID: docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
    lastState: {}
    name: webapp-color
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-03-01T23:37:20Z"
  hostIP: 172.25.0.15
  phase: Running
  podIP: 10.42.0.9
  podIPs:
  - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-01T23:37:15Z"

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  







What is the value set on the environment variable APP_COLOR on the container in the pod?


spec:
  containers:
  - env:
    - name: APP_COLOR
      value: pink












View the web application UI by clicking on the Webapp Color Tab above your terminal.

This is located on the right side.


Acessei:
https://30080-port-cd4024e9fe43444d.labs.kodekloud.com/


Hello from webapp-color!

















Update the environment variable on the POD to display a green background

Note: Delete and recreate the POD. Only make the necessary changes. Do not modify the name of the Pod.

    Pod Name: webapp-color

    Label Name: webapp-color

    Env: APP_COLOR=green



controlplane ~ ➜  kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          7m16s

controlplane ~ ➜  



- Erro, editando direto

kubectl edit pod webapp-color

~~~~bash
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
# pods "webapp-color" was not valid:
# * spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
#   core.PodSpec{
#     Volumes:        {{Name: "kube-api-access-4wq6t", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}}},
#     InitContainers: nil,
#     Containers: []core.Container{
#       {
#         ... // 5 identical fields
#         Ports:   nil,
#         EnvFrom: nil,
#         Env: []core.EnvVar{
#           {
#             Name:      "APP_COLOR",
# -           Value:     "pink",
# +           Value:     "green",
#             ValueFrom: nil,
#           },
#         },
#         Resources:    {},
#         VolumeMounts: {{Name: "kube-api-access-4wq6t", ReadOnly: true, MountPath: "/var/run/secrets/kubernetes.io/serviceaccount"}},
#         ... // 12 identical fields
#       },
#     },
#     EphemeralContainers: nil,
#     RestartPolicy:       "Always",
#     ... // 28 identical fields
#   }

#
apiVersion: v1
kind: Pod
~~~~



# captures all elements and attributes, even internal accounting
kubectl get pod <podname> -n <namespace> -o=yaml > my-object.yaml

There are utilities such as kubectl-neat that can be used, but you can also use the jq utility to remove these elements.  Below is the jq command to delete the elements, then yq to convert back to yaml.

kubectl get pod <podname> -n <namespace> -o=json | jq 'del(.metadata.resourceVersion,.metadata.uid,.metadata.selfLink,.metadata.creationTimestamp,.metadata.annotations,.metadata.generation,.metadata.ownerReferences)' | yq eval - -P > my-object.cleaned.yaml


kubectl get pod <podname> -n <namespace> -o=json | jq 'del(.metadata.resourceVersion,.metadata.uid,.metadata.selfLink,.metadata.creationTimestamp,.metadata.annotations,.metadata.generation,.metadata.ownerReferences)' | yq eval - -P > my-object.cleaned.yaml


kubectl get pod webapp-color -n default -o=json | jq 'del(.metadata.resourceVersion,.metadata.uid,.metadata.selfLink,.metadata.creationTimestamp,.metadata.annotations,.metadata.generation,.metadata.ownerReferences)' | yq eval - -P > my-object.cleaned.yaml


controlplane ~ ✖ kubectl get pod webapp-color -n default -o=json | jq 'del(.metadata.resourceVersion,.metadata.uid,.metadata.selfLink,.metadata.creationTimestamp,.metadata.annotations,.metadata.generation,.metadata.ownerReferences)' | yq eval - -P > my-object.cleaned.yaml

controlplane ~ ➜  ls
my-object.cleaned.yaml  sample.yaml

controlplane ~ ➜  cat my-object.cleaned.yaml 
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
    - env:
        - name: APP_COLOR
          value: pink
      image: kodekloud/webapp-color
      imagePullPolicy: Always
      name: webapp-color
      resources: {}
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
        - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          name: kube-api-access-4wq6t
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
    - name: kube-api-access-4wq6t
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
      lastTransitionTime: "2023-03-01T23:37:15Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-03-01T23:37:21Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-03-01T23:37:21Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-03-01T23:37:15Z"
      status: "True"
      type: PodScheduled
  containerStatuses:
    - containerID: containerd://0df8e232bea7d42b650728d2004a828ecb2bd3067de8e97bb0686d5b8bae2de4
      image: docker.io/kodekloud/webapp-color:latest
      imageID: docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
      lastState: {}
      name: webapp-color
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-03-01T23:37:20Z"
  hostIP: 172.25.0.15
  phase: Running
  podIP: 10.42.0.9
  podIPs:
    - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-01T23:37:15Z"

controlplane ~ ➜  







kubectl get pod webapp-color -o yaml > objeto-completo.yaml

controlplane ~ ✖ kubectl get pod webapp-color -o yaml > objeto-completo.yaml

controlplane ~ ➜  cat objeto-completo.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: "2023-03-01T23:37:15Z"
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
  resourceVersion: "902"
  uid: e02f4e28-9fa4-4a6e-8d35-46b99d45a166
spec:
  containers:
  - env:
    - name: APP_COLOR
      value: pink
    image: kodekloud/webapp-color
    imagePullPolicy: Always
    name: webapp-color
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-4wq6t
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
  - name: kube-api-access-4wq6t
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
    lastTransitionTime: "2023-03-01T23:37:15Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2023-03-01T23:37:21Z"
    status: "True"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2023-03-01T23:37:21Z"
    status: "True"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2023-03-01T23:37:15Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://0df8e232bea7d42b650728d2004a828ecb2bd3067de8e97bb0686d5b8bae2de4
    image: docker.io/kodekloud/webapp-color:latest
    imageID: docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
    lastState: {}
    name: webapp-color
    ready: true
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2023-03-01T23:37:20Z"
  hostIP: 172.25.0.15
  phase: Running
  podIP: 10.42.0.9
  podIPs:
  - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-01T23:37:15Z"

controlplane ~ ➜  



controlplane ~ ➜  ls
my-object.cleaned.yaml  objeto-completo.yaml    sample.yaml

controlplane ~ ➜  vi my-object.cleaned.yaml 

controlplane ~ ➜  kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          16m

controlplane ~ ➜  kubectl delete pod webapp-color
pod "webapp-color" deleted

controlplane ~ ➜  kubectl apply -f my-object.cleaned.yaml 
pod/webapp-color created

controlplane ~ ➜  

controlplane ~ ➜  
















View the changes to the web application UI by clicking on the Webapp Color Tab above your terminal.

If you already have it open, simply refresh the browser.

https://30080-port-cd4024e9fe43444d.labs.kodekloud.com/
Hello from webapp-color!























How many ConfigMaps exists in the default namespace?

controlplane ~ ➜  kubectl get configmaps
NAME               DATA   AGE
kube-root-ca.crt   1      33m
db-config          3      21s

controlplane ~ ➜  













Identify the database host from the config map db-config

controlplane ~ ➜  kubectl describe configmap db-config
Name:         db-config
Namespace:    default
Labels:       <none>
Annotations:  <none>

Data
====
DB_HOST:
----
SQL01.example.com
DB_NAME:
----
SQL01
DB_PORT:
----
3306

BinaryData
====

Events:  <none>

controlplane ~ ➜  

















Create a new ConfigMap for the webapp-color POD. Use the spec given below.

    ConfigName Name: webapp-config-map

    Data: APP_COLOR=darkblue



controlplane ~ ➜  kubectl get configmap db-config -o yaml
apiVersion: v1
data:
  DB_HOST: SQL01.example.com
  DB_NAME: SQL01
  DB_PORT: "3306"
kind: ConfigMap
metadata:
  creationTimestamp: "2023-03-01T23:56:00Z"
  name: db-config
  namespace: default
  resourceVersion: "1259"
  uid: aac7a60e-9942-4494-a51d-0fe063464362

controlplane ~ ➜  




- Exemplo:

~~~~YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  APP_COLOR: blue
  APP_MODE: prod
~~~~



- Editado:

~~~~YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: webapp-config-map
  namespace: default
data:
  APP_COLOR: darkblue
~~~~



controlplane ~ ➜  ls
my-object.cleaned.yaml  objeto-completo.yaml    sample.yaml

controlplane ~ ➜  vi configmap-editado.yaml

controlplane ~ ➜  kubectl apply -f configmap-editado.yaml
configmap/webapp-config-map created

controlplane ~ ➜  



- Outra opção seria criar via comando imperativo:

# Create ConfigMaps from literal values

~~~~bash
kubectl create configmap special-config --from-literal=special.how=very --from-literal=special.type=charm
~~~~


- Editado:

~~~~bash
kubectl create configmap webapp-config-map --from-literal=APP_COLOR=darkblue
~~~~









Update the environment variable on the POD to use the newly created ConfigMap

Note: Delete and recreate the POD. Only make the necessary changes. Do not modify the name of the Pod.

    Pod Name: webapp-color

    EnvFrom: webapp-config-map



controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-5d56847996-ww5q6   1/1     Running     0          40m
kube-system   coredns-5c6b6c5476-ffh7q                  1/1     Running     0          40m
kube-system   helm-install-traefik-crd-xrg9d            0/1     Completed   0          40m
kube-system   helm-install-traefik-jz4z8                0/1     Completed   1          40m
kube-system   svclb-traefik-337fd2c0-wgn87              2/2     Running     0          39m
kube-system   traefik-56b8c5fb5c-6qs6w                  1/1     Running     0          39m
kube-system   metrics-server-7b67f64457-df55b           1/1     Running     0          40m
default       webapp-color                              1/1     Running     0          8m27s

controlplane ~ ➜  kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          8m29s

controlplane ~ ➜  


controlplane ~ ➜  cat my-object.cleaned.yaml 
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
  namespace: default
spec:
  containers:
    - env:
        - name: APP_COLOR
          value: green
      image: kodekloud/webapp-color
      imagePullPolicy: Always
      name: webapp-color
      resources: {}
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
        - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          name: kube-api-access-4wq6t
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
    - name: kube-api-access-4wq6t
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
      lastTransitionTime: "2023-03-01T23:37:15Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-03-01T23:37:21Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-03-01T23:37:21Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-03-01T23:37:15Z"
      status: "True"
      type: PodScheduled
  containerStatuses:
    - containerID: containerd://0df8e232bea7d42b650728d2004a828ecb2bd3067de8e97bb0686d5b8bae2de4
      image: docker.io/kodekloud/webapp-color:latest
      imageID: docker.io/kodekloud/webapp-color@sha256:99c3821ea49b89c7a22d3eebab5c2e1ec651452e7675af243485034a72eb1423
      lastState: {}
      name: webapp-color
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-03-01T23:37:20Z"
  hostIP: 172.25.0.15
  phase: Running
  podIP: 10.42.0.9
  podIPs:
    - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-01T23:37:15Z"

controlplane ~ ➜  cp my-object.cleaned.yaml pod-com-configmap.yaml

controlplane ~ ➜  
controlplane ~ ➜  cp my-object.cleaned.yaml pod-com-configmap.yaml

controlplane ~ ➜  




controlplane ~ ➜  vi pod-com-configmap-v2.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
NAME           READY   STATUS    RESTARTS   AGE
webapp-color   1/1     Running   0          12m

controlplane ~ ➜  kubectl delete pod webapp-color
pod "webapp-color" deleted


controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod-com-configmap-v2.yaml
pod/webapp-color created

controlplane ~ ➜  















View the changes to the web application UI by clicking on the Webapp Color Tab above your terminal.

If you already have it open, simply refresh the browser.


https://30080-port-cd4024e9fe43444d.labs.kodekloud.com/

Hello from webapp-color!

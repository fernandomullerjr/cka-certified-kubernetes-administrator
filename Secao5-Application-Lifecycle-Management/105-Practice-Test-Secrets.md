
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "Aula 105. Practice Test - Secrets"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status





------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 105. Practice Test - Secrets


How many Secrets exist on the system?

In the current(default) namespace.
                                                   

controlplane ~ ➜  kubectl get secrets -A
NAMESPACE     NAME                                TYPE                                  DATA   AGE
kube-system   k3s-serving                         kubernetes.io/tls                     2      18m
kube-system   controlplane.node-password.k3s      Opaque                                1      18m
kube-system   sh.helm.release.v1.traefik-crd.v1   helm.sh/release.v1                    1      17m
kube-system   sh.helm.release.v1.traefik.v1       helm.sh/release.v1                    1      17m
default       dashboard-token                     kubernetes.io/service-account-token   3      96s

controlplane ~ ➜  


- RESPOSTA:
1








How many secrets are defined in the dashboard-token secret?

controlplane ~ ✖ kubectl get secret dashboard-token
NAME              TYPE                                  DATA   AGE
dashboard-token   kubernetes.io/service-account-token   3      2m36s

controlplane ~ ➜  kubectl describe secret dashboard-token
Name:         dashboard-token
Namespace:    default
Labels:       <none>
Annotations:  kubernetes.io/service-account.name: dashboard-sa
              kubernetes.io/service-account.uid: 9d9dfe58-107c-462b-8e90-5eca0bc89486

Type:  kubernetes.io/service-account-token

Data
====
ca.crt:     570 bytes
namespace:  7 bytes
token:      eyJhbGciOiJSUzI1NiIsImtpZCI6IjFJam5uNWxEX1RVSnJfRlg2RnNVN1BETlJmQ1BqLTdISFZTWlZiSlIwTkEifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJkZWZhdWx0Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9zZWNyZXQubmFtZSI6ImRhc2hib2FyZC10b2tlbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJkYXNoYm9hcmQtc2EiLCJrdWJlcm5ldGVzLmlvL3NlcnZpY2VhY2NvdW50L3NlcnZpY2UtYWNjb3VudC51aWQiOiI5ZDlkZmU1OC0xMDdjLTQ2MmItOGU5MC01ZWNhMGJjODk0ODYiLCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.klw-15U6f7kUCOxwy6r5_zRarOoKDj_ehD61yu7okh87lOxuxeCCwPcTPtrQ-u9fkyYy3382JtpKCrna09YB2YMU4GZh7MVQoKoHBuQkfL8DIHrHSdGwfpU7FXrWj-xyeAuIzDTZLyQaaq8biGOs2vXQe8dTWg3uXu8LxVT2opoljTFIhgIW-bZY60l27hSPB-krefamgUIvnG7YBRA5aj-sKqfeLeVF38hXS5PUk8D3LcYVrAtgjgMkX7lF36Q2IB3LMKcYXfaBm3JvaCOidN1CnnhhCPpQX8s2teZyJeDxvah6nI4-Ii-ghASFXgTKm2yKhLKQa53wvGIjEuiYFw

controlplane ~ ➜  


- RESPOSTA:
3












What is the type of the dashboard-token secret?


- resposta:
kubernetes.io/service-account-token














Which of the following is not a secret data defined in dashboard-token secret?

- RESPOSTA:
type














e are going to deploy an application with the below architecture

We have already deployed the required pods and services. Check out the pods and services created. Check out the web application using the Webapp MySQL link above your terminal, next to the Quiz Portal Link.



controlplane ~ ➜  kubectl get all
NAME             READY   STATUS    RESTARTS   AGE
pod/webapp-pod   1/1     Running   0          33s
pod/mysql        1/1     Running   0          33s

NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.43.0.1      <none>        443/TCP          21m
service/webapp-service   NodePort    10.43.177.41   <none>        8080:30080/TCP   33s
service/sql01            ClusterIP   10.43.200.71   <none>        3306/TCP         33s

controlplane ~ ➜  
















The reason the application is failed is because we have not created the secrets yet. Create a new secret named db-secret with the data given below.

You may follow any one of the methods discussed in lecture to create the secret.

    Secret Name: db-secret

    Secret 1: DB_Host=sql01

    Secret 2: DB_User=root

    Secret 3: DB_Password=password123

~~~~YAML
apiVersion: v1
kind: Secret
metadata:
 name: db-secret
data:
  DB_Host: sql01
  DB_User: root
  DB_Password: password123
~~~~


vi secret-manifest.yaml


controlplane ~ ➜  kubectl apply -f secret-manifest.yaml
Error from server (BadRequest): error when creating "secret-manifest.yaml": Secret in version "v1" cannot be handled as a Secret: illegal base64 data at input byte 4

controlplane ~ ✖ 



- Encriptando os valores:

~~~~bash
$ echo -n "sql01" | base64
$ echo -n "root" | base64
$ echo -n "password123"| base64


fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ echo -n "sql01" | base64
c3FsMDE=
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ echo -n "root" | base64
cm9vdA==
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$ echo -n "password123"| base64
cGFzc3dvcmQxMjM=
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator$

~~~~


vi secret-manifest.yaml

~~~~YAML
apiVersion: v1
kind: Secret
metadata:
 name: db-secret
data:
  DB_Host: c3FsMDE=
  DB_User: cm9vdA==
  DB_Password: cGFzc3dvcmQxMjM=
~~~~


controlplane ~ ➜  kubectl apply -f secret-manifest.yaml
secret/db-secret created

controlplane ~ ➜  
controlplane ~ ➜  kubectl get all
NAME             READY   STATUS    RESTARTS   AGE
pod/webapp-pod   1/1     Running   0          6m8s
pod/mysql        1/1     Running   0          6m8s

NAME                     TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
service/kubernetes       ClusterIP   10.43.0.1      <none>        443/TCP          27m
service/webapp-service   NodePort    10.43.177.41   <none>        8080:30080/TCP   6m8s
service/sql01            ClusterIP   10.43.200.71   <none>        3306/TCP         6m8s

controlplane ~ ➜  




https://30080-port-cfe76abc866c42e7.labs.kodekloud.com/

Failed connecting to the MySQL database.
Environment Variables: DB_Host=Not Set; DB_Database=Not Set; DB_User=Not Set; DB_Password=Not Set; 2003: Can't connect to MySQL server on 'localhost:3306' (111 Connection refused)

From webapp-pod!










Configure webapp-pod to load environment variables from the newly created secret.

Delete and recreate the pod if required.

    Pod name: webapp-pod

    Image name: kodekloud/simple-webapp-mysql

    Env From: Secret=db-secret



kubectl get pod webapp-pod -n default -o=json | jq 'del(.metadata.resourceVersion,.metadata.uid,.metadata.selfLink,.metadata.creationTimestamp,.metadata.annotations,.metadata.generation,.metadata.ownerReferences)' | yq eval - -P > my-object.cleaned.yaml

controlplane ~ ➜  cat my-object.cleaned.yaml 
~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-pod
  name: webapp-pod
  namespace: default
spec:
  containers:
    - image: kodekloud/simple-webapp-mysql
      imagePullPolicy: Always
      name: webapp
      resources: {}
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
        - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          name: kube-api-access-p8ngj
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
    - name: kube-api-access-p8ngj
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
      lastTransitionTime: "2023-03-29T01:34:34Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:44Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:44Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:34Z"
      status: "True"
      type: PodScheduled
  containerStatuses:
    - containerID: containerd://6fb0ad1a381485dcfb2085ba0171fc9584de8e8b6d7eabbcbcb9a9fc0c627e2d
      image: docker.io/kodekloud/simple-webapp-mysql:latest
      imageID: docker.io/kodekloud/simple-webapp-mysql@sha256:92943d2b3ea4a1db7c8a9529cd5786ae3b9999e0246ab665c29922e9800d1b41
      lastState: {}
      name: webapp
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-03-29T01:34:44Z"
  hostIP: 172.25.0.55
  phase: Running
  podIP: 10.42.0.9
  podIPs:
    - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-29T01:34:34Z"
~~~~
controlplane ~ ➜  








    envFrom:
    - secretRef:
        name: app-secret




- Editado

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-pod
  name: webapp-pod
  namespace: default
spec:
  containers:
    - image: kodekloud/simple-webapp-mysql
      imagePullPolicy: Always
      name: webapp
      resources: {}
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
        - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          name: kube-api-access-p8ngj
          readOnly: true
  envFrom:
    - secretRef:
        name: app-secret
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
    - name: kube-api-access-p8ngj
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
      lastTransitionTime: "2023-03-29T01:34:34Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:44Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:44Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:34Z"
      status: "True"
      type: PodScheduled
  containerStatuses:
    - containerID: containerd://6fb0ad1a381485dcfb2085ba0171fc9584de8e8b6d7eabbcbcb9a9fc0c627e2d
      image: docker.io/kodekloud/simple-webapp-mysql:latest
      imageID: docker.io/kodekloud/simple-webapp-mysql@sha256:92943d2b3ea4a1db7c8a9529cd5786ae3b9999e0246ab665c29922e9800d1b41
      lastState: {}
      name: webapp
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-03-29T01:34:44Z"
  hostIP: 172.25.0.55
  phase: Running
  podIP: 10.42.0.9
  podIPs:
    - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-29T01:34:34Z"
~~~~









controlplane ~ ➜  vi meu-pod-editado.yaml

controlplane ~ ➜  kubectl apply -f meu-pod-editado.yaml
Warning: resource pods/webapp-pod is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
The request is invalid: patch: Invalid value: "map[metadata:map[annotations:map[kubectl.kubernetes.io/last-applied-configuration:{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"labels\":{\"name\":\"webapp-pod\"},\"name\":\"webapp-pod\",\"namespace\":\"default\"},\"spec\":{\"containers\":[{\"image\":\"kodekloud/simple-webapp-mysql\",\"imagePullPolicy\":\"Always\",\"name\":\"webapp\",\"resources\":{},\"terminationMessagePath\":\"/dev/termination-log\",\"terminationMessagePolicy\":\"File\",\"volumeMounts\":[{\"mountPath\":\"/var/run/secrets/kubernetes.io/serviceaccount\",\"name\":\"kube-api-access-p8ngj\",\"readOnly\":true}]}],\"dnsPolicy\":\"ClusterFirst\",\"enableServiceLinks\":true,\"envFrom\":[{\"secretRef\":{\"name\":\"app-secret\"}}],\"nodeName\":\"controlplane\",\"preemptionPolicy\":\"PreemptLowerPriority\",\"priority\":0,\"restartPolicy\":\"Always\",\"schedulerName\":\"default-scheduler\",\"securityContext\":{},\"serviceAccount\":\"default\",\"serviceAccountName\":\"default\",\"terminationGracePeriodSeconds\":30,\"tolerations\":[{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/not-ready\",\"operator\":\"Exists\",\"tolerationSeconds\":300},{\"effect\":\"NoExecute\",\"key\":\"node.kubernetes.io/unreachable\",\"operator\":\"Exists\",\"tolerationSeconds\":300}],\"volumes\":[{\"name\":\"kube-api-access-p8ngj\",\"projected\":{\"defaultMode\":420,\"sources\":[{\"serviceAccountToken\":{\"expirationSeconds\":3607,\"path\":\"token\"}},{\"configMap\":{\"items\":[{\"key\":\"ca.crt\",\"path\":\"ca.crt\"}],\"name\":\"kube-root-ca.crt\"}},{\"downwardAPI\":{\"items\":[{\"fieldRef\":{\"apiVersion\":\"v1\",\"fieldPath\":\"metadata.namespace\"},\"path\":\"namespace\"}]}}]}}]},\"status\":{\"conditions\":[{\"lastProbeTime\":null,\"lastTransitionTime\":\"2023-03-29T01:34:34Z\",\"status\":\"True\",\"type\":\"Initialized\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2023-03-29T01:34:44Z\",\"status\":\"True\",\"type\":\"Ready\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2023-03-29T01:34:44Z\",\"status\":\"True\",\"type\":\"ContainersReady\"},{\"lastProbeTime\":null,\"lastTransitionTime\":\"2023-03-29T01:34:34Z\",\"status\":\"True\",\"type\":\"PodScheduled\"}],\"containerStatuses\":[{\"containerID\":\"containerd://6fb0ad1a381485dcfb2085ba0171fc9584de8e8b6d7eabbcbcb9a9fc0c627e2d\",\"image\":\"docker.io/kodekloud/simple-webapp-mysql:latest\",\"imageID\":\"docker.io/kodekloud/simple-webapp-mysql@sha256:92943d2b3ea4a1db7c8a9529cd5786ae3b9999e0246ab665c29922e9800d1b41\",\"lastState\":{},\"name\":\"webapp\",\"ready\":true,\"restartCount\":0,\"started\":true,\"state\":{\"running\":{\"startedAt\":\"2023-03-29T01:34:44Z\"}}}],\"hostIP\":\"172.25.0.55\",\"phase\":\"Running\",\"podIP\":\"10.42.0.9\",\"podIPs\":[{\"ip\":\"10.42.0.9\"}],\"qosClass\":\"BestEffort\",\"startTime\":\"2023-03-29T01:34:34Z\"}}\n]] spec:map[envFrom:[map[secretRef:map[name:app-secret]]]]]": strict decoding error: unknown field "spec.envFrom"

controlplane ~ ✖ 








controlplane ~ ✖ kubectl delete pod webapp-pod
pod "webapp-pod" deleted
^[[A^[[A
controlplane ~ ➜  kubectl apply -f meu-pod-editado.yaml
Error from server (BadRequest): error when creating "meu-pod-editado.yaml": Pod in version "v1" cannot be handled as a Pod: strict decoding error: unknown field "spec.envFrom"

controlplane ~ ✖ 







controlplane ~ ➜  cat my-object.cleaned.yaml 
~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-pod
  name: webapp-pod
  namespace: default
spec:
  containers:
    - image: kodekloud/simple-webapp-mysql
      imagePullPolicy: Always
      name: webapp
      resources: {}
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      envFrom:
        - secretRef:
            name: db-secret
      volumeMounts:
        - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          name: kube-api-access-p8ngj
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
    - name: kube-api-access-p8ngj
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
      lastTransitionTime: "2023-03-29T01:34:34Z"
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:44Z"
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:44Z"
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2023-03-29T01:34:34Z"
      status: "True"
      type: PodScheduled
  containerStatuses:
    - containerID: containerd://6fb0ad1a381485dcfb2085ba0171fc9584de8e8b6d7eabbcbcb9a9fc0c627e2d
      image: docker.io/kodekloud/simple-webapp-mysql:latest
      imageID: docker.io/kodekloud/simple-webapp-mysql@sha256:92943d2b3ea4a1db7c8a9529cd5786ae3b9999e0246ab665c29922e9800d1b41
      lastState: {}
      name: webapp
      ready: true
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2023-03-29T01:34:44Z"
  hostIP: 172.25.0.55
  phase: Running
  podIP: 10.42.0.9
  podIPs:
    - ip: 10.42.0.9
  qosClass: BestEffort
  startTime: "2023-03-29T01:34:34Z"
~~~~
controlplane ~ ➜  




controlplane ~ ✖ vi meu-pod-editado.yaml

controlplane ~ ➜  kubectl apply -f meu-pod-editado.yaml
pod/webapp-pod created

controlplane ~ ➜  
controlplane ~ ➜  kubectl get pods 
NAME         READY   STATUS                       RESTARTS   AGE
mysql        1/1     Running                      0          15m
webapp-pod   0/1     CreateContainerConfigError   0          13s

controlplane ~ ➜  




- Ajustado o nome da Secret no EnvFrom do Pod:

controlplane ~ ➜  vi meu-pod-editado.yaml

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f meu-pod-editado.yaml
pod/webapp-pod created

controlplane ~ ➜  kubectl get pods 
NAME         READY   STATUS    RESTARTS   AGE
mysql        1/1     Running   0          17m
webapp-pod   1/1     Running   0          2s

controlplane ~ ➜  
















info

View the web application to verify it can successfully connect to the database


https://30080-port-cfe76abc866c42e7.labs.kodekloud.com/
<https://30080-port-cfe76abc866c42e7.labs.kodekloud.com/>

Successfully connected to the MySQL database.
Environment Variables: DB_Host=sql01; DB_Database=Not Set; DB_User=root; DB_Password=password123;

From webapp-pod!

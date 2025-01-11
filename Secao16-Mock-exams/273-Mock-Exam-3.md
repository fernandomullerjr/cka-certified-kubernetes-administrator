#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "273. Mock Exam - 3."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  273. Mock Exam - 3


### 1 / 9
Weight: 12

Create a new service account with the name pvviewer. Grant this Service account access to list all PersistentVolumes in the cluster by creating an appropriate cluster role called pvviewer-role and ClusterRoleBinding called pvviewer-role-binding.
Next, create a pod called pvviewer with the image: redis and serviceAccount: pvviewer in the default namespace.

ServiceAccount: pvviewer

ClusterRole: pvviewer-role

ClusterRoleBinding: pvviewer-role-binding

Pod: pvviewer

Pod configured to use ServiceAccount pvviewer ?



https://kubernetes.io/docs/concepts/security/service-accounts/

How to use service accounts

To use a Kubernetes service account, you do the following:

    Create a ServiceAccount object using a Kubernetes client like kubectl or a manifest that defines the object.

    Grant permissions to the ServiceAccount object using an authorization mechanism such as RBAC.

    Assign the ServiceAccount object to Pods during Pod creation.



controlplane ~ ➜  kubectl create sa --help
Create a service account with the specified name.

Aliases:
serviceaccount, sa

Examples:
  # Create a new service account named my-service-account
  kubectl create serviceaccount my-service-account

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --field-manager='kubectl-create':
        Name of the manager used to track field ownership.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
        be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
        is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --validate='strict':
        Must be one of: strict (or true), warn, ignore (or false).              "true" or "strict" will use a schema to validate
        the input and fail the request if invalid. It will perform server side validation if ServerSideFieldValidation
        is enabled on the api-server, but will fall back to less reliable client-side validation if not.                "warn" will
        warn about unknown or duplicate fields without blocking the request if server-side field validation is enabled
        on the API server, and behave as "ignore" otherwise.            "false" or "ignore" will not perform any schema
        validation, silently dropping any unknown or duplicate fields.

Usage:
  kubectl create serviceaccount NAME [--dry-run=server|client|none] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  


- Criando SA
kubectl create serviceaccount pvviewer




controlplane ~ ➜  kubectl create clusterrole --help
Create a cluster role.

Examples:
  # Create a cluster role named "pod-reader" that allows user to perform "get", "watch" and "list" on pods
  kubectl create clusterrole pod-reader --verb=get,list,watch --resource=pods
  
  # Create a cluster role named "pod-reader" with ResourceName specified
  kubectl create clusterrole pod-reader --verb=get --resource=pods --resource-name=readablepod
--resource-name=anotherpod
  
  # Create a cluster role named "foo" with API Group specified
  kubectl create clusterrole foo --verb=get,list,watch --resource=rs.apps
  
  # Create a cluster role named "foo" with SubResource specified
  kubectl create clusterrole foo --verb=get,list,watch --resource=pods,pods/status
  
  # Create a cluster role name "foo" with NonResourceURL specified
  kubectl create clusterrole "foo" --verb=get --non-resource-url=/logs/*
  
  # Create a cluster role name "monitoring" with AggregationRule specified
  kubectl create clusterrole monitoring --aggregation-rule="rbac.example.com/aggregate-to-monitoring=true"



https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/

<https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/>

controlplane ~ ➜  kubectl api-resources
NAME                                SHORTNAMES   APIVERSION                        NAMESPACED   KIND
bindings                                         v1                                true         Binding
componentstatuses                   cs           v1                                false        ComponentStatus
configmaps                          cm           v1                                true         ConfigMap
endpoints                           ep           v1                                true         Endpoints
events                              ev           v1                                true         Event
limitranges                         limits       v1                                true         LimitRange
namespaces                          ns           v1                                false        Namespace
nodes                               no           v1                                false        Node
persistentvolumeclaims              pvc          v1                                true         PersistentVolumeClaim
persistentvolumes                   pv           v1                                false        PersistentVolume
pods                                po           v1                                true         Pod
podtemplates                                     v1                                true         PodTemplate
replicationcontrollers              rc           v1                                true         ReplicationController
resourcequotas                      quota        v1                                true         ResourceQuota
secrets                                          v1                                true         Secret
serviceaccounts                     sa           v1                                true         ServiceAccount
services                            svc          v1                                true         Service
mutatingwebhookconfigurations                    admissionregistration.k8s.io/v1   false        MutatingWebhookConfiguration
validatingadmissionpolicies                      admissionregistration.k8s.io/v1   false        ValidatingAdmissionPolicy
validatingadmissionpolicybindings                admissionregistration.k8s.io/v1   false        ValidatingAdmissionPolicyBinding
validatingwebhookconfigurations                  admissionregistration.k8s.io/v1   false        ValidatingWebhookConfiguration
customresourcedefinitions           crd,crds     apiextensions.k8s.io/v1           false        CustomResourceDefinition
apiservices                                      apiregistration.k8s.io/v1         false        APIService
controllerrevisions                              apps/v1                           true         ControllerRevision
daemonsets                          ds           apps/v1                           true         DaemonSet
deployments                         deploy       apps/v1                           true         Deployment
replicasets                         rs           apps/v1                           true         ReplicaSet
statefulsets                        sts          apps/v1                           true         StatefulSet
selfsubjectreviews                               authentication.k8s.io/v1          false        SelfSubjectReview
tokenreviews                                     authentication.k8s.io/v1          false        TokenReview
localsubjectaccessreviews                        authorization.k8s.io/v1           true         LocalSubjectAccessReview
selfsubjectaccessreviews                         authorization.k8s.io/v1           false        SelfSubjectAccessReview
selfsubjectrulesreviews                          authorization.k8s.io/v1           false        SelfSubjectRulesReview
subjectaccessreviews                             authorization.k8s.io/v1           false        SubjectAccessReview
horizontalpodautoscalers            hpa          autoscaling/v2                    true         HorizontalPodAutoscaler
cronjobs                            cj           batch/v1                          true         CronJob
jobs                                             batch/v1                          true         Job
certificatesigningrequests          csr          certificates.k8s.io/v1            false        CertificateSigningRequest
leases                                           coordination.k8s.io/v1            true         Lease
endpointslices                                   discovery.k8s.io/v1               true         EndpointSlice
events                              ev           events.k8s.io/v1                  true         Event
flowschemas                                      flowcontrol.apiserver.k8s.io/v1   false        FlowSchema
prioritylevelconfigurations                      flowcontrol.apiserver.k8s.io/v1   false        PriorityLevelConfiguration
ingressclasses                                   networking.k8s.io/v1              false        IngressClass
ingresses                           ing          networking.k8s.io/v1              true         Ingress
networkpolicies                     netpol       networking.k8s.io/v1              true         NetworkPolicy
runtimeclasses                                   node.k8s.io/v1                    false        RuntimeClass
poddisruptionbudgets                pdb          policy/v1                         true         PodDisruptionBudget
clusterrolebindings                              rbac.authorization.k8s.io/v1      false        ClusterRoleBinding
clusterroles                                     rbac.authorization.k8s.io/v1      false        ClusterRole
rolebindings                                     rbac.authorization.k8s.io/v1      true         RoleBinding
roles                                            rbac.authorization.k8s.io/v1      true         Role
priorityclasses                     pc           scheduling.k8s.io/v1              false        PriorityClass
csidrivers                                       storage.k8s.io/v1                 false        CSIDriver
csinodes                                         storage.k8s.io/v1                 false        CSINode
csistoragecapacities                             storage.k8s.io/v1                 true         CSIStorageCapacity
storageclasses                      sc           storage.k8s.io/v1                 false        StorageClass
volumeattachments                                storage.k8s.io/v1                 false        VolumeAttachment

controlplane ~ ➜  


kubectl create clusterrole pvviewer-role --verb=list --resource=persistentvolumes

controlplane ~ ➜  kubectl create clusterrole pvviewer-role --verb=list --resource=persistentvolumes
clusterrole.rbac.authorization.k8s.io/pvviewer-role created

controlplane ~ ➜  





controlplane ~ ➜  kubectl create clusterrolebinding --help
Create a cluster role binding for a particular cluster role.

Examples:
  # Create a cluster role binding for user1, user2, and group1 using the cluster-admin cluster role
  kubectl create clusterrolebinding cluster-admin --clusterrole=cluster-admin --user=user1 --user=user2 --group=group1

    --serviceaccount=[]:
        Service accounts to bind to the clusterrole, in the format <namespace>:<name>. The flag can be repeated to add
        multiple service accounts.

- Criando o binding:
kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=pvviewer


controlplane ~ ➜  kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=pvviewer
error: serviceaccount must be <namespace>:<name>

controlplane ~ ✖ 

- Criando o binding, ajustado:
kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer


controlplane ~ ➜  kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer
clusterrolebinding.rbac.authorization.k8s.io/pvviewer-role-binding created

controlplane ~ ➜  




controlplane ~ ➜  kubectl create deployment --help
Create a deployment with the specified name.

Aliases:
deployment, deploy

Examples:
  # Create a deployment named my-dep that runs the busybox image
  kubectl create deployment my-dep --image=busybox
  
  # Create a deployment with a command
  kubectl create deployment my-dep --image=busybox -- date
  
  # Create a deployment named my-dep that runs the nginx image with 3 replicas
  kubectl create deployment my-dep --image=nginx --replicas=3
  
  # Create a deployment named my-dep that runs the busybox image and expose port 5701
  kubectl create deployment my-dep --image=busybox --port=5701
  
  # Create a deployment named my-dep that runs multiple containers
  kubectl create deployment my-dep --image=busybox:latest --image=ubuntu:latest --image=nginx

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --field-manager='kubectl-create':
        Name of the manager used to track field ownership.

    --image=[]:
        Image names to run. A deployment can have multiple images set for multi-container pod.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

- Criando dry-run
kubectl create deployment pvviewer --image=redis --dry-run=client -o yaml



controlplane ~ ➜  

controlplane ~ ➜  kubectl create deployment pvviewer --image=redis --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: pvviewer
  name: pvviewer
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pvviewer
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: pvviewer
    spec:
      containers:
      - image: redis
        name: redis
        resources: {}
status: {}

controlplane ~ ➜  

https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
<https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/>


- Ajustando manifesto para o Pod:

~~~~yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: pvviewer
  name: pvviewer
spec:
  replicas: 1
  serviceAccountName: pvviewer
  selector:
    matchLabels:
      app: pvviewer
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: pvviewer
    spec:
      containers:
      - image: redis
        name: redis
        resources: {}
~~~~


controlplane ~ ➜  vi pod.yaml

controlplane ~ ➜  kubectl apply -f pod.yaml
Error from server (BadRequest): error when creating "pod.yaml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "spec.serviceAccountName"

controlplane ~ ✖ 

O erro que você está enfrentando ocorre porque o campo `serviceAccountName` está fora do lugar no manifesto YAML. O campo `serviceAccountName` pertence à seção `spec.template.spec`, e não diretamente em `spec` no nível do `Deployment`.

Aqui está a correção para o seu manifesto:

### Manifesto corrigido:
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: pvviewer
  name: pvviewer
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pvviewer
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: pvviewer
    spec:
      serviceAccountName: pvviewer  # Corrigido: colocado dentro de spec.template.spec
      containers:
      - image: redis
        name: redis
        resources: {}
```

### Explicação:
1. **Local correto para `serviceAccountName`:**
   - O campo `serviceAccountName` deve ser definido no nível de `spec.template.spec` porque ele se aplica diretamente ao pod que será criado pelo `Deployment`.
   - `spec` no nível do `Deployment` é para configurações de alto nível, como `replicas` e `selector`.

2. **Erro original:**
   - O campo foi colocado diretamente em `spec`, onde não é reconhecido pelo Kubernetes, resultando no erro de **strict decoding**.

3. **Estrutura correta:**
   - `serviceAccountName` agora está no lugar correto, dentro de `spec.template.spec`, alinhado com as expectativas do controlador do Kubernetes.

### Aplicando o manifesto corrigido:
Salve o arquivo corrigido como `pod.yaml` e aplique-o novamente:
```bash
kubectl apply -f pod.yaml
```

Agora, o `Deployment` deverá ser criado sem erros. 🚀




controlplane ~ ✖ vi pod.yaml

controlplane ~ ➜  kubectl apply -f pod.yaml
deployment.apps/pvviewer created

controlplane ~ ➜  





### 2 / 9
Weight: 12

List the InternalIP of all nodes of the cluster. Save the result to a file /root/CKA/node_ips.

Answer should be in the format: InternalIP of controlplane<space>InternalIP of node01 (in a single line)

Task Completed



kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}'


kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'

controlplane ~ ✖ kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}'
192.9.200.3 192.9.200.6
controlplane ~ ➜  


- Comando ajustado:
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips

controlplane ~ ➜  cat /root/CKA/node_ips 
192.9.200.3 192.9.200.6
controlplane ~ ➜  





### 3 / 9
Weight: 12

Create a pod called multi-pod with two containers.
Container 1: name: alpha, image: nginx
Container 2: name: beta, image: busybox, command: sleep 4800

Environment Variables:
container 1:
name: alpha

Container 2:
name: beta

Pod Name: multi-pod

Container 1: alpha

Container 2: beta

Container beta commands set correctly?

Container 1 Environment Value Set

Container 2 Environment Value Set





controlplane ~ ➜  kubectl create deployment --help 
Create a deployment with the specified name.

Aliases:
deployment, deploy

Examples:
  # Create a deployment named my-dep that runs the busybox image
  kubectl create deployment my-dep --image=busybox
  
  # Create a deployment with a command
  kubectl create deployment my-dep --image=busybox -- date
  
  # Create a deployment named my-dep that runs the nginx image with 3 replicas
  kubectl create deployment my-dep --image=nginx --replicas=3
  
  # Create a deployment named my-dep that runs the busybox image and expose port 5701
  kubectl create deployment my-dep --image=busybox --port=5701
  
  # Create a deployment named my-dep that runs multiple containers
  kubectl create deployment my-dep --image=busybox:latest --image=ubuntu:latest --image=nginx

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --field-manager='kubectl-create':
        Name of the manager used to track field ownership.

    --image=[]:
        Image names to run. A deployment can have multiple images set for multi-container pod.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

https://kubernetes.io/docs/concepts/workloads/pods/

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


apiVersion: batch/v1
kind: Job
metadata:
  name: hello
spec:
  template:
    # This is the pod template
    spec:
      containers:
      - name: hello
        image: busybox:1.28
        command: ['sh', '-c', 'echo "Hello, Kubernetes!" && sleep 3600']
      restartPolicy: OnFailure
    # The pod template ends here



- Criando Pod com multiplos containers:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  containers:
  - name: alpha
    image: nginx
    ports:
    - containerPort: 80
  - name: beta
    image: busybox
    command: ['sh', '-c', 'sleep 4800']
    ports:
    - containerPort: 80
~~~~


https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/


Environment Variables:
container 1:
name: alpha

Container 2:
name: beta

exemplo
https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/
apiVersion: v1
kind: Pod
metadata:
  name: envar-demo
  labels:
    purpose: demonstrate-envars
spec:
  containers:
  - name: envar-demo-container
    image: gcr.io/google-samples/hello-app:2.0
    env:
    - name: DEMO_GREETING
      value: "Hello from the environment"
    - name: DEMO_FAREWELL
      value: "Such a sweet sorrow"


- Criando Pod com multiplos containers, com variaveis:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  containers:
  - name: alpha
    image: nginx
    env:
    - name: name
      value: "alpha"
  - name: beta
    image: busybox
    env:
    - name: name
      value: "beta"
    command: ['sh', '-c', 'sleep 4800']
~~~~


controlplane ~ ➜  kubectl apply -f pod-3.yaml
pod/multi-pod created

controlplane ~ ➜  





### 4 / 9
Weight: 8

Create a Pod called non-root-pod , image: redis:alpine

runAsUser: 1000

fsGroup: 2000

Pod non-root-pod fsGroup configured

Pod non-root-pod runAsUser configured



~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: non-root-pod
spec:
  containers:
  - name: non-root-pod
    image: redis:alpine
~~~~

https://kubernetes.io/docs/tasks/configure-pod-container/security-context/

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

- Ajustado


~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: non-root-pod
spec:
  securityContext:
    runAsUser: 1000
    fsGroup: 2000
  containers:
  - name: non-root-pod
    image: redis:alpine
~~~~



controlplane ~ ➜  vi pod-4.yaml

controlplane ~ ➜  kubectl apply -f pod-4.yaml
pod/non-root-pod created

controlplane ~ ➜  





### 5 / 9
Weight: 14

We have deployed a new pod called np-test-1 and a service called np-test-service. Incoming connections to this service are not working. Troubleshoot and fix it.
Create NetworkPolicy, by the name ingress-to-nptest that allows incoming connections to the service over port 80.

Important: Don't delete any current objects deployed.

Important: Don't Alter Existing Objects!

NetworkPolicy: Applied to All sources (Incoming traffic from all pods)?

NetWorkPolicy: Correct Port?

NetWorkPolicy: Applied to correct Pod?




controlplane ~ ➜  kubectl get pod -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
default       multi-pod                              2/2     Running   0             106s
default       non-root-pod                           1/1     Running   0             50s
default       np-test-1                              1/1     Running   0             23s
default       pvviewer-794bff5687-9cq77              1/1     Running   0             6m13s
kube-system   coredns-77d6fd4654-gvtq8               1/1     Running   0             18m
kube-system   coredns-77d6fd4654-xh9bl               1/1     Running   0             18m
kube-system   etcd-controlplane                      1/1     Running   0             19m
kube-system   kube-apiserver-controlplane            1/1     Running   0             19m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             19m
kube-system   kube-proxy-54rx2                       1/1     Running   0             18m
kube-system   kube-proxy-fbfsf                       1/1     Running   0             18m
kube-system   kube-scheduler-controlplane            1/1     Running   0             19m
kube-system   weave-net-ncgjs                        2/2     Running   0             18m
kube-system   weave-net-v4r4n                        2/2     Running   1 (18m ago)   18m

controlplane ~ ➜  

https://kubernetes.io/docs/tasks/administer-cluster/declare-network-policy/



networkpolicies                     netpol       networking.k8s.io/v1              true         NetworkPolicy




controlplane ~ ➜  kubectl get netpol
NAME           POD-SELECTOR   AGE
default-deny   <none>         5m7s

controlplane ~ ➜  kubectl get netpol -A
NAMESPACE   NAME           POD-SELECTOR   AGE
default     default-deny   <none>         5m10s

controlplane ~ ➜  




controlplane ~ ➜  kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
multi-pod                   2/2     Running   0          7m28s
non-root-pod                1/1     Running   0          6m32s
np-test-1                   1/1     Running   0          6m5s
pvviewer-794bff5687-9cq77   1/1     Running   0          11m

controlplane ~ ➜  kubectl get svc
NAME              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
kubernetes        ClusterIP   10.96.0.1        <none>        443/TCP   24m
np-test-service   ClusterIP   10.101.242.154   <none>        80/TCP    6m7s

controlplane ~ ➜  


controlplane ~ ➜  curl np-test-service
curl: (6) Could not resolve host: np-test-service

controlplane ~ ✖ 

controlplane ~ ✖ curl 10.101.242.154
^C

controlplane ~ ✖ kubectl describe pod np-test-1
Name:             np-test-1
Namespace:        default
Priority:         0
Service Account:  default
Node:             node01/192.15.140.6
Start Time:       Sat, 11 Jan 2025 22:36:31 +0000
Labels:           run=np-test-1
Annotations:      <none>
Status:           Running
IP:               10.244.192.4



controlplane ~ ➜  kubectl run busybox --rm -ti --image=busybox:1.28 -- /bin/sh
If you don't see a command prompt, try pressing enter.
/ # curl np-test-service
/bin/sh: curl: not found
/ # wget np-test-service
Connecting to np-test-service (10.101.242.154:80)
^C
/ # 


apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: access-nginx
spec:
  podSelector:
    matchLabels:
      app: nginx
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: "true"


- Criando netpol:

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: "true"
    ports:
    - protocol: TCP
      port: 80
~~~~


controlplane ~ ➜  vi questao5-netpol.yaml

controlplane ~ ➜  kubectl apply -f questao5-netpol.yaml
networkpolicy.networking.k8s.io/ingress-to-nptest created

controlplane ~ ➜  kubectl get netpol
NAME                POD-SELECTOR    AGE
default-deny        <none>          12m
ingress-to-nptest   run=np-test-1   3s

controlplane ~ ➜  


- Não resolveu

/ # wget np-test-service
Connecting to np-test-service (10.101.242.154:80)
wget: can't connect to remote host (10.101.242.154): Connection timed out

- Ajustando

~~~~yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  ingress:
  - from:
    - podSelector:
        matchLabels:
          run: busybox
    ports:
    - protocol: TCP
      port: 80
~~~~


controlplane ~ ➜  vi questao5-netpol.yaml 

controlplane ~ ➜  kubectl apply -f questao5-netpol.yaml 
networkpolicy.networking.k8s.io/ingress-to-nptest configured

controlplane ~ ➜  kubectl get netpol
NAME                POD-SELECTOR    AGE
default-deny        <none>          17m
ingress-to-nptest   run=np-test-1   4m46s

controlplane ~ ➜  


- Testando
OK:

/ # wget np-test-service
Connecting to np-test-service (10.101.242.154:80)
index.html           100% |***********************************************************************************************************************************|   615   0:00:00 ETA
/ # 






### 6 / 9
Weight: 12

Taint the worker node node01 to be Unschedulable. Once done, create a pod called dev-redis, image redis:alpine, to ensure workloads are not scheduled to this worker node. Finally, create a new pod called prod-redis and image: redis:alpine with toleration to be scheduled on node01.

key: env_type, value: production, operator: Equal and effect: NoSchedule

Key = env_type

Value = production

Effect = NoSchedule

pod 'dev-redis' (no tolerations) is not scheduled on node01?

Create a pod 'prod-redis' to run on node01



controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   43m   v1.31.0
node01         Ready    <none>          43m   v1.31.0

controlplane ~ ➜  


controlplane ~ ✖ kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux


controlplane ~ ➜  kubectl taint --help
Update the taints on one or more nodes.

  *  A taint consists of a key, value, and effect. As an argument here, it is expressed as key=value:effect.
  *  The key must begin with a letter or number, and may contain letters, numbers, hyphens, dots, and underscores, up to
253 characters.
  *  Optionally, the key can begin with a DNS subdomain prefix and a single '/', like example.com/my-app.
  *  The value is optional. If given, it must begin with a letter or number, and may contain letters, numbers, hyphens,
dots, and underscores, up to 63 characters.
  *  The effect must be NoSchedule, PreferNoSchedule or NoExecute.
  *  Currently taint can only apply to node.

Examples:
  # Update node 'foo' with a taint with key 'dedicated' and value 'special-user' and effect 'NoSchedule'
  # If a taint with that key and effect already exists, its value is replaced as specified
  kubectl taint nodes foo dedicated=special-user:NoSchedule
  
  # Remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' if one exists
  kubectl taint nodes foo dedicated:NoSchedule-
  
  # Remove from node 'foo' all the taints with key 'dedicated'
  kubectl taint nodes foo dedicated-
  
  # Add a taint with key 'dedicated' on nodes having label myLabel=X
  kubectl taint node -l myLabel=X  dedicated=foo:PreferNoSchedule
  
  # Add to node 'foo' a taint with key 'bar' and no value
  kubectl taint nodes foo bar:NoSchedule


kubectl taint nodes node01 kubernetes.io/hostname=node01:NoSchedule



controlplane ~ ✖ kubectl taint nodes node01 kubernetes.io/hostname=node01:NoSchedule
node/node01 tainted

controlplane ~ ➜  



controlplane ~ ➜  kubectl run --help
Create and run a particular image in a pod.

Examples:
  # Start a nginx pod
  kubectl run nginx --image=nginx
  
  # Start a hazelcast pod and let the container expose port 5701
  kubectl run hazelcast --image=hazelcast/hazelcast --port=5701
  
  # Start a hazelcast pod and set environment variables "DNS_DOMAIN=cluster" and "POD_NAMESPACE=default" in the
container
  kubectl run hazelcast --image=hazelcast/hazelcast --env="DNS_DOMAIN=cluster" --env="POD_NAMESPACE=default"
  
  # Start a hazelcast pod and set labels "app=hazelcast" and "env=prod" in the container
  kubectl run hazelcast --image=hazelcast/hazelcast --labels="app=hazelcast,env=prod"
  
  # Dry run; print the corresponding API objects without creating them
  kubectl run nginx --image=nginx --dry-run=client
  
  # Start a nginx pod, but overload the spec with a partial set of values parsed from JSON
  kubectl run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'
  
  # Start a busybox pod and keep it in the foreground, don't restart it if it exits
  kubectl run -i -t busybox --image=busybox --restart=Never
  
  # Start the nginx pod using the default command, but use custom arguments (arg1 .. argN) for that command
  kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>
  
  # Start the nginx pod using a different command and custom arguments
  kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>

kubectl run dev-redis --image=redis:alpine


controlplane ~ ➜  kubectl run dev-redis --image=redis:alpine
pod/dev-redis created

controlplane ~ ➜  



https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

Here's an example of a pod that has some tolerations defined:
pods/pod-with-toleration.yaml [Copy pods/pod-with-toleration.yaml to clipboard]

apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels:
    env: test
spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  tolerations:
  - key: "example-key"
    operator: "Exists"
    effect: "NoSchedule"


kubectl run prod-redis --image=redis:alpine -o yaml --dry-run=client


controlplane ~ ➜  kubectl run prod-redis --image=redis:alpine -o yaml --dry-run=client
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: prod-redis
  name: prod-redis
spec:
  containers:
  - image: redis:alpine
    name: prod-redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  




kubectl taint nodes node01 env_type=production:NoSchedule


controlplane ~ ➜  kubectl taint nodes node01 env_type=production:NoSchedule
node/node01 tainted

controlplane ~ ➜  


controlplane ~ ➜  vi questao6-pod-toleration.yaml

controlplane ~ ➜  kubectl apply -f questao6-pod-toleration.yaml
The Pod "prod-redis" is invalid: spec.tolerations[0].operator: Invalid value: core.Toleration{Key:"env_type", Operator:"Exists", Value:"production", Effect:"NoSchedule", TolerationSeconds:(*int64)(nil)}: value must be empty when `operator` is 'Exists'

controlplane ~ ✖ 


- Ajustando

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: prod-redis
  name: prod-redis
spec:
  containers:
  - image: redis:alpine
    name: prod-redis
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  tolerations:
  - key: "env_type"
    operator: "Equal"
    value: "production"
    effect: "NoSchedule"
status: {}
~~~~


controlplane ~ ✖ vi questao6-pod-toleration.yaml

controlplane ~ ➜  kubectl apply -f questao6-pod-toleration.yaml
pod/prod-redis created

controlplane ~ ➜  


controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   54m   v1.31.0
node01         Ready    <none>          54m   v1.31.0

controlplane ~ ➜  kubectl get pod
NAME                        READY   STATUS    RESTARTS   AGE
busybox                     1/1     Running   0          27m
dev-redis                   1/1     Running   0          7m56s
multi-pod                   2/2     Running   0          37m
non-root-pod                1/1     Running   0          36m
np-test-1                   1/1     Running   0          36m
prod-redis                  1/1     Running   0          32s
pvviewer-794bff5687-9cq77   1/1     Running   0          41m

controlplane ~ ➜  kubectl get pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE    IP             NODE           NOMINATED NODE   READINESS GATES
busybox                     1/1     Running   0          27m    10.244.192.5   node01         <none>           <none>
dev-redis                   1/1     Running   0          8m3s   10.244.0.4     controlplane   <none>           <none>
multi-pod                   2/2     Running   0          37m    10.244.192.2   node01         <none>           <none>
non-root-pod                1/1     Running   0          36m    10.244.192.3   node01         <none>           <none>
np-test-1                   1/1     Running   0          36m    10.244.192.4   node01         <none>           <none>
prod-redis                  1/1     Running   0          39s    10.244.0.5     controlplane   <none>           <none>
pvviewer-794bff5687-9cq77   1/1     Running   0          42m    10.244.192.1   node01         <none>           <none>

controlplane ~ ➜  


- Pod nao subiu no node01
pode ser devido 2 taints
e como só tem 1 toleration


controlplane ~ ✖ kubectl describe node node01
Name:               node01
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=node01
                    kubernetes.io/os=linux
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sat, 11 Jan 2025 22:18:17 +0000
Taints:             env_type=production:NoSchedule
                    kubernetes.io/hostname=node01:NoSchedule


https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/

For example, imagine you taint a node like this

kubectl taint nodes node1 key1=value1:NoSchedule
kubectl taint nodes node1 key1=value1:NoExecute
kubectl taint nodes node1 key2=value2:NoSchedule

And a pod has two tolerations:

tolerations:
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoSchedule"
- key: "key1"
  operator: "Equal"
  value: "value1"
  effect: "NoExecute"

In this case, the pod will not be able to schedule onto the node, because there is no toleration matching the third taint. But it will be able to continue running if it is already running on the node when the taint is added, because the third taint is the only one of the three that is not tolerated by the pod.




controlplane ~ ➜  kubectl taint --help
Update the taints on one or more nodes.

  *  A taint consists of a key, value, and effect. As an argument here, it is expressed as key=value:effect.
  *  The key must begin with a letter or number, and may contain letters, numbers, hyphens, dots, and underscores, up to
253 characters.
  *  Optionally, the key can begin with a DNS subdomain prefix and a single '/', like example.com/my-app.
  *  The value is optional. If given, it must begin with a letter or number, and may contain letters, numbers, hyphens,
dots, and underscores, up to 63 characters.
  *  The effect must be NoSchedule, PreferNoSchedule or NoExecute.
  *  Currently taint can only apply to node.

Examples:
  # Update node 'foo' with a taint with key 'dedicated' and value 'special-user' and effect 'NoSchedule'
  # If a taint with that key and effect already exists, its value is replaced as specified
  kubectl taint nodes foo dedicated=special-user:NoSchedule
  
  # Remove from node 'foo' the taint with key 'dedicated' and effect 'NoSchedule' if one exists
  kubectl taint nodes foo dedicated:NoSchedule-


kubectl taint nodes node01 kubernetes.io/hostname=node01:NoSchedule-

controlplane ~ ➜  kubectl taint nodes node01 kubernetes.io/hostname=node01:NoSchedule-
node/node01 untainted

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE     IP             NODE           NOMINATED NODE   READINESS GATES
busybox                     1/1     Running   0          32m     10.244.192.5   node01         <none>           <none>
dev-redis                   1/1     Running   0          13m     10.244.0.4     controlplane   <none>           <none>
multi-pod                   2/2     Running   0          42m     10.244.192.2   node01         <none>           <none>
non-root-pod                1/1     Running   0          41m     10.244.192.3   node01         <none>           <none>
np-test-1                   1/1     Running   0          41m     10.244.192.4   node01         <none>           <none>
prod-redis                  1/1     Running   0          5m38s   10.244.0.5     controlplane   <none>           <none>
pvviewer-794bff5687-9cq77   1/1     Running   0          47m     10.244.192.1   node01         <none>           <none>

controlplane ~ ➜  kubectl delete -f questao
questao1-deployment.yaml      questao3-pod-multi-pod.yaml   questao4-pod.yaml             questao5-netpol.yaml          questao6-pod-toleration.yaml

controlplane ~ ➜  kubectl delete -f questao6-pod-toleration.yaml 
pod "prod-redis" deleted

controlplane ~ ➜  kubectl apply -f questao6-pod-toleration.yaml 
pod/prod-redis created

controlplane ~ ➜  kubectl get pod -o wide
NAME                        READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
busybox                     1/1     Running   0          32m   10.244.192.5   node01         <none>           <none>
dev-redis                   1/1     Running   0          13m   10.244.0.4     controlplane   <none>           <none>
multi-pod                   2/2     Running   0          43m   10.244.192.2   node01         <none>           <none>
non-root-pod                1/1     Running   0          42m   10.244.192.3   node01         <none>           <none>
np-test-1                   1/1     Running   0          41m   10.244.192.4   node01         <none>           <none>
prod-redis                  1/1     Running   0          2s    10.244.192.6   node01         <none>           <none>
pvviewer-794bff5687-9cq77   1/1     Running   0          47m   10.244.192.1   node01         <none>           <none>

controlplane ~ ➜  







### 7 / 9
Weight: 8

Create a pod called hr-pod in hr namespace belonging to the production environment and frontend tier .
image: redis:alpine

Use appropriate labels and create all the required objects if it does not exist in the system already.

hr-pod labeled with environment production?

hr-pod labeled with tier frontend?



# ###################################################################################################################### 
# ###################################################################################################################### 
## RESPOSTAS

### 1 / 9

controlplane ~ ➜  kubectl create serviceaccount pvviewer
serviceaccount/pvviewer created

controlplane ~ ➜  kubectl create clusterrole pvviewer-role --verb=list --resource=persistentvolumes
clusterrole.rbac.authorization.k8s.io/pvviewer-role created

controlplane ~ ➜  kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer
clusterrolebinding.rbac.authorization.k8s.io/pvviewer-role-binding created

controlplane ~ ➜  vi questao1-deployment.yaml

controlplane ~ ➜  kubectl apply -f questao1-deployment.yaml
deployment.apps/pvviewer created

controlplane ~ ➜  cat questao1-deployment.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: pvviewer
  name: pvviewer
spec:
  replicas: 1
  selector:
    matchLabels:
      app: pvviewer
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: pvviewer
    spec:
      serviceAccountName: pvviewer  # Corrigido: colocado dentro de spec.template.spec
      containers:
      - image: redis
        name: redis
        resources: {}

controlplane ~ ➜  



### 2 / 9
kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips



### 3 / 9
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao3--pod-multi-containers-variaveis.yaml

controlplane ~ ➜  vi questao3-pod-multi-pod.yaml

controlplane ~ ➜  kubectl apply -f questao3-pod-multi-pod.yaml
pod/multi-pod created

controlplane ~ ➜  date
Sat Jan 11 10:35:09 PM UTC 2025

controlplane ~ ➜  




### 4 / 9

controlplane ~ ➜  vi questao4-pod.yaml

controlplane ~ ➜  kubectl apply -f questao4-pod.yaml
pod/non-root-pod created

controlplane ~ ➜  



### 5 / 9
Secao16-Mock-exams/273-x--questao5-netpol.yaml



### 6 / 9
kubectl run dev-redis --image=redis:alpine
kubectl taint nodes node01 env_type=production:NoSchedule
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao7-pod-toleration.yaml




# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO - DICAS

- Usar o comando abaixo para descobrir resources
kubectl api-resources
fonte:
<https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/>



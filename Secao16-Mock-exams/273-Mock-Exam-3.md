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


kubectl run hr-pod --namespace=hr --image=redis:alpine --labels="environment=production,tier=frontend"



### 8 / 9
Weight: 8

A kubeconfig file called super.kubeconfig has been created under /root/CKA. There is something wrong with the configuration. Troubleshoot and fix it.

Fix /root/CKA/super.kubeconfig


controlplane ~ ➜  cat /root/CKA/super.kubeconfig
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJTUQ0ZXdCbjdWc0V3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBeE1URXlNekl5TWpoYUZ3MHpOVEF4TURreU16STNNamhhTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUURxZzRpbXc4MFMxVWZQcUZ1Q0tIVHFvQWFRN0lQOXpaUHg4VW1zbERiZ1gvOEZlMXplRDJ5ZXFjL1MKSjEzeXFFS05nVWlEdHlOdkpLQ0xFRlFPZ0VEbmRFUkpHZUpPREpvL0ZuL291VmZJdmVkT1Y3bXZQN0RVOWIxQwp3K1dEbkdzUVAvQkxybnlQZ0MzZm9ja0g1SWJOZVg3RmxKeTJ4UHFFQkp4RU1vLzNjaW1lczFYeWhrcmV5NzY1Ckgrc1Aycm5FdlZjZVRnTDZyTG9WaXA2MTZlYjdFeDlSTHBHTEgzdGYzNHNoZjdMNmZqdHdmcHpQVWwzOUVpQUwKSFQzZlBRcWMwcEhHS2ozZ3YyaWNyTkMyblZ0UVR3bFFQUUNJN3NmdkthTnUvb2ZHVTUzVksvdXZiVUtDRndRbwphalAzYUVYNGRwaFo3TXhEVkUwejdVdVV4dDZsQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJRY0txV3cxUWE2WDFLbUtaYWhkUmZnQk14YTJUQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQ0QzOXl0cHczZwpaVkh2VlVnbHRqT1I5bllYVWhBK1RKbmxBWW5WMXNpc2NFU3hteWhzSWpuN2FHUmtVMk1SYW0xd0o5Vm9SK2xPCnV0clFxSUdTbmFiaDB4WU1FaDhvOVg3QTlVSXRNbXhVMXlGUjlxQ2RWRXI2cmhJM0Z2aGVXT1VrUlBNbVFLRG8KSHRUN3J5ZVRQT0pReHNjNEJ6alhkdEU5U05uZUtFZXZVWlpOK1EwQ1I0TFJkMHJRZTQrSmpLb2ZuZ2hzb1RQZQoxc3NlVFA2K2twa1RwM1M4MFBveVJHcUtQTHRRckFaSXFhbFZYZnhjVmM4UmY2UlJPdHZITFBSTDh0M1JBOWdUCk9mL3FvOE0xbXcyMFVMbWdXZlBTK1pwTkVUQTZqT3NaRjlqUHYyWUZtL3QySStLZEFjdlNQZ0txQU5jNnVES0cKZnE2cldpeU5wZFo2Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:9999
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLVENDQWhHZ0F3SUJBZ0lJQnJyTXBKOW1wTGd3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBeE1URXlNekl5TWpoYUZ3MHlOakF4TVRFeU16STNNamhhTUR3eApIekFkQmdOVkJBb1RGbXQxWW1WaFpHMDZZMngxYzNSbGNpMWhaRzFwYm5NeEdUQVhCZ05WQkFNVEVHdDFZbVZ5CmJtVjBaWE10WVdSdGFXNHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFEQS8wbjEKNHRZT3lLQjRiVnYvSWhsRUNpNFY4ZVgwV2RxQ3FNbUFoVEgvUU4wTC8rV0hYVkZsbmZZdEU0VXg1MStXU1RHVgpwcE9ZTkpaQk1zNmtBbDFpREU2c0NzbXgvK2Q5dVVSME5zWVlSYW5XaFI4MVk5ODc1NVNuSGxXUHBTbXdlT2l2CmpCL1BrYzhRSnJ5Ym1oSVlERUZieHNPRnNKMzJMQnFOaG1NWjdYVDd1cm9Bakk2ZW4yLzZBaXMxbUNiaEwrdXEKb1pGK2syM0Z6LzhDdEkycWM1UzBLMm1HcitrR0pEbnBWYlpkbmdoa2dtUkZqVjhlM2poTklTNlVOSm1OUitLbwpSNUp0T3dhRUJhdjFlT1dZdWg1Qm1QZlp0aDgwS0ZCc2tSYWZzQXlQV3EybDZaVU8vVko4dHVWcW1rYVY1RTlUCjhvY2NLS0ZsWFhXRDNrYU5BZ01CQUFHalZqQlVNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUsKQmdnckJnRUZCUWNEQWpBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRkJ3cXBiRFZCcnBmVXFZcApscUYxRitBRXpGclpNQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUJ2OVYzRERVN3QzQ040VzRCdVVQRHU1OU1FClVvUEZxdlpsUHJBazdPNTdPeS90c3pQTklXbG9kcTFHczhaUlliRVpqckwvZEVsYVJDNE44V2svaG5SY3U3WFcKcnI2Q0JzS2VpdFo3V0dna05FWjlDcGdLSElUdkhnNko5N25UQWhjY1FjOEZOeWgrc0FZZy83aStTbUVqc3NuTwp6clhVNUtHL3MwK1RBeGlJRnRiR2tncVBORkp2UCtTTHN0WmNyanZSVXZPZG1abEp0TUwxdXFpeGZSN0FJaElZCjJIQW94VEF1M0M1Zk1XeExscTFSdFFwaTZEaDQxVm1xQkcyVU44NGg5c0k3eTN2T1A1aDZJZlc1cFllTit5ZnQKUjlRU3FxMWxCd2xmdG51YVVkOS9hK3ZZTUtyNlJaQTlKTnJnRVk3TjcxN3I0UWZWdzZNMUVYVlN2enVGCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcFFJQkFBS0NBUUVBd1A5SjllTFdEc2lnZUcxYi95SVpSQW91RmZIbDlGbmFncWpKZ0lVeC8wRGRDLy9sCmgxMVJaWjMyTFJPRk1lZGZsa2t4bGFhVG1EU1dRVExPcEFKZFlneE9yQXJKc2YvbmZibEVkRGJHR0VXcDFvVWYKTldQZk8rZVVweDVWajZVcHNIam9yNHdmejVIUEVDYThtNW9TR0F4Qlc4YkRoYkNkOWl3YWpZWmpHZTEwKzdxNgpBSXlPbnA5ditnSXJOWmdtNFMvcnFxR1JmcE50eGMvL0FyU05xbk9VdEN0cGhxL3BCaVE1NlZXMlhaNElaSUprClJZMWZIdDQ0VFNFdWxEU1pqVWZpcUVlU2JUc0doQVdyOVhqbG1Mb2VRWmozMmJZZk5DaFFiSkVXbjdBTWoxcXQKcGVtVkR2MVNmTGJsYXBwR2xlUlBVL0tISENpaFpWMTFnOTVHalFJREFRQUJBb0lCQVFDVTdLbWF0bll0SkQxSAprRU9jQlNqdjZ0Y1RFZjA2NTVjSW1jd2JneXhJWmpuc0I0T0xSOFFHb0xTVXBlcHl6ckpnMm93TGlXVjgzcDlQCklqQjRPR2Jzd01oNFV6NitQdFRYbS8ycG01YVNwamJmRlF3Mis2RUhyYlIwbktDelhtUmtDM2lwOVh1YWhVMzkKalphZWoyNEU1bmdNcEx5OVRjTW1jWFB2MzFKYmJ4eDBZanJWcXM1bjJiWGhIRFRsUVJKQmdURFA5eVg2bk9BLwpJSVUyaWFFVWpPRDRDM3g3MGFHY0VMbHVqMUtCMU5Ga3FZU2w2NmY3dGk4VWwybUhCZWU5QTVtQzVxM2liYzNlCjZ6c1BRODA1ZkU0UVVVVDJ2cDVJRTFUQ21nR3BpbkNZTFl0USs4TElnR1c5VjJmVWRWNE5BYUgyVHAyMFlpMEoKUCtyYjJSMTFBb0dCQU51d21uOVpyK3BYQkdLZ0VIcE5EQnJtai93cDlGenV2Kzlhbi9kckVQb3VIb0Zhamg2agptNmU3czdXN25ZYldoeTNLUTJNQUY5NER2USsxTVozNkFNV1pjRUdVbXFHcTZBQmRmRjI3SDlHL0dmZkN4VHhJClpUeElVeitDQjZzRTRraFV3N3c5eE41Zk9yOG5ERWNjeU1OeWcxQmlkeVN5L3hhTUJXbXVTWjBQQW9HQkFPRGwKU0FNQ1BIbENCWUJSMURnTkpFeTRzK0VFMkhKak5ydlQveEpOdTFjSU4wMWVRbHVVb1RtSUw3a0w4aDlBZ1dsdwpuWGdMRTBJQkFMSWZ6Q09ZbEpLWm5MUGhYeUZ4RFd3bVppOG9wQ0NJMUpKV1VBeHJ2YzgxNmhIblZCdnNUZlNtCmtML2EvU24ySDZNNTVrNUlGUHFCLzNVdnJGRERsVzVDdXBUSnVGcWpBb0dBZTlvVlQ2UnRZMnlKUVZ6QnpXRXcKYU40QTRJVjZpUVhrV1BrN1k4NE5kUzJZN3czeFAxNjNPeG03MThHY3JrNjFTT0JWbXpPTFFSUFVlMDJJV21wKwpFdWhNKy92ZUxUUmZ0UXovTnd4dWhOMzZzczR3U2FyNnY4QjZoancxUEhuMVpCZTlmWnRKS0tDQlN4Q2xnRlcrCjdVamF0TysrQVllVC9jOFVvaDZxeTRzQ2dZRUFoY21BSkdJUkxhV0w5a0UzdVR5QUtxLzZPbE9TbThIUHpyOFgKejRDMGdOcmZZMFErdjVKVXN4QUVLOVlpYkZzSVlYeGdBUWk5cFJkSm5hMXkySDR0YkdTN3B2cmNoOTFrT2NGQwpLcTNIclo4WXJoRnd2MkxjNE1iVy8xMlpXSjhqNVBXdHlLUnkxS0taUVpYeEh3S2NrRVlEZldnbDMwbnF2RlF3CkFORmJ2WGNDZ1lFQXRYZEp1Q1QwRmhFZlJzS1lqenRjZnhHbHZPM1plYnhLMjhTV0k0VzF5elNia1V4WFR1S3MKT0VlSXFpR3JhYmQ3bHphUGY4Um9iOG8wT080VjRzcUJRNnBRZU9yQlRLV0YrWHJPdHhRd3hNT1JBVVB1TzJUVQpSVS82N296cVlYSG1Ec0JucGczYmQvbFhjaTlONkE2QmdhdksvS2NNVGR2ams4MTFyM3UybmFFPQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=

controlplane ~ ➜  


controlplane ~ ➜  ss -tulp | grep apiserver
tcp   LISTEN 0      4096               *:6443                *:*    users:(("kube-apiserver",pid=3668,fd=3)) 

controlplane ~ ➜  


- Ajustando porta
de
9999
para
6443

vi /root/CKA/super.kubeconfig





### 9 / 9
Weight: 14

We have created a new deployment called nginx-deploy. scale the deployment to 3 replicas. Has the replica's increased? Troubleshoot the issue and fix it.

deployment has 3 replicas


controlplane ~ ➜  kubectl scale --help
Set a new size for a deployment, replica set, replication controller, or stateful set.

 Scale also allows users to specify one or more preconditions for the scale action.

 If --current-replicas or --resource-version is specified, it is validated before the scale is attempted, and it is
guaranteed that the precondition holds true when the scale is sent to the server.

Examples:
  # Scale a replica set named 'foo' to 3
  kubectl scale --replicas=3 rs/foo
  
  # Scale a resource identified by type and name specified in "foo.yaml" to 3
  kubectl scale --replicas=3 -f foo.yaml
  
  # If the deployment named mysql's current size is 2, scale mysql to 3
  kubectl scale --current-replicas=2 --replicas=3 deployment/mysql
  
  # Scale multiple replication controllers
  kubectl scale --replicas=5 rc/example1 rc/example2 rc/example3
  
  # Scale stateful set named 'web' to 3
  kubectl scale --replicas=3 statefulset/web


controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/1     1            1           10m
pvviewer       1/1     1            1           14m

controlplane ~ ➜  

kubectl scale --replicas=3 deployment/nginx-deploy


controlplane ~ ➜  kubectl scale --replicas=3 deployment/nginx-deploy
deployment.apps/nginx-deploy scaled

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/3     1            1           11m
pvviewer       1/1     1            1           15m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/3     1            1           11m
pvviewer       1/1     1            1           15m

controlplane ~ ➜  kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
dev-redis                      1/1     Running   0          12m
multi-pod                      2/2     Running   0          14m
nginx-deploy-db7c4d999-hpcmq   1/1     Running   0          11m
non-root-pod                   1/1     Running   0          14m
np-test-1                      1/1     Running   0          14m
prod-redis                     1/1     Running   0          12m
pvviewer-794bff5687-vgg4l      1/1     Running   0          15m

controlplane ~ ➜  


ficou só com 1 Pod
analisando



controlplane ~ ✖ kubectl get deployment nginx-deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/3     1            1           22m

controlplane ~ ➜  kubectl describe deployment nginx-deploy
Name:                   nginx-deploy
Namespace:              default
CreationTimestamp:      Sat, 11 Jan 2025 23:40:25 +0000
Labels:                 app=nginx-deploy
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app=nginx-deploy
Replicas:               3 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  app=nginx-deploy
  Containers:
   nginx:
    Image:         nginx
    Port:          <none>
    Host Port:     <none>
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     env_type=production:NoSchedule
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-deploy-db7c4d999 (1/1 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  23m   deployment-controller  Scaled up replica set nginx-deploy-db7c4d999 to 1

controlplane ~ ➜  kubectl get deployment nginx-deploy -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2025-01-11T23:40:25Z"
  generation: 2
  labels:
    app: nginx-deploy
  name: nginx-deploy
  namespace: default
  resourceVersion: "2607"
  uid: e7e080f7-ac37-4072-b6a5-eaa31c8b4565
spec:
  progressDeadlineSeconds: 600
  replicas: 3
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-deploy
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deploy
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      tolerations:
      - effect: NoSchedule
        key: env_type
        operator: Equal
        value: production
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2025-01-11T23:40:30Z"
    lastUpdateTime: "2025-01-11T23:40:30Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2025-01-11T23:40:25Z"
    lastUpdateTime: "2025-01-11T23:40:30Z"
    message: ReplicaSet "nginx-deploy-db7c4d999" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  




controlplane ~ ➜  kubectl get rs
NAME                     DESIRED   CURRENT   READY   AGE
nginx-deploy-db7c4d999   1         1         1       25m
pvviewer-794bff5687      1         1         1       29m

controlplane ~ ➜  


kubectl scale --replicas=3 rs/nginx-deploy-db7c4d999


controlplane ~ ➜  kubectl scale --replicas=3 rs/nginx-deploy-db7c4d999
replicaset.apps/nginx-deploy-db7c4d999 scaled

controlplane ~ ➜  kubectl get rs
NAME                     DESIRED   CURRENT   READY   AGE
nginx-deploy-db7c4d999   3         1         1       38m
pvviewer-794bff5687      1         1         1       42m

controlplane ~ ➜  kubectl get rs
NAME                     DESIRED   CURRENT   READY   AGE
nginx-deploy-db7c4d999   3         1         1       38m
pvviewer-794bff5687      1         1         1       42m

controlplane ~ ➜  kubectl get pod
NAME                           READY   STATUS    RESTARTS   AGE
dev-redis                      1/1     Running   0          40m
multi-pod                      2/2     Running   0          42m
nginx-deploy-db7c4d999-hpcmq   1/1     Running   0          39m
non-root-pod                   1/1     Running   0          41m
np-test-1                      1/1     Running   0          41m
prod-redis                     1/1     Running   0          40m
pvviewer-794bff5687-vgg4l      1/1     Running   0          42m

controlplane ~ ➜  



controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   52m   v1.31.0
node01         Ready    <none>          51m   v1.31.0

controlplane ~ ➜  



controlplane ~ ➜  kubectl get hpa
No resources found in default namespace.

controlplane ~ ➜  kubectl get hpa -A
No resources found

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe rs nginx-deploy-db7c4d999
Name:           nginx-deploy-db7c4d999
Namespace:      default
Selector:       app=nginx-deploy,pod-template-hash=db7c4d999
Labels:         app=nginx-deploy
                pod-template-hash=db7c4d999
Annotations:    deployment.kubernetes.io/desired-replicas: 1
                deployment.kubernetes.io/max-replicas: 2
                deployment.kubernetes.io/revision: 1
Controlled By:  Deployment/nginx-deploy
Replicas:       1 current / 3 desired
Pods Status:    1 Running / 0 Waiting / 0 Succeeded / 0 Failed
Pod Template:
  Labels:  app=nginx-deploy
           pod-template-hash=db7c4d999
  Containers:
   nginx:
    Image:         nginx
    Port:          <none>
    Host Port:     <none>
    Environment:   <none>
    Mounts:        <none>
  Volumes:         <none>
  Node-Selectors:  <none>
  Tolerations:     env_type=production:NoSchedule
Events:
  Type    Reason            Age   From                   Message
  ----    ------            ----  ----                   -------
  Normal  SuccessfulCreate  40m   replicaset-controller  Created pod: nginx-deploy-db7c4d999-hpcmq


- Ajustados os Annotations:

controlplane ~ ➜  kubectl edit rs nginx-deploy-db7c4d999
replicaset.apps/nginx-deploy-db7c4d999 edited

controlplane ~ ➜  


- Segue com poucos:


controlplane ~ ➜  kubectl get rs
NAME                     DESIRED   CURRENT   READY   AGE
nginx-deploy-db7c4d999   3         1         1       41m
pvviewer-794bff5687      1         1         1       45m

controlplane ~ ➜  



- Dia 12/01/2025:

tshoot


controlplane ~ ➜  kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
dev-redis                      1/1     Running   0          12m
multi-pod                      2/2     Running   0          13m
nginx-deploy-db7c4d999-qtqrp   1/1     Running   0          10m
non-root-pod                   1/1     Running   0          13m
np-test-1                      1/1     Running   0          13m
prod-redis                     1/1     Running   0          11m
pvviewer-794bff5687-7xzpf      1/1     Running   0          14m

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/1     1            1           10m
pvviewer       1/1     1            1           14m

controlplane ~ ➜  



kubectl scale --replicas=3 deployment/nginx-deploy


https://kubernetes.io/docs/concepts/workloads/controllers/deployment/
kubectl rollout status deployment/nginx-deploy

controlplane ~ ➜  kubectl rollout status deployment/nginx-deploy
Waiting for deployment spec update to be observed...

kubectl get pods --show-labels
controlplane ~ ✖ kubectl get pods --show-labels
NAME                           READY   STATUS    RESTARTS   AGE   LABELS
dev-redis                      1/1     Running   0          15m   run=dev-redis
multi-pod                      2/2     Running   0          16m   <none>
nginx-deploy-db7c4d999-qtqrp   1/1     Running   0          13m   app=nginx-deploy,pod-template-hash=db7c4d999


kubectl rollout history deployment/nginx-deploy


controlplane ~ ➜  kubectl rollout history deployment/nginx-deploy
deployment.apps/nginx-deploy 
REVISION  CHANGE-CAUSE
1         <none>


controlplane ~ ➜  


controlplane ~ ➜  kubectl edit deployment/nginx-deploy
deployment.apps/nginx-deploy edited

controlplane ~ ➜  kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
dev-redis                      1/1     Running   0          24m
multi-pod                      2/2     Running   0          25m
nginx-deploy-db7c4d999-qtqrp   1/1     Running   0          22m
non-root-pod                   1/1     Running   0          25m
np-test-1                      1/1     Running   0          25m
prod-redis                     1/1     Running   0          23m
pvviewer-794bff5687-7xzpf      1/1     Running   0          26m

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/3     1            1           22m
pvviewer       1/1     1            1           26m

controlplane ~ ➜  kubectl get rs
NAME                     DESIRED   CURRENT   READY   AGE
nginx-deploy-db7c4d999   1         1         1       22m
pvviewer-794bff5687      1         1         1       26m

controlplane ~ ➜  kubectl delete rs nginx-deploy-db7c4d999
replicaset.apps "nginx-deploy-db7c4d999" deleted

controlplane ~ ➜  kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
pvviewer-794bff5687   1         1         1       27m

controlplane ~ ➜  kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
pvviewer-794bff5687   1         1         1       27m

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/3     1            1           22m
pvviewer       1/1     1            1           27m

controlplane ~ ➜  kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
pvviewer-794bff5687   1         1         1       27m

controlplane ~ ➜  


controlplane ~ ✖ kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   32m   v1.31.0
node01         Ready    <none>          31m   v1.31.0

controlplane ~ ➜  kubectl get pod -o wide
NAME                           READY   STATUS    RESTARTS   AGE   IP             NODE     NOMINATED NODE   READINESS GATES
dev-redis                      1/1     Running   0          27m   10.244.192.5   node01   <none>           <none>
multi-pod                      2/2     Running   0          28m   10.244.192.2   node01   <none>           <none>
nginx-deploy-db7c4d999-qtqrp   1/1     Running   0          25m   10.244.192.7   node01   <none>           <none>
non-root-pod                   1/1     Running   0          28m   10.244.192.3   node01   <none>           <none>
np-test-1                      1/1     Running   0          28m   10.244.192.4   node01   <none>           <none>
prod-redis                     1/1     Running   0          26m   10.244.192.6   node01   <none>           <none>
pvviewer-794bff5687-7xzpf      1/1     Running   0          29m   10.244.192.1   node01   <none>           <none>

controlplane ~ ➜  



controlplane ~ ✖ kubectl get nodes
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   32m   v1.31.0
node01         Ready    <none>          31m   v1.31.0

controlplane ~ ➜  kubectl get pod -o wide
NAME                           READY   STATUS    RESTARTS   AGE   IP             NODE     NOMINATED NODE   READINESS GATES
dev-redis                      1/1     Running   0          27m   10.244.192.5   node01   <none>           <none>
multi-pod                      2/2     Running   0          28m   10.244.192.2   node01   <none>           <none>
nginx-deploy-db7c4d999-qtqrp   1/1     Running   0          25m   10.244.192.7   node01   <none>           <none>
non-root-pod                   1/1     Running   0          28m   10.244.192.3   node01   <none>           <none>
np-test-1                      1/1     Running   0          28m   10.244.192.4   node01   <none>           <none>
prod-redis                     1/1     Running   0          26m   10.244.192.6   node01   <none>           <none>
pvviewer-794bff5687-7xzpf      1/1     Running   0          29m   10.244.192.1   node01   <none>           <none>

controlplane ~ ➜  




controlplane ~ ➜  kubectl get deployment/nginx-deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/13    1            1           26m

controlplane ~ ➜  kubectl get deployment/nginx-deploy -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2025-01-12T14:47:56Z"
  generation: 4
  labels:
    app: nginx-deploy
  name: nginx-deploy
  namespace: default
  resourceVersion: "2617"
  uid: 48b66eda-fa11-4ac7-bd1a-39666852c002
spec:
  progressDeadlineSeconds: 600
  replicas: 13
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: nginx-deploy
  strategy:
    rollingUpdate:
      maxSurge: 75%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deploy
    spec:
      containers:
      - image: nginx
        imagePullPolicy: Always
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
      tolerations:
      - effect: NoSchedule
        key: env_type
        operator: Equal
        value: production
status:
  availableReplicas: 1
  conditions:
  - lastTransitionTime: "2025-01-12T14:47:57Z"
    lastUpdateTime: "2025-01-12T14:47:57Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2025-01-12T14:47:56Z"
    lastUpdateTime: "2025-01-12T14:47:57Z"
    message: ReplicaSet "nginx-deploy-db7c4d999" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 1
  replicas: 1
  updatedReplicas: 1

controlplane ~ ➜  


Não exatamente. A lógica de **taints** e **tolerations** em Kubernetes funciona assim:

1. **Taints nos nodes**:  
   Uma taint adicionada a um node impede que qualquer pod que **não tenha uma toleration correspondente** seja agendado nesse node. Ou seja, o node "repele" pods que não sejam explicitamente tolerantes àquela taint.

2. **Tolerations nos pods**:  
   Quando um pod possui uma toleration, ele pode ser agendado em um node que tenha a taint correspondente. Porém, **ter uma toleration não obriga o pod a ser agendado naquele node**, apenas permite que ele seja.

### Respostas para suas perguntas:

1. **Pod com toleration só sobe em node com a taint?**  
   Não. O pod com a toleration **pode ser agendado em qualquer node**, desde que o node não tenha restrições adicionais (como taints que o pod não tolera). A toleration apenas permite que ele ignore a "repulsão" de um node com a taint correspondente.

2. **Node sem a taint impede o pod de subir?**  
   Não. Um node sem taints não tem restrições adicionais, então qualquer pod pode ser agendado nele, mesmo que o pod tenha tolerations. A toleration simplesmente não será utilizada nesse caso.

---

### Exemplos práticos:

#### Exemplo 1: Taint + Toleration
- **Node:** `taint=example:NoSchedule`
- **Pod:** tem a toleration correspondente.

Resultado:  
O pod pode ser agendado nesse node porque ele "tolera" a taint.

#### Exemplo 2: Sem Taint
- **Node:** não tem nenhuma taint.
- **Pod:** tem uma toleration.

Resultado:  
O pod pode ser agendado nesse node sem problemas, pois a toleration não restringe o agendamento a nodes com taints.

#### Exemplo 3: Taint sem Toleration
- **Node:** `taint=example:NoSchedule`
- **Pod:** não tem nenhuma toleration.

Resultado:  
O pod **não será agendado** nesse node, porque ele não tolera a taint presente.

---

Se precisar de mais detalhes ou exemplos sobre como configurar isso, é só avisar! 😊




controlplane ~ ➜  

controlplane ~ ➜  kubectl describe node controlplane
Name:               controlplane
Roles:              control-plane
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/arch=amd64
                    kubernetes.io/hostname=controlplane
                    kubernetes.io/os=linux
                    node-role.kubernetes.io/control-plane=
                    node.kubernetes.io/exclude-from-external-load-balancers=
Annotations:        kubeadm.alpha.kubernetes.io/cri-socket: unix:///var/run/containerd/containerd.sock
                    node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Sun, 12 Jan 2025 14:40:41 +0000
Taints:             <none>
Unschedulable:      false
Lease:
  HolderIdentity:  controlplane
  AcquireTime:     <unset>
  RenewTime:       Sun, 12 Jan 2025 15:18:42 +0000
Conditions:
  Type                 Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----                 ------  -----------------                 ------------------                ------                       -------
  NetworkUnavailable   False   Sun, 12 Jan 2025 14:40:56 +0000   Sun, 12 Jan 2025 14:40:56 +0000   WeaveIsUp                    Weave pod has set this
  MemoryPressure       False   Sun, 12 Jan 2025 15:18:28 +0000   Sun, 12 Jan 2025 14:40:38 +0000   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure         False   Sun, 12 Jan 2025 15:18:28 +0000   Sun, 12 Jan 2025 14:40:38 +0000   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure          False   Sun, 12 Jan 2025 15:18:28 +0000   Sun, 12 Jan 2025 14:40:38 +0000   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready                True    Sun, 12 Jan 2025 15:18:28 +0000   Sun, 12 Jan 2025 14:40:51 +0000   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  192.10.228.6
  Hostname:    controlplane
Capacity:
  cpu:                36
  ephemeral-storage:  1016057248Ki
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214587048Ki
  pods:               110
Allocatable:
  cpu:                36
  ephemeral-storage:  936398358207
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             214484648Ki
  pods:               110
System Info:
  Machine ID:                 132e3d2451f947fe9214456160254717
  System UUID:                94b55166-4127-739c-a835-d74215feb39c
  Boot ID:                    257c4359-855e-4a22-83a8-a3192aade72c
  Kernel Version:             5.4.0-1106-gcp
  OS Image:                   Ubuntu 22.04.4 LTS
  Operating System:           linux
  Architecture:               amd64
  Container Runtime Version:  containerd://1.6.26
  Kubelet Version:            v1.31.0
  Kube-Proxy Version:         
PodCIDR:                      10.244.0.0/24
PodCIDRs:                     10.244.0.0/24
Non-terminated Pods:          (9 in total)
  Namespace                   Name                                    CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                    ------------  ----------  ---------------  -------------  ---
  hr                          hr-pod                                  0 (0%)        0 (0%)      0 (0%)           0 (0%)         31m
  kube-system                 coredns-77d6fd4654-b6fk6                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     37m
  kube-system                 coredns-77d6fd4654-drl2c                100m (0%)     0 (0%)      70Mi (0%)        170Mi (0%)     37m
  kube-system                 etcd-controlplane                       100m (0%)     0 (0%)      100Mi (0%)       0 (0%)         38m
  kube-system                 kube-apiserver-controlplane             250m (0%)     0 (0%)      0 (0%)           0 (0%)         38m
  kube-system                 kube-contro1ler-manager-controlplane    200m (0%)     0 (0%)      0 (0%)           0 (0%)         30m
  kube-system                 kube-proxy-cksrl                        0 (0%)        0 (0%)      0 (0%)           0 (0%)         37m
  kube-system                 kube-scheduler-controlplane             100m (0%)     0 (0%)      0 (0%)           0 (0%)         38m
  kube-system                 weave-net-hn7nn                         100m (0%)     0 (0%)      200Mi (0%)       0 (0%)         37m
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                950m (2%)   0 (0%)
  memory             440Mi (0%)  340Mi (0%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
Events:
  Type     Reason                   Age   From             Message
  ----     ------                   ----  ----             -------
  Normal   Starting                 37m   kube-proxy       
  Normal   Starting                 38m   kubelet          Starting kubelet.
  Warning  CgroupV1                 38m   kubelet          Cgroup v1 support is in maintenance mode, please migrate to Cgroup v2.
  Warning  InvalidDiskCapacity      38m   kubelet          invalid capacity 0 on image filesystem
  Normal   NodeAllocatableEnforced  38m   kubelet          Updated Node Allocatable limit across pods
  Normal   NodeHasSufficientMemory  38m   kubelet          Node controlplane status is now: NodeHasSufficientMemory
  Normal   NodeHasNoDiskPressure    38m   kubelet          Node controlplane status is now: NodeHasNoDiskPressure
  Normal   NodeHasSufficientPID     38m   kubelet          Node controlplane status is now: NodeHasSufficientPID
  Normal   RegisteredNode           37m   node-controller  Node controlplane event: Registered Node controlplane in Controller
  Normal   NodeReady                37m   kubelet          Node controlplane status is now: NodeReady



controlplane ~ ➜  kubectl get pod -o wide
NAME                           READY   STATUS    RESTARTS   AGE   IP             NODE     NOMINATED NODE   READINESS GATES
dev-redis                      1/1     Running   0          34m   10.244.192.5   node01   <none>           <none>
multi-pod                      2/2     Running   0          35m   10.244.192.2   node01   <none>           <none>
nginx-deploy-db7c4d999-qtqrp   1/1     Running   0          32m   10.244.192.7   node01   <none>           <none>
non-root-pod                   1/1     Running   0          35m   10.244.192.3   node01   <none>           <none>
np-test-1                      1/1     Running   0          35m   10.244.192.4   node01   <none>           <none>
prod-redis                     1/1     Running   0          33m   10.244.192.6   node01   <none>           <none>
pvviewer-794bff5687-7xzpf      1/1     Running   0          36m   10.244.192.1   node01   <none>           <none>

controlplane ~ ➜  


kubectl get deployment/nginx-deploy -o yaml

kubectl edit deployment/nginx-deploy

removendo strategy

kubectl rollout restart deployment <NOME_DO_DEPLOYMENT>
kubectl rollout restart deployment nginx-deploy

controlplane ~ ➜  kubectl rollout restart deployment nginx-deploy
deployment.apps/nginx-deploy restarted

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get rs
NAME                  DESIRED   CURRENT   READY   AGE
pvviewer-794bff5687   1         1         1       43m

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   1/3     1            1           38m
pvviewer       1/1     1            1           43m

controlplane ~ ➜  

7. Certifique-se de que o controlador do Deployment está funcionando

O controlador do Deployment é responsável por gerenciar a atualização. Verifique se o cluster está em bom estado:

kubectl get componentstatuses

Se algo estiver Unhealthy, pode haver problemas no cluster que estão afetando o Deployment.

controlplane ~ ➜  kubectl get componentstatuses
Warning: v1 ComponentStatus is deprecated in v1.19+
NAME                 STATUS      MESSAGE                                                                                        ERROR
controller-manager   Unhealthy   Get "https://127.0.0.1:10257/healthz": dial tcp 127.0.0.1:10257: connect: connection refused   
scheduler            Healthy     ok                                                                                             
etcd-0               Healthy     ok                                                                                             

controlplane ~ ➜  
8. Logs do Controller Manager

Se nada resolver, você pode verificar os logs do controlador do Kubernetes (caso tenha acesso ao cluster):

kubectl -n kube-system logs <NOME_DO_POD_DO_CONTROLLER_MANAGER>

O status **Unhealthy** do `controller-manager` indica um problema no **controlador central do Kubernetes**, que é responsável por gerenciar operações como escalonamento de `Deployments`, controle de réplicas, e atualizações.

### **Causa provável**
O erro:  
`Get "https://127.0.0.1:10257/healthz": dial tcp 127.0.0.1:10257: connect: connection refused`  
indica que o Kubernetes está tentando acessar o endpoint `/healthz` do `controller-manager`, mas não consegue se conectar a ele. Isso geralmente ocorre por problemas de configuração ou falhas no serviço do `controller-manager`.

---

### **Como resolver?**

#### **1. Verifique os pods no namespace `kube-system`**
Liste os pods para ver se o `controller-manager` está ativo e funcionando:

```bash
kubectl get pods -n kube-system
```

Procure pelo pod relacionado ao `kube-controller-manager`. Ele geralmente tem um nome como `kube-controller-manager-<NOME_DO_NODE>`.

- **Se o pod está em erro ou CrashLoopBackOff:**
  Verifique os logs do pod:
  ```bash
  kubectl logs -n kube-system <NOME_DO_POD_DO_CONTROLLER_MANAGER>
  ```

#### **2. Verifique o status dos nodes**
Certifique-se de que todos os nodes estão operacionais:

```bash
kubectl get nodes
```

Se o node mestre estiver **NotReady**, o problema pode ser mais geral, relacionado à conectividade, recursos insuficientes, ou configuração incorreta.

#### **3. Diagnóstico do processo do `kube-controller-manager`**
O `controller-manager` pode não estar rodando corretamente no node mestre.

- **Se você está usando um cluster configurado manualmente (não gerenciado):**  
  Verifique o status do serviço no node mestre:

  ```bash
  systemctl status kube-controller-manager
  ```

  - **Se o serviço não está rodando**, tente reiniciá-lo:
    ```bash
    systemctl restart kube-controller-manager
    ```

- **Se você está usando um cluster gerenciado (como AKS, EKS, ou GKE):**  
  Entre em contato com o suporte do provedor, pois a manutenção do plano de controle geralmente é responsabilidade deles.

#### **4. Verifique as configurações do arquivo de manifest**
Se o `controller-manager` é gerenciado por um **manifest estático** (em `/etc/kubernetes/manifests/`), verifique o arquivo correspondente (`kube-controller-manager.yaml`):

```bash
cat /etc/kubernetes/manifests/kube-controller-manager.yaml
```

Procure por problemas como:
- Caminhos errados para certificados ou arquivos.
- Configurações incorretas de endpoints.

#### **5. Problemas de rede**
Certifique-se de que o `controller-manager` consegue se comunicar com outros componentes, como o **etcd**. No node mestre, teste a conectividade com o etcd:

```bash
curl -k https://127.0.0.1:2379/health
```

Deve retornar algo como:
```json
{"health":"true"}
```

#### **6. Logs adicionais**
Verifique os logs do sistema no node mestre para mensagens de erro relevantes:

```bash
journalctl -u kube-controller-manager
```

#### **7. Valide a configuração geral do cluster**
Certifique-se de que os componentes estão configurados corretamente. Ferramentas como o `kubeadm` podem ajudar a verificar problemas de configuração:

```bash
kubeadm config view
```

---

### **Soluções temporárias (workarounds)**
1. **Reinicie os componentes do master node:**
   ```bash
   systemctl restart kubelet
   ```

2. **Force a recriação do pod estático do `controller-manager`:**  
   Delete o arquivo de manifest temporariamente e reaponte:
   ```bash
   mv /etc/kubernetes/manifests/kube-controller-manager.yaml /tmp/
   mv /tmp/kube-controller-manager.yaml /etc/kubernetes/manifests/
   ```

---

Se mesmo assim o problema persistir, envie os logs do `kube-controller-manager` ou o conteúdo do arquivo `kube-controller-manager.yaml` para que eu possa ajudar com mais detalhes! 😊


controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS             RESTARTS      AGE
coredns-77d6fd4654-b6fk6               1/1     Running            0             48m
coredns-77d6fd4654-drl2c               1/1     Running            0             48m
etcd-controlplane                      1/1     Running            0             48m
kube-apiserver-controlplane            1/1     Running            0             48m
kube-contro1ler-manager-controlplane   0/1     ImagePullBackOff   0             40m
kube-proxy-2wvbl                       1/1     Running            0             48m
kube-proxy-cksrl                       1/1     Running            0             48m
kube-scheduler-controlplane            1/1     Running            0             48m
weave-net-hn7nn                        2/2     Running            1 (48m ago)   48m
weave-net-vbdgh                        2/2     Running            0             48m

controlplane ~ ➜  



controlplane ~ ➜  cat /etc/kubernetes/manifests/
etcd.yaml                     kube-apiserver.yaml           kube-controller-manager.yaml  .kubelet-keep                 kube-scheduler.yaml

controlplane ~ ➜  cat /etc/kubernetes/manifests/kube-controller-manager.yaml 
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    component: kube-contro1ler-manager
    tier: control-plane
  name: kube-contro1ler-manager
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-contro1ler-manager
    - --allocate-node-cidrs=true
    - --authentication-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --authorization-kubeconfig=/etc/kubernetes/controller-manager.conf
    - --bind-address=127.0.0.1
    - --client-ca-file=/etc/kubernetes/pki/ca.crt
    - --cluster-cidr=10.244.0.0/16
    - --cluster-name=kubernetes
    - --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
    - --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
    - --controllers=*,bootstrapsigner,tokencleaner
    - --kubeconfig=/etc/kubernetes/controller-manager.conf
    - --leader-elect=true
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --root-ca-file=/etc/kubernetes/pki/ca.crt
    - --service-account-private-key-file=/etc/kubernetes/pki/sa.key
    - --service-cluster-ip-range=10.96.0.0/12
    - --use-service-account-credentials=true
    image: registry.k8s.io/kube-contro1ler-manager:v1.31.0
    imagePullPolicy: IfNotPresent
    livenessProbe:
      failureThreshold: 8
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    name: kube-contro1ler-manager
    resources:
      requests:
        cpu: 200m
    startupProbe:
      failureThreshold: 24
      httpGet:
        host: 127.0.0.1
        path: /healthz
        port: 10257
        scheme: HTTPS
      initialDelaySeconds: 10
      periodSeconds: 10
      timeoutSeconds: 15
    volumeMounts:
    - mountPath: /etc/ssl/certs
      name: ca-certs
      readOnly: true
    - mountPath: /etc/ca-certificates
      name: etc-ca-certificates
      readOnly: true
    - mountPath: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      name: flexvolume-dir
    - mountPath: /etc/kubernetes/pki
      name: k8s-certs
      readOnly: true
    - mountPath: /etc/kubernetes/controller-manager.conf
      name: kubeconfig
      readOnly: true
    - mountPath: /usr/local/share/ca-certificates
      name: usr-local-share-ca-certificates
      readOnly: true
    - mountPath: /usr/share/ca-certificates
      name: usr-share-ca-certificates
      readOnly: true
  hostNetwork: true
  priority: 2000001000
  priorityClassName: system-node-critical
  securityContext:
    seccompProfile:
      type: RuntimeDefault
  volumes:
  - hostPath:
      path: /etc/ssl/certs
      type: DirectoryOrCreate
    name: ca-certs
  - hostPath:
      path: /etc/ca-certificates
      type: DirectoryOrCreate
    name: etc-ca-certificates
  - hostPath:
      path: /usr/libexec/kubernetes/kubelet-plugins/volume/exec
      type: DirectoryOrCreate
    name: flexvolume-dir
  - hostPath:
      path: /etc/kubernetes/pki
      type: DirectoryOrCreate
    name: k8s-certs
  - hostPath:
      path: /etc/kubernetes/controller-manager.conf
      type: FileOrCreate
    name: kubeconfig
  - hostPath:
      path: /usr/local/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-local-share-ca-certificates
  - hostPath:
      path: /usr/share/ca-certificates
      type: DirectoryOrCreate
    name: usr-share-ca-certificates
status: {}

controlplane ~ ➜  



controlplane ~ ➜  vi /etc/kubernetes/manifests/kube-controller-manager.yaml 

controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS      AGE
coredns-77d6fd4654-b6fk6               1/1     Running   0             50m
coredns-77d6fd4654-drl2c               1/1     Running   0             50m
etcd-controlplane                      1/1     Running   0             50m
kube-apiserver-controlplane            1/1     Running   0             50m
kube-controller-manager-controlplane   0/1     Running   0             2s
kube-proxy-2wvbl                       1/1     Running   0             50m
kube-proxy-cksrl                       1/1     Running   0             50m
kube-scheduler-controlplane            1/1     Running   0             50m
weave-net-hn7nn                        2/2     Running   1 (50m ago)   50m
weave-net-vbdgh                        2/2     Running   0             50m

controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS      AGE
coredns-77d6fd4654-b6fk6               1/1     Running   0             51m
coredns-77d6fd4654-drl2c               1/1     Running   0             51m
etcd-controlplane                      1/1     Running   0             51m
kube-apiserver-controlplane            1/1     Running   0             51m
kube-controller-manager-controlplane   0/1     Running   0             8s
kube-proxy-2wvbl                       1/1     Running   0             50m
kube-proxy-cksrl                       1/1     Running   0             51m
kube-scheduler-controlplane            1/1     Running   0             51m
weave-net-hn7nn                        2/2     Running   1 (50m ago)   51m
weave-net-vbdgh                        2/2     Running   0             50m

controlplane ~ ➜  date
Sun Jan 12 03:31:51 PM UTC 2025

controlplane ~ ➜  kubectl get pods -n kube-system
NAME                                   READY   STATUS    RESTARTS      AGE
coredns-77d6fd4654-b6fk6               1/1     Running   0             51m
coredns-77d6fd4654-drl2c               1/1     Running   0             51m
etcd-controlplane                      1/1     Running   0             51m
kube-apiserver-controlplane            1/1     Running   0             51m
kube-controller-manager-controlplane   1/1     Running   0             11s
kube-proxy-2wvbl                       1/1     Running   0             50m
kube-proxy-cksrl                       1/1     Running   0             51m
kube-scheduler-controlplane            1/1     Running   0             51m
weave-net-hn7nn                        2/2     Running   1 (51m ago)   51m
weave-net-vbdgh                        2/2     Running   0             50m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get pods
NAME                           READY   STATUS    RESTARTS   AGE
dev-redis                      1/1     Running   0          46m
multi-pod                      2/2     Running   0          47m
nginx-deploy-86576fdbb-477dh   1/1     Running   0          8s
nginx-deploy-86576fdbb-8fj8j   1/1     Running   0          8s
nginx-deploy-86576fdbb-lx9k4   1/1     Running   0          8s
non-root-pod                   1/1     Running   0          47m
np-test-1                      1/1     Running   0          47m
prod-redis                     1/1     Running   0          45m
pvviewer-794bff5687-7xzpf      1/1     Running   0          48m

controlplane ~ ➜  kubectl get deploy
NAME           READY   UP-TO-DATE   AVAILABLE   AGE
nginx-deploy   3/3     3            3           44m
pvviewer       1/1     1            1           48m

controlplane ~ ➜  kubectl get rs
NAME                     DESIRED   CURRENT   READY   AGE
nginx-deploy-86576fdbb   3         3         3       15s
pvviewer-794bff5687      1         1         1       48m

controlplane ~ ➜  





- Questoes
resultados

Your score
62%
Pass Percentage - 74% 


erradas:

### q1

erradas:
"Pod: pvviewer

Pod configured to use ServiceAccount pvviewer ?
"

Task

Create a new service account with the name pvviewer. Grant this Service account access to list all PersistentVolumes in the cluster by creating an appropriate cluster role called pvviewer-role and ClusterRoleBinding called pvviewer-role-binding.
Next, create a pod called pvviewer with the image: redis and serviceAccount: pvviewer in the default namespace.
Solution

Pods authenticate to the API Server using ServiceAccounts. If the serviceAccount name is not specified, the default service account for the namespace is used during a pod creation.

Reference: https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/

Now, create a service account pvviewer:

kubectl create serviceaccount pvviewer

To create a clusterrole:

kubectl create clusterrole pvviewer-role --resource=persistentvolumes --verb=list

To create a clusterrolebinding:

kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer

Solution manifest file to create a new pod called pvviewer as follows:

---
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: pvviewer
  name: pvviewer
spec:
  containers:
  - image: redis
    name: pvviewer
  # Add service account name
  serviceAccountName: pvviewer

Details

ServiceAccount: pvviewer

ClusterRole: pvviewer-role

ClusterRoleBinding: pvviewer-role-binding

Pod: pvviewer

Pod configured to use ServiceAccount pvviewer ?


### q5

errada: "NetworkPolicy: Applied to All sources (Incoming traffic from all pods)?"

Task

We have deployed a new pod called np-test-1 and a service called np-test-service. Incoming connections to this service are not working. Troubleshoot and fix it.
Create NetworkPolicy, by the name ingress-to-nptest that allows incoming connections to the service over port 80.

Important: Don't delete any current objects deployed.
Solution

Solution manifest file to create a network policy ingress-to-nptest as follows:

---
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: ingress-to-nptest
  namespace: default
spec:
  podSelector:
    matchLabels:
      run: np-test-1
  policyTypes:
  - Ingress
  ingress:
  - ports:
    - protocol: TCP
      port: 80

Details

Important: Don't Alter Existing Objects!

NetworkPolicy: Applied to All sources (Incoming traffic from all pods)?

NetWorkPolicy: Correct Port?

NetWorkPolicy: Applied to correct Pod?




### q6

errada: "pod 'dev-redis' (no tolerations) is not scheduled on node01?"

Task

Taint the worker node node01 to be Unschedulable. Once done, create a pod called dev-redis, image redis:alpine, to ensure workloads are not scheduled to this worker node. Finally, create a new pod called prod-redis and image: redis:alpine with toleration to be scheduled on node01.

key: env_type, value: production, operator: Equal and effect: NoSchedule
Solution

To add taints on the node01 worker node:

kubectl taint node node01 env_type=production:NoSchedule

Now, deploy dev-redis pod and to ensure that workloads are not scheduled to this node01 worker node.

kubectl run dev-redis --image=redis:alpine

To view the node name of recently deployed pod:

kubectl get pods -o wide

Solution manifest file to deploy new pod called prod-redis with toleration to be scheduled on node01 worker node.

---
apiVersion: v1
kind: Pod
metadata:
  name: prod-redis
spec:
  containers:
  - name: prod-redis
    image: redis:alpine
  tolerations:
  - effect: NoSchedule
    key: env_type
    operator: Equal
    value: production     

To view only prod-redis pod with less details:

kubectl get pods -o wide | grep prod-redis

Details

Key = env_type

Value = production

Effect = NoSchedule

pod 'dev-redis' (no tolerations) is not scheduled on node01?

Create a pod 'prod-redis' to run on node01







# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## Dia 17/01/2025

- Questoes
resultados

Your score
62%
Pass Percentage - 74% 

- TSHOOT questoes erradas
erradas


### 1 / 9
Weight: 12

Create a new service account with the name pvviewer. Grant this Service account access to list all PersistentVolumes in the cluster by creating an appropriate cluster role called pvviewer-role and ClusterRoleBinding called pvviewer-role-binding.
Next, create a pod called pvviewer with the image: redis and serviceAccount: pvviewer in the default namespace.

ServiceAccount: pvviewer

ClusterRole: pvviewer-role

ClusterRoleBinding: pvviewer-role-binding

Pod: pvviewer

Pod configured to use ServiceAccount pvviewer ?


kubectl create serviceaccount pvviewer
kubectl create clusterrole pvviewer-role --resource=persistentvolumes --verb=list
kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer

apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: pvviewer
  name: pvviewer
spec:
  containers:
  - image: redis
    name: pvviewer
    resources: {}
  serviceAccountName: pvviewer


- Criar um Deployment é diferente de criar um Pod, no caso da questão1, eu havia criado um Deployment para criar o Pod, então computou como erro.
atenção!


controlplane ~ ➜  kubectl create serviceaccount pvviewer
kubectl create clusterrole pvviewer-role --resource=persistentvolumes --verb=list
kubectl create clusterrolebinding pvviewer-role-binding --clusterrole=pvviewer-role --serviceaccount=default:pvviewer
serviceaccount/pvviewer created
clusterrole.rbac.authorization.k8s.io/pvviewer-role created
clusterrolebinding.rbac.authorization.k8s.io/pvviewer-role-binding created

controlplane ~ ➜  vi questao1-pod.yaml

controlplane ~ ➜  kubectl apply -f questao1-pod.yaml
pod/pvviewer created

controlplane ~ ➜  date
Fri Jan 17 11:39:15 AM UTC 2025

controlplane ~ ➜  



### 2 / 9
Weight: 12

List the InternalIP of all nodes of the cluster. Save the result to a file /root/CKA/node_ips.

Answer should be in the format: InternalIP of controlplane<space>InternalIP of node01 (in a single line)

Task Completed


kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips

controlplane ~ ➜  kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}' > /root/CKA/node_ips

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


/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao3--pod-multi-containers-variaveis.yaml

controlplane ~ ➜  vi questao3-pod-multi-pod.yaml

controlplane ~ ➜  kubectl apply -f questao3-pod-multi-pod.yaml
pod/multi-pod created





### 4 / 9
Weight: 8

Create a Pod called non-root-pod , image: redis:alpine

runAsUser: 1000

fsGroup: 2000

Pod non-root-pod fsGroup configured

Pod non-root-pod runAsUser configured


controlplane ~ ➜  vi questao4-pod.yaml

controlplane ~ ➜  kubectl apply -f questao4-pod.yaml
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


O que eu havia aplicado antes:

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


- Exemplo da documentação do Kubernetes:

https://kubernetes.io/docs/concepts/services-networking/network-policies/
<https://kubernetes.io/docs/concepts/services-networking/network-policies/>

An example NetworkPolicy might look like this:
service/networking/networkpolicy.yaml
[Copy service/networking/networkpolicy.yaml to clipboard]

apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: test-network-policy
  namespace: default
spec:
  podSelector:
    matchLabels:
      role: db
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - ipBlock:
        cidr: 172.17.0.0/16
        except:
        - 172.17.1.0/24
    - namespaceSelector:
        matchLabels:
          project: myproject
    - podSelector:
        matchLabels:
          role: frontend
    ports:
    - protocol: TCP
      port: 6379
  egress:
  - to:
    - ipBlock:
        cidr: 10.0.0.0/24
    ports:
    - protocol: TCP
      port: 5978

policyTypes: Each NetworkPolicy includes a policyTypes list which may include either Ingress, Egress, or both. 
The policyTypes field indicates whether or not the given policy applies to ingress traffic to selected pod, egress traffic from selected pods, or both. 
If no policyTypes are specified on a NetworkPolicy then by default Ingress will always be set and Egress will be set if the NetworkPolicy has any egress rules.


- Correção a ser aplicada:

5. Run the below command for solution:  
 
     <details>
 
     ```
     apiVersion: networking.k8s.io/v1
     kind: NetworkPolicy
     metadata:
       name: ingress-to-nptest
       namespace: default
     spec:
       podSelector:
         matchLabels:
           run: np-test-1
       policyTypes:
       - Ingress
       ingress:
       - ports:
         - protocol: TCP
           port: 80
     ```
     </details>


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

controlplane ~ ➜  vi questao5-netpol.yaml

controlplane ~ ➜  kubectl apply -f questao5-netpol.yaml
networkpolicy.networking.k8s.io/ingress-to-nptest created

controlplane ~ ➜  



### 6 / 9
kubectl run dev-redis --image=redis:alpine
kubectl taint nodes node01 env_type=production:NoSchedule
kubectl run prod-redis --image=redis:alpine -o yaml --dry-run=client
/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao7-pod-toleration.yaml

controlplane ~ ➜  vi questao7.yaml

controlplane ~ ➜  kubectl apply -f questao7.yaml
pod/prod-redis created


### 7 / 9
kubectl create ns hr
kubectl run hr-pod --namespace=hr --image=redis:alpine --labels="environment=production,tier=frontend"

controlplane ~ ➜  kubectl create ns hr
namespace/hr created

controlplane ~ ➜  kubectl run hr-pod --namespace=hr --image=redis:alpine --labels="environment=production,tier=frontend"
pod/hr-pod created

controlplane ~ ➜  

### 8 / 9
- Ajustando porta
de
9999
para
6443

vi /root/CKA/super.kubeconfig



### 9 / 9
kubectl get deployment/nginx-deploy -o yaml

kubectl edit deployment/nginx-deploy

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao16-Mock-exams/273-x--questao9-kube-controller.yaml
https://www.illumine.tw/xkldimedn11/kubernetes-waiting-for-deployment-spec-update-to-be-observed



# ###################################################################################################################### 
# ###################################################################################################################### 
## PENDENTE

- Questoes
resultados

Your score
62%
Pass Percentage - 74% 

- TSHOOT questoes erradas
erradas



# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO - DICAS

- Criar um Deployment é diferente de criar um Pod, no caso da questão1, eu havia criado um Deployment para criar o Pod, então computou como erro.
atenção!

- Para Network Policy, cuidar o trecho "policyTypes"
  policyTypes:
  - Ingress
  - Egress

- Usar o comando abaixo para descobrir resources
kubectl api-resources
fonte:
<https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/>



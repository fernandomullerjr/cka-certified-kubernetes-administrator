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



# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO - DICAS

- Usar o comando abaixo para descobrir resources
kubectl api-resources
fonte:
<https://kubernetes.io/docs/reference/kubectl/generated/kubectl_api-resources/>

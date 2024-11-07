#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "270. Solution - Mock Exam -1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  270. Solution - Mock Exam -1

### RECOMENDAÇÃO - CONFIGURAR ATALHOS

<https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/>
kubectl Cheat Sheet

Esta página contém uma lista de comandos kubectl e flags frequentemente usados.

Kubectl Autocomplete

~~~~BASH
source <(kubectl completion bash) # configuração de autocomplete no bash do shell atual, o pacote bash-completion precisa ter sido instalado primeiro.
echo "source <(kubectl completion bash)" >> ~/.bashrc # para adicionar o autocomplete permanentemente no seu shell bash.
~~~~


Você também pode usar uma abreviação para o atalho para kubectl que também funciona com o auto completar:

~~~~BASH
alias k=kubectl
complete -o default -F __start_kubectl k
~~~~








### 1 / 12
Weight: 6

Deploy a pod named nginx-pod using the nginx:alpine image.

Once done, click on the Next Question button in the top right corner of this panel. You may navigate back and forth freely between all questions. Once done with all questions, click on End Exam. Your work will be validated at the end and score shown. Good Luck!

Name: nginx-pod

Image: nginx:alpine


- Ideia é fornecer resposta rápida, usando comando imperativo:
k run nginx-pod --image=nginx:alpine






### 2 / 12
Weight: 8

Deploy a messaging pod using the redis:alpine image with the labels set to tier=msg.

Pod Name: messaging

Image: redis:alpine

Labels: tier=msg



~~~~bash
controlplane ~ ➜  k run --help
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

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --annotations=[]:
        Annotations to apply to the pod.

    --attach=false:
        If true, wait for the Pod to start running, and then attach to the Pod as if 'kubectl attach ...' were called.
        Default false, unless '-i/--stdin' is set, in which case the default is true. With '--restart=Never' the exit
        code of the container process is returned.

    --cascade='background':
        Must be "background", "orphan", or "foreground". Selects the deletion cascading strategy for the dependents
        (e.g. Pods created by a ReplicationController). Defaults to background.

    --command=false:
        If true and extra arguments are present, use them as the 'command' field in the container, rather than the
        'args' field which is the default.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --env=[]:
        Environment variables to set in the container.

    --expose=false:
        If true, create a ClusterIP service associated with the pod.  Requires `--port`.

    --field-manager='kubectl-run':
        Name of the manager used to track field ownership.

    -f, --filename=[]:
        to use to replace the resource.

    --force=false:
        If true, immediately remove resources from API and bypass graceful deletion. Note that immediate deletion of
        some resources may result in inconsistency or data loss and requires confirmation.

    --grace-period=-1:
        Period of time in seconds given to the resource to terminate gracefully. Ignored if negative. Set to 1 for
        immediate shutdown. Can only be set to 0 when --force is true (force deletion).

    --image='':
        The image for the container to run.

    --image-pull-policy='':
        The image pull policy for the container.  If left empty, this value will not be specified by the client and
        defaulted by the server.

    -k, --kustomize='':
        Process a kustomization directory. This flag can't be used together with -f or -R.

    -l, --labels='':
        Comma separated labels to apply to the pod. Will override previous values.

    --leave-stdin-open=false:
        If the pod is started in interactive mode or with stdin, leave stdin open after the first attach completes. By
        default, stdin will be closed after the first attach completes.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --override-type='merge':
        The method used to override the generated object: json, merge, or strategic.

    --overrides='':
        An inline JSON override for the generated object. If this is non-empty, it is used to override the generated
        object. Requires that the object supply a valid apiVersion field.

    --pod-running-timeout=1m0s:
        The length of time (like 5s, 2m, or 3h, higher than zero) to wait until at least one pod is running

    --port='':
        The port that this container exposes.

    --privileged=false:
        If true, run the container in privileged mode.

    -q, --quiet=false:
        If true, suppress prompt messages.

    -R, --recursive=false:
        Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
        organized within the same directory.

    --restart='Always':
        The restart policy for this Pod.  Legal values [Always, OnFailure, Never].

    --rm=false:
        If true, delete the pod after it exits.  Only valid when attaching to the container, e.g. with '--attach' or
        with '-i/--stdin'.

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
        be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    -i, --stdin=false:
        Keep stdin open on the container in the pod, even if nothing is attached.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
        is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --timeout=0s:
        The length of time to wait before giving up on a delete, zero means determine a timeout from the size of the
        object

    -t, --tty=false:
        Allocate a TTY for the container in the pod.

    --wait=false:
        If true, wait for resources to be gone before returning. This waits for finalizers.

Usage:
  kubectl run NAME --image=image [--env="key=value"] [--port=port] [--dry-run=server|client] [--overrides=inline-json]
[--command] -- [COMMAND] [args...] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  
~~~~


- Comando ajustado
kubectl run messaging --image=redis:alpine --labels="tier=msg"








### 3 / 12
Weight: 4

Create a namespace named apx-x9984574.

Namespace: apx-x9984574


k create ns apx-x9984574





continua em:
4:60





### 4 / 12
Weight: 7

Get the list of nodes in JSON format and store it in a file at /opt/outputs/nodes-z3444kd9.json.

Task completed

k get nodes -o json > /opt/outputs/nodes-z3444kd9.json






### 5 / 12
Weight: 12

Create a service messaging-service to expose the messaging application within the cluster on port 6379.

Use imperative commands.

Service: messaging-service

Port: 6379

Type: ClusterIp

Use the right labels

kubectl expose pod messaging --port=6379 --name messaging-service

~~~~bash

controlplane ~ ➜  k expose --help
Expose a resource as a new Kubernetes service.

 Looks up a deployment, service, replica set, replication controller or pod by name and uses the selector for that
resource as the selector for a new service on the specified port. A deployment or replica set will be exposed as a
service only if its selector is convertible to a selector that service supports, i.e. when the selector contains only
the matchLabels component. Note that if no port is specified via --port and the exposed resource has multiple ports, all
will be re-used by the new service. Also if no labels are specified, the new service will re-use the labels from the
resource it exposes.

 Possible resources include (case insensitive):

 pod (po), service (svc), replicationcontroller (rc), deployment (deploy), replicaset (rs)

Examples:
  # Create a service for a replicated nginx, which serves on port 80 and connects to the containers on port 8000
  kubectl expose rc nginx --port=80 --target-port=8000
  
  # Create a service for a replication controller identified by type and name specified in "nginx-controller.yaml",
which serves on port 80 and connects to the containers on port 8000
  kubectl expose -f nginx-controller.yaml --port=80 --target-port=8000
  
  # Create a service for a pod valid-pod, which serves on port 444 with the name "frontend"
  kubectl expose pod valid-pod --port=444 --name=frontend
  
  # Create a second service based on the above service, exposing the container port 8443 as port 443 with the name
"nginx-https"
  kubectl expose service nginx --port=443 --target-port=8443 --name=nginx-https
  
  # Create a service for a replicated streaming application on port 4100 balancing UDP traffic and named 'video-stream'.
  kubectl expose rc streamer --port=4100 --protocol=UDP --name=video-stream
  
  # Create a service for a replicated nginx using replica set, which serves on port 80 and connects to the containers on
port 8000
  kubectl expose rs nginx --port=80 --target-port=8000
  
  # Create a service for an nginx deployment, which serves on port 80 and connects to the containers on port 8000
  kubectl expose deployment nginx --port=80 --target-port=8000

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --cluster-ip='':
        ClusterIP to be assigned to the service. Leave empty to auto-allocate, or set to 'None' to create a headless
        service.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --external-ip='':
        Additional external IP address (not managed by Kubernetes) to accept for the service. If this IP is routed to
        a node, the service can be accessed by this IP in addition to its generated service IP.

    --field-manager='kubectl-expose':
        Name of the manager used to track field ownership.

    -f, --filename=[]:
        Filename, directory, or URL to files identifying the resource to expose a service

    -k, --kustomize='':
        Process the kustomization directory. This flag can't be used together with -f or -R.

    -l, --labels='':
        Labels to apply to the service created by this call.

    --load-balancer-ip='':
        IP to assign to the LoadBalancer. If empty, an ephemeral IP will be created and used (cloud-provider
        specific).

    --name='':
        The name for the newly created object.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --override-type='merge':
        The method used to override the generated object: json, merge, or strategic.

    --overrides='':
        An inline JSON override for the generated object. If this is non-empty, it is used to override the generated
        object. Requires that the object supply a valid apiVersion field.

    --port='':
        The port that the service should serve on. Copied from the resource being exposed, if unspecified

    --protocol='':
        The network protocol for the service to be created. Default is 'TCP'.

    -R, --recursive=false:
        Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
        organized within the same directory.

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
        be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --selector='':
        A label selector to use for this service. Only equality-based selector requirements are supported. If empty
        (the default) infer the selector from the replication controller or replica set.)

    --session-affinity='':
        If non-empty, set the session affinity for the service to this; legal values: 'None', 'ClientIP'

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    --target-port='':
        Name or number for the port on the container that the service should direct traffic to. Optional.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
        is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --type='':
        Type for this service: ClusterIP, NodePort, LoadBalancer, or ExternalName. Default is 'ClusterIP'.

Usage:
  kubectl expose (-f FILENAME | TYPE NAME) [--port=port] [--protocol=TCP|UDP|SCTP] [--target-port=number-or-name]
[--name=name] [--external-ip=external-ip-of-service] [--type=type] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  
~~~~











### 6 / 12
Weight: 11

Create a deployment named hr-web-app using the image kodekloud/webapp-color with 2 replicas.

Name: hr-web-app

Image: kodekloud/webapp-color

Replicas: 2


- Manifesto de base:

~~~~yaml
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: hr-web-app
  name: hr-web-app
spec:
  replicas: 2
  selector:
    matchLabels:
      app: hr-web-app
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: hr-web-app
    spec:
      containers:
      - image: kodekloud/webapp-color
        name: webapp-color
        resources: {}
status: {}
~~~~

In v1.19, we can add --replicas flag with kubectl create deployment command:
kubectl create deployment hr-web-app --image=kodekloud/webapp-color --replicas=2











### 7 / 12
Weight: 8

Create a static pod named static-busybox on the controlplane node that uses the busybox image and the command sleep 1000.

Name: static-busybox

Image: busybox


To Create a static pod, copy it to the static pods directory. In this case, it is /etc/kubernetes/manifests. Apply below manifests:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: static-busybox
  name: static-busybox
spec:
  containers:
  - command:
    - sleep
    - "1000"
    image: busybox
    name: static-busybox
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
~~~~

~~~~bash
 
  # Start the nginx pod using a different command and custom arguments
  kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>

~~~~

- Comando ajustado:

~~~~bash
k run nginx --image=busybox --dry-run=client -o yaml --command -- sleep 1000
~~~~

OBS:
Como é um Pod estático, cuidar para pegar só um dry-run e criar ele estático, na pasta ````/etc/kubernetes/manifests````.

~~~~yaml
controlplane ~ ➜  k run nginx --image=busybox --dry-run=client -o yaml --command -- sleep 1000
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - command:
    - sleep
    - "1000"
    image: busybox
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  
~~~~

- Comando ajustado, já enviando para o diretório de Pods estáticos:

~~~~bash
k run nginx --image=busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-pod.yaml
~~~~

OBS:
Como é um Pod estático, cuidar para pegar só um dry-run e criar ele estático, na pasta ````/etc/kubernetes/manifests````.



controlplane ~ ➜  k run nginx --image=busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-pod.yaml

controlplane ~ ➜  cat /etc/kubernetes/manifests/static-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - command:
    - sleep
    - "1000"
    image: busybox
    name: nginx
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

controlplane ~ ➜  




# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

### 1 / 12
- Ideia é fornecer resposta rápida, usando comando imperativo:
k run nginx-pod --image=nginx:alpine

### 2 / 12
- Comando ajustado
kubectl run messaging --image=redis:alpine --labels="tier=msg"

### 3 / 12
k create ns apx-x9984574

### 4 / 12
k get nodes -o json > /opt/outputs/nodes-z3444kd9.json

### 5 / 12
k expose pod messaging --port=6379 --name messaging-service

### 6 / 12
k create deployment hr-web-app --image=kodekloud/webapp-color --replicas=2

### 7 / 12
~~~~bash
k run nginx --image=busybox --dry-run=client -o yaml --command -- sleep 1000 > /etc/kubernetes/manifests/static-pod.yaml
~~~~
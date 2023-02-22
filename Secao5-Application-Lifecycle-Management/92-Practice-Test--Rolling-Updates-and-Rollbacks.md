
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 92. Practice Test - Rolling Updates and Rollbacks"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################

# 92. Practice Test - Rolling Updates and Rollbacks



Practice Test - Rolling Updates and Rollbacks

Practice Test: https://uklabs.kodekloud.com/topic/practice-test-rolling-updates-and-rollbacks-2/







We have deployed a simple web application. Inspect the PODs and the Services


Wait for the application to fully deploy and view the application using the link called Webapp Portal above your terminal.



controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-5d56847996-2csdm   1/1     Running     0          18m
kube-system   coredns-5c6b6c5476-sgvn6                  1/1     Running     0          18m
kube-system   helm-install-traefik-crd-lnkrj            0/1     Completed   0          18m
kube-system   helm-install-traefik-9vgl8                0/1     Completed   1          18m
kube-system   svclb-traefik-039eb2be-kfs48              2/2     Running     0          17m
kube-system   metrics-server-7b67f64457-mmttp           1/1     Running     0          18m
kube-system   traefik-56b8c5fb5c-b689v                  1/1     Running     0          17m
kube-public   curl                                      1/1     Running     0          68s
default       frontend-6fb456676-nf8vh                  1/1     Running     0          55s
default       frontend-6fb456676-2qk9t                  1/1     Running     0          55s
default       frontend-6fb456676-rtk46                  1/1     Running     0          55s
default       frontend-6fb456676-2z89v                  1/1     Running     0          54s

controlplane ~ ➜  










What is the current color of the web application?

Access the Webapp Portal.








Run the script named curl-test.sh to send multiple requests to test the web application. Take a note of the output.

Execute the script at /root/curl-test.sh.


controlplane ~ ➜  

controlplane ~ ➜  /root/curl-test.sh > saida-curl.txt

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  head saida-curl.txt 
Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK


controlplane ~ ➜  tail saida-curl.txt 
Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK

Hello, Application Version: v1 ; Color: blue OK


controlplane ~ ➜  














Inspect the deployment and identify the number of PODs deployed by it

 

controlplane ~ ➜  kubectl get deploy -A
NAMESPACE     NAME                     READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   local-path-provisioner   1/1     1            1           20m
kube-system   coredns                  1/1     1            1           20m
kube-system   metrics-server           1/1     1            1           20m
kube-system   traefik                  1/1     1            1           19m
default       frontend                 4/4     4            4           2m59s

controlplane ~ ➜  










What container image is used to deploy the applications?

controlplane ~ ➜  kubectl describe deployment frontend
Name:                   frontend
Namespace:              default
CreationTimestamp:      Wed, 22 Feb 2023 02:12:59 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=webapp
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        20
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=webapp
  Containers:
   simple-webapp:
    Image:        kodekloud/webapp-color:v1
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   frontend-6fb456676 (4/4 replicas created)
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  3m50s  deployment-controller  Scaled up replica set frontend-6fb456676 to 4

controlplane ~ ➜  



RESPOSTA:
kodekloud/webapp-color:v1











Inspect the deployment and identify the current strategy

StrategyType:           RollingUpdate








StrategyType:           RollingUpdate

















Let us try that. Upgrade the application by setting the image on the deployment to kodekloud/webapp-color:v2

Do not delete and re-create the deployment. Only set the new image name for the existing deployment.

    Deployment Name: frontend

    Deployment Image: kodekloud/webapp-color:v2



controlplane ~ ➜  kubectl get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
frontend   4/4     4            4           6m56s

controlplane ~ ➜  


controlplane ~ ✖ kubectl set deploy -h
Configure application resources.

 These commands help you make changes to existing application resources.

Available Commands:
  env              Update environment variables on a pod template
  image            Update the image of a pod template
  resources        Update resource requests/limits on objects with pod templates
  selector         Set the selector on a resource
  serviceaccount   Update the service account of a resource
  subject          Update the user, group, or service account in a role binding or cluster role binding

Usage:
  kubectl set SUBCOMMAND [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).



kubectl set deploy image=kodekloud/webapp-color:v2

não funcionou





controlplane ~ ➜  kubectl set image -h
Update existing container image(s) of resources.

 Possible resources include (case insensitive):

  pod (po), replicationcontroller (rc), deployment (deploy), daemonset (ds), statefulset (sts), cronjob (cj), replicaset
(rs)

Examples:
  # Set a deployment's nginx container image to 'nginx:1.9.1', and its busybox container image to 'busybox'
  kubectl set image deployment/nginx busybox=busybox nginx=nginx:1.9.1
  
  # Update all deployments' and rc's nginx container's image to 'nginx:1.9.1'
  kubectl set image deployments,rc nginx=nginx:1.9.1 --all
  
  # Update image of all containers of daemonset abc to 'nginx:1.9.1'
  kubectl set image daemonset abc *=nginx:1.9.1
  
  # Print result (in yaml format) of updating nginx container image from local file, without hitting the server
  kubectl set image -f path/to/file.yaml nginx=nginx:1.9.1 --local -o yaml






kubectl set image deployment/frontend simple-webapp=kodekloud/webapp-color:v2

controlplane ~ ➜  kubectl set image deployment/frontend simple-webapp=kodekloud/webapp-color:v2
deployment.apps/frontend image updated

controlplane ~ ➜  


controlplane ~ ➜  kubectl get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
frontend   5/4     2            3           10m

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS        RESTARTS   AGE
kube-system   local-path-provisioner-5d56847996-2csdm   1/1     Running       0          27m
kube-system   coredns-5c6b6c5476-sgvn6                  1/1     Running       0          27m
kube-system   helm-install-traefik-crd-lnkrj            0/1     Completed     0          27m
kube-system   helm-install-traefik-9vgl8                0/1     Completed     1          27m
kube-system   svclb-traefik-039eb2be-kfs48              2/2     Running       0          27m
kube-system   metrics-server-7b67f64457-mmttp           1/1     Running       0          27m
kube-system   traefik-56b8c5fb5c-b689v                  1/1     Running       0          27m
kube-public   curl                                      1/1     Running       0          10m
default       frontend-6fb456676-2z89v                  1/1     Running       0          10m
default       frontend-6fb456676-2qk9t                  1/1     Terminating   0          10m
default       frontend-6566d7d589-jv74l                 1/1     Running       0          29s
default       frontend-6566d7d589-nnpmk                 1/1     Running       0          28s
default       frontend-6fb456676-rtk46                  1/1     Terminating   0          10m
default       frontend-6fb456676-nf8vh                  1/1     Terminating   0          10m
default       frontend-6566d7d589-vtwhr                 1/1     Running       0          5s
default       frontend-6566d7d589-jxkp2                 1/1     Running       0          5s

controlplane ~ ➜  date
Wed Feb 22 02:23:22 UTC 2023

controlplane ~ ➜  



controlplane ~ ➜  kubectl describe deployment frontend
Name:                   frontend
Namespace:              default
CreationTimestamp:      Wed, 22 Feb 2023 02:12:59 +0000
Labels:                 <none>
Annotations:            deployment.kubernetes.io/revision: 2
Selector:               name=webapp
Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        20
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:  name=webapp
  Containers:
   simple-webapp:
    Image:        kodekloud/webapp-color:v2
    Port:         8080/TCP
    Host Port:    0/TCP
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   frontend-6566d7d589 (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  10m   deployment-controller  Scaled up replica set frontend-6fb456676 to 4
  Normal  ScalingReplicaSet  52s   deployment-controller  Scaled up replica set frontend-6566d7d589 to 1
  Normal  ScalingReplicaSet  52s   deployment-controller  Scaled down replica set frontend-6fb456676 to 3 from 4
  Normal  ScalingReplicaSet  51s   deployment-controller  Scaled up replica set frontend-6566d7d589 to 2 from 1
  Normal  ScalingReplicaSet  28s   deployment-controller  Scaled down replica set frontend-6fb456676 to 1 from 3
  Normal  ScalingReplicaSet  28s   deployment-controller  Scaled up replica set frontend-6566d7d589 to 4 from 2
  Normal  ScalingReplicaSet  4s    deployment-controller  Scaled down replica set frontend-6fb456676 to 0 from 1

controlplane ~ ➜  











Run the script curl-test.sh again. Notice the requests now hit both the old and newer versions. However none of them fail.

Execute the script at /root/curl-test.sh.


controlplane ~ ➜  ls
curl-pod.yaml   curl-test.sh    saida-curl.txt

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  date
Wed Feb 22 02:24:17 UTC 2023

controlplane ~ ➜  


controlplane ~ ➜  /root/curl-test.sh > saida-curl-2.txt

controlplane ~ ➜  cat saida-curl-2.txt
Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK

Hello, Application Version: v2 ; Color: green OK


controlplane ~ ➜  














Up to how many PODs can be down for upgrade at a time

Consider the current strategy settings and number of PODs - 4


- Detalhes do Deployment que peguei mais cedo:
    Replicas:               4 desired | 4 updated | 4 total | 4 available | 0 unavailable
    StrategyType:           RollingUpdate
    MinReadySeconds:        20
    RollingUpdateStrategy:  25% max unavailable, 25% max surge


- RESPOSTA:
Com base nisto, a resposta é 1.


















Change the deployment strategy to Recreate

Delete and re-create the deployment if necessary. Only update the strategy type for the existing deployment.

    Deployment Name: frontend

    Deployment Image: kodekloud/webapp-color:v2

    Strategy: Recreate


Pegando o comando de base:

controlplane ~ ➜  kubectl edit -h
Edit a resource from the default editor.

 The edit command allows you to directly edit any API resource you can retrieve via the command-line tools. It will open
the editor defined by your KUBE_EDITOR, or EDITOR environment variables, or fall back to 'vi' for Linux or 'notepad' for
Windows. You can edit multiple objects, although changes are applied one at a time. The command accepts file names as
well as command-line arguments, although the files you point to must be previously saved versions of resources.

 Editing is done with the API version used to fetch the resource. To edit using a specific API version, fully-qualify
the resource, version, and group.

 The default format is YAML. To edit in JSON, specify "-o json".

 The flag --windows-line-endings can be used to force Windows line endings, otherwise the default for your operating
system will be used.

 In the event an error occurs while updating, a temporary file will be created on disk that contains your unapplied
changes. The most common error when updating a resource is another editor changing the resource on the server. When this
occurs, you will have to apply your changes to the newer version of the resource, or update your temporary saved copy to
include the latest resource version.

Examples:
  # Edit the service named 'registry'
  kubectl edit svc/registry
  
  # Use an alternative editor
  KUBE_EDITOR="nano" kubectl edit svc/registry
  
  # Edit the job 'myjob' in JSON using the v1 API format
  kubectl edit job.v1.batch/myjob -o json
  
  # Edit the deployment 'mydeployment' in YAML and save the modified config in its annotation
  kubectl edit deployment/mydeployment -o yaml --save-config
  
  # Edit the deployment/mydeployment's status subresource
  kubectl edit deployment mydeployment --subresource='status'




controlplane ~ ➜  kubectl create -h
Create a resource from a file or from stdin.

 JSON and YAML formats are accepted.

Examples:
  # Create a pod using the data in pod.json
  kubectl create -f ./pod.json
  
  # Create a pod based on the JSON passed into stdin
  cat pod.json | kubectl create -f -
  
  # Edit the data in registry.yaml in JSON then create the resource using the edited data
  kubectl create -f registry.yaml --edit -o json




bectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  kubectl create deployment -h
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
        Image names to run.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --port=-1:
        The port that this container exposes.

    -r, --replicas=1:
        Number of replicas to create. Default is 1.

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
  kubectl create deployment NAME --image=image -- [COMMAND] [args...] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  










kubectl create deployment frontend --image=kodekloud/webapp-color:v2 --replicas=4 --strategy=recreate --dry-run=client


controlplane ~ ➜  kubectl create deployment frontend --image=kodekloud/webapp-color:v2 --replicas=4 --strategy=recreate --dry-run=clienterror: unknown flag: --strategy
See 'kubectl create deployment --help' for usage.

controlplane ~ ✖ 






kubectl create deployment frontend --image=kodekloud/webapp-color:v2 --replicas=4 --dry-run=client

controlplane ~ ✖ kubectl create deployment frontend --image=kodekloud/webapp-color:v2 --replicas=4 --dry-run=client
deployment.apps/frontend created (dry run)

controlplane ~ ➜  




kubectl create deployment frontend --image=kodekloud/webapp-color:v2 --replicas=4 --dry-run=client -o yaml


controlplane ~ ➜  kubectl create deployment frontend --image=kodekloud/webapp-color:v2 --replicas=4 --dry-run=client -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: frontend
  name: frontend
spec:
  replicas: 4
  selector:
    matchLabels:
      app: frontend
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: frontend
    spec:
      containers:
      - image: kodekloud/webapp-color:v2
        name: webapp-color
        resources: {}
status: {}

controlplane ~ ➜  






- Editando:

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: frontend
  name: frontend
spec:
  replicas: 4
  selector:
    matchLabels:
      app: frontend
  strategy: {Recreate}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: frontend
    spec:
      containers:
      - image: kodekloud/webapp-color:v2
        name: webapp-color
        resources: {}
status: {}




controlplane ~ ✖ kubectl delete deploy frontend
deployment.apps "frontend" deleted

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f front2.yaml
Error from server (BadRequest): error when creating "front2.yaml": Deployment in version "v1" cannot be handled as a Deployment: strict decoding error: unknown field "spec.strategy.Recreate"

controlplane ~ ✖ 




- Editando denovo:

apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: frontend
  name: frontend
spec:
  replicas: 4
  selector:
    matchLabels:
      app: frontend
  strategy:
    type: Recreate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: frontend
    spec:
      containers:
      - image: kodekloud/webapp-color:v2
        name: webapp-color
        resources: {}
status: {}


controlplane ~ ➜  vi front3.yaml 

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f front3.yaml 
deployment.apps/frontend created

controlplane ~ ➜  

controlplane ~ ➜  kubectl get deploy
NAME       READY   UP-TO-DATE   AVAILABLE   AGE
frontend   4/4     4            4           6s

controlplane ~ ➜  


controlplane ~ ➜  kubectl describe deploy frontend
Name:               frontend
Namespace:          default
CreationTimestamp:  Wed, 22 Feb 2023 02:45:10 +0000
Labels:             app=frontend
Annotations:        deployment.kubernetes.io/revision: 1
Selector:           app=frontend
Replicas:           4 desired | 4 updated | 4 total | 4 available | 0 unavailable
StrategyType:       Recreate
MinReadySeconds:    0
Pod Template:
  Labels:  app=frontend
  Containers:
   webapp-color:
    Image:        kodekloud/webapp-color:v2
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   frontend-745dcffc94 (4/4 replicas created)
Events:
  Type    Reason             Age   From                   Message
  ----    ------             ----  ----                   -------
  Normal  ScalingReplicaSet  24s   deployment-controller  Scaled up replica set frontend-745dcffc94 to 4

controlplane ~ ➜  



























Upgrade the application by setting the image on the deployment to kodekloud/webapp-color:v3

Do not delete and re-create the deployment. Only set the new image name for the existing deployment.

    Deployment Name: frontend

    Deployment Image: kodekloud/webapp-color:v3



kubectl set image deployment/frontend simple-webapp=kodekloud/webapp-color:v3


controlplane ~ ➜  kubectl set image deployment/frontend simple-webapp=kodekloud/webapp-color:v3
error: unable to find container named "simple-webapp"

controlplane ~ ✖ 




kubectl set image deployment/frontend webapp-color=kodekloud/webapp-color:v3


controlplane ~ ✖ kubectl set image deployment/frontend webapp-color=kodekloud/webapp-color:v3

deployment.apps/frontend image updated

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe deploy frontend 
Name:               frontend
Namespace:          default
CreationTimestamp:  Wed, 22 Feb 2023 02:45:10 +0000
Labels:             app=frontend
Annotations:        deployment.kubernetes.io/revision: 1
Selector:           app=frontend
Replicas:           4 desired | 0 updated | 0 total | 0 available | 0 unavailable
StrategyType:       Recreate
MinReadySeconds:    0
Pod Template:
  Labels:  app=frontend
  Containers:
   webapp-color:
    Image:        kodekloud/webapp-color:v3
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:       <none>
  Volumes:        <none>
Conditions:
  Type          Status  Reason
  ----          ------  ------
  Progressing   True    NewReplicaSetAvailable
  Available     False   MinimumReplicasUnavailable
Events:
  Type    Reason             Age    From                   Message
  ----    ------             ----   ----                   -------
  Normal  ScalingReplicaSet  2m28s  deployment-controller  Scaled up replica set frontend-745dcffc94 to 4
  Normal  ScalingReplicaSet  13s    deployment-controller  Scaled down replica set frontend-745dcffc94 to 0 from 4

controlplane ~ ➜  
















Run the script curl-test.sh again. Notice the failures. Wait for the new application to be ready. Notice that the requests now do not hit both the versions

Execute the script at /root/curl-test.sh.




controlplane ~ ➜  tail saida-curl-3.txt
Failed

Failed

Failed

Failed

Failed


controlplane ~ ➜  tail saida-curl-3.txt
Failed

Failed

Failed

Failed

Failed


controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-5d56847996-2csdm   1/1     Running     0          55m
kube-system   coredns-5c6b6c5476-sgvn6                  1/1     Running     0          55m
kube-system   helm-install-traefik-crd-lnkrj            0/1     Completed   0          55m
kube-system   helm-install-traefik-9vgl8                0/1     Completed   1          55m
kube-system   svclb-traefik-039eb2be-kfs48              2/2     Running     0          54m
kube-system   metrics-server-7b67f64457-mmttp           1/1     Running     0          55m
kube-system   traefik-56b8c5fb5c-b689v                  1/1     Running     0          54m
kube-public   curl                                      1/1     Running     0          37m
default       frontend-7b5fbdc5fc-gr2z8                 1/1     Running     0          2m39s
default       frontend-7b5fbdc5fc-d8vbc                 1/1     Running     0          2m38s
default       frontend-7b5fbdc5fc-4k4jl                 1/1     Running     0          2m39s
default       frontend-7b5fbdc5fc-4bp69                 1/1     Running     0          2m39s

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  tail saida-curl-4.txt
Failed

Failed

Failed

Failed


controlplane ~ ➜  tail saida-curl-4.txt
Failed

Failed

Failed

Failed

Failed


controlplane ~ ➜  cat saida-curl-4.txt
Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed

Failed


controlplane ~ ➜  ls
curl-pod.yaml     front.yaml        front3.yaml       saida-curl-3.txt  saida-curl.txt
curl-test.sh      front2.yaml       saida-curl-2.txt  saida-curl-4.txt

controlplane ~ ➜  cat curl-test.sh 
for i in {1..35}; do
   kubectl exec --namespace=kube-public curl -- sh -c 'test=`wget -qO- -T 2  http://webapp-service.default.svc.cluster.local:8080/info 2>&1` && echo "$test OK" || echo "Failed"';
   echo ""
done

controlplane ~ ➜  kubectl get svc
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
kubernetes       ClusterIP   10.43.0.1       <none>        443/TCP          56m
webapp-service   NodePort    10.43.137.228   <none>        8080:30080/TCP   39m

controlplane ~ ➜  /curl-test
-bash: /curl-test: No such file or directory

controlplane ~ ✖ /curl-test.sh
-bash: /curl-test.sh: No such file or directory

controlplane ~ ✖ sh curl-test.sh 

Failed


controlplane ~ ➜  

controlplane ~ ➜  




- Provavel que seja devido os Labels dos Pods
daí o Service não encaminhar corretamente
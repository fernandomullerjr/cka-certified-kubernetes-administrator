
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# push

git status
git add .
git commit -m "171. Practice Test - Image Security."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 171. Practice Test - Image Security



What secret type must we choose for docker registry?








We have an application running on our cluster. Let us explore it first. What image is the application using?

root@controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
default       web-694fcfd956-cv5zk                   1/1     Running   0             56s
default       web-694fcfd956-kdzd9                   1/1     Running   0             56s
kube-system   coredns-5d78c9869d-92k8m               1/1     Running   0             38m
kube-system   coredns-5d78c9869d-m5nvx               1/1     Running   0             38m
kube-system   etcd-controlplane                      1/1     Running   0             39m
kube-system   kube-apiserver-controlplane            1/1     Running   0             39m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             39m
kube-system   kube-proxy-sbm5x                       1/1     Running   0             38m
kube-system   kube-scheduler-controlplane            1/1     Running   0             39m
kube-system   weave-net-vxdf7                        2/2     Running   1 (38m ago)   38m

root@controlplane ~ ➜  

root@controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
web    2/2     2            2           67s

root@controlplane ~ ➜  kubectl get deploy web -o yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  annotations:
    deployment.kubernetes.io/revision: "1"
  creationTimestamp: "2023-11-18T20:38:27Z"
  generation: 1
  labels:
    app: web
  name: web
  namespace: default
  resourceVersion: "3458"
  uid: 4e7ef1aa-3cc6-41db-87b9-d951c8d19d95
spec:
  progressDeadlineSeconds: 600
  replicas: 2
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app: web
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: web
    spec:
      containers:
      - image: nginx:alpine
        imagePullPolicy: IfNotPresent
        name: nginx
        resources: {}
        terminationMessagePath: /dev/termination-log
        terminationMessagePolicy: File
      dnsPolicy: ClusterFirst
      restartPolicy: Always
      schedulerName: default-scheduler
      securityContext: {}
      terminationGracePeriodSeconds: 30
status:
  availableReplicas: 2
  conditions:
  - lastTransitionTime: "2023-11-18T20:38:31Z"
    lastUpdateTime: "2023-11-18T20:38:31Z"
    message: Deployment has minimum availability.
    reason: MinimumReplicasAvailable
    status: "True"
    type: Available
  - lastTransitionTime: "2023-11-18T20:38:27Z"
    lastUpdateTime: "2023-11-18T20:38:31Z"
    message: ReplicaSet "web-694fcfd956" has successfully progressed.
    reason: NewReplicaSetAvailable
    status: "True"
    type: Progressing
  observedGeneration: 1
  readyReplicas: 2
  replicas: 2
  updatedReplicas: 2

root@controlplane ~ ➜  














We decided to use a modified version of the application from an internal private registry. Update the image of the deployment to use a new image from myprivateregistry.com:5000

The registry is located at myprivateregistry.com:5000. Don't worry about the credentials for now. We will configure them in the upcoming steps.

    Use Image from private registry



root@controlplane ~ ➜  vi deploy-editado.yaml

root@controlplane ~ ➜  kubectl apply -f deploy-editado.yaml
Warning: resource deployments/web is missing the kubectl.kubernetes.io/last-applied-configuration annotation which is required by kubectl apply. kubectl apply should only be used on resources created declaratively by either kubectl create --save-config or kubectl apply. The missing annotation will be patched automatically.
deployment.apps/web configured

root@controlplane ~ ➜  kubectl delete -f deploy-editado.yaml
deployment.apps "web" deleted

root@controlplane ~ ➜  kubectl apply -f deploy-editado.yaml
deployment.apps/web created

root@controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
web    0/2     2            0           4s

root@controlplane ~ ➜  

root@controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
web    0/2     2            0           23s

root@controlplane ~ ➜  















## PENDENTE
- Questão do registry privado nao ficou OK



- Testar solução:

<https://github.com/kodekloudhub/certified-kubernetes-administrator-course/blob/master/docs/07-Security/24-Practice-Test-Image-Security.md>

- Use the kubectl edit deployment command to edit the image name to myprivateregistry.com:5000/nginx:alpine

  <details>
  
  ```
  $ kubectl edit deployment web
  ```
  
  </details>





## NOVA TENTATIVA

18/11/2023

What secret type must we choose for docker registry?





We have an application running on our cluster. Let us explore it first. What image is the application using?






We decided to use a modified version of the application from an internal private registry. Update the image of the deployment to use a new image from myprivateregistry.com:5000

The registry is located at myprivateregistry.com:5000. Don't worry about the credentials for now. We will configure them in the upcoming steps.

    Use Image from private registry

kubectl edit deployment web


myprivateregistry.com:5000/nginx:alpine                                

root@controlplane ~ ➜  kubectl edit deployment web
deployment.apps/web edited

root@controlplane ~ ➜  










Are the new PODs created with the new images successfully running?

root@controlplane ~ ➜  kubectl get pods
NAME                   READY   STATUS         RESTARTS   AGE
web-694fcfd956-slh8b   1/1     Running        0          3m24s
web-694fcfd956-z4nr7   1/1     Running        0          3m24s
web-776bccfbcf-kt5h9   0/1     ErrImagePull   0          26s

root@controlplane ~ ➜  













Create a secret object with the credentials required to access the registry.

Name: private-reg-cred
Username: dock_user
Password: dock_password
Server: myprivateregistry.com:5000
Email: dock_user@myprivateregistry.com

    Secret: private-reg-cred

    Secret Type: docker-registry

    Secret Data


root@controlplane ~ ➜  kubectl create secret -h
Create a secret using specified subcommand.

Available Commands:
  docker-registry   Create a secret for use with a Docker registry
  generic           Create a secret from a local file, directory, or literal value
  tls               Create a TLS secret

Usage:
  kubectl create secret [flags] [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

root@controlplane ~ ➜  


https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/

Create a Secret by providing credentials on the command line

Create this Secret, naming it regcred:

kubectl create secret docker-registry regcred --docker-server=<your-registry-server> --docker-username=<your-name> --docker-password=<your-pword> --docker-email=<your-email>

where:

    <your-registry-server> is your Private Docker Registry FQDN. Use https://index.docker.io/v1/ for DockerHub.
    <your-name> is your Docker username.
    <your-pword> is your Docker password.
    <your-email> is your Docker email.

- Editando o comando:

kubectl create secret docker-registry private-reg-cred --docker-server=myprivateregistry.com:5000 --docker-username=dock_user --docker-password=dock_password --docker-email=dock_user@myprivateregistry.com

root@controlplane ~ ➜  kubectl create secret docker-registry private-reg-cred --docker-server=myprivateregistry.com:5000 --docker-username=dock_user --docker-password=dock_password --docker-email=dock_user@myprivateregistry.com
secret/private-reg-cred created

root@controlplane ~ ➜  












Configure the deployment to use credentials from the new secret to pull images from the private registry

    Image Pull Secret: private-reg-cred

https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
Create a Pod that uses your Secret

Here is a manifest for an example Pod that needs access to your Docker credentials in regcred:
pods/private-reg-pod.yaml [Copy pods/private-reg-pod.yaml to clipboard]

apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  containers:
  - name: private-reg-container
    image: <your-private-image>
  imagePullSecrets:
  - name: regcred


- Editar o Deployment:
kubectl edit deployment web

- Adicionar:
  imagePullSecrets:
  - name: private-reg-cred


root@controlplane ~ ➜  kubectl edit deployment web
error: deployments.apps "web" is invalid
error: deployments.apps "web" is invalid
deployment.apps/web edited

root@controlplane ~ ➜  









Check the status of PODs. Wait for them to be running. You have now successfully configured a Deployment to pull images from the private registry.

root@controlplane ~ ➜  kubectl get pods
NAME                   READY   STATUS    RESTARTS   AGE
web-5999cdc98b-kjf8l   1/1     Running   0          29s
web-5999cdc98b-v85dr   1/1     Running   0          31s

root@controlplane ~ ➜  


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 54. Labels and Selectors"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 54. Labels and Selectors

# Conteúdo do Github da Kodekloud

# Labels and Selectors
  - Take me to [Video Tutorial](https://kodekloud.com/topic/labels-and-selectors/)
  
In this section, we will take a look at **`Labels and Selectors`**

#### Labels and Selectors are standard methods to group things together.
  
#### Labels are properties attached to each item.


  
#### Selectors help you to filter these items
 

  
How are labels and selectors are used in kubernetes?
- We have created different types of objects in kubernetes such as **`PODs`**, **`ReplicaSets`**, **`Deployments`** etc.
  

  
How do you specify labels?
   ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
     name: simple-webapp
     labels:
       app: App1
       function: Front-end
    spec:
     containers:
     - name: simple-webapp
       image: simple-webapp
       ports:
       - containerPort: 8080
   ```

 
Once the pod is created, to select the pod with labels run the below command
```bash
$ kubectl get pods --selector app=App1
```

Kubernetes uses labels to connect different objects together
   ```yaml
    apiVersion: apps/v1
    kind: ReplicaSet
    metadata:
      name: simple-webapp
      labels:
        app: App1
        function: Front-end
    spec:
     replicas: 3
     selector:
       matchLabels:
        app: App1
    template:
      metadata:
        labels:
          app: App1
          function: Front-end
      spec:
        containers:
        - name: simple-webapp
          image: simple-webapp   
   ```



For services
 
      ```yaml
      apiVersion: v1
      kind: Service
      metadata:
       name: my-service
      spec:
       selector:
         app: App1
       ports:
       - protocol: TCP
         port: 80
         targetPort: 9376 
```

  
## Annotations
- While labels and selectors are used to group objects, annotations are used to record other details for informative purpose.
    ```yaml
    apiVersion: apps/v1
    kind: ReplicaSet
    metadata:
      name: simple-webapp
      labels:
        app: App1
        function: Front-end
      annotations:
         buildversion: 1.34
    spec:
     replicas: 3
     selector:
       matchLabels:
        app: App1
    template:
      metadata:
        labels:
          app: App1
          function: Front-end
      spec:
        containers:
        - name: simple-webapp
          image: simple-webapp   
    ```


K8s Reference Docs:
- https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/











# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# TRANSCRIÇÃO

Hello and welcome to this lecture on labels and selectors.

My name is Mumshad Mannambeth what do we know about labels and selectors already labels and selectors

are a standard method to group things together.

Say you have a set of different species.

A user wants to be able to filter them based on different criteria such as based on their class or kind

if they are domestic or wild or see by their color and not just group.

You want to be able to filter them based on a criteria such as all green animals or with multiple criteria

such as everything green.

That is also a bird.

Whatever that classification maybe you need the ability to group things together and filter them based

on your needs and the best way to do that is with labels. Labels or properties attached to each item.

So you add properties to each item for their class kind and color selectors help you filter these items.

For example when you say class equals mammal we get a list of mammals and when you say color equals

green we get the green mammals we see labels and selectors used everywhere such as the keywords you

tag to YouTube videos or blogs that help users filter and find the right content we see labels added

to items in an online store that help you add different kinds of filters to view your products.

So how are labels and selectors used in Kubernetes?

We have created a lot of different types of Objects in Kuberentes. Pods, Services, ReplicaSets and Deployments.

etc. For Kubernetes, all of these are different objects.

Over time you may end up having hundreds or thousands of these objects in your cluster.

Then you will need a way to filter and view different objects by different categories such as to group

objects by their type or view objects by application or by their functionality whatever it may be.

You can group and select objects using labels and selectors for each object attach labels as per your

needs, like app, function etc.

Then while selecting specify a condition to filter specific objects.

For example app == App1. So how exactly do you specify labels in kubernetes.

In a pod-definition file, under metadata,

create a section called labels. Under that add the labels in a key value format like this.

You can add as many labels as you like. Once the pod is created, to select the pod with the labels

use the kubectl get pods command along with the selector option, and specify the condition like

app=App1.

Now this is one use case of labels and selectors. Kubernetes objects use labels and selectors internally

to connect different objects together. For example to create a replicaset consisting of 3 different

pods,

we first label the pod definition and use selector in a replicaset to group the pods . In the replica-set

set definition file.

You will see labels defined in two places.

Note that this is an area where beginners attempt to make a mistake.

The labels defined under the template section are the labels configured on the pods. The labels you see

at the top are the labels of the replicas set itself.

We're not really concerned about the labels of the replica set for now because we are trying to get

the replica set to discover the pods.

The labels on the replica set will be used if you were to configure some other object to discover the

replica set in order to connect the replica set to the pod we configure the selector field under the

replica set specification to match the labels defined on the pod a single label will do if it matches

correctly.

However if you feel there could be other pods with the same label but with a different function then

you could specify both the labels to ensure that the right pods are discovered by the replica set on

creation.

If the labels match the replica set is created successfully it works the same for other objects like

a service when a service is created it uses the selector defined in the service definition file to match

the labels set on the pods in the replica set definition file.

Finally let’s look at annotations. While labels and selectors are used to group and select objects, annotations

are used to record other details for inflammatory purpose.

For example tool details like name, version build information etc or contact details, phone numbers, email

ids etc, that may be used for some kind of integration purpose. Well, that’s it for this lecture on

labels and selectors and annotations.

Head over to the coding exercises section and practice working with labels and selectors.












# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 

How are labels and selectors are used in kubernetes?
    We have created different types of objects in kubernetes such as PODs, ReplicaSets, Deployments etc.


- How do you specify labels?

- POD

````yaml
apiVersion: v1
kind: Pod
metadata:
 name: simple-webapp
 labels:
   app: App1
   function: Front-end
spec:
 containers:
 - name: simple-webapp
   image: simple-webapp
   ports:
   - containerPort: 8080
````



- Once the pod is created, to select the pod with labels run the below command
~~~~bash
$ kubectl get pods --selector app=App1

kubectl apply -f 54-pod-with-labels.yaml
kubectl delete -f 54-pod-with-labels.yaml

fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling$ kubectl get pods --selector app=App1
NAME            READY   STATUS         RESTARTS   AGE
simple-webapp   0/1     ErrImagePull   0          47s
fernando@debian10x64:~/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling$
~~~~


- ReplicaSet

````yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: simple-webapp
  labels:
    app: App1
    function: Front-end
spec:
 replicas: 3
 selector:
   matchLabels:
    app: App1
template:
  metadata:
    labels:
      app: App1
      function: Front-end
  spec:
    containers:
    - name: simple-webapp
      image: simple-webapp  
````



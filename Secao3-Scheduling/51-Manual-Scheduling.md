

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 51. Manual Scheduling"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 51. Manual Scheduling

# Transcript

Every POD has a field called NodeName that, by default, is not set.

You don’t typically specify this field when you create the manifest file, Kubernetes adds it automtically.

The scheduler goes through all the pods and looks for those that do not have this property set.

Those are the candidates for scheduling.

It then identifies the right node for the POD, by running the scheduling algorithm.

Once identified it schedules the POD on the Node by setting the node Name property to the name of the

node by creating a binding object. So if there is no scheduler to monitor and schedule nodes what happens?

The pods continue to be in a pending state.

So what can you do about it.

You can manually assign pods to node yourself. Well without a scheduler,

the easiest way to schedule a pod is to simply set the node name field to the name of the node in your

pod specification while creating the POD.

The pod then gets assigned to the specified node. You can only specify the node name at creation time.

What if the pod is already created and you want to assign the pod to a node? Kubernetes won’t allow

you to modify the node Name property of a pod.

So another way to assign a note to an existing pod is to create a binding object and send a post request

to the pod binding API thus mimicking what the actual scheduler does. In the binding object you specify

a target node with the name of the node. Then send a post request to the pods binding API with the data

set to the binding object in a JSON format.

So you must convert the YAML file into its equivalent JSON format.

Well that's it for this lecture.

Head over to the practice test and practice manually scheduling pods on nodes.










# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 51. Manual Scheduling

In this section, we will take a look at **`Manually Scheduling`** a **`POD`** on a node.

## How Scheduling Works
- What do you do when you do not have a scheduler in your cluster?
  - Every POD has a field called NodeName that by default is not set. You don't typically specify this field when you create the manifest file, kubernetes adds it automatically.
  - Once identified it schedules the POD on the node by setting the nodeName property to the name of the node by creating a binding object.
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
     name: nginx
     labels:
      name: nginx
    spec:
     containers:
     - name: nginx
       image: nginx
       ports:
       - containerPort: 8080
     nodeName: node02
    ```


## No Scheduler
  - You can manually assign pods to node itself. Well without a scheduler, to schedule pod is to set **`nodeName`** property in your pod definition file while creating a pod.
    
    
  - Another way
    ```yaml
    apiVersion: v1
    kind: Binding
    metadata:
      name: nginx
    target:
      apiVersion: v1
      kind: Node
      name: node02
    ```

    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
     name: nginx
     labels:
      name: nginx
    spec:
     containers:
     - name: nginx
       image: nginx
       ports:
       - containerPort: 8080
    ```

    
    
K8s Reference Docs:
- https://kubernetes.io/docs/reference/using-api/api-concepts/
- https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename











# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# DOC

## nodeName

<https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodename>

nodeName is a more direct form of node selection than affinity or nodeSelector. nodeName is a field in the Pod spec. If the nodeName field is not empty, the scheduler ignores the Pod and the kubelet on the named node tries to place the Pod on that node. Using nodeName overrules using nodeSelector or affinity and anti-affinity rules.

Some of the limitations of using nodeName to select nodes are:

    If the named node does not exist, the Pod will not run, and in some cases may be automatically deleted.
    If the named node does not have the resources to accommodate the Pod, the Pod will fail and its reason will indicate why, for example OutOfmemory or OutOfcpu.
    Node names in cloud environments are not always predictable or stable.

Here is an example of a Pod spec using the nodeName field:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
  nodeName: kube-01
```

The above Pod will only run on the node kube-01.
Pod topology spread const














# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# Manual Scheduling of Pods on Nodes

How to schedule a pod to a particular node.
<https://automateinfra.com/kubernetes-series-part-3/>
    Create a file named pod-binding.yaml and copy/paste the below content.

```yaml
apiVersion: v1
Kind: Binding
metadata:
  name: nginx
target:
  apiVersion: v1
  kind: Node
  name: node-name
```

    Run the below post requent to the kubernetes cluster as shown below

curl - --header "Content-Type:application/json" --request POST --data '{}' http://$SERVER/api/v1/namespaces/default/pods/$PODNAME/binding/




- Comando editado:
curl - --header "Content-Type:application/json" --request POST --data '{"apiVersion":"v1", "kind": "Binding“ …. }' http://$SERVER/api/v1/namespaces/default/pods/$PODNAME/binding/
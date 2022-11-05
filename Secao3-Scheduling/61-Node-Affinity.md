
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 61. Node Affinity"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 61. Node Affinity

# Material do GitHub da KodeKloud

# Node Affinity
  - Take me to the [Video Tutorial](https://kodekloud.com/topic/node-affinity-2/)
  
In this section, we will talk about "Node Affinity" feature in kubernetes.

#### The primary feature of Node Affinity is to ensure that the pods are hosted on particular nodes.
- With **`Node Selectors`** we cannot provide the advance expressions.
  ```
  apiVersion: v1
  kind: Pod
  metadata:
   name: myapp-pod
  spec:
   containers:
   - name: data-processor
     image: data-processor
   nodeSelector:
    size: Large
  ```

  ```
  apiVersion: v1
  kind: Pod
  metadata:
   name: myapp-pod
  spec:
   containers:
   - name: data-processor
     image: data-processor
   affinity:
     nodeAffinity:
       requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: size
              operator: In
              values: 
              - Large
              - Medium
  ```
  
  ```
  apiVersion: v1
  kind: Pod
  metadata:
   name: myapp-pod
  spec:
   containers:
   - name: data-processor
     image: data-processor
   affinity:
     nodeAffinity:
       requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: size
              operator: NotIn
              values: 
              - Small
  ```

  
  ```
  apiVersion: v1
  kind: Pod
  metadata:
   name: myapp-pod
  spec:
   containers:
   - name: data-processor
     image: data-processor
   affinity:
     nodeAffinity:
       requiredDuringSchedulingIgnoredDuringExecution:
          nodeSelectorTerms:
          - matchExpressions:
            - key: size
              operator: Exists
  ```
  
  

## Node Affinity Types
- Available
  - requiredDuringSchedulingIgnoredDuringExecution
  - preferredDuringSchedulingIgnoredDuringExecution
- Planned
  - requiredDuringSchedulingRequiredDuringExecution
  - preferredDuringSchedulingRequiredDuringExecution
  
  
## Node Affinity Types States

  
#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/
- https://kubernetes.io/blog/2017/03/advanced-scheduling-in-kubernetes/







# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 61. Node Affinity

# Transcrição

Instructor: Hello and welcome to this lecture.

In this lecture, we will talk about node affinity feature

in Kubernetes.

The primary purpose of node affinity feature

is to ensure that pods are hosted on particular nodes,

in this case to ensure the large data processing pod

ends up on node one.

In the previous lecture,

we did this easily using node selectors.

We discussed that you cannot provide

advanced expressions like or or not with node selectors.

The node affinity feature

provides us with advanced capabilities

to limit pod placement on specific nodes.

With great power comes great complexity,

so the simple node selector specification

will now look like this with node affinity

although both does exactly the same thing.

Place the pod on the large node.

Let us look at it a bit closer.

Under spec you have affinity

and then node affinity under that.

And then you have a property

that looks like a sentence called,

required during scheduling, ignored during execution.

No description needed for that.

And then you have the node selector terms,

that is NRA,

and that is where you will specify the key and value pairs.

The key value pairs are in the form

key, operator and value,

where the operator is in.

The in operator ensures that the pod

will be placed on a node

whose label size has any value

in the list of values specified here?

In this case, it is just one called large.

If you think your pod could be placed on a large

or a medium node, you could simply add the value

to the list of values like this.

You could use the node in operator to say something like,

size not in small,

where node affinity will match the nodes

with a size not set to small.

We know that we have only set the label size to large

and medium nodes.

The smaller nodes don't even have the label set

so we don't really have to even check the value

of the label.

As long as we are sure we don't set a label size

to the smaller node,

using the exist operator will give us the same result.

The exist operator will simply check

if the label size exists on the nodes,

and you don't need the value section for that

as it does not compare the values.

There are a number of other operators as well.

Check the documentation for specific details.

Now, we understand all of this

and we're comfortable with creating a pod

with specific affinity rules.

When the pods are created,

these rules are considered

and the pods are placed onto the right nodes.

But what if node affinity could not match a node

with a given expression?

In this case, what if there are no nodes

with the label called size?

Say we had the labels and the pods are scheduled.

What if someone changes the label on the node

at a future point in time?

will the pod continue to stay on the node?

All of this is answered by the long sentence like property

under node affinity,

which happens to be the type of node affinity.

The type of node affinity defines the behavior

of the scheduler with respect to node affinity

and the stages in the life cycle of the pod.

There are currently two types of node affinity available,

required during scheduling, ignored during execution

and preferred during scheduling, ignored during execution.

And there are additional types of node affinity planned

as of this recording.

Required during scheduling, required during execution.

We will now break this down to understand further.

We will start by looking

at the two available affinity types.

There are two states in the lifecycle of a pod

when considering node affinity,

during scheduling and during execution.

During scheduling is the state where a pod does not exist

and is created for the first time.

We have no doubt that when a pod is first created

the affinity rules specified are considered

to place the pods on the right nodes.

Now, what if the nodes

with matching labels are not available?

For example, we forgot to label the node as large.

That is where the type of node affinity used

comes into play.

If you select the required type, which is the first one,

the scheduler will mandate that the pod be placed on a node

with a given affinity rules.

If it cannot find one, the pod will not be scheduled.

This type will be used in cases

where the placement of the pod is crucial.

If a matching node does not exist

the pod will not be scheduled.

But let's say the pod placement is less important

than running the workload itself.

In that case, you could set it to preferred

and in cases where a matching node is not found,

the scheduler will simply ignore node affinity rules

and place the pod on any available node.

This is a way of telling the scheduler,

"Hey, try your best to place the pod on matching node."

But if you really cannot find one, just place it anywhere.

The second part of the property or the other state

is during execution.

During execution is the state where a pod

has been running and a change is made in the environment

that affects node affinity,

such as a change in the label of a node.

For example, say an administrator removed the label

we set earlier called size equals large from the node.

Now what would happen to the pods

that are running on the node?

As you can see, the two types of node affinity

available today has this value set to ignored,

which means pods will continue to run

and any changes in node affinity

will not impact them once they are scheduled.

The new types expected in the future

only have a difference in the during execution phase.

A new option called required during execution is introduced

which will evict any pods that are running on nodes

that do not meet affinity rules.

In the earlier example, a pod running on the large node

will be evicted or terminated

if the label large is removed from the node.

Well, that's it for this lecture.

Head over to the coding exercises

and practice working with node affinity rules.

In the next lecture,

we will compare taints and tolerations and node affinity.












# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 61. Node Affinity


- Pode ser usada uma lista de valores como parametro no Node Affinity:
como Large, Medium, etc

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: size
                operator: In
                values:
                  - Large
                  - Medium
~~~~




- Exemplo de Pod que procura por um Node que não tenha a Label "Small"

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: size
                operator: NotIn
                values:
                  - Small
~~~~



You could use the node in operator to say something like, size not in small, where node affinity will match the nodes with a size not set to small.
We know that we have only set the label size to large and medium nodes.
The smaller nodes don't even have the label set so we don't really have to even check the value of the label.

As long as we are sure we don't set a label size to the smaller node, using the exist operator will give us the same result.
The exist operator will simply check if the label size exists on the nodes, and you don't need the value section for that as it does not compare the values.

- Este exemplo abaixo, usando o operador [Exists], ele verifica somente a chave, não considera os valores, para ele não é necessário:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
spec:
  containers:
    - name: data-processor
      image: data-processor
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
          - matchExpressions:
              - key: size
                operator: Exists
~~~~









# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# Node Affinity types

<https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#node-affinity>
<https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/>
<https://kubernetes.io/blog/2017/03/advanced-scheduling-in-kubernetes/>

    requiredDuringSchedulingIgnoredDuringExecution: The scheduler can't schedule the Pod unless the rule is met. This functions like nodeSelector, but with a more expressive syntax.
    preferredDuringSchedulingIgnoredDuringExecution: The scheduler tries to find a node that meets the rule. If a matching node is not available, the scheduler still schedules the Pod.

# “IgnoredDuringExecution”
“IgnoredDuringExecution”
significa que se uma alteração for realizada sobre Node Affinity durante o tempo em que o Pod está correndo, não vai afetar ele.
“IgnoredDuringExecution” means that the pod will still run if labels on a node change and affinity rules are no longer met.

# "preferredDuringSchedulingIgnoredDuringExecution"
"preferredDuringSchedulingIgnoredDuringExecution"
prefere que o Node tenha a Label, mas se tiver 1 node disponivel que não tenha a Label e o node com a Label esperada não esteja disponível, vai ser usado este mesmo, sem problemas.



# "requiredDuringSchedulingRequiredDuringExecution"
"requiredDuringSchedulingRequiredDuringExecution"
 There are future plans to offer requiredDuringSchedulingRequiredDuringExecution which will evict pods from nodes as soon as they don’t satisfy the node affinity rule(s).

Observação:
neste type ele tem required nos 2 casos(DuringScheduling e DuringExecution)


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
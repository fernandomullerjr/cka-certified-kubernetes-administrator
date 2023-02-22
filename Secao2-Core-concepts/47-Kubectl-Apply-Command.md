

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 47. Kubectl Apply Command"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 47. Kubectl Apply Command

In this lecture, we will understand more about how the cattle supply command works.

In the previous lecture, we saw how a cubicle to apply command can be used to manage objects in a declarative

way.

In this lecture, we will see a bit more about how the command works internally.

The Applied Command takes into consideration the local configuration file, the life object definition

on Kubernetes and the last applied configuration before making a decision on what changes are to be

made.

So when you run the apply command, if the object does not already exist, the object is created.

When the object is created.

An object configuration similar to what we created locally is created within Kubernetes, but with additional

fields to store status of the object.

This is the life configuration of the object on the Kubernetes cluster.

This is how Kubernetes internally stores information about an object, no matter what approach you use

to create the object.

But when you use the cube to apply command to create an object, it does something a bit more.

The YAML version of the local object configuration file we wrote is converted to a JSON format and it

is then stored as the last applied configuration going forward for any updates to the object.

All the three are compared to identify what changes are to be made on the live object.

For example, say when the engine x image is updated to 1.19 in our local file and we run the apply

command.

This value is compared with the value in the live configuration and if there is a difference, the life

configuration is updated with the new value.

After any change, the last applied JSON format is always updated to the latest so that it's always

up to date.

So why do we then really need the last applied configuration?

Right.

So if a field was deleted, say, for example, the type label was deleted.

And now when we run the command, we see that the last applied configuration had a label, but it's

not present in the local configuration.

This means that the field needs to be removed from the live configuration.

So if a field was present in the live configuration and not present in the local or the last applied

configuration, then it will be left as is.

But if a field is missing from the local file and it is present in the last applied configuration,

so that means that in the previous step or whenever the last time we ran the applied command, that

particular field was there and it is now being removed.

So the last applied configuration helps us figure out.

What field?

Fields have been removed from the local file.

Right.

So that field is then removed from the actual live configuration.

What we just discussed is available for your reference in detail in the Kubernetes document pages.

So follow this link to view that.

So we saw the three sets of files and we know that the local file is what stored on our local system.

The live object configuration is in the Kubernetes memory, but where is this JSON file that has the

last applied configuration stored?

Well, it's stored on the live object configuration on the Kubernetes cluster itself as an annotation

named Last Applied Configuration.

So remember that this is only done when you use the API command.

The code will create or replace commands.

Do not store the last applied configuration like this.

So you must bear in mind not to mix the imperative and declarative approaches while managing the Kubernetes

objects.

So once you use the applied command going forward, whenever a change is made, the apply command compares

all three sections the local pod definition file, the live object configuration and the last applied

configuration stored within the life object configuration file for deciding what changes are to be made

to the live configuration, similar to what we saw in the previous slide.

Well, that's it for this lecture.

I will see you in the next.











# RESUMO
- O Kubernetes compara 3 configurações durante o apply.
  object configuration file	  /  live object configuration	  /   last-applied-configuration	

- Maiores detalhes em:
  <https://kubernetes.io/docs/tasks/manage-kubernetes-objects/declarative-config/>
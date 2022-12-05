Transcrição

-: Okay in this video, we will go over the practice test

for node affinity. So the first question is

to identify

the labels on node, node 01,

so to count

the number of labels on node 01. So let's do

kubectl, describe node,

node 01

and let's look at the labels.

So we have 1, 2, 3, 4, 5, 5 labels.

So we're gonna select five.

And then the next question is, what is the value set

to the label at beta.kubernetes.io/arc?

So

on node 01, so we are already

on node 01 and it is AMD 64.

That's

this one.

Okay. So the next question is to apply a label

called color equals blue to node 01.

So for that we're going to use the kubectl

label command. So let's take a look at the help.

And here we have some examples.

So you have kubectl label, the pods or node,

whatever.

What is the object that we wanna apply the label to?

And then the node name, and then just the label.

So it's pretty straightforward.

So we're gonna do kubectl, label,

node,

node 01

and then color equals

blue.

Let's

verify that

it's set correctly.

We're gonna go back, cause the labels

and we see the color equals blue.

Okay. Now the next one is to create a new deployment

named blue with the nginx image and three replicas.

So lets create a deployment.

The name is blue,

image is

nginx,

and

replicas is three.

Okay,

so the next one is, which nodes can the pods

for the blue deployment be placed on?

So we, we've gotta check the tense on, on both

the nodes. So let's do that.

Let's

check the tense on each one.

So we're gonna do a, we've gotta describe node

Let's check node 01.

And

let's

check for

tense.

So there are no tense set on, node 01 and the

other node which I believe is the control plane node.

Let's check that too.

So...

So the node plane. So there are no, no tense on either

of these nodes but for now the pods can be scheduled

on either of the nodes because there are no tense

on any of these nodes.

Okay, so in this question, the task is to set node affinity

to the deployment to place the part on node 01 only.

So we're going to edit the deployment.

So that's kubectl edit deployment

blue.

So we're here and

what we need to do is on the pod specification

now we've got to set the node affinity for these, right?

So we, we have to use the required

during scheduling, ignore during execution

then use the color and the values to close.

So for this, let's go to the Kubernetes documentation page

and search for

affinity.

And let's get this.

And here, let's look for the affinity

spec.

So we going to copy this

and

paste it here.

So here, basically this one is an example for a pod.

And so all of these are kind of aligned

bit more to the left.

But here, this is under the pod

which is under the template section of deployment.

So we have to move it all a little bit to the right.

So for this, what I'm gonna do here is

the first one is, okay, first line is okay

but all these remaining lines

we need to move it

one step inside.

So

press capital V and then select all the lines.

Then I'm gonna do a greater than symbol.

So that's shift dot on the keyboard that I'm using.

It moves everything to the, to the right.

So it's not, not very pretty

but I think that will do the job for now.

And I'm just going to

set the key to color

and

the value to low.

So there, there are ways that we can set the VIM settings

so that this always, it gets intended

with spaces

as opposed to multiple spaces at a time that you

can see here. So, we're gonna save that

and let's give this a shot.

Okay, so that's done.

Now the question is to find

out which nodes the ports are placed on.

So let's run a kubectl get pods -o wide

that kind of shows us that all the pods

are all node 01.

So they're all on node 01.

So the next task is to create a new deployment named red

with nginx image and two replicas

and ensure it gets placed on the control plane node only.

And the recommendation is to use the label node kubernetes

.io/master which is already set on the control plane node.

So if you look at the

control plane node

we see that there is this label, right?

It doesn't have a value set, right?

So all we need to do is

to set a node affinity

rule that says

the pods that are part

of the deployment red should be placed

on a node that has this label set.

And the label does not have a value.

But if this label exists

then that's where it should be placed on.

So let's try and do that.

So we'll use the kubectl create deployment command

and then the name is Redis.

Sorry, red.

Image is nginx

and replicas

=2.

Okay? But we're not gonna create it.

So we're gonna do a dry run because we need to

get the yaml file to input the node affinity rules.

So we're gonna do a dry run=client

and then -o yaml

that's gonna give us the yaml output.

Then we're going to

put it to a file named red.yaml.

Now we're going to edit that file.

And within the spec section

we're gonna do the same

as we did before.

So we're gonna copy this node affinity rule

and paste it.

Now we've got to select all of these lines.

I'm gonna do a

shift dot shift dot on my keyboard

which is gonna, and that's basically the, the greater

than symbol and it's gonna move to the right.

Now we're gonna change this to the key is the label

which is this.

I'm gonna copy and paste.

And as we realize that this label does not have value

so there's no point in checking the value here.

So we're gonna get rid of this and all,

all we are gonna do is say if the label exists

so the operator would be Exists

with the capital E,

lets save that.

And now we're going to create

a deployment.

There seems to be some error.

So let's go back,

see what the error is.

It's on line 26

Do not find expected

key.

So line

26

is this.

Okay, actually it's this line here.

So this is not currently intended, that's the problem.

We're going to move it two characters before.

Okay, So we're going to save that.

Let's try that again.

Okay. So even though here it's said line 26

the issue was a few lines above

okay so let's check our solution.

All right, So that works.

And if we look at pods now,

we'll see that those

the new pods are on node control plane.

Okay?

Okay, that's the end of this lab.
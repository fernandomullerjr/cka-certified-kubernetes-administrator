

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 57. Taints and Tolerations"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# # Taints and Tolerations
  - Take me to [Video Tutorial](https://kodekloud.com/topic/taints-and-tolerations-2/)
  
In this section, we will take a look at taints and tolerations.
- Pod to node relationship and how you can restrict what pods are placed on what nodes.

#### Taints and Tolerations are used to set restrictions on what pods can be scheduled on a node. 
- Only pods which are tolerant to the particular taint on a node will get scheduled on that node.

  
## Taints
- Use **`kubectl taint nodes`** command to taint a node.

  Syntax
  ```
  $ kubectl taint nodes <node-name> key=value:taint-effect
  ```
 
  Example
  ```
  $ kubectl taint nodes node1 app=blue:NoSchedule
  ```
  
- The taint effect defines what would happen to the pods if they do not tolerate the taint.
- There are 3 taint effects
  - **`NoSchedule`**
  - **`PreferNoSchedule`**
  - **`NoExecute`**
  
  
## Tolerations
   - Tolerations are added to pods by adding a **`tolerations`** section in pod definition.
     ```yaml
     apiVersion: v1
     kind: Pod
     metadata:
      name: myapp-pod
     spec:
      containers:
      - name: nginx-container
        image: nginx
      tolerations:
      - key: "app"
        operator: "Equal"
        value: "blue"
        effect: "NoSchedule"
     ```
    

    

#### Taints and Tolerations do not tell the pod to go to a particular node. Instead, they tell the node to only accept pods with certain tolerations.
- To see this taint, run the below command
  ```bash
  $ kubectl describe node kubemaster | grep Taint
  ```
 
  
     
#### K8s Reference Docs
- https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/











# Traduções de taint
Classe gramatical	Tradução	Traduções reversas	Frequência
help_outline
substantivo
	
a mancha
	

    spot, stain, blot, taint, blemish, tarnish

	
a mácula
	

    stain, taint, defilement, blot, scar, smirch

	
a nódoa
	

    stain, spot, taint, blur, splotch, soil

	
o defeito
	

    defect, fault, blemish, flaw, bug, taint

	
verbo
	
manchar
	

    stain, taint, sully, smudge, soil, besmirch

	
contaminar
	

    contaminate, infect, taint, inoculate, vitiate, attaint

	
corromper
	

    corrupt, defile, bribe, taint, spoil, pervert

	
apodrecer
	

    rot, fester, decay, putrefy, moulder, taint

	
viciar
	

    vitiate, addict, taint, debauch

	
infectar
	

    infect, disease, taint, inoculate

	
contaminar-se
	

    taint







# OBSERVAÇÃO
- Taints são setados nos Nodes.
- Tolerations são setados nos Pods.




- Valores dos Tolerations no YAML, precisam estar entre aspas duplas
continua em 6:15








# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# # Taints


kubectl describe node kubemaster | grep Taint
kubectl describe node minikube | grep Taint

fernando@debian10x64:~$ kubectl describe node minikube | grep Taint
Taints:             <none>
fernando@debian10x64:~$




<https://blog.kubecost.com/blog/kubernetes-taints/>
    NoSchedule—The pod will not get scheduled to the node without a matching toleration.

    NoExecute—This will immediately evict all the pods without the matching toleration from the node.

    PerferNoSchedule—This is a softer version of NoSchedule where the controller will not try to schedule a pod with the tainted node. However, it is not a strict requirement.

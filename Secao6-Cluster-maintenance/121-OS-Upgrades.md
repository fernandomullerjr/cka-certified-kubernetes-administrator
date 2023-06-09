
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "121. OS Upgrades"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 121. OS Upgrades

# OS Upgrades
  - Take me to [Video Tutorial](https://kodekloud.com/topic/os-upgrades/)
  
In this section, we will take a look at OS upgrades.

#### If the node was down for more than 5 minutes, then the pods are terminated from that node

  ![os](../../images/os.PNG)
  
- You can purposefully **`drain`** the node of all the workloads so that the workloads are moved to other nodes.
  ```
  $ kubectl drain node-1
  ```
- The node is also cordoned or marked as unschedulable.
- When the node is back online after a maintenance, it is still unschedulable. You then need to uncordon it.
  ```
  $ kubectl uncordon node-1
  ```
- There is also another command called cordon. Cordon simply marks a node unschedulable. Unlike drain it does not terminate or move the pods on an existing node.

  ![drain](../../images/drain.PNG)
  
  
#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/administer-cluster/safely-drain-node/




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 121. OS Upgrades


The following startup parameters are provided to control eviction:

    pod-eviction-timeout: After the NotReady state node exceeds a default time of five minutes, the eviction will be executed.




## drain
Use kubectl drain to remove a node from service

You can use kubectl drain to safely evict all of your pods from a node before you perform maintenance on the node (e.g. kernel upgrade, hardware maintenance, etc.). Safe evictions allow the pod's containers to gracefully terminate and will respect the PodDisruptionBudgets you have specified.
Note: By default kubectl drain ignores certain system pods on the node that cannot be killed; see the kubectl drain documentation for more details.

- Drenando um node, ele faz um "shutdown gracefully" nos Pods, recriando os Pods em outros nodes:

```bash
kubectl drain node-1
```

- Após drenado, o node pode ser reiniciado e realizada a manutenção nele.
- Após terminada a manutenção, o node ao retornar ainda está "unschedulable", sendo necessário usar o comando uncordon, para normalizar ele:

```bash
kubectl uncordon node-1
```


- Também existe o comando cordon, que pega e marca um node como "unschedulable", mas não remove ou drena os Pods que estão nele, apenas não permite que novos Pods sejam schedulados nele:
~~~~bash
kubectl cordon NODE
~~~~



# RESUMO
- Por padrão o node leva 5min para "evitar" os Pods.
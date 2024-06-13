#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "258. Worker Node Failure."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##  258. Worker Node Failure

# Worker Node Failure

  - Lets check the status of the Nodes in the cluster, are they **`Ready`** or **`NotReady`**

    ```
    kubectl get nodes
    ```

  - If they are **`NotReady`** then check the **`LastHeartbeatTime`** of the node to find out the time when node might have crashed

    ```
    kubectl describe node worker-1
    ```



  - Check the possible **`CPU`** and **`MEMORY`**  using **`top`** and **`df -h`** 



  - Check the status and the logs of the **`kubelet`** for the possible issues.

    ```
    service kubelet status
    ```

    ```
    sudo journalctl -u kubelet
    ```
  
    
  - Check the **`kubelet`** Certificates, they are not expired, and in the right group and issued by the right CA.

    ```
    openssl x509 -in /var/lib/kubelet/worker-1.crt -text
    ```







# ###################################################################################################################### 
# ###################################################################################################################### 
##  258. Worker Node Failure

- Para pegar problemas de nodes, validar via describe se algum item da coluna "Conditions" tem algum setado com "true", podendo indicar algum problema:
kubectl describe node

<https://kubernetes.io/docs/reference/node/node-status/>
Conditions

The conditions field describes the status of all Running nodes. Examples of conditions include:
Node Condition	Description
Ready	True if the node is healthy and ready to accept pods, False if the node is not healthy and is not accepting pods, and Unknown if the node controller has not heard from the node in the last node-monitor-grace-period (default is 40 seconds)
DiskPressure	True if pressure exists on the disk size—that is, if the disk capacity is low; otherwise False
MemoryPressure	True if pressure exists on the node memory—that is, if the node memory is low; otherwise False
PIDPressure	True if pressure exists on the processes—that is, if there are too many processes on the node; otherwise False
NetworkUnavailable	True if the network for the node is not correctly configured, otherwise False


- Checar os certificados do **`kubelet`**, se expiraram, estão no grupo correto e estão emitidos no CA correto:

```bash
openssl x509 -in /var/lib/kubelet/worker-1.crt -text
```


- Se o node estiver **`NotReady`** , conferir o  **`LastHeartbeatTime`** para validar quando o node crashou:

```bash
kubectl describe node worker-1
```


## KUBELET

- Conferir os logs do **`kubelet`** :

```bash
    service kubelet status
```

```bash
sudo journalctl -u kubelet
```






# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- Para pegar problemas de nodes, validar via describe se algum item da coluna "Conditions" tem algum setado com "true", podendo indicar algum problema. Verificar por DiskPressure, MemoryPressure, PIDPressure, NetworkUnavailable:
kubectl describe node


- Checar os certificados do **`kubelet`**, se expiraram, estão no grupo correto e estão emitidos no CA correto:

```bash
openssl x509 -in /var/lib/kubelet/worker-1.crt -text
```


- Se o node estiver **`NotReady`** , conferir o  **`LastHeartbeatTime`** para validar quando o node crashou:

```bash
kubectl describe node worker-1
```


- Conferir os logs do **`kubelet`** :

```bash
    service kubelet status
```

```bash
sudo journalctl -u kubelet
```
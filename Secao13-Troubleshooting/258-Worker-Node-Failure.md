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
    serivce kubelet status
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



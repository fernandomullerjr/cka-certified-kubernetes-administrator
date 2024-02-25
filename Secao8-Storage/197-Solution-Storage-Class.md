
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 197. Solution - Storage Class."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 197. Solution - Storage Class

# Practice Test - Storage Class
  
  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-storage-class-2/)

#### Solution

  1. Check the Solution

     <details>

      ```
      0
      ```
    
     </details>

  2. Check the Solution

     <details>

      ```
      2
      ```
     </details>
 
  3. Check the Solution

     <details>

      ```
      local-storage
      ```
     </details>

  4. Check the Solution
    
     <details>

      ```
      WaitForFirstConsumer
      ```
      </details>

  5. Check the Solution

     <details>

      ```
      portworx-volume
      ```

     </details>

  6. Check the Solution

     <details>

      ```
      NO
      ```
     </details>

  7. Check the Solution

     <details>

      ```
      apiVersion: v1
      kind: PersistentVolumeClaim
      metadata:
        name: local-pvc
      spec:
        accessModes:
        - ReadWriteOnce
        resources:
          requests:
            storage: 500Mi
        storageClassName: local-storage
      ```
     </details>

  8. Check the Solution

     <details>

      ```
      Pending
      ```
     </details>

  9. Check the Solution

     <details>

      ```
      A Pod consuming the volume in not scheduled
      ```
     </details>

  10. Check the Solution

      <details>
 
       ```
       The Storage Class called local-storage makes use of VolumeBindingMode set to WaitForFirstConsumer. This will delay the binding and provisioning of a PersistentVolume until a Pod using the PersistentVolumeClaim is created.
       ```
      </details>

  11. Check the Solution

      <details>
 
       ```
       apiVersion: v1
       kind: Pod
       metadata:
         name: nginx
         labels:
           name: nginx
       spec:
           containers:
           - name: nginx
             image: nginx:alpine
             volumeMounts:
             - name: local-persistent-storage
               mountPath: /var/www/html
           volumes:
           - name: local-persistent-storage
             persistentVolumeClaim:
               claimName: local-pvc
       ```
      </details>

  12. Check the Solution

      <details>
 
       ```
       apiVersion: storage.k8s.io/v1
       kind: StorageClass
       metadata:
         name: delayed-volume-sc
       provisioner: kubernetes.io/no-provisioner
       volumeBindingMode: WaitForFirstConsumer
       ```
      </details>




# ###################################################################################################################### 
# ###################################################################################################################### 
## 197. Solution - Storage Class

https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/


What is the name of the Storage Class that does not support dynamic volume provisioning?

- RESPOSTA
local-storage

controlplane ~ ➜  kubectl get sc -A
NAME                        PROVISIONER                     RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)        rancher.io/local-path           Delete          WaitForFirstConsumer   false                  27m
local-storage               kubernetes.io/no-provisioner    Delete          WaitForFirstConsumer   false                  12s
portworx-io-priority-high   kubernetes.io/portworx-volume   Delete          Immediate              false                  12s

controlplane ~ ➜  date
Fri Feb 23 23:43:12 UTC 2024


- A resposta é "local-storage" devido o PROVISIONER.
No caso ele utiliza o "kubernetes.io/no-provisioner"



# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- O Provisioner define se o Storage Class suporta Dynamic Provisioning.

# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 189. Persistent Volumes."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  189. Persistent Volumes

# Persistent Volumes

In this section, we will take a look at **Persistent Volumes**

- In the large evnironment, with a lot of users deploying a lot of pods, the users would have to configure storage every time for each Pod.
- Whatever storage solution is used, the users who deploys the pods would have to configure that on all pod definition files in his environment. Every time a change is to be made, the user would have to make them on all of his pods.


- A Persistent Volume is a cluster-wide pool of storage volumes configured by an administrator to be used by users deploying application on the cluster. The users can now select storage from this pool using Persistent Volume Claims.

  ```
  pv-definition.yaml
  
  kind: PersistentVolume
  apiVersion: v1
  metadata:
    name: pv-vol1
  spec:
    accessModes: [ "ReadWriteOnce" ]
    capacity:
     storage: 1Gi
    hostPath:
     path: /tmp/data
  ```

  ```
  $ kubectl create -f pv-definition.yaml
  persistentvolume/pv-vol1 created

  $ kubectl get pv
  NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
  pv-vol1   1Gi        RWO            Retain           Available                                   3min
  
  $ kubectl delete pv pv-vol1
  persistentvolume "pv-vol1" deleted
  ```

#### Kubernetes Persistent Volumes

- https://kubernetes.io/docs/concepts/storage/persistent-volumes/
- https://portworx.com/tutorial-kubernetes-persistent-volumes/






# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  189. Persistent Volumes

- Manifesto

~~~~YAML
kind: PersistentVolume
apiVersion: v1
metadata:
  name: pv-vol1
spec:
  accessModes: ["ReadWriteOnce"]
  capacity:
    storage: 1Gi
  hostPath:
    path: /tmp/data

~~~~




# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# resumo

- Não utilizar o tipo de volume HostPath em ambientes de produção.

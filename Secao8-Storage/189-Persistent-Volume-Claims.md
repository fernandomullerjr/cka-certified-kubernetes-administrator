
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 189. Persistent Volume Claims."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  189. Persistent Volume Claims

# Persistent Volume Claims

  - Take me to [Lecture](https://kodekloud.com/topic/persistent-volume-claims-4/)

In this section, we will take a look at **Persistent Volume Claim**

- Now we will create a Persistent Volume Claim to make the storage available to the node.
- Volumes and Persistent Volume Claim are two separate objects in the Kubernetes namespace.
- Once the Persistent Volume Claim created, Kubernetes binds the Persistent Volumes to claim based on the request and properties set on the volume.


- If properties not matches or Persistent Volume is not available for the Persistent Volume Claim then it will display the pending state.

```
pvc-definition.yaml

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: myclaim
spec:
  accessModes: [ "ReadWriteOnce" ]
  resources:
   requests:
     storage: 1Gi
```

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

#### Create the Persistent Volume

```
$ kubectl create -f pv-definition.yaml
persistentvolume/pv-vol1 created

$ kubectl get pv
NAME      CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   REASON   AGE
pv-vol1   1Gi        RWO            Retain           Available                                   10s
```


#### Create the Persistent Volume Claim

```
$ kubectl create -f pvc-definition.yaml
persistentvolumeclaim/myclaim created

$ kubectl get pvc
NAME      STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
myclaim   Pending                                                     35s

$ kubectl get pvc
NAME      STATUS   VOLUME    CAPACITY   ACCESS MODES   STORAGECLASS   AGE
myclaim   Bound    pv-vol1   1Gi        RWO                           1min

```

#### Delete the Persistent Volume Claim

```
$ kubectl delete pvc myclaim
```

#### Delete the Persistent Volume

```
$ kubectl delete pv pv-vol1
```


#### Kubernetes Persistent Volume Claims Reference Docs

- https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims
- https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#persistentvolumeclaim-v1-core
- https://docs.cloud.oracle.com/en-us/iaas/Content/ContEng/Tasks/contengcreatingpersistentvolumeclaim.htm





# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  189. Persistent Volume Claims

https://kubernetes.io/docs/concepts/storage/persistent-volumes/#persistentvolumeclaims

## Selector

Claims can specify a label selector to further filter the set of volumes. Only the volumes whose labels match the selector can be bound to the claim. The selector can consist of two fields:

    matchLabels - the volume must have a label with this value
    matchExpressions - a list of requirements made by specifying key, list of values, and operator that relates the key and values. Valid operators include In, NotIn, Exists, and DoesNotExist.

All of the requirements, from both matchLabels and matchExpressions, are ANDed together – they must all be satisfied in order to match.



## Reclaim Policy

Current reclaim policies are:

    Retain -- manual reclamation
    Recycle -- basic scrub (rm -rf /thevolume/*)
    Delete -- delete the volume

For Kubernetes 1.29, only nfs and hostPath volume types support recycling.





# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# RESUMO

- Se o PVC der match com vários PV, é possível utilizar Labels para especificar um Volume desejado.
- O padrão ao deletar um PVC é o "Retain", que mantem o Volume, que precisa ser deletado manualmente.

# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 195. Storage Class."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 195. Storage Class

  - Take me to [Lecture](https://kodekloud.com/topic/storage-class/)

In this section, we will take a look at **Storage Class**

- We discussed about how to create Persistent Volume and Persistent Volume Claim and We also saw that how to use into the Pod's volume to claim that volume space.
- We created Persistent Volume but before this if we are taking a volume from Cloud providers like GCP, AWS, Azure. We need to first create disk in the Google Cloud as an example. 
- We need to create manually each time when we define in the Pod definition file. that's called **Static Provisioning**. 

#### Static Provisioning

![class-18](../../images/class18.PNG)


#### Dynamic Provisioning

![class-19](../../images/class19.PNG)

- Now we have a Storage Class, So we no longer to define Persistent Volume. It will create automatically when a Storage Class is created. It's called **Dynamic Provisioning**. 

```
sc-definition.yaml

apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
   name: google-storage
provisioner: kubernetes.io/gce-pd
```

#### Create a Storage Class

```
$ kubectl create -f sc-definition.yaml
storageclass.storage.k8s.io/google-storage created
```

#### List the Storage Class

```
$ kubectl get sc
NAME             PROVISIONER            RECLAIMPOLICY   VOLUMEBINDINGMODE   ALLOWVOLUMEEXPANSION   AGE
google-storage   kubernetes.io/gce-pd   Delete          Immediate           false                  20s
```

#### Create a Persistent Volume Claim

```
pvc-definition.yaml

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: myclaim
spec:
  accessModes: [ "ReadWriteOnce" ]
  storageClassName: google-storage       
  resources:
   requests:
     storage: 500Mi
```
```
$ kubectl create -f pvc-definition.yaml

```
#### Create a Pod

```
pod-definition.yaml

apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
    - name: frontend
      image: nginx
      volumeMounts:
      - mountPath: "/var/www/html"
        name: web
  volumes:
    - name: web
      persistentVolumeClaim:
        claimName: myclaim
```
```
$ kubectl create -f pod-definition.yaml
```
#### Provisioner

![class-20](../../images/class20.PNG)

#### Kubernetes Storage Class Reference Docs

- https://kubernetes.io/docs/concepts/storage/storage-classes/
- https://cloud.google.com/kubernetes-engine/docs/concepts/persistent-volumes#storageclasses
- https://docs.aws.amazon.com/eks/latest/userguide/storage-classes.html





# ###################################################################################################################### 
# ###################################################################################################################### 
## 195. Storage Class

<https://kubernetes.io/docs/concepts/storage/storage-classes/>

Here's an example of a StorageClass:
storage/storageclass-low-latency.yaml [Copy storage/storageclass-low-latency.yaml to clipboard]

~~~~yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: low-latency
  annotations:
    storageclass.kubernetes.io/is-default-class: "false"
provisioner: csi-driver.example-vendor.example
reclaimPolicy: Retain # default value is Delete
allowVolumeExpansion: true
mountOptions:
  - discard # this might enable UNMAP / TRIM at the block storage layer
volumeBindingMode: WaitForFirstConsumer
parameters:
  guaranteedReadWriteLatency: "true" # provider-specific
~~~~






## Dynamic Volume Provisioning

<https://kubernetes.io/docs/concepts/storage/dynamic-provisioning/>

Dynamic volume provisioning allows storage volumes to be created on-demand. Without dynamic provisioning, cluster administrators have to manually make calls to their cloud or storage provider to create new storage volumes, and then create PersistentVolume objects to represent them in Kubernetes. The dynamic provisioning feature eliminates the need for cluster administrators to pre-provision storage. Instead, it automatically provisions storage when it is requested by users.
Background

The implementation of dynamic volume provisioning is based on the API object StorageClass from the API group storage.k8s.io. A cluster administrator can define as many StorageClass objects as needed, each specifying a volume plugin (aka provisioner) that provisions a volume and the set of parameters to pass to that provisioner when provisioning. A cluster administrator can define and expose multiple flavors of storage (from the same or different storage systems) within a cluster, each with a custom set of parameters. This design also ensures that end users don't have to worry about the complexity and nuances of how storage is provisioned, but still have the ability to select from multiple storage options.

More information on storage classes can be found here.
Enabling Dynamic Provisioning

To enable dynamic provisioning, a cluster administrator needs to pre-create one or more StorageClass objects for users. StorageClass objects define which provisioner should be used and what parameters should be passed to that provisioner when dynamic provisioning is invoked. The name of a StorageClass object must be a valid DNS subdomain name.

The following manifest creates a storage class "slow" which provisions standard disk-like persistent disks.

~~~~yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: slow
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-standard
~~~~

The following manifest creates a storage class "fast" which provisions SSD-like persistent disks.

~~~~yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: fast
provisioner: kubernetes.io/gce-pd
parameters:
  type: pd-ssd
~~~~

Using Dynamic Provisioning

Users request dynamically provisioned storage by including a storage class in their PersistentVolumeClaim. Before Kubernetes v1.6, this was done via the volume.beta.kubernetes.io/storage-class annotation. However, this annotation is deprecated since v1.9. Users now can and should instead use the storageClassName field of the PersistentVolumeClaim object. The value of this field must match the name of a StorageClass configured by the administrator (see below).

To select the "fast" storage class, for example, a user would create the following PersistentVolumeClaim:

~~~~yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: claim1
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: fast
  resources:
    requests:
      storage: 30Gi
~~~~

This claim results in an SSD-like Persistent Disk being automatically provisioned. When the claim is deleted, the volume is destroyed.
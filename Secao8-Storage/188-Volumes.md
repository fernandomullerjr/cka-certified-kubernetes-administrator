
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m " 188. Volumes."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 188. Volumes

# Volumes

In this section, we will take a look at **Volumes**

- We discussed about Docker storage, If we don't attach the volume in the container runtime, when container destroyed and then all data will be lost. So, We need to persist data into the Docker container so we attach a volume to the containers when they are created.
- The data are processed by the container is now placed in this volume thereby retaining it permanently. Even if the container is deleted the data remains in the volume.

- In the Kubernetes world, the PODs created in Kubernetes are transient in nature. When a POD is created to process data and then deleted, the data processed by it gets deleted as well. 
- For example, We create a simple POD that generated a random between 1 and 100 and writes that to a file at `/opt/number.out`. To persist into the volume.
- We create a volume for that. In this case I specify a path `/data` on the host. Files are stored in the directory data on my node. We use the volumeMounts field in each container to mount the data-volume to the directory `/opt` within the container. The random number will now be written to `/opt` mount inside the container, which happens to be on the data-volume which is in fact `/data` directory on the host. When the pod gets deleted, the file with the random number still lives on the host.


## Volume Storage Options

- In the volumes, hostPath volume type is fine with the single node. It's not recomended for use with the multi node cluster.
- In the Kubernetes, it supports several types of standard storage solutions such as NFS, GlusterFS, CephFS or public cloud solutions like AWS EBS, Azure Disk or Google's Persistent Disk.


```
volumes:
- name: data-volume
  awsElasticBlockStore:
    volumeID: <volume-id>
    fsType: ext4
```

#### Kubernetes Volumes Reference Docs

- https://kubernetes.io/docs/concepts/storage/volumes/
- https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/
- https://unofficial-kubernetes.readthedocs.io/en/latest/concepts/storage/volumes/
- https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.18/#volume-v1-core


# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 188. Volumes


preciso deste manifesto corrigido e indentado :

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: random-number-generator
spec:
  containers:
  - image: alpine
  name: alpine
  command: ["/bin/sh","-c"]
  args: ["shuf -i 0-100 -n 1 >> /opt/number.out;"]
  volumes:
  - name: data-volume
  /data
  volumeMounts:
  - mountPath: /opt
  name: data-volume
  hostPath:
  path: /data
  type: Directory
~~~~


ChatGPT

Aqui está o manifesto corrigido e indentado:

~~~~YAML

apiVersion: v1
kind: Pod
metadata:
  name: random-number-generator
spec:
  containers:
  - image: alpine
    name: alpine
    command: ["/bin/sh", "-c"]
    args: ["shuf -i 0-100 -n 1 >> /opt/number.out;"]
    volumeMounts:
    - mountPath: /opt
      name: data-volume
  volumes:
  - name: data-volume
    hostPath:
      path: /data
      type: Directory
~~~~

Principais correções:

    Os campos name e image dentro do contêiner devem ser indentados para a mesma profundidade.
    Os campos mountPath e name dentro de volumeMounts devem ser indentados adequadamente.
    O campo volumes deve ser definido após containers.
    Adição de um hífen (-) antes de /data para corrigir o erro de indentação.



como funciona este manifesto? quais paths são no container e no host?
ChatGPT

Vamos analisar o manifesto para entender como ele funciona e quais são os paths no container e no host:

~~~~yaml

apiVersion: v1
kind: Pod
metadata:
  name: random-number-generator
spec:
  containers:
  - image: alpine
    name: alpine
    command: ["/bin/sh", "-c"]
    args: ["shuf -i 0-100 -n 1 >> /opt/number.out;"]
    volumeMounts:
    - mountPath: /opt
      name: data-volume
  volumes:
  - name: data-volume
    hostPath:
      path: /data
      type: Directory
~~~~

    Container Path:
        O contêiner usa o caminho /opt para montar o volume especificado.

    Host Path:
        O volume é um hostPath e está montado no caminho /data no host.

Em resumo, o contêiner tem acesso ao diretório /opt e pode escrever um número gerado aleatoriamente no arquivo /opt/number.out. Esse diretório /opt está montado a partir de um volume chamado data-volume. Por sua vez, esse volume data-volume é um hostPath montado no diretório /data no host.

Portanto, qualquer coisa escrita no caminho /opt dentro do contêiner será refletida no diretório /data no host. Este exemplo em particular cria um número aleatório entre 0 e 100 e o anexa ao arquivo /opt/number.out dentro do contêiner, que é, na verdade, o diretório /data no host devido ao volume hostPath.
User
o host é o node do Kubernetes neste caso?
ChatGPT

Sim, no contexto do Kubernetes, o termo "host" refere-se ao nó (node) onde os pods são executados. Cada nó em um cluster Kubernetes é responsável por executar os containers que compõem os pods. Quando você usa um hostPath em um volume, você está especificando um caminho no sistema de arquivos do nó hospedeiro (host node) para ser montado no pod.

Portanto, no seu manifesto, o caminho /data especificado em hostPath se refere a um diretório no nó do Kubernetes onde o pod está sendo executado. O conteúdo desse diretório no host é acessível para o contêiner no pod através do ponto de montagem em /opt no contêiner.
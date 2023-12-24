
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "186. Container Storage Interface (CSI)."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 186. Container Storage Interface (CSI)

# Container Storage Interface

In this section, we will take a look at **Container Storage Interface**

## Container Runtime Interface

- Kubernetes used Docker alone as the container runtime engine, and all the code to work with Docker was embedded within the Kubernetes source code. Other container runtimes, such as rkt and CRI-O.
- The Container Runtime Interface is a standard that defines how an orchestration solution like Kubernetes would communicate with container runtimes like Docker. If any new container runtime interace is developed, they can simply follow the CRI standards.


## Container Networking Interface

- To support different networking solutions, the container networking interface was introduced. Any new networking vendors could simply develop their plugin based on the CNI standards and make their solution work with Kubernetes.


## Container Storage Interface

- The container storage interface was developed to support multiple storage solutions. With CSI, you can now write your own drivers for your own storage to work with Kubernetes. Portworx, Amazon EBS, Azure Disk, GlusterFS etc.
- CSI is not a Kubernetes specific standard. It is meant to be a universal standard and if implemented, allows any container orchestration tool to work with any storage vendor with a supported plugin. Kubernetes, Cloud Foundry and Mesos are onboard with CSI.
- It defines a set of RPCs or remote procedure calls that will be called by the container orchestrator. These must be implemented by the storage drivers.


#### Container Storage Interface 

- https://github.com/container-storage-interface/spec
- https://kubernetes-csi.github.io/docs/
- http://mesos.apache.org/documentation/latest/csi/
- https://www.nomadproject.io/docs/internals/plugins/csi#volume-lifecycle





# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# 186. Container Storage Interface (CSI)

O Container Storage Interface (CSI) é uma especificação padrão para a interface entre orquestradores de contêineres, como o Kubernetes, e sistemas de armazenamento externos. Ele permite que os orquestradores de contêineres interajam com diferentes tipos de armazenamento de maneira consistente, independentemente do provedor de armazenamento subjacente.

A implementação do CSI no Kubernetes envolve alguns componentes principais:

    CSI Driver: Este é o componente que implementa a especificação CSI e é fornecido pelo provedor de armazenamento. O CSI Driver é responsável por interagir com o sistema de armazenamento específico e atuar como uma ponte entre o Kubernetes e o armazenamento externo.

    CSIDriver Resource: No Kubernetes, você cria um recurso CSIDriver para registrar um driver CSI no cluster. Isso informa ao Kubernetes sobre o driver CSI disponível e suas características.

    Pod Spec: Quando você deseja usar um volume CSI em um pod, você define um volume no spec do pod referenciando o driver CSI desejado. Isso envolve a criação de um recurso PersistentVolume (PV) e um recurso PersistentVolumeClaim (PVC) associado. O PVC é montado no pod e o driver CSI é responsável por atender a essas solicitações.

Aqui está um exemplo básico de como isso pode parecer:

~~~~yaml

apiVersion: v1
kind: PersistentVolume
metadata:
  name: example-pv
spec:
  capacity:
    storage: 1Gi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: example-csi
  csi:
    driver: com.example.csi
    volumeHandle: volume-id-from-csi
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: example-pvc
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: example-csi
  resources:
    requests:
      storage: 1Gi
---
apiVersion: v1
kind: Pod
metadata:
  name: example-pod
spec:
  volumes:
    - name: example-volume
      persistentVolumeClaim:
        claimName: example-pvc
  containers:
    - name: example-container
      image: nginx
      volumeMounts:
        - mountPath: "/data"
          name: example-volume
~~~~

Neste exemplo:

    Um PersistentVolume é definido com um driver CSI chamado com.example.csi.
    Um PersistentVolumeClaim é criado para solicitar uma parte do armazenamento disponível.
    Um pod é definido com um volume montado usando o PVC.

É importante observar que os detalhes específicos variam com base no driver CSI que você está usando e no sistema de armazenamento subjacente. Certifique-se de consultar a documentação do provedor de armazenamento e do driver CSI para obter informações detalhadas sobre como configurar e usar o CSI no seu ambiente específico.


## RPC

O Container Storage Interface (CSI) utiliza chamadas de procedimento remoto (RPC) para facilitar a comunicação entre o orquestrador de contêineres (como o Kubernetes) e o driver de armazenamento externo. As RPCs são um mecanismo de comunicação que permite que processos em execução em diferentes espaços de endereço solicitem serviços uns aos outros como se fossem chamadas de procedimento locais, mesmo que estejam em máquinas diferentes.

No contexto do CSI, as RPCs são usadas para que o orquestrador de contêineres solicite operações de armazenamento ao driver CSI. Aqui estão alguns conceitos-chave relacionados a essa interação:

    gRPC (gRPC Remote Procedure Calls): O CSI utiliza gRPC como o protocolo para suas RPCs. gRPC é um framework de código aberto desenvolvido pelo Google que facilita a criação de sistemas distribuídos eficientes e escaláveis. Ele usa o Protocol Buffers como a linguagem de interface.

    gRPC Service Definition: O serviço CSI é definido em um arquivo .proto, que especifica os métodos RPC disponíveis e os tipos de mensagens de entrada e saída para cada método. Este arquivo é compilado para gerar os stubs de código para o cliente (orquestrador) e o servidor (driver CSI).

    Identificação e Autenticação: A comunicação entre o orquestrador e o driver CSI pode envolver identificação e autenticação. Mecanismos como certificados TLS podem ser usados para garantir que a comunicação seja segura.

    CSI Controller Service: O serviço de controlador CSI geralmente lida com operações de administração, como a criação e exclusão de volumes. As chamadas de RPC associadas podem incluir métodos como CreateVolume, DeleteVolume, ControllerPublishVolume, entre outros.

    CSI Node Service: O serviço de nó CSI está envolvido nas operações de montagem e desmontagem de volumes em nós específicos. As chamadas de RPC associadas podem incluir métodos como NodePublishVolume e NodeUnpublishVolume.

Ao longo do ciclo de vida de um pod em execução em um nó, o orquestrador pode chamar métodos CSI para criar, montar e desmontar volumes conforme necessário.

É importante observar que os detalhes específicos das RPCs podem variar entre os diferentes drivers CSI, uma vez que esses drivers são implementados por fornecedores de armazenamento externo. A documentação específica do driver CSI que você está usando deve ser consultada para entender detalhes precisos sobre as RPCs disponíveis e como configurar a interação entre o orquestrador e o driver.
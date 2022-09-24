
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 28. Recap - ReplicaSets. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 28 - Recap - ReplicaSets

- ReplicationController é o antigo, que está sendo substituido pelo ReplicaSet.

- Exemplo de manifesto de um ReplicationController:
<https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/>

~~~~yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: nginx
spec:
  replicas: 3
  selector:
    app: nginx
  template:
    metadata:
      name: nginx
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx
        ports:
        - containerPort: 80
~~~~



# Controladores de Replicação e Conjuntos de Replicação

<https://www.digitalocean.com/community/tutorials/uma-introducao-ao-kubernetes-pt>

Frequentemente, ao trabalhar com o Kubernetes, em vez de trabalhar com pods únicos, você estará gerenciando grupos de pods idênticos e replicados. Estes são criados a partir de modelos de pod e podem ser escalados horizontalmente por controladores conhecidos como Replication Controllers e Replication Sets.

Um Replication Controller ou controlador de replicação é um objeto que define um modelo de pod e os parâmetros de controle para escalar réplicas idênticas ou decrementar o número de cópias em execução. Esta é uma maneira fácil de distribuir a carga e aumentar a disponibilidade nativamente dentro do Kubernetes. O replication controller sabe como criar novos pods quando necessário, porque um modelo que se assemelha a uma definição de pod está embutido dentro da configuração dele.

O replication controller é responsável por assegurar que o número de pods implantados no cluster corresponde ao número de pods em sua configuração. Se um pod ou host subjacente falhar, o controlador irá iniciar novos pods para compensar. Se o número de réplicas na configuração do controlador se alterar, o controlador inicializa ou destrói containers para corresponder ao número desejado. Os replication controllers também podem realizar atualizações contínuas passando um conjunto de pods para uma nova versão. um a um, minimizando o impacto na disponibilidade da aplicação.

Replication Sets ou Conjuntos de Replicação são uma iteração no design do replication controller com maior flexibilidade em como o controlador identifica os pods que ele deve gerenciar. Os replication sets estão começando a substituir os replication controllers por causa de seus recursos de seleção de réplicas que são maiores, mas eles não são capazes de fazer atualizações contínuas para colocar os backends em uma nova versão como os replication controllers fazem. Em vez disso, os replication sets destinam-se a ser usados dentro de unidades adicionais de nível superior que fornecem essa funcionalidade.

Assim como os pods, tanto os replication controllers quanto os replication sets raramente são as unidades com as quais você trabalhará diretamente. Enquanto eles constroem-se em cima do projeto do pod para adicionar escalonamento horizontal e garantias de confiabilidade, eles não possuem alguns dos recursos de gerenciamento de ciclo de vida refinados encontrados em objetos mais complexos.







# Exemplo da aula

~~~~yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: myapp-rc
  labels:
    app: myapp
    type: front-end
spec:
 template:
    metadata:
      name: myapp-pod
      labels:
        app: myapp
        type: front-end
    spec:
     containers:
     - name: nginx-container
       image: nginx
 replicas: 3
~~~~


- To Create the replication controller
kubectl create -f rc-definition.yaml

- To list all the replication controllers
kubectl get replicationcontroller

- To list pods that are launch by the replication controller
kubectl get pods



# Creating a ReplicaSet
ReplicaSet Definition File

~~~~yaml
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myapp-replicaset
  labels:
    app: myapp
    type: front-end
spec:
 template:
    metadata:
      name: myapp-pod
      labels:
        app: myapp
        type: front-end
    spec:
     containers:
     - name: nginx-container
       image: nginx
 replicas: 3
 selector:
   matchLabels:
    type: front-end
~~~~



- ReplicaSet requires a selector definition when compare to Replication Controller.

- To Create the replicaset
    kubectl create -f replicaset-definition.yaml

- To list all the replicaset
    kubectl get replicaset

- To list pods that are launch by the replicaset
    kubectl get pods



# ReplicaSet
- O ReplicaSet precisa do Selector.
- Precisam ser especificados os Labels que vão dar match, que devem estar conforme o bloco de código sobre Pod.





# Labels and Selectors
What is the deal with Labels and Selectors? Why do we label pods and objects in kubernetes?


How to scale replicaset
    There are multiple ways to scale replicaset
        First way is to update the number of replicas in the replicaset-definition.yaml definition file. E.g replicas: 6 and then run


~~~~yaml
apiVersion: apps/v1
   kind: ReplicaSet
   metadata:
     name: myapp-replicaset
     labels:
       app: myapp
       type: front-end
   spec:
    template:
       metadata:
         name: myapp-pod
         labels:
           app: myapp
           type: front-end
       spec:
        containers:
        - name: nginx-container
          image: nginx
    replicas: 6
    selector:
      matchLabels:
       type: front-end
~~~~
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 35. Kubernetes Services. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# # Kubernetes Services
  - Take me to [Video Tutorial](https://kodekloud.com/topic/services-3/)
  
In this section we will take a look at **`services`** in kubernetes

## Services
- Kubernetes Services enables communication between various components within and outside of the application.

  
#### Let's look at some other aspects of networking

## External Communication

- How do we as an **`external user`** access the **`web page`**?

  - From the node (Able to reach the application as expected)
  
   
  - From outside world (This should be our expectation, without something in the middle it will not reach the application)
  
   
    
 ## Service Types
 
 #### There are 3 types of service types in kubernetes
 
    
 1. NodePort
    - Where the service makes an internal POD accessible on a POD on the NODE.
      ```
      apiVersion: v1
      kind: Service
      metadata:
       name: myapp-service
      spec:
       types: NodePort
       ports:
       - targetPort: 80
         port: 80
         nodePort: 30008
      ```
      
      #### To connect the service to the pod
      ```
      apiVersion: v1
      kind: Service
      metadata:
       name: myapp-service
      spec:
       type: NodePort
       ports:
       - targetPort: 80
         port: 80
         nodePort: 30008
       selector:
         app: myapp
         type: front-end
       ```


      
      #### To create the service
      ```
      $ kubectl create -f service-definition.yaml
      ```
      
      #### To list the services
      ```
      $ kubectl get services
      ```
      
      #### To access the application from CLI instead of web browser
      ```
      $ curl http://192.168.1.2:30008
      ```
      


      #### A service with multiple pods
      
      
      #### When Pods are distributed across multiple nodes
     

     
            
 1. ClusterIP
    - In this case the service creates a **`Virtual IP`** inside the cluster to enable communication between different services such as a set of frontend servers to a set of backend servers.
    
 1. LoadBalancer
    - Where the service provisions a **`loadbalancer`** for our application in supported cloud providers.
    
K8s Reference Docs:
- https://kubernetes.io/docs/concepts/services-networking/service/
- https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/





# IMPORTANTE
- TargetPort = porta do Pod
- Port = porta do Service
- NodePort = porta do Node


# push
git status
git add .
git commit -m "Aula 35. Kubernetes Services. pt2"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



- continua em
8:15



# #################################################
# #################################################
# #################################################
# O que é um serviço do Kubernetes?

Um Service agrupa um conjunto de endpoints de pod em um único recurso. É possível configurar várias maneiras de acessar o agrupamento. Por padrão, você recebe um endereço IP de cluster estável que os clientes dentro do cluster podem usar para contatar pods no serviço. Um cliente envia uma solicitação ao endereço IP estável e a solicitação é encaminhada a um dos pods no serviço.

Um serviço identifica seus pods membro com um seletor. Para que um pod seja membro do serviço, ele precisa ter todos os rótulos especificados no seletor. Um rótulo é um par de chave-valor arbitrário anexado a um objeto.

O manifesto de serviço a seguir tem um seletor que especifica dois rótulos. O campo selector diz que qualquer pod que tenha o rótulo app: metrics e o rótulo department:engineering é membro deste serviço.

~~~~yaml
apiVersion: v1
kind: Service
metadata:
  name: my-service
spec:
  selector:
    app: metrics
    department: engineering
  ports:
  ...
~~~~





- O traço no começo da declaração das portas, indica que é um array.

 - targetPort: 80
   port: 80
   nodePort: 30008



- O range de portas do NodePort:
TCP	Inbound	30000-32767	NodePort Services†





# push
git status
git add .
git commit -m "Aula 35. Kubernetes Services. pt3"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status

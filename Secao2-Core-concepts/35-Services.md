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





- O traço no começo da declaração das portas, indica que é um Array de portas.

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




# #################################################
# #################################################
# #################################################
# L4 Round Robin Load Balancing with kube-proxy
<https://blog.getambassador.io/load-balancing-strategies-in-kubernetes-l4-round-robin-l7-round-robin-ring-hash-and-more-6a5b81595d6c>
In a typical Kubernetes cluster, requests that are sent to a Kubernetes Service are routed by a component named kube-proxy. Somewhat confusingly, kube-proxy isn’t a proxy in the classic sense, but a process that implements a virtual IP for a service via iptables rules. This architecture adds additional complexity to routing. A small amount of latency is introduced for each request which increases as the number of services grows.

Moreover, kube-proxy routes at Layer 4 (L4), i.e., TCP, which doesn’t necessarily fit well with today’s application-centric protocols. For example, imagine two gRPC clients connecting to your backend Pods. In L4 load balancing, each client would be sent to a different backend Pod using round robin load balancing. This is true even if one client is sending 1 request per minute, while the other client is sending 100 requests per second.

So why use kube-proxy at all? In one word: simplicity. The entire round robin load balancing process is delegated to Kubernetes, the default strategy. Thus, whether you’re sending a request via Ambassador Edge Stack or via another service, you’re going through the same load balancing mechanism.







# #################################################
# #################################################
# #################################################
# Load balancing in Kubernetes Services

<https://learnk8s.io/kubernetes-long-lived-connections>

Kubernetes Services don't exist.

There's no process listening on the IP address and port of the Service.

    You can check that this is the case by accessing any node in your Kubernetes cluster and executing netstat -ntlp.

Even the IP address can't be found anywhere.

The IP address for a Service is allocated by the control plane in the controller manager and stored in the database — etcd.

That same IP address is then used by another component: kube-proxy.

Kube-proxy reads the list of IP addresses for all Services and writes a collection of iptables rules in every node.

The rules are meant to say: "if you see this Service IP address, instead rewrite the request and pick one of the Pod as the destination".

The Service IP address is used only as a placeholder — that's why there is no process listening on the IP address or port.

    Consider a cluster with three Nodes. Each Node has a Pod deployed.
    1/8

    Consider a cluster with three Nodes. Each Node has a Pod deployed.
    Next 

Does iptables use round-robin?

No, iptables is primarily used for firewalls, and it is not designed to do load balancing.

However, you could craft a smart set of rules that could make iptables behave like a load balancer.

And this is precisely what happens in Kubernetes.

If you have three Pods, kube-proxy writes the following rules:

    select Pod 1 as the destination with a likelihood of 33%. Otherwise, move to the next rule
    choose Pod 2 as the destination with a probability of 50%. Otherwise, move to the following rule
    select Pod 3 as the destination (no probability)

The compound probability is that Pod 1, Pod 2 and Pod 3 have all have a one-third chance (33%) to be selected.
iptables rules for three Pods

Also, there's no guarantee that Pod 2 is selected after Pod 1 as the destination.

# importante
Iptables use the statistic module with random mode. So the load balancing algorithm is random.
Iptables use the statistic module with random mode. So the load balancing algorithm is random.
Iptables use the statistic module with random mode. So the load balancing algorithm is random.
Iptables use the statistic module with random mode. So the load balancing algorithm is random.





# push
git status
git add .
git commit -m "Aula 35. Kubernetes Services. pt4"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status

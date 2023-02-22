# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push
git status
git add .
git commit -m "Aula 36. Services Cluster IP. pt1"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# # 36. Services Cluster IP

# Kubernetes Services - ClusterIP
  - Take me to [Video Tutorial](https://kodekloud.com/topic/services-cluster-ip-2/)
  
In this section we will take a look at **`services - ClusterIP`** in kubernetes
         
## ClusterIP
- In this case the service creates a **`Virtual IP`** inside the cluster to enable communication between different services such as a set of frontend servers to a set of backend servers.
    

    
#### What is a right way to establish connectivity between these services or tiers  
- A kubernetes service can help us group the pods together and provide a single interface to access the pod in a group.


  
#### To create a service of type ClusterIP
```
apiVersion: v1
kind: Service
metadata:
 name: back-end
spec:
 types: ClusterIP
 ports:
 - targetPort: 80
   port: 80
 selector:
   app: myapp
   type: back-end
```
```
$ kubectl create -f service-definition.yaml
```

#### To list the services
```
$ kubectl get services
```

   
K8s Reference Docs:
- https://kubernetes.io/docs/concepts/services-networking/service/
- https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/






# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# importante
- O tipo padrão de service é o ClusterIP, se não for especificado um tipo, o Kubernetes assume automaticamente que é um ClusterIP!
- O tipo padrão de service é o ClusterIP, se não for especificado um tipo, o Kubernetes assume automaticamente que é um ClusterIP!
- O tipo padrão de service é o ClusterIP, se não for especificado um tipo, o Kubernetes assume automaticamente que é um ClusterIP!
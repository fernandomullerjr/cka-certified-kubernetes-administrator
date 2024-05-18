#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "252. Application Failure."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ###################################################################################################################### 
# ###################################################################################################################### 
##  252. Application Failure

# Application Failure
  
  - In this lecture we will go step by step in troubleshooting Application failure.

  - To check the Application/Service status of the webserver

    ```
    curl http://web-service-ip:node-port
    ```

    ![app](../../images/app.PNG)

  - To check the endpoint of the service and compare it with the selectors

    ```
    kubectl describe service web-service
    ```   

    ![svc](../../images/svc.PNG)


  - To check the status and logs of the pod

    ```
    kubectl get pod
    ```

    ```
    kubectl describe pod web
    ```

    ```
    kubectl logs web
    ```

  - To check the logs of the previous pod

    ```
    kubectl logs web -f --previous
    ```
    
    ![db](../../images/db.PNG)


  #### Hands on Labs

  - Lets troubleshoot the [Application](https://kodekloud.com/topic/practice-test-application-failure/)






# ###################################################################################################################### 
# ###################################################################################################################### 
##  252. Application Failure


- Checar o endpoint, se está acessível, utilizar o curl para tentar acessar o ip ou endereço, por exemplo.
curl http://web-service-ip:node-port

- Verificar o Service
conferir o Selector, bater com os Labels dos Pods
conferir os Endpoints

- Conferir o Pod usando "kubectl describe pod" e "kubectl logs <nome-do-pod>".

- Também existe a opção de verificar os logs de um Pod anterior:
kubectl logs web -f --previous

- Conferir logs do Pod do DB.



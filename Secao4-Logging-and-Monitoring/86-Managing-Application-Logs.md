
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 86. Managing Application Logs"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status







# ##############################################################################################################################################################
#  86. Managing Application Logs


# Managing Application Logs
  - Take me to [Video Tutorial](https://kodekloud.com/topic/managing-application-logs/)

In this section, we will take a look at managing application logs

#### Let us start with logging in docker

![ld](../../images/ld.PNG)
 
![ld1](../../images/ld1.PNG)
 
#### Logs - Kubernetes
```
apiVersion: v1
kind: Pod
metadata:
  name: event-simulator-pod
spec:
  containers:
  - name: event-simulator
    image: kodekloud/event-simulator
```
 ![logs-k8s](../../images/logs-k8s.png)
 
- To view the logs
  ```
  $ kubectl logs -f event-simulator-pod
  ```
- If there are multiple containers in a pod then you must specify the name of the container explicitly in the command.
  ```
  $ kubectl logs -f <pod-name> <container-name>
  $ kubectl logs -f even-simulator-pod event-simulator
  ```

  ![logs1](../../images/logs1.PNG)
  
#### K8s Reference Docs
- https://kubernetes.io/blog/2015/06/cluster-level-logging-with-kubernetes/
 







# ##############################################################################################################################################################
#  86. Managing Application Logs



docker run kodekloud/event-simulator



~~~~bash
fernando@debian10x64:~$ docker run kodekloud/event-simulator
Unable to find image 'kodekloud/event-simulator:latest' locally
latest: Pulling from kodekloud/event-simulator
4fe2ade4980c: Pull complete
7cf6a1d62200: Pull complete
3be976674be6: Pull complete
c52373c891c4: Pull complete
afe67e449426: Pull complete
663782b72351: Pull complete
cd7a503c982e: Pull complete
Digest: sha256:1e3e9c72136bbc76c96dd98f29c04f298c3ae241c7d44e2bf70bcc209b030bf9
Status: Downloaded newer image for kodekloud/event-simulator:latest
[2023-02-08 02:53:12,292] INFO in event-simulator: USER4 logged out
[2023-02-08 02:53:13,294] INFO in event-simulator: USER4 logged in
[2023-02-08 02:53:14,296] INFO in event-simulator: USER1 logged out
[2023-02-08 02:53:15,297] INFO in event-simulator: USER2 is viewing page3
[2023-02-08 02:53:16,299] INFO in event-simulator: USER2 is viewing page1
[2023-02-08 02:53:17,301] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:53:17,301] INFO in event-simulator: USER3 is viewing page3
[2023-02-08 02:53:18,304] INFO in event-simulator: USER3 is viewing page2
[2023-02-08 02:53:19,306] INFO in event-simulator: USER4 logged out
[2023-02-08 02:53:29,342] INFO in event-simulator: USER4 is viewing page2
[2023-02-08 02:53:30,346] INFO in event-simulator: USER4 is viewing page1
[2023-02-08 02:53:31,351] INFO in event-simulator: USER3 is viewing page1
[2023-02-08 02:53:32,354] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:53:32,354] INFO in event-simulator: USER4 is viewing page1
[2023-02-08 02:53:33,356] INFO in event-simulator: USER1 is viewing page2
[2023-02-08 02:53:34,360] INFO in event-simulator: USER4 is viewing page2
[2023-02-08 02:53:35,362] INFO in event-simulator: USER3 logged out
[2023-02-08 02:53:36,366] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-08 02:53:36,366] INFO in event-simulator: USER2 is viewing page2
[2023-02-08 02:53:37,370] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:53:37,370] INFO in event-simulator: USER1 is viewing page3
~~~~






docker run -d kodekloud/event-simulator

~~~~bash
fernando@debian10x64:~$ docker run -d kodekloud/event-simulator
606d2a73060f8193297b90eed203b145f36e37bcc3588b2bd39f882bd2041324
fernando@debian10x64:~$
fernando@debian10x64:~$ docker ps
CONTAINER ID   IMAGE                       COMMAND                  CREATED         STATUS         PORTS     NAMES
606d2a73060f   kodekloud/event-simulator   "/bin/sh -c 'python …"   2 seconds ago   Up 2 seconds             brave_babbage
fernando@debian10x64:~$
 
fernando@debian10x64:~$ docker logs -f brave_babbage
[2023-02-08 02:54:17,810] INFO in event-simulator: USER4 is viewing page2
[2023-02-08 02:54:18,815] INFO in event-simulator: USER3 is viewing page2
[2023-02-08 02:54:19,818] INFO in event-simulator: USER3 logged in
[2023-02-08 02:54:20,822] INFO in event-simulator: USER4 is viewing page1
[2023-02-08 02:54:21,825] INFO in event-simulator: USER3 is viewing page2
[2023-02-08 02:54:22,826] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:54:22,826] INFO in event-simulator: USER4 is viewing page2
[2023-02-08 02:54:23,831] INFO in event-simulator: USER1 is viewing page2
[2023-02-08 02:54:24,835] INFO in event-simulator: USER1 logged in
[2023-02-08 02:54:25,836] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-08 02:54:25,837] INFO in event-simulator: USER4 is viewing page3
[2023-02-08 02:54:26,840] INFO in event-simulator: USER4 is viewing page3
[2023-02-08 02:54:27,841] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:54:27,842] INFO in event-simulator: USER2 logged in
[2023-02-08 02:54:28,845] INFO in event-simulator: USER2 logged in
[2023-02-08 02:54:29,847] INFO in event-simulator: USER4 is viewing page2
[2023-02-08 02:54:30,857] INFO in event-simulator: USER4 is viewing page1
[2023-02-08 02:54:31,862] INFO in event-simulator: USER4 is viewing page1
[2023-02-08 02:54:32,872] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:54:32,872] INFO in event-simulator: USER3 logged in
[2023-02-08 02:54:33,890] WARNING in event-simulator: USER7 Order failed as the item is OUT OF STOCK.
[2023-02-08 02:54:33,890] INFO in event-simulator: USER1 is viewing page2
[2023-02-08 02:54:34,902] INFO in event-simulator: USER3 is viewing page1
[2023-02-08 02:54:35,908] INFO in event-simulator: USER1 is viewing page1
[2023-02-08 02:54:36,924] INFO in event-simulator: USER4 logged out
[2023-02-08 02:54:37,931] WARNING in event-simulator: USER5 Failed to Login as the account is locked due to MANY FAILED ATTEMPTS.
[2023-02-08 02:54:37,932] INFO in event-simulator: USER4 logged out
[2023-02-08 02:54:38,947] INFO in event-simulator: USER2 is viewing page3
[2023-02-08 02:54:39,951] INFO in event-simulator: USER2 logged in
[2023-02-08 02:54:40,954] INFO in event-simulator: USER3 logged out
^C
fernando@debian10x64:~$
~~~~







- Criar um manifesto para um Pod, com esta imagem Docker do exemplo:

#### Logs - Kubernetes
```
apiVersion: v1
kind: Pod
metadata:
  name: event-simulator-pod
spec:
  containers:
  - name: event-simulator
    image: kodekloud/event-simulator
```


- To view the logs
```bash
$ kubectl logs -f event-simulator-pod
```

- If there are multiple containers in a pod then you must specify the name of the container explicitly in the command.
```bash
$ kubectl logs -f <pod-name> <container-name>
$ kubectl logs -f even-simulator-pod event-simulator
```



```bash
$ kubectl logs -f <pod-name> <container-name>
$ kubectl logs -f even-simulator-pod event-simulator"	
```

Quando um Pod tem múltiplos Containers, é necessário especifica o Pod e o Container onde deseja visualizar os logs.










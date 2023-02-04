
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 83. Monitor Cluster Components"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
#  83. Monitor Cluster Components


# Monitor Cluster Components
  - Take me to [Video Tutuorials](https://kodekloud.com/topic/monitor-cluster-components/)
  
In this section, we will take a look at monitoring kubernetes cluster

#### How do you monitor resource consumption in kubernetes? or more importantly, what would you like to monitor?
  ![mon](../../images/mon.PNG)
 
## Heapster vs Metrics Server
- Heapster is now deprecated and a slimmed down version was formed known as the **`metrics server`**.

  ![hpms](../../images/hpms.PNG)
  
## Metrics Server

  ![ms1](../../images/ms1.PNG)

#### How are the metrics generated for the PODs on these nodes?

  ![ca](../../images/ca.PNG)
  
## Metrics Server - Getting Started

  ![msg](../../images/msg.PNG)
  
- Clone the metric server from github repo
  ```
  $ git clone https://github.com/kubernetes-incubator/metrics-server.git
  ```
- Deploy the metric server
  ```
  $ kubectl create -f metric-server/deploy/1.8+/
  ```
  
- View the cluster performance
  ```
  $ kubectl top node
  ```
- View performance metrics of pod
  ```
  $ kubectl top pod
  ```
  
  ![view](../../images/view.PNG)
  
  
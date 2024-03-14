
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "218. Solution - Deploy Network Solution"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
## 218. Solution - Deploy Network Solution

# Practice Test - Deploy Networking Solution

  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-deploy-network-solution/)

#### Solution

  1. <details>
      <summary>We have deployed an application called app in the default namespace. What is the state of the pod?</summary>

      ```bash
      kubectl get pods
      ```

      Note it is stuck at `ContainerCreating`. It will reamin this way.

      > NotRunning

     </details>

  2. <details>
      <summary>Inspect why the POD is not running.</summary>

      ```bash
      kubectl describe pod app
      ```

      The answer is in the `Events` section. It cannot allocate an IP address, therefore...

      > No network configured

     </details>

  3. <details>
      <summary>Deploy weave-net networking solution to the cluster.</summary>

      Apply the manifest found under the `/root/weave` directory.
     </details>















# ###################################################################################################################### 
# ###################################################################################################################### 
## 218. Solution - Deploy Network Solution


https://kubernetes.io/docs/concepts/cluster-administration/addons/

<https://kubernetes.io/docs/concepts/cluster-administration/addons/>



root@debian10x64:/home/fernando# kubectl describe cm kube-proxy -n kube-system | grep -i cidr
clusterCIDR: ""
  excludeCIDRs: null
root@debian10x64:/home/fernando#




https://www.techtarget.com/searchitoperations/tutorial/Step-by-step-guide-Get-started-with-Weave-for-Kubernetes


- No video de solução, trata sobre a questão do range de ip.

- Material que tem a variável IPALLOC_RANGE citada no video:
<https://www.pluralsight.com/cloud-guru/labs/aws/setting-up-kubernetes-networking-with-weave-net>


Install Weave Net in the Cluster

Do the following on the controller server:

Log in to the controller server in a new terminal window, and then do the following:

    Get the configuration from Weaveworks like this:

    wget https://github.com/weaveworks/weave/releases/download/v2.6.0/weave-daemonset-k8s-1.11.yaml

    Edit the configuration file with vim.

    vim weave-daemonset-k8s-1.11.yaml

    Add the following lines (press Escape and then enter i for insert mode):

    - name: IPALLOC_RANGE
      value: 10.200.0.0/16

    The edited code snippet should then look like this:

        spec:
          containers:
            - name: weave
              command:
                - /home/weave/launch.sh
              env:
                - name: IPALLOC_RANGE
                  value: 10.200.0.0/16
                - name: HOSTNAME

    Save the file by pressing Escape and then entering :wq! .

    Apply the configuration with:

    kubectl apply -f ./weave-daemonset-k8s-1.11.yaml

    Verify that everything is working:

kubectl get pods -n kube-system

This should return two weave-net pods and look something like this:

NAME              READY     STATUS    RESTARTS   AGE
weave-net-m69xq   2/2       Running   0          11s
weave-net-vmb2n   2/2       Running   0          11s

    Spin up some Pods to test the networking functionality by first creating an Nginx deployment with two replicas:

cat << EOF | kubectl apply --kubeconfig admin.kubeconfig -f -
   apiVersion: apps/v1
   kind: Deployment
   metadata:
     name: nginx
   spec:
     selector:
       matchLabels:
         run: nginx
     replicas: 2
     template:
       metadata:
         labels:
           run: nginx
       spec:
         containers:
         - name: my-nginx
           image: nginx
           ports:
           - containerPort: 80
EOF

    Next, create a service for that deployment so that we can test connectivity to services as well:

kubectl expose deployment/nginx

    Start up another Pod. We will use this Pod to test our networking. We will test whether we can connect to the other Pods and services from this Pod.

kubectl run busybox --image=radial/busyboxplus:curl --command -- sleep 3600

POD_NAME=$(kubectl get pods -l run=busybox -o jsonpath="{.items[0].metadata.name}")

    Get the IP addresses of our two nginx pods:

kubectl get ep nginx

There should be two IP addresses listed under `ENDPOINTS`. For example:

NAME      ENDPOINTS                       AGE
nginx     10.200.0.2:80,10.200.128.1:80   50m

    Make sure the busybox Pod can connect to the nginx Pods on both of those IP addresses:

kubectl exec $POD_NAME -- curl <first nginx pod IP address>

kubectl exec $POD_NAME -- curl <second nginx pod IP address>

Both commands should return some HTML with the title "Welcome to Nginx!" This means that we can successfully connect to other pods.

    Now let's verify that we can connect to services.

kubectl get svc

This should display the IP address for our Nginx service. For example, in this case, the IP is 10.32.0.54:

NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.32.0.1    <none>        443/TCP   1h
nginx        ClusterIP   10.32.0.54   <none>        80/TCP    53m

    Check that we can access the service from the busybox Pod:

kubectl exec $POD_NAME -- curl <nginx service IP address>

This should also return HTML with the title "Welcome to nginx!"

Getting this response means that we have successfully reached the Nginx service from inside a Pod and that our networking configuration is working!





# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

- No video foi necessário ajuste no manifesto do Weave, para ajustar o CIDR dos ips alocáveis.
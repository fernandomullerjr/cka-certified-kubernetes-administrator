


############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 73. Static Pods"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status





# ##############################################################################################################################################################
# 73. Static Pods

# Static Pods 
  - Take me to [Video Tutorial](https://kodekloud.com/topic/static-pods/)
  
In this section, we will take a look at Static Pods

#### How do you provide a pod definition file to the kubelet without a kube-apiserver?
- You can configure the kubelet to read the pod definition files from a directory on the server designated to store information about pods.

## Configure Static Pod
- The designated directory can be any directory on the host and the location of that directory is passed in to the kubelet as an option while running the service.
  - The option is named as **`--pod-manifest-path`**.

  
## Another way to configure static pod 
- Instead of specifying the option directly in the **`kubelet.service`** file, you could provide a path to another config file using the config option, and define the directory path as staticPodPath in the file.

 

## View the static pods
- To view the static pods
```
  $ docker ps
```
 

#### The kubelet can create both kinds of pods - the static pods and the ones from the api server at the same time.
 

## Static Pods - Use Case
 
  
## Static Pods vs DaemonSets

  

#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/







# ##############################################################################################################################################################
# 73. Static Pods

- Os Pods que são criados através do Kubelet, são lidos da pasta:
kubernetes static pods /etc/kubernetes/manifests

- É nececessário configurar o kubelet.service o "--pod-manifest-path", indicando o caminho da pasta "/etc/kubernetes/manifests", para que o Kubelet leia os manifestos.

- Também é possível usar o "--config", para indicar um arquivo que configuração em YAML, que vai ter o caminho dos manifestos para os Static Pods, exemplo:
    staticPodPath: <the directory>


- Exemplo de criação de um Pod estático:

fonte:
https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/
<https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/>

For example, this is how to start a simple web server as a static Pod:

1.    Choose a node where you want to run the static Pod. In this example, it's my-node1.

    ssh my-node1

2.    Choose a directory, say /etc/kubernetes/manifests and place a web server Pod definition there, for example /etc/kubernetes/manifests/static-web.yaml:

~~~~bash
# Run this command on the node where kubelet is running
mkdir -p /etc/kubernetes/manifests/
cat <<EOF >/etc/kubernetes/manifests/static-web.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-web
  labels:
    role: myrole
spec:
  containers:
    - name: web
      image: nginx
      ports:
        - name: web
          containerPort: 80
          protocol: TCP
EOF
~~~~

3.    Configure your kubelet on the node to use this directory by running it with --pod-manifest-path=/etc/kubernetes/manifests/ argument. On Fedora edit /etc/kubernetes/kubelet to include this line:
~~~~bash
    KUBELET_ARGS="--cluster-dns=10.254.0.10 --cluster-domain=kube.local --pod-manifest-path=/etc/kubernetes/manifests/"
~~~~

    or add the staticPodPath: <the directory> field in the kubelet configuration file.

4.    Restart the kubelet. On Fedora, you would run:

    # Run this command on the node where the kubelet is running
    systemctl restart kubelet




# ##############################################################################################################################################################
#
# IMPORTANTE / RESUMO

- O Kubelet consegue operar um node de forma autonoma, sem ter o etcd cluster, Scheduler, Kube-api-server, etc
- O Kubelet consegue apenas criar Pods.
- Os manifestos precisam ser editados/criados na pasta "/etc/kubernetes/manifests".
- Os "Static Pods" e os "DaemonSets" são ignorados pelo "Kube-Scheduler".
- Para visualizar os Pods, é necessário utilizar os comandos comuns do Docker, como "docker ps", neste exemplo onde estamos utilizando o Kubelet de forma autonoma, sem ter um Kube-API-Server.
- Os Pods criados via Kubelet, são mostrados no Kube-APIserver, pois o Kubelet cria um mirror no Kube-APIserver, apenas de leitura(read-only).
- Para editar estes Pods, somente via arquivo do manifesto.
- Um uso de caso para os Static Pods, é para efetuar o deploy dos recursos de um cluster por conta própria. Por exemplo, instalar o Kubelet em cada node Master, API-server,
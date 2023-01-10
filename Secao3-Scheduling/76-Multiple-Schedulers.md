
# ############################################################################################################################################################### ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 76. Multiple Schedulers"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ##############################################################################################################################################################
#  76. Multiple Schedulers



# Multiple Schedulers 
  - Take me to [Video Tutorial](https://kodekloud.com/topic/multiple-schedulers/)

In this section, we will take a look at multiple schedulers

## Custom Schedulers
- Your kubernetes cluster can schedule multiple schedulers at the same time.

  ![ms](../../images/ms.PNG)
  
## Deploy additional scheduler
- Download the binary
  ```
  $ wget https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler
  ```
  ![das](../../images/das.PNG)
  
## Deploy additional scheduler - kubeadm
   
  ![dask](../../images/dask.PNG)
  
  - To create a scheduler pod
    ```
    $ kubectl create -f my-custom-scheduler.yaml
    ```
  
## View Schedulers
- To list the scheduler pods
  ```
  $ kubectl get pods -n kube-system
  ```

## Use the Custom Scheduler
- Create a pod definition file and add new section called **`schedulerName`** and specify the name of the new scheduler
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: nginx
  spec:
    containers:
    - image: nginx
      name: nginx
    schedulerName: my-custom-scheduler
  ```
  ![cs](../../images/cs.png)
  
- To create a pod definition
  ```
  $ kubectl create -f pod-definition.yaml
  ```
- To list pods
  ```
  $ kubectl get pods
  ```

## View Events
- To view events
  ```
  $ kubectl get events
  ```
  ![cs1](../../images/cs1.PNG)
  
## View Scheduler Logs
- To view scheduler logs
  ```
  $ kubectl logs my-custom-scheduler -n kube-system
  ```
  ![cs2](../../images/cs2.PNG)
  
#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/
  









# ##############################################################################################################################################################
#  76. Multiple Schedulers

- Caso necessário, é possivel ter Scheduler personalizado.
- É possível ter vários Schedulers, conforme a necessidade.

- O Kubernetes tem um Scheduler padrão, chamado "default-scheduler".

<https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/>



01:38




# KubeSchedulerConfiguration
- O nome do Scheduler padrão "default-scheduler" é definido num KubeSchedulerConfiguration

- Exemplo:

~~~~yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: default-scheduler
~~~~




- Criando arquivos separados para o KubeSchedulerConfiguration de nossos outros Scheduler:

~~~~yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: my-scheduler
~~~~

~~~~yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: my-scheduler-2
~~~~






## Deploy additional scheduler
- Download the binary
  ```
  $ wget https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler
  ```






# PENDENTE
- Video continua em:
2:33
- Ver sobre a config do Scheduler.
- Analisar material adicional:
<https://acloudguru-content-attachment-production.s3-accelerate.amazonaws.com/1597959153627-06_06_Setting%20up%20the%20Kubernetes%20Scheduler.pdf>





# OBSERVAÇÃO
- Os arquivos YAML de config dos Scheduler ficam na pasta:
/etc/kubernetes/config





- Exemplo de criação do SystemD Service do kube-scheduler

Create the kube-scheduler systemd unit file:

~~~~bash
cat << EOF | sudo tee /etc/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes
[Service]
ExecStart=/usr/local/bin/kube-scheduler \\
--config=/etc/kubernetes/config/kube-scheduler.yaml \\
--v=2
Restart=on-failure
RestartSec=5
[Install]
WantedBy=multi-user.target
EOF
~~~~





my-custom-scheduler.yaml

~~~~bash
$ cat /etc/kubernetes/manifests/kube-scheduler.yaml
~~~~


~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: kube-scheduler
  namespace: kube-system
spec:
  containers:
  - command: 
    - kube-scheduler
    - --address=127.0.0.127
    - --kubeconfig=/etc/kubernetes/scheduler.--kubeconfig
    - --leader-elect=true
    image: k8s.gcr.io/kube-scheduler-amd64:v1:18.6
    name: kube-scheduler
~~~~





- Outro exemplo de Pod de kube-scheduler:

And kube-scheduler:

~~~~yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    scheduler.alpha.kubernetes.io/critical-pod: ""
  labels:
    component: kube-scheduler
    tier: control-plane
  name: kube-scheduler
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --master=http://127.0.0.1:8080
    image: gcr.io/google_containers/kube-scheduler-amd64:v1.9.6
    name: kube-scheduler
  hostNetwork: true
~~~~







- Ajustado, conforme video no minuto 3:10:

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling/76-pod-kube-scheduler.yaml

~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-custom-scheduler
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --master=http://127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf

    image: gcr.io/google_containers/kube-scheduler-amd64:v1.11.3
    name: kube-scheduler
~~~




- Config do Scheduler:

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling/76-my-scheduler-config.yaml

~~~~yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: my-scheduler
~~~~




- Ajustado novamente o manifesto para o Pod do Scheduler, adicionando o parametro --config, que aponta para a configuração personalizada para o Scheduler:
versão2

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling/76-pod-kube-scheduler_v2.yaml

~~~yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-custom-scheduler
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --master=http://127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    - --config=/etc/kubernetes/config/my-scheduler-config.yaml

    image: gcr.io/google_containers/kube-scheduler-amd64:v1.11.3
    name: kube-scheduler
~~~






- Config do Scheduler, ajustada, incluindo a configuração de Leader Election:

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling/76-my-scheduler-config_v2.yaml

~~~~yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
  - schedulerName: my-scheduler
leaderElection:
  leaderElect: true
  resourceNamespace: kube-system
  resourceName: lock-object-my-scheduler
~~~~




- A configuração de Leader define quem vai definer aonde o Pod vai ser provisionado.





- É possível criar o Config do Scheduler localmente e passar para o Pod como um Volume.
- Exemplo da documentação do Kubernetes:
<https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/>

~~~~yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: my-scheduler
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: my-scheduler-as-kube-scheduler
subjects:
- kind: ServiceAccount
  name: my-scheduler
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: system:kube-scheduler
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: my-scheduler-as-volume-scheduler
subjects:
- kind: ServiceAccount
  name: my-scheduler
  namespace: kube-system
roleRef:
  kind: ClusterRole
  name: system:volume-scheduler
  apiGroup: rbac.authorization.k8s.io
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-scheduler-config
  namespace: kube-system
data:
  my-scheduler-config.yaml: |
    apiVersion: kubescheduler.config.k8s.io/v1beta2
    kind: KubeSchedulerConfiguration
    profiles:
      - schedulerName: my-scheduler
    leaderElection:
      leaderElect: false    
---
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    component: scheduler
    tier: control-plane
  name: my-scheduler
  namespace: kube-system
spec:
  selector:
    matchLabels:
      component: scheduler
      tier: control-plane
  replicas: 1
  template:
    metadata:
      labels:
        component: scheduler
        tier: control-plane
        version: second
    spec:
      serviceAccountName: my-scheduler
      containers:
      - command:
        - /usr/local/bin/kube-scheduler
        - --config=/etc/kubernetes/my-scheduler/my-scheduler-config.yaml
        image: gcr.io/my-gcp-project/my-kube-scheduler:1.0
        livenessProbe:
          httpGet:
            path: /healthz
            port: 10259
            scheme: HTTPS
          initialDelaySeconds: 15
        name: kube-second-scheduler
        readinessProbe:
          httpGet:
            path: /healthz
            port: 10259
            scheme: HTTPS
        resources:
          requests:
            cpu: '0.1'
        securityContext:
          privileged: false
        volumeMounts:
          - name: config-volume
            mountPath: /etc/kubernetes/my-scheduler
      hostNetwork: false
      hostPID: false
      volumes:
        - name: config-volume
          configMap:
            name: my-scheduler-config
~~~~










- To create a scheduler pod

kubectl create -f my-custom-scheduler.yaml

kubectl create -f /home/fernando/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling/76-pod-kube-scheduler_v2.yaml



View Schedulers

    To list the scheduler pods

    $ kubectl get pods -n kube-system

Use the Custom Scheduler

    Create a pod definition file and add new section called schedulerName and specify the name of the new scheduler

    apiVersion: v1
    kind: Pod
    metadata:
      name: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
      schedulerName: my-custom-scheduler




# PENDENTE
- Necessário efetuar o deploy de um Pod que tenha o Scheduler. O Pod tem um arquivo de config, que no video do Udemy não mostra como ele busca a config, o certo seria fazer um mapeamento de um Volume, ao estilo da DOC do Kubernetes.
- Testar deploy do Pod usando um volume que aponte pro ConfigMap da config, seguir o DOC:
<https://kubernetes.io/docs/tasks/extend-kubernetes/configure-multiple-schedulers/>
- Continuar o video em 7:33, validando que a solução ficou igual ao video.

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "122. Practice Test - OS Upgrades."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 122. Practice Test - OS Upgrades

Let us explore the environment first. How many nodes do you see in the cluster?

Including the controlplane and worker nodes.





                All rights reserved                                                                                                                                                  

controlplane ~ ➜  kubectl get nodes -A
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   17m   v1.27.0
node01         Ready    <none>          16m   v1.27.0

controlplane ~ ➜  



- RESPOSTA
2







How many applications do you see hosted on the cluster?

Check the number of deployments in the default namespace.



controlplane ~ ➜  kubectl get deploy
NAME   READY   UP-TO-DATE   AVAILABLE   AGE
blue   3/3     3            3           23s

controlplane ~ ➜  






Which nodes are the applications hosted on?

controlplane ~ ➜  kubectl get deploy -A
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE
default       blue      3/3     3            3           44s
kube-system   coredns   2/2     2            2           18m

controlplane ~ ➜  kubectl get deploy -A -o wide
NAMESPACE     NAME      READY   UP-TO-DATE   AVAILABLE   AGE   CONTAINERS   IMAGES                                    SELECTOR
default       blue      3/3     3            3           48s   nginx        nginx:alpine                              app=blue
kube-system   coredns   2/2     2            2           18m   coredns      registry.k8s.io/coredns/coredns:v1.10.1   k8s-app=kube-dns

controlplane ~ ➜  



controlplane ~ ➜  

controlplane ~ ➜  kubectl describe pod -A | grep -i node
Node:             node01/192.2.247.11
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
  Normal  Scheduled  2m51s  default-scheduler  Successfully assigned default/blue-6b478c8dbf-29smj to node01
Node:             controlplane/192.2.247.8
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Node:             node01/192.2.247.11
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
  Normal  Scheduled  2m51s  default-scheduler  Successfully assigned default/blue-6b478c8dbf-l8nf2 to node01
Priority Class Name:  system-node-critical
Node:                 node01/192.2.247.11
                      tier=node
Node-Selectors:              <none>
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
  Normal  Scheduled  19m   default-scheduler  Successfully assigned kube-flannel/kube-flannel-ds-5s8cz to node01
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.247.8
                      tier=node
Node-Selectors:              <none>
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Node:                 controlplane/192.2.247.8
Node-Selectors:              kubernetes.io/os=linux
                             node-role.kubernetes.io/control-plane:NoSchedule
                             node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
  Warning  FailedScheduling        20m   default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/not-ready: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling..
Node:                 controlplane/192.2.247.8
Node-Selectors:              kubernetes.io/os=linux
                             node-role.kubernetes.io/control-plane:NoSchedule
                             node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
  Warning  FailedScheduling        20m   default-scheduler  0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/not-ready: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling..
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.247.8
Controlled By:  Node/controlplane
Node-Selectors:    <none>
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.247.8
Controlled By:  Node/controlplane
      --authorization-mode=Node,RBAC
      --enable-admission-plugins=NodeRestriction
Node-Selectors:    <none>
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.247.8
Controlled By:  Node/controlplane
      --allocate-node-cidrs=true
Node-Selectors:    <none>
Priority Class Name:  system-node-critical
Node:                 node01/192.2.247.11
      --hostname-override=$(NODE_NAME)
      NODE_NAME:   (v1:spec.nodeName)
Node-Selectors:              kubernetes.io/os=linux
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
  Normal  Scheduled  19m   default-scheduler  Successfully assigned kube-system/kube-proxy-2nz67 to node01
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.247.8
      --hostname-override=$(NODE_NAME)
      NODE_NAME:   (v1:spec.nodeName)
Node-Selectors:              kubernetes.io/os=linux
                             node.kubernetes.io/disk-pressure:NoSchedule op=Exists
                             node.kubernetes.io/memory-pressure:NoSchedule op=Exists
                             node.kubernetes.io/network-unavailable:NoSchedule op=Exists
                             node.kubernetes.io/not-ready:NoExecute op=Exists
                             node.kubernetes.io/pid-pressure:NoSchedule op=Exists
                             node.kubernetes.io/unreachable:NoExecute op=Exists
                             node.kubernetes.io/unschedulable:NoSchedule op=Exists
Priority Class Name:  system-node-critical
Node:                 controlplane/192.2.247.8
Controlled By:  Node/controlplane
Node-Selectors:    <none>

controlplane ~ ➜  


- RESPOSTA:
controlplane,node01















We need to take node01 out for maintenance. Empty the node of all applications and mark it unschedulable.

   Node node01 Unschedulable

    Pods evicted from node01




controlplane ~ ➜  kubectl get node -A
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   24m   v1.27.0
node01         Ready    <none>          23m   v1.27.0

controlplane ~ ➜  

controlplane ~ ➜  kubectl drain node01
node/node01 cordoned
error: unable to drain node "node01" due to error:cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-flannel/kube-flannel-ds-5s8cz, kube-system/kube-proxy-2nz67, continuing command...
There are pending nodes to be drained:
 node01
cannot delete DaemonSet-managed Pods (use --ignore-daemonsets to ignore): kube-flannel/kube-flannel-ds-5s8cz, kube-system/kube-proxy-2nz67

controlplane ~ ✖ 


controlplane ~ ✖ kubectl get node -A
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready                      control-plane   24m   v1.27.0
node01         Ready,SchedulingDisabled   <none>          24m   v1.27.0

controlplane ~ ➜  date
Thu 08 Jun 2023 09:45:20 PM EDT

controlplane ~ ➜  


controlplane ~ ✖ kubectl drain node01 --ignore-daemonsets
node/node01 already cordoned
Warning: ignoring DaemonSet-managed Pods: kube-flannel/kube-flannel-ds-5s8cz, kube-system/kube-proxy-2nz67
evicting pod default/blue-6b478c8dbf-l8nf2
evicting pod default/blue-6b478c8dbf-29smj
pod/blue-6b478c8dbf-l8nf2 evicted
pod/blue-6b478c8dbf-29smj evicted
node/node01 drained

controlplane ~ ➜  kubectl get node -A
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready                      control-plane   27m   v1.27.0
node01         Ready,SchedulingDisabled   <none>          26m   v1.27.0

controlplane ~ ➜  












What nodes are the apps on now?

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
default        blue-6b478c8dbf-dphtp                  1/1     Running   0          10m
default        blue-6b478c8dbf-m75lf                  1/1     Running   0          36s
default        blue-6b478c8dbf-tvh7b                  1/1     Running   0          35s
kube-flannel   kube-flannel-ds-5s8cz                  1/1     Running   0          27m
kube-flannel   kube-flannel-ds-bnzlj                  1/1     Running   0          27m
kube-system    coredns-5d78c9869d-5t6fc               1/1     Running   0          27m
kube-system    coredns-5d78c9869d-s28xp               1/1     Running   0          27m
kube-system    etcd-controlplane                      1/1     Running   0          27m
kube-system    kube-apiserver-controlplane            1/1     Running   0          27m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          27m
kube-system    kube-proxy-2nz67                       1/1     Running   0          27m
kube-system    kube-proxy-5wv49                       1/1     Running   0          27m
kube-system    kube-scheduler-controlplane            1/1     Running   0          27m

controlplane ~ ➜  kubectl describe pod -A | grep -i node:
Node:             controlplane/192.2.247.8
Node:             controlplane/192.2.247.8
Node:             controlplane/192.2.247.8
Node:                 node01/192.2.247.11
Node:                 controlplane/192.2.247.8
Node:                 controlplane/192.2.247.8
Node:                 controlplane/192.2.247.8
Node:                 controlplane/192.2.247.8
Node:                 controlplane/192.2.247.8
Node:                 controlplane/192.2.247.8
Node:                 node01/192.2.247.11
Node:                 controlplane/192.2.247.8
Node:                 controlplane/192.2.247.8

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE    IP             NODE           NOMINATED NODE   READINESS GATES
default        blue-6b478c8dbf-dphtp                  1/1     Running   0          16m    10.244.0.4     controlplane   <none>           <none>
default        blue-6b478c8dbf-m75lf                  1/1     Running   0          7m8s   10.244.0.5     controlplane   <none>           <none>
default        blue-6b478c8dbf-tvh7b                  1/1     Running   0          7m7s   10.244.0.6     controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-5s8cz                  1/1     Running   0          33m    192.2.247.11   node01         <none>           <none>
kube-flannel   kube-flannel-ds-bnzlj                  1/1     Running   0          34m    192.2.247.8    controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-5t6fc               1/1     Running   0          34m    10.244.0.3     controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-s28xp               1/1     Running   0          34m    10.244.0.2     controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          34m    192.2.247.8    controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          34m    192.2.247.8    controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          34m    192.2.247.8    controlplane   <none>           <none>
kube-system    kube-proxy-2nz67                       1/1     Running   0          33m    192.2.247.11   node01         <none>           <none>
kube-system    kube-proxy-5wv49                       1/1     Running   0          34m    192.2.247.8    controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          34m    192.2.247.8    controlplane   <none>           <none>

controlplane ~ ➜  





kubectl drain node01 --ignore-daemonsets --force



https://jamesdefabia.github.io/docs/user-guide/kubectl/kubectl_drain/

The given node will be marked unschedulable to prevent new pods from arriving. Then drain deletes all pods except mirror pods (which cannot be deleted through the API server). If there are DaemonSet-managed pods, drain will not proceed without –ignore-daemonsets, and regardless it will not delete any DaemonSet-managed pods, because those pods would be immediately replaced by the DaemonSet controller, which ignores unschedulable markings. If there are any pods that are neither mirror pods nor managed–by ReplicationController, DaemonSet or Job–, then drain will not delete any pods unless you use –force.

When you are ready to put the node back into service, use kubectl uncordon, which will make the node schedulable again.









Claro! Aqui está um exemplo de manifesto do Kubernetes para um DaemonSet com o campo nodeSelector configurado:

~~~~yaml

apiVersion: apps/v1
kind: DaemonSet
metadata:
  name: meu-daemonset
spec:
  selector:
    matchLabels:
      app: meu-app
  template:
    metadata:
      labels:
        app: meu-app
    spec:
      nodeSelector:
        chave: valor
      containers:
      - name: meu-container
        image: minha-imagem:tag
        # Especificar os comandos, portas, volumes, etc. conforme necessário
~~~~

No exemplo acima, substitua chave e valor no campo nodeSelector pelas etiquetas correspondentes que você deseja usar para selecionar os nós nos quais o DaemonSet será implantado. Isso garante que o DaemonSet seja executado apenas nos nós que têm a etiqueta especificada.

Certifique-se de personalizar outras partes do manifesto, como o nome, as imagens e as configurações de contêineres, para atender às suas necessidades específicas.

Espero que isso ajude!




controlplane ~ ➜  kubectl get nodes --show-labels
NAME           STATUS                     ROLES           AGE   VERSION   LABELS
controlplane   Ready                      control-plane   57m   v1.27.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=controlplane,kubernetes.io/os=linux,node-role.kubernetes.io/control-plane=,node.kubernetes.io/exclude-from-external-load-balancers=
node01         Ready,SchedulingDisabled   <none>          57m   v1.27.0   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=node01,kubernetes.io/os=linux



node01         Ready,SchedulingDisabled   <none>          57m   v1.27.0   
beta.kubernetes.io/arch=amd64,
beta.kubernetes.io/os=linux,
kubernetes.io/arch=amd64,
kubernetes.io/hostname=node01,
kubernetes.io/os=linux


- SOLUÇÃO

~~~~YAML

    spec:
      nodeSelector:
        kubernetes.io/hostname: controlplane
~~~~




controlplane ~ ➜  kubectl edit ds kube-flannel-ds -n kube-flannel
daemonset.apps/kube-flannel-ds edited

controlplane ~ ➜  kubectl get ds -A
NAMESPACE      NAME              DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR                         AGE
kube-flannel   kube-flannel-ds   1         1         0       1            0           kubernetes.io/hostname=controlplane   59m
kube-system    kube-proxy        2         2         2       2            2           kubernetes.io/os=linux                60m

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
default        blue-6b478c8dbf-dphtp                  1/1     Running   0          42m   10.244.0.4     controlplane   <none>           <none>
default        blue-6b478c8dbf-m75lf                  1/1     Running   0          33m   10.244.0.5     controlplane   <none>           <none>
default        blue-6b478c8dbf-tvh7b                  1/1     Running   0          33m   10.244.0.6     controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-vhnw6                  1/1     Running   0          21s   192.2.247.8    controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-5t6fc               1/1     Running   0          60m   10.244.0.3     controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-s28xp               1/1     Running   0          60m   10.244.0.2     controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          60m   192.2.247.8    controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          60m   192.2.247.8    controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          60m   192.2.247.8    controlplane   <none>           <none>
kube-system    kube-proxy-2nz67                       1/1     Running   0          60m   192.2.247.11   node01         <none>           <none>
kube-system    kube-proxy-5wv49                       1/1     Running   0          60m   192.2.247.8    controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          60m   192.2.247.8    controlplane   <none>           <none>

controlplane ~ ➜  date
Thu 08 Jun 2023 10:21:17 PM EDT

controlplane ~ ➜  





- SOLUÇÃO

~~~~YAML

    spec:
      nodeSelector:
        kubernetes.io/hostname: controlplane
~~~~


controlplane ~ ➜  kubectl edit ds kube-proxy -n kube-system
daemonset.apps/kube-proxy edited

controlplane ~ ➜  



controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
default        blue-6b478c8dbf-dphtp                  1/1     Running   0          44m     10.244.0.4    controlplane   <none>           <none>
default        blue-6b478c8dbf-m75lf                  1/1     Running   0          35m     10.244.0.5    controlplane   <none>           <none>
default        blue-6b478c8dbf-tvh7b                  1/1     Running   0          35m     10.244.0.6    controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-vhnw6                  1/1     Running   0          2m15s   192.2.247.8   controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-5t6fc               1/1     Running   0          62m     10.244.0.3    controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-s28xp               1/1     Running   0          62m     10.244.0.2    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          62m     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          62m     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          62m     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-proxy-wg4wz                       1/1     Running   0          18s     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          62m     192.2.247.8   controlplane   <none>           <none>

controlplane ~ ➜  date
Thu 08 Jun 2023 10:23:10 PM EDT

controlplane ~ ➜  


- RESPOSTA
controlplane








The maintenance tasks have been completed. Configure the node node01 to be schedulable again.

    Node01 is Schedulable


kubectl uncordon node01


controlplane ~ ➜  kubectl get node
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready                      control-plane   63m   v1.27.0
node01         Ready,SchedulingDisabled   <none>          62m   v1.27.0

controlplane ~ ➜  kubectl uncordon node01
node/node01 uncordoned

controlplane ~ ➜  kubectl get node
NAME           STATUS   ROLES           AGE   VERSION
controlplane   Ready    control-plane   63m   v1.27.0
node01         Ready    <none>          62m   v1.27.0

controlplane ~ ➜  







How many pods are scheduled on node01 now?


^[[A
controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE     IP            NODE           NOMINATED NODE   READINESS GATES
default        blue-6b478c8dbf-dphtp                  1/1     Running   0          46m     10.244.0.4    controlplane   <none>           <none>
default        blue-6b478c8dbf-m75lf                  1/1     Running   0          36m     10.244.0.5    controlplane   <none>           <none>
default        blue-6b478c8dbf-tvh7b                  1/1     Running   0          36m     10.244.0.6    controlplane   <none>           <none>
kube-flannel   kube-flannel-ds-vhnw6                  1/1     Running   0          3m58s   192.2.247.8   controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-5t6fc               1/1     Running   0          63m     10.244.0.3    controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-s28xp               1/1     Running   0          63m     10.244.0.2    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          63m     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          63m     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          63m     192.2.247.8   controlplane   <none>           <none>
kube-system    kube-proxy-wg4wz                       1/1     Running   0          2m1s    192.2.247.8   controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          63m     192.2.247.8   controlplane   <none>           <none>

controlplane ~ ➜  

- RESPOSTA
0





Why are there no pods on node01?





We need to carry out a maintenance activity on node01 again. Try draining the node again using the same command as before: kubectl drain node01 --ignore-daemonsets

Did that work?


controlplane ~ ➜  kubectl drain node01 --ignore-daemonsets
node/node01 cordoned
error: unable to drain node "node01" due to error:cannot delete Pods declare no controller (use --force to override): default/hr-app, continuing command...
There are pending nodes to be drained:
 node01
cannot delete Pods declare no controller (use --force to override): default/hr-app

controlplane ~ ✖ 





Why did the drain command fail on node01? It worked the first time!

-RESPOSTA
Pod não é parte de um ReplicaSet







What is the name of the POD hosted on node01 that is not part of a replicaset?

- RESPOSTA
hr-app






What would happen to hr-app if node01 is drained forcefully?

Try it and see for yourself.









Oops! We did not want to do that! hr-app is a critical application that should not be destroyed. We have now reverted back to the previous state and re-deployed hr-app as a deployment.










hr-app is a critical app and we do not want it to be removed and we do not want to schedule any more pods on node01.
Mark node01 as unschedulable so that no new pods are scheduled on this node.

Make sure that hr-app is not affected.

    Node01 Unschedulable

    hr-app still running on node01?


controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE   IP            NODE           NOMINATED NODE   READINESS GATES
default        blue-6b478c8dbf-dphtp                  1/1     Running   0          54m   10.244.0.4    controlplane   <none>           <none>
default        blue-6b478c8dbf-m75lf                  1/1     Running   0          44m   10.244.0.5    controlplane   <none>           <none>
default        blue-6b478c8dbf-tvh7b                  1/1     Running   0          44m   10.244.0.6    controlplane   <none>           <none>
default        hr-app-6d6df76fc-84pln                 1/1     Running   0          42s   10.244.1.5    node01         <none>           <none>
kube-flannel   kube-flannel-ds-vhnw6                  1/1     Running   0          11m   192.2.247.8   controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-5t6fc               1/1     Running   0          71m   10.244.0.3    controlplane   <none>           <none>
kube-system    coredns-5d78c9869d-s28xp               1/1     Running   0          71m   10.244.0.2    controlplane   <none>           <none>
kube-system    etcd-controlplane                      1/1     Running   0          71m   192.2.247.8   controlplane   <none>           <none>
kube-system    kube-apiserver-controlplane            1/1     Running   0          71m   192.2.247.8   controlplane   <none>           <none>
kube-system    kube-controller-manager-controlplane   1/1     Running   0          71m   192.2.247.8   controlplane   <none>           <none>
kube-system    kube-proxy-wg4wz                       1/1     Running   0          10m   192.2.247.8   controlplane   <none>           <none>
kube-system    kube-scheduler-controlplane            1/1     Running   0          71m   192.2.247.8   controlplane   <none>           <none>

controlplane ~ ➜  kubectl cordon node01
node/node01 cordoned

controlplane ~ ➜  kubectl get pods -A -o wide | grep hr
default        hr-app-6d6df76fc-84pln                 1/1     Running   0          57s   10.244.1.5    node01         <none>           <none>

controlplane ~ ➜  date
Thu 08 Jun 2023 10:33:08 PM EDT

controlplane ~ ➜  kubectl get node
NAME           STATUS                     ROLES           AGE   VERSION
controlplane   Ready                      control-plane   72m   v1.27.0
node01         Ready,SchedulingDisabled   <none>          71m   v1.27.0

controlplane ~ ➜  
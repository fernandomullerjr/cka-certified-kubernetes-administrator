
How many network policies do you see in the environment?

We have deployed few web applications, services and network policies. Inspect the environment.



controlplane ~ ➜  kubectl api-resources | grep netw
ingressclasses                                 networking.k8s.io/v1                   false        IngressClass
ingresses                         ing          networking.k8s.io/v1                   true         Ingress
networkpolicies                   netpol       networking.k8s.io/v1                   true         NetworkPolicy

controlplane ~ ➜  
controlplane ~ ➜  kubectl get netpol
NAME             POD-SELECTOR   AGE
payroll-policy   name=payroll   107s

controlplane ~ ➜  kubectl get netpol -A
NAMESPACE   NAME             POD-SELECTOR   AGE
default     payroll-policy   name=payroll   110s

controlplane ~ ➜  kubectl get netpol -A -o wide
NAMESPACE   NAME             POD-SELECTOR   AGE
default     payroll-policy   name=payroll   116s

controlplane ~ ➜  









What is the name of the Network Policy?

payroll-policy










Which pod is the Network Policy applied on?

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
default       external                               1/1     Running   0             2m42s
default       internal                               1/1     Running   0             2m42s
default       mysql                                  1/1     Running   0             2m42s
default       payroll                                1/1     Running   0             2m42s
kube-system   coredns-5d78c9869d-dgljz               1/1     Running   0             65m
kube-system   coredns-5d78c9869d-fxx92               1/1     Running   0             65m
kube-system   etcd-controlplane                      1/1     Running   0             65m
kube-system   kube-apiserver-controlplane            1/1     Running   0             65m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             65m
kube-system   kube-proxy-5g6zg                       1/1     Running   0             65m
kube-system   kube-scheduler-controlplane            1/1     Running   0             65m
kube-system   weave-net-62lp5                        2/2     Running   1 (65m ago)   65m

controlplane ~ ➜  kubectl get pods -A -o wide
NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE     IP             NODE           NOMINATED NODE   READINESS GATES
default       external                               1/1     Running   0             2m46s   10.244.0.5     controlplane   <none>           <none>
default       internal                               1/1     Running   0             2m46s   10.244.0.4     controlplane   <none>           <none>
default       mysql                                  1/1     Running   0             2m46s   10.244.0.6     controlplane   <none>           <none>
default       payroll                                1/1     Running   0             2m46s   10.244.0.7     controlplane   <none>           <none>
kube-system   coredns-5d78c9869d-dgljz               1/1     Running   0             65m     10.244.0.2     controlplane   <none>           <none>
kube-system   coredns-5d78c9869d-fxx92               1/1     Running   0             65m     10.244.0.3     controlplane   <none>           <none>
kube-system   etcd-controlplane                      1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-apiserver-controlplane            1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-controller-manager-controlplane   1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-proxy-5g6zg                       1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   kube-scheduler-controlplane            1/1     Running   0             65m     192.27.180.6   controlplane   <none>           <none>
kube-system   weave-net-62lp5                        2/2     Running   1 (65m ago)   65m     192.27.180.6   controlplane   <none>           <none>

controlplane ~ ➜  kubectl get pods -A -l name=payroll
NAMESPACE   NAME      READY   STATUS    RESTARTS   AGE
default     payroll   1/1     Running   0          3m4s

controlplane ~ ➜  


- RESPOSTA
Como a Network Policy é aplicada conforme o label do Pod.
No caso, o "POD-SELECTOR"  da Network Policy é o "name=payroll"
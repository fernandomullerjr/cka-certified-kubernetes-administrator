

# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# push

git status
git add .
git commit -m "Aula 52. Practice Test - Manual Scheduling"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# 52. Practice Test - Manual Scheduling




# A pod definition file nginx.yaml is given. Create a pod using the file.

Only create the POD for now. We will inspect its status next.

    Pod nginx Created


controlplane ~ ➜  ls
nginx.yaml  sample.yaml

controlplane ~ ➜  kubectl apply -f nginx.yaml 
pod/nginx created

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       nginx                                  0/1     Pending   0          5s
kube-system   coredns-6d4b75cb6d-58928               1/1     Running   0          15m
kube-system   coredns-6d4b75cb6d-f45kr               1/1     Running   0          15m
kube-system   etcd-controlplane                      1/1     Running   0          15m
kube-system   kube-apiserver-controlplane            1/1     Running   0          15m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          15m
kube-system   kube-flannel-ds-kvtd4                  1/1     Running   0          15m
kube-system   kube-flannel-ds-t88lv                  1/1     Running   0          15m
kube-system   kube-proxy-kx6fm                       1/1     Running   0          15m
kube-system   kube-proxy-t55r6                       1/1     Running   0          15m

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  










# Why is the POD in a pending state?

Inspect the environment for various kubernetes control plane components.


- Resposta:
No Scheduler present




controlplane ~ ➜  kubectl get nodes -o wide
NAME           STATUS   ROLES           AGE   VERSION   INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
controlplane   Ready    control-plane   17m   v1.24.0   10.64.2.3     <none>        Ubuntu 18.04.6 LTS   5.4.0-1092-gcp   containerd://1.6.6
node01         Ready    <none>          16m   v1.24.0   10.64.2.6     <none>        Ubuntu 18.04.6 LTS   5.4.0-1092-gcp   containerd://1.6.6

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl describe pod nginx
Name:         nginx
Namespace:    default
Priority:     0
Node:         <none>
Labels:       <none>
Annotations:  <none>
Status:       Pending
IP:           
IPs:          <none>
Containers:
  nginx:
    Image:        nginx
    Port:         <none>
    Host Port:    <none>
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-hhxjc (ro)
Volumes:
  kube-api-access-hhxjc:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:                      <none>

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods --namespace kube-system
NAME                                   READY   STATUS    RESTARTS   AGE
coredns-6d4b75cb6d-58928               1/1     Running   0          20m
coredns-6d4b75cb6d-f45kr               1/1     Running   0          20m
etcd-controlplane                      1/1     Running   0          20m
kube-apiserver-controlplane            1/1     Running   0          20m
kube-controller-manager-controlplane   1/1     Running   0          20m
kube-flannel-ds-kvtd4                  1/1     Running   0          20m
kube-flannel-ds-t88lv                  1/1     Running   0          19m
kube-proxy-kx6fm                       1/1     Running   0          20m
kube-proxy-t55r6                       1/1     Running   0          19m

controlplane ~ ➜  



- Motivo do Pod não ser "schedulado":
Não há 1 pod do kube-scheduler no namespace kube-system






# Manually schedule the pod on node01.

Delete and recreate the POD if necessary.

    Status: Running

    Pod: nginx



- Assim não foi:

```yaml
apiVersion: v1
Kind: Binding
metadata:
  name: nginx
target:
  apiVersion: v1
  kind: Node
  name: node01
```


vi pod-binding.yaml

curl - --header "Content-Type:application/json" --request POST --data '{"apiVersion":"v1", "kind": "Binding“ …. }' http://$SERVER/api/v1/namespaces/default/pods/$PODNAME/binding/


- Não funcionou:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
  labels: 
    app: nginx

spec:
  containers:
    - name: nginx
      image: nginx
      ports
        - containerPort: 8080
  nodeName: node01
```






# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
# ##############################################################################################################################################################
## SOLUÇÃO
<https://www.waytoeasylearn.com/learn/kubernetes-manual-scheduling/>
Jeito mais fácil é criar uma manifesto e especificar o campo nodeName

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
  nodeName: node01
```

controlplane ~ ✖ vi pod2.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f pod2.yaml
error: error parsing pod2.yaml: error converting YAML to JSON: yaml: line 13: could not find expected ':'

controlplane ~ ✖ vi pod2.yaml

controlplane ~ ➜  kubectl apply -f pod2.yaml
The Pod "nginx" is invalid: spec: Forbidden: pod updates may not change fields other than `spec.containers[*].image`, `spec.initContainers[*].image`, `spec.activeDeadlineSeconds`, `spec.tolerations` (only additions to existing tolerations) or `spec.terminationGracePeriodSeconds` (allow it to be set to 1 if it was previously negative)
  core.PodSpec{
        Volumes:        {{Name: "kube-api-access-hhxjc", VolumeSource: {Projected: &{Sources: {{ServiceAccountToken: &{ExpirationSeconds: 3607, Path: "token"}}, {ConfigMap: &{LocalObjectReference: {Name: "kube-root-ca.crt"}, Items: {{Key: "ca.crt", Path: "ca.crt"}}}}, {DownwardAPI: &{Items: {{Path: "namespace", FieldRef: &{APIVersion: "v1", FieldPath: "metadata.namespace"}}}}}}, DefaultMode: &420}}}},
        InitContainers: nil,
        Containers: []core.Container{
                {
                        ... // 3 identical fields
                        Args:       nil,
                        WorkingDir: "",
-                       Ports:      nil,
+                       Ports:      []core.ContainerPort{{ContainerPort: 80, Protocol: "TCP"}},
                        EnvFrom:    nil,
                        Env:        nil,
                        ... // 14 identical fields
                },
        },
        EphemeralContainers: nil,
        RestartPolicy:       "Always",
        ... // 4 identical fields
        ServiceAccountName:           "default",
        AutomountServiceAccountToken: nil,
-       NodeName:                     "",
+       NodeName:                     "node01",
        SecurityContext:              &{},
        ImagePullSecrets:             nil,
        ... // 17 identical fields
  }


controlplane ~ ✖ kubectl delete -f pod2.yaml
pod "nginx" deleted

controlplane ~ ➜  kubectl apply -f pod2.yaml
pod/nginx created

controlplane ~ ➜  





controlplane ~ ➜  kubectl get pods -A
NAMESPACE     NAME                                   READY   STATUS    RESTARTS   AGE
default       nginx                                  1/1     Running   0          20s
kube-system   coredns-6d4b75cb6d-58928               1/1     Running   0          30m
kube-system   coredns-6d4b75cb6d-f45kr               1/1     Running   0          30m
kube-system   etcd-controlplane                      1/1     Running   0          30m
kube-system   kube-apiserver-controlplane            1/1     Running   0          30m
kube-system   kube-controller-manager-controlplane   1/1     Running   0          30m
kube-system   kube-flannel-ds-kvtd4                  1/1     Running   0          30m
kube-system   kube-flannel-ds-t88lv                  1/1     Running   0          29m
kube-system   kube-proxy-kx6fm                       1/1     Running   0          30m
kube-system   kube-proxy-t55r6                       1/1     Running   0          29m

controlplane ~ ➜  



Observação:
poderia ter sido usado o replace, para não precisar fazer o delete e apply do Pod, por exemplo:
kubectl replace --force -f nginx.yaml
kubectl replace --force -f pod2.yaml



  # Force replace, delete and then re-create the resource
  kubectl replace --force -f ./pod.json









# Now schedule the same pod on the controlplane node.

Delete and recreate the POD if necessary.

    Status: Running

    Pod: nginx

    Node: controlplane?


```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 82
  nodeName: controlplane
```

/home/fernando/cursos/cka-certified-kubernetes-administrator/Secao3-Scheduling/52-pod-manual-scheduling2.yaml

vi pod3.yaml










# RESUMO
- Motivo do Pod não ser "schedulado":
    Não há 1 pod do kube-scheduler no namespace kube-system
-poderia ter sido usado o replace, para não precisar fazer o delete e apply do Pod, por exemplo:
    kubectl replace --force -f nginx.yaml
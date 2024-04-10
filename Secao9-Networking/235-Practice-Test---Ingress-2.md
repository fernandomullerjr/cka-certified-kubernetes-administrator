
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "235. Practice Test - Ingress - 2 ."
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  235. Practice Test - Ingress - 2



info

We have deployed two applications. Explore the setup.

Note: They are in a different namespace.

controlplane ~ ➜  kubectl get all -A
NAMESPACE      NAME                                       READY   STATUS    RESTARTS   AGE
app-space      pod/default-backend-79755fc44c-sx8hl       1/1     Running   0          3m22s
app-space      pod/webapp-video-74bf8df7f5-2sxv5          1/1     Running   0          3m23s
app-space      pod/webapp-wear-7b784f68d8-8skq7           1/1     Running   0          3m23s
kube-flannel   pod/kube-flannel-ds-zr8wx                  1/1     Running   0          10m
kube-system    pod/coredns-69f9c977-4c4hw                 1/1     Running   0          10m
kube-system    pod/coredns-69f9c977-7jpnq                 1/1     Running   0          10m
kube-system    pod/etcd-controlplane                      1/1     Running   0          10m
kube-system    pod/kube-apiserver-controlplane            1/1     Running   0          10m
kube-system    pod/kube-controller-manager-controlplane   1/1     Running   0          10m
kube-system    pod/kube-proxy-6pbs5                       1/1     Running   0          10m
kube-system    pod/kube-scheduler-controlplane            1/1     Running   0          10m

NAMESPACE     NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
app-space     service/default-http-backend   ClusterIP   10.108.61.186   <none>        80/TCP                   3m22s
app-space     service/video-service          ClusterIP   10.100.32.152   <none>        8080/TCP                 3m23s
app-space     service/wear-service           ClusterIP   10.110.180.68   <none>        8080/TCP                 3m23s
default       service/kubernetes             ClusterIP   10.96.0.1       <none>        443/TCP                  10m
kube-system   service/kube-dns               ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   10m

NAMESPACE      NAME                             DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
kube-flannel   daemonset.apps/kube-flannel-ds   1         1         1       1            1           <none>                   10m
kube-system    daemonset.apps/kube-proxy        1         1         1       1            1           kubernetes.io/os=linux   10m

NAMESPACE     NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
app-space     deployment.apps/default-backend   1/1     1            1           3m22s
app-space     deployment.apps/webapp-video      1/1     1            1           3m23s
app-space     deployment.apps/webapp-wear       1/1     1            1           3m23s
kube-system   deployment.apps/coredns           2/2     2            2           10m

NAMESPACE     NAME                                         DESIRED   CURRENT   READY   AGE
app-space     replicaset.apps/default-backend-79755fc44c   1         1         1       3m22s
app-space     replicaset.apps/webapp-video-74bf8df7f5      1         1         1       3m23s
app-space     replicaset.apps/webapp-wear-7b784f68d8       1         1         1       3m23s
kube-system   replicaset.apps/coredns-69f9c977             2         2         2       10m

controlplane ~ ➜  


controlplane ~ ➜  kubectl get all -n app-space
NAME                                   READY   STATUS    RESTARTS   AGE
pod/default-backend-79755fc44c-sx8hl   1/1     Running   0          3m59s
pod/webapp-video-74bf8df7f5-2sxv5      1/1     Running   0          4m
pod/webapp-wear-7b784f68d8-8skq7       1/1     Running   0          4m

NAME                           TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE
service/default-http-backend   ClusterIP   10.108.61.186   <none>        80/TCP     3m59s
service/video-service          ClusterIP   10.100.32.152   <none>        8080/TCP   4m
service/wear-service           ClusterIP   10.110.180.68   <none>        8080/TCP   4m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/default-backend   1/1     1            1           3m59s
deployment.apps/webapp-video      1/1     1            1           4m
deployment.apps/webapp-wear       1/1     1            1           4m

NAME                                         DESIRED   CURRENT   READY   AGE
replicaset.apps/default-backend-79755fc44c   1         1         1       3m59s
replicaset.apps/webapp-video-74bf8df7f5      1         1         1       4m
replicaset.apps/webapp-wear-7b784f68d8       1         1         1       4m

controlplane ~ ➜  

controlplane ~ ➜  kubectl get all -n default
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   11m

controlplane ~ ➜  kubectl get all -n kube-system
NAME                                       READY   STATUS    RESTARTS   AGE
pod/coredns-69f9c977-4c4hw                 1/1     Running   0          11m
pod/coredns-69f9c977-7jpnq                 1/1     Running   0          11m
pod/etcd-controlplane                      1/1     Running   0          11m
pod/kube-apiserver-controlplane            1/1     Running   0          11m
pod/kube-controller-manager-controlplane   1/1     Running   0          11m
pod/kube-proxy-6pbs5                       1/1     Running   0          11m
pod/kube-scheduler-controlplane            1/1     Running   0          11m

NAME               TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
service/kube-dns   ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   11m

NAME                        DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
daemonset.apps/kube-proxy   1         1         1       1            1           kubernetes.io/os=linux   11m

NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/coredns   2/2     2            2           11m

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/coredns-69f9c977   2         2         2       11m

controlplane ~ ➜  







Let us now deploy an Ingress Controller. First, create a namespace called ingress-nginx.

We will isolate all ingress related objects into its own namespace.

Name: ingress-nginx

kubectl create ns ingress-nginx
controlplane ~ ➜  kubectl create ns ingress-nginx
namespace/ingress-nginx created

controlplane ~ ➜  







The NGINX Ingress Controller requires a ConfigMap object. Create a ConfigMap object with name ingress-nginx-controller in the ingress-nginx namespace.


No data needs to be configured in the ConfigMap.

Name: ingress-nginx-controller



controlplane ~ ➜  kubectl create configmap -h
Create a config map based on a file, directory, or specified literal value.

 A single config map may package one or more key/value pairs.

 When creating a config map based on a file, the key will default to the basename of the file, and the value will
default to the file content.  If the basename is an invalid key, you may specify an alternate key.

 When creating a config map based on a directory, each file whose basename is a valid key in the directory will be
packaged into the config map.  Any directory entries except regular files are ignored (e.g. subdirectories, symlinks,
devices, pipes, etc).

Aliases:
configmap, cm

Examples:
  # Create a new config map named my-config based on folder bar
  kubectl create configmap my-config --from-file=path/to/bar
  
  # Create a new config map named my-config with specified keys instead of file basenames on disk
  kubectl create configmap my-config --from-file=key1=/path/to/bar/file1.txt --from-file=key2=/path/to/bar/file2.txt
  
  # Create a new config map named my-config with key1=config1 and key2=config2
  kubectl create configmap my-config --from-literal=key1=config1 --from-literal=key2=config2
  
  # Create a new config map named my-config from the key=value pairs in the file
  kubectl create configmap my-config --from-file=path/to/bar
  
  # Create a new config map named my-config from an env file
  kubectl create configmap my-config --from-env-file=path/to/foo.env --from-env-file=path/to/bar.env


kubectl create configmap ingress-nginx-controller -n ingress-nginx

controlplane ~ ➜  kubectl create configmap ingress-nginx-controller -n ingress-nginx
configmap/ingress-nginx-controller created

controlplane ~ ➜  










The NGINX Ingress Controller requires two ServiceAccounts. Create both ServiceAccount with name ingress-nginx and ingress-nginx-admission in the ingress-nginx namespace.

Use the spec provided below.

Name: ingress-nginx

Name: ingress-nginx-admission


controlplane ~ ➜  kubectl create sa -h
Create a service account with the specified name.

Aliases:
serviceaccount, sa

Examples:
  # Create a new service account named my-service-account
  kubectl create serviceaccount my-service-account

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --field-manager='kubectl-create':
        Name of the manager used to track field ownership.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
        be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
        is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --validate='strict':
        Must be one of: strict (or true), warn, ignore (or false).              "true" or "strict" will use a schema to validate
        the input and fail the request if invalid. It will perform server side validation if ServerSideFieldValidation
        is enabled on the api-server, but will fall back to less reliable client-side validation if not.                "warn" will
        warn about unknown or duplicate fields without blocking the request if server-side field validation is enabled
        on the API server, and behave as "ignore" otherwise.            "false" or "ignore" will not perform any schema
        validation, silently dropping any unknown or duplicate fields.

Usage:
  kubectl create serviceaccount NAME [--dry-run=server|client|none] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  


kubectl create sa ingress-nginx -n ingress-nginx
kubectl create sa ingress-nginx-admission -n ingress-nginx



controlplane ~ ➜  
kubectl create sa ingress-nginx -n ingress-nginx
kubectl create sa ingress-nginx-admission -n ingress-nginx
serviceaccount/ingress-nginx created
serviceaccount/ingress-nginx-admission created

controlplane ~ ➜  










We have created the Roles, RoleBindings, ClusterRoles, and ClusterRoleBindings for the ServiceAccount. Check it out!!








Let us now deploy the Ingress Controller. Create the Kubernetes objects using the given file.

The Deployment and it's service configuration is given at /root/ingress-controller.yaml. There are several issues with it. Try to fix them.

    Note: Do not edit the default image provided in the given file. The image validation check passes when other issues are resolved.

Deployed in the correct namespace.

Replicas: 1

Use the right image

Namespace: ingress-nginx

Service name: ingress-nginx-controller

NodePort: 30080


controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  ls /root
ingress-controller.yaml  sample.yaml

controlplane ~ ➜  cat /root/ingress-controller.yaml 
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
    app.kubernetes.io/version: 1.1.2
    helm.sh/chart: ingress-nginx-4.0.18
  name: ingress-nginx-controller
  namespace: ingress-
spec:
  minReadySeconds: 0
  revisionHistoryLimit: 10
  selector:
    matchLabels:
      app.kubernetes.io/component: controller
      app.kubernetes.io/instance: ingress-nginx
      app.kubernetes.io/name: ingress-nginx
  template:
    metadata:
      labels:
        app.kubernetes.io/component: controller
        app.kubernetes.io/instance: ingress-nginx
        app.kubernetes.io/name: ingress-nginx
    spec:
      containers:
      - args:
        - /nginx-ingress-controller
        - --publish-service=$(POD_NAMESPACE)/ingress-nginx-controller
        - --election-id=ingress-controller-leader
        - --watch-ingress-without-class=true
        - --default-backend-service=app-space/default-http-backend
        - --controller-class=k8s.io/ingress-nginx
        - --ingress-class=nginx
        - --configmap=$(POD_NAMESPACE)/ingress-nginx-controller
        - --validating-webhook=:8443
        - --validating-webhook-certificate=/usr/local/certificates/cert
        - --validating-webhook-key=/usr/local/certificates/key
        env:
        - name: POD_NAME
          valueFrom:
            fieldRef:
              fieldPath: metadata.name
        - name: POD_NAMESPACE
          valueFrom:
            fieldRef:
              fieldPath: metadata.namespace
        - name: LD_PRELOAD
          value: /usr/local/lib/libmimalloc.so
        image: registry.k8s.io/ingress-nginx/controller:v1.1.2@sha256:28b11ce69e57843de44e3db6413e98d09de0f6688e33d4bd384002a44f78405c
        imagePullPolicy: IfNotPresent
        lifecycle:
          preStop:
            exec:
              command:
              - /wait-shutdown
        livenessProbe:
          failureThreshold: 5
          httpGet:
            path: /healthz
            port: 10254
            scheme: HTTP
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        name: controller
        ports:
        - name: http
            containerPort: 80
          protocol: TCP
        - containerPort: 443
          name: https
          protocol: TCP
        - containerPort: 8443
          name: webhook
          protocol: TCP
        readinessProbe:
          failureThreshold: 3
          httpGet:
            path: /healthz
            port: 10254
            scheme: HTTP
          initialDelaySeconds: 10
          periodSeconds: 10
          successThreshold: 1
          timeoutSeconds: 1
        resources:
          requests:
            cpu: 100m
            memory: 90Mi
        securityContext:
          allowPrivilegeEscalation: true
          capabilities:
            add:
            - NET_BIND_SERVICE
            drop:
            - ALL
          runAsUser: 101
        volumeMounts:
        - mountPath: /usr/local/certificates/
          name: webhook-cert
          readOnly: true
      dnsPolicy: ClusterFirst
      nodeSelector:
        kubernetes.io/os: linux
      serviceAccountName: ingress-nginx
      terminationGracePeriodSeconds: 300
      volumes:
      - name: webhook-cert
        secret:
          secretName: ingress-nginx-admission

---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app.kubernetes.io/component: controller
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/managed-by: Helm
    app.kubernetes.io/name: ingress-nginx
    app.kubernetes.io/part-of: ingress-nginx
    app.kubernetes.io/version: 1.1.2
    helm.sh/chart: ingress-nginx-4.0.18
  name: ingress-controller
  namespace: ingress-nginx
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 80
    nodeport: 30080
  selector:
    app.kubernetes.io/component: controller
    app.kubernetes.io/instance: ingress-nginx
    app.kubernetes.io/name: ingress-nginx
  type: NodePort

controlplane ~ ➜  


https://kubernetes.github.io/ingress-nginx/deploy/
https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/cloud/deploy.yaml


controlplane ~ ➜  vi /root/ingress-editado.yaml

controlplane ~ ➜  kubectl validate /root/ingress-editado.yaml
error: unknown command "validate" for "kubectl"

controlplane ~ ✖ kubectl apply -f /root/ingress-editado.yaml
error: error parsing /root/ingress-editado.yaml: error converting YAML to JSON: yaml: line 74: mapping values are not allowed in this context

controlplane ~ ✖ vi /root/ingress-editado.yaml



controlplane ~ ➜  kubectl apply -f /root/ingress-editado.yaml
deployment.apps/ingress-nginx-controller created
Error from server (BadRequest): error when creating "/root/ingress-editado.yaml": Service in version "v1" cannot be handled as a Service: strict decoding error: unknown field "spec.ports[0].nodeport"

controlplane ~ ✖ 



controlplane ~ ✖ vi /root/ingress-editado.yaml

controlplane ~ ➜  kubectl apply -f /root/ingress-editado.yaml
deployment.apps/ingress-nginx-controller configured
Error from server (BadRequest): error when creating "/root/ingress-editado.yaml": Service in version "v1" cannot be handled as a Service: strict decoding error: unknown field "spec.ports[0].nodeport"

controlplane ~ ✖ 




controlplane ~ ✖ 

controlplane ~ ✖ vi /root/ingress-editado.yaml

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl apply -f /root/ingress-editado.yaml
deployment.apps/ingress-nginx-controller configured
service/ingress-nginx-controller created

controlplane ~ ➜  


















Create the ingress resource to make the applications available at /wear and /watch on the Ingress service.

Also, make use of rewrite-target annotation field: -

nginx.ingress.kubernetes.io/rewrite-target: /


Ingress resource comes under the namespace scoped, so don't forget to create the ingress in the app-space namespace.

Ingress Created

Path: /wear

Path: /watch

Configure correct backend service for /wear

Configure correct backend service for /watch

Configure correct backend port for /wear service

Configure correct backend port for /watch service




controlplane ~ ➜  kubectl get svc -A
NAMESPACE       NAME                                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                  AGE
app-space       default-http-backend                 ClusterIP   10.108.61.186   <none>        80/TCP                   43m
app-space       video-service                        ClusterIP   10.100.32.152   <none>        8080/TCP                 43m
app-space       wear-service                         ClusterIP   10.110.180.68   <none>        8080/TCP                 43m
default         kubernetes                           ClusterIP   10.96.0.1       <none>        443/TCP                  51m
ingress-nginx   ingress-nginx-controller             NodePort    10.97.208.159   <none>        80:30080/TCP             14m
ingress-nginx   ingress-nginx-controller-admission   ClusterIP   10.100.79.66    <none>        443/TCP                  33m
kube-system     kube-dns                             ClusterIP   10.96.0.10      <none>        53/UDP,53/TCP,9153/TCP   51m

controlplane ~ ➜  


EXEMPLO


```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
spec:
  rules:
  - http:
      paths:
      - path: /wear
        backend:
          serviceName: wear-service
          servicePort: 80
      - path: /watch
        backend:
          serviceName: watch-service
          servicePort: 80
```



  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"

    

EDITADO


```
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /wear
        backend:
          serviceName: wear-service
          servicePort: 8080
      - path: /watch
        backend:
          serviceName: video-service
          servicePort: 8080
```


controlplane ~ ➜  vi ingress-2.yaml

controlplane ~ ➜  kubectl apply -f ingress-2.yaml
error: resource mapping not found for name: "ingress-wear-watch" namespace: "app-space" from "ingress-2.yaml": no matches for kind "Ingress" in version "extensions/v1beta1"
ensure CRDs are installed first

controlplane ~ ✖ 



apiVersion: networking.k8s.io/v1

EDITADO


```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /wear
        backend:
          serviceName: wear-service
          servicePort: 8080
      - path: /watch
        backend:
          serviceName: video-service
          servicePort: 8080
```




controlplane ~ ✖ vi ingress-2.yaml

controlplane ~ ➜  kubectl apply -f ingress-2.yaml
Error from server (BadRequest): error when creating "ingress-2.yaml": Ingress in version "v1" cannot be handled as a Ingress: strict decoding error: unknown field "spec.rules[0].http.paths[0].backend.serviceName", unknown field "spec.rules[0].http.paths[0].backend.servicePort", unknown field "spec.rules[0].http.paths[1].backend.serviceName", unknown field "spec.rules[0].http.paths[1].backend.servicePort"

controlplane ~ ✖ 




EDITADO


```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - path: /wear
        backend:
          service: 
          name: wear-service
          port:
            number: 8080
      - path: /watch
        backend:
          service: video-service
          port:
            number: 8080
```


controlplane ~ ✖ vi ingress-2.yaml

controlplane ~ ➜  kubectl apply -f ingress-2.yaml
Error from server (BadRequest): error when creating "ingress-2.yaml": Ingress in version "v1" cannot be handled as a Ingress: json: cannot unmarshal string into Go struct field IngressBackend.spec.rules.http.paths.backend.service of type v1.IngressServiceBackend

controlplane ~ ✖ 




  # Create an ingress with the same host and multiple paths
  kubectl create ingress multipath --class=default \
  --rule="foo.com/=svc:port" \
  --rule="foo.com/admin/=svcadmin:portadmin"





  # Create an ingress with the same host and multiple paths
  kubectl create ingress multipath --class=default --dry-run=client -o yaml \
  --rule="foo.com/=svc:port" \
  --rule="foo.com/admin/=svcadmin:portadmin"



controlplane ~ ➜  
  kubectl create ingress multipath --class=default --dry-run=client -o yaml \
  --rule="foo.com/=svc:port" \
  --rule="foo.com/admin/=svcadmin:portadmin"
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  creationTimestamp: null
  name: multipath
spec:
  ingressClassName: default
  rules:
  - host: foo.com
    http:
      paths:
      - backend:
          service:
            name: svc
            port:
              name: port
        path: /
        pathType: Exact
      - backend:
          service:
            name: svcadmin
            port:
              name: portadmin
        path: /admin/
        pathType: Exact
status:
  loadBalancer: {}

controlplane ~ ➜  




EDITADO


```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              name: 8080
        path: /wear
      - backend:
          service:
            name: video-service
            port:
              name: 8080
        path: /watch
```



controlplane ~ ➜  vi ingress-3.yaml

controlplane ~ ➜  kubectl apply -f ingress-3.yaml
Error from server (BadRequest): error when creating "ingress-3.yaml": Ingress in version "v1" cannot be handled as a Ingress: json: cannot unmarshal number into Go struct field ServiceBackendPort.spec.rules.http.paths.backend.service.port.name of type string

controlplane ~ ✖ 



EDITADO


```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              name: 8080
        path: /wear
      - backend:
          service:
            name: video-service
            port:
              name: 8080
        path: /watch
```



  # Create an ingress with multiple hosts and the pathType as Prefix
  kubectl create ingress ingress1 --class=default --dry-run=client -o yaml \
  --rule="foo.com/path*=svc:8080" \
  --rule="bar.com/admin*=svc2:http"




controlplane ~ ➜  
  kubectl create ingress ingress1 --class=default --dry-run=client -o yaml \
  --rule="foo.com/path*=svc:8080" \
  --rule="bar.com/admin*=svc2:http"
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  creationTimestamp: null
  name: ingress1
spec:
  ingressClassName: default
  rules:
  - host: foo.com
    http:
      paths:
      - backend:
          service:
            name: svc
            port:
              number: 8080
        path: /path
        pathType: Prefix
  - host: bar.com
    http:
      paths:
      - backend:
          service:
            name: svc2
            port:
              name: http
        path: /admin
        pathType: Prefix
status:
  loadBalancer: {}

controlplane ~ ➜  



EDITADO


```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /watch
```



controlplane ~ ➜  vi ingress-3.yaml

controlplane ~ ➜  kubectl apply -f ingress-3.yaml
The Ingress "ingress-wear-watch" is invalid: 
* spec.rules[0].http.paths[0].pathType: Required value: pathType must be specified
* spec.rules[0].http.paths[1].pathType: Required value: pathType must be specified

controlplane ~ ✖ 



EDITADO


```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-wear-watch
  namespace: app-space
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
spec:
  rules:
  - http:
      paths:
      - backend:
          service:
            name: wear-service
            port:
              number: 8080
        path: /wear
        pathType: Prefix
      - backend:
          service:
            name: video-service
            port:
              number: 8080
        path: /watch
        pathType: Prefix
```




controlplane ~ ✖ vi ingress-3.yaml

controlplane ~ ➜  kubectl apply -f ingress-3.yaml
ingress.networking.k8s.io/ingress-wear-watch created

controlplane ~ ➜  












Access the application using the Ingress tab on top of your terminal.

Make sure you can access the right applications at /wear and /watch paths.




## PENDENTE
- Ver sobre manifesto ingress, estrutura e yaml base.

- Ver sobre manifesto ingress, estrutura e yaml base.
- Ver sobre manifesto ingress, estrutura e yaml base.
- Ver sobre manifesto ingress, estrutura e yaml base.
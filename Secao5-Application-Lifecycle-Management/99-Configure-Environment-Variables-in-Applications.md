

------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "Aula 99. Configure Environment Variables in Applications"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status




------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
#  99. Configure Environment Variables in Applications





# Configure Environment Variables In Applications
  - Take me to [Video Tutorial](https://kodekloud.com/topic/configure-environment-variables-in-applications/)
  
#### ENV variables in Docker
```
$ docker run -e APP_COLOR=pink simple-webapp-color
```

#### ENV variables in kubernetes 
- To set an environment variable set an **`env`** property in pod definition file.
  
  ```
  apiVersion: v1
  kind: Pod
  metadata:
    name: simple-webapp-color
  spec:
   containers:
   - name: simple-webapp-color
     image: simple-webapp-color
     ports:
     - containerPort: 8080
     env:
     - name: APP_COLOR
       value: pink
  ```
  ![env](../../images/env.PNG)
  
- There are other ways of setting the environment variables such as **`ConfigMaps`** and **`Secrets`**

  ![cms](../../images/cms.PNG)
  
#### K8s Reference Docs
- https://kubernetes.io/docs/tasks/inject-data-application/define-environment-variable-container/









------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
#  99. Configure Environment Variables in Applications



## ENV variables in Docker
```
$ docker run -e APP_COLOR=pink simple-webapp-color
```


------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
## ENV variables in kubernetes 

- Método simples, utilizando o env direto no código do manifesto.

- To set an environment variable set an **`env`** property in pod definition file.

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: simple-webapp-color
spec:
 containers:
 - name: simple-webapp-color
   image: simple-webapp-color
   ports:
   - containerPort: 8080
   env:
   - name: APP_COLOR
     value: pink
~~~~



- There are other ways of setting the environment variables such as **`ConfigMaps`** and **`Secrets`**






------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
## Variáveis no Kubernetes usando Secrets

### Define a container environment variable with data from a single Secret

Define an environment variable as a key-value pair in a Secret:
  kubectl create secret generic backend-user --from-literal=backend-username='backend-admin'

Assign the backend-username value defined in the Secret to the SECRET_USERNAME environment variable in the Pod specification.

~~~~YAML
apiVersion: v1
  kind: Pod
  metadata:
    name: env-single-secret
  spec:
    containers:
    - name: envars-test-container
      image: nginx
      env:
      - name: SECRET_USERNAME
        valueFrom:
          secretKeyRef:
            name: backend-user
            key: backend-username
~~~~


- Create the Pod:
  kubectl create -f https://k8s.io/examples/pods/inject/pod-single-secret-env-variable.yaml

- In your shell, display the content of SECRET_USERNAME container environment variable
  kubectl exec -i -t env-single-secret -- /bin/sh -c 'echo $SECRET_USERNAME'

- The output is
  backend-admin



### Define container environment variables with data from multiple Secrets

- As with the previous example, create the Secrets first.
  kubectl create secret generic backend-user --from-literal=backend-username='backend-admin'
  kubectl create secret generic db-user --from-literal=db-username='db-admin'

- Define the environment variables in the Pod specification.

~~~~YAML
apiVersion: v1
  kind: Pod
  metadata:
    name: envvars-multiple-secrets
  spec:
    containers:
    - name: envars-test-container
      image: nginx
      env:
      - name: BACKEND_USERNAME
        valueFrom:
          secretKeyRef:
            name: backend-user
            key: backend-username
      - name: DB_USERNAME
        valueFrom:
          secretKeyRef:
            name: db-user
            key: db-username
~~~~

- Create the Pod:
  kubectl create -f https://k8s.io/examples/pods/inject/pod-multiple-secret-env-variable.yaml

- In your shell, display the container environment variables
  kubectl exec -i -t envvars-multiple-secrets -- /bin/sh -c 'env | grep _USERNAME'

- The output is
  DB_USERNAME=db-admin
  BACKEND_USERNAME=backend-admin




### Configure all key-value pairs in a Secret as container environment variables

Note: This functionality is available in Kubernetes v1.6 and later.

- Create a Secret containing multiple key-value pairs
    kubectl create secret generic test-secret --from-literal=username='my-app' --from-literal=password='39528$vdg7Jb'

- Use envFrom to define all of the Secret's data as container environment variables. The key from the Secret becomes the environment variable name in the Pod.

~~~~YAML
apiVersion: v1
  kind: Pod
  metadata:
    name: envfrom-secret
  spec:
    containers:
    - name: envars-test-container
      image: nginx
      envFrom:
      - secretRef:
          name: test-secret
~~~~


- Create the Pod:
  kubectl create -f https://k8s.io/examples/pods/inject/pod-secret-envFrom.yaml

- In your shell, display username and password container environment variables
  kubectl exec -i -t envfrom-secret -- /bin/sh -c 'echo "username: $username\npassword: $password\n"'

- The output is
  username: my-app
  password: 39528$vdg7Jb










------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
#### Variáveis no Kubernetes usando ConfigMaps


- Exemplo de ConfigMap
Here's an example ConfigMap that has some keys with single values, and other keys where the value looks like a fragment of a configuration format.

~~~~YAML
apiVersion: v1
kind: ConfigMap
metadata:
  name: game-demo
data:
  # property-like keys; each key maps to a simple value
  player_initial_lives: "3"
  ui_properties_file_name: "user-interface.properties"

  # file-like keys
  game.properties: |
    enemy.types=aliens,monsters
    player.maximum-lives=5    
  user-interface.properties: |
    color.good=purple
    color.bad=yellow
    allow.textmode=true 
~~~~

- Here's an example Pod that uses values from game-demo to configure a Pod:

~~~~YAML
apiVersion: v1
kind: Pod
metadata:
  name: configmap-demo-pod
spec:
  containers:
    - name: demo
      image: alpine
      command: ["sleep", "3600"]
      env:
        # Define the environment variable
        - name: PLAYER_INITIAL_LIVES # Notice that the case is different here
                                     # from the key name in the ConfigMap.
          valueFrom:
            configMapKeyRef:
              name: game-demo           # The ConfigMap this value comes from.
              key: player_initial_lives # The key to fetch.
        - name: UI_PROPERTIES_FILE_NAME
          valueFrom:
            configMapKeyRef:
              name: game-demo
              key: ui_properties_file_name
      volumeMounts:
      - name: config
        mountPath: "/config"
        readOnly: true
  volumes:
  # You set volumes at the Pod level, then mount them into containers inside that Pod
  - name: config
    configMap:
      # Provide the name of the ConfigMap you want to mount.
      name: game-demo
      # An array of keys from the ConfigMap to create as files
      items:
      - key: "game.properties"
        path: "game.properties"
      - key: "user-interface.properties"
        path: "user-interface.properties"
~~~~

A ConfigMap doesn't differentiate between single line property values and multi-line file-like values. What matters is how Pods and other objects consume those values.

For this example, defining a volume and mounting it inside the demo container as /config creates two files, /config/game.properties and /config/user-interface.properties, even though there are four keys in the ConfigMap. This is because the Pod definition specifies an items array in the volumes section. If you omit the items array entirely, every key in the ConfigMap becomes a file with the same name as the key, and you get 4 files








# PENDENTE
- Criar material sobre uso de variáveis utilizando ConfigMaps
- aula 99, diferenças



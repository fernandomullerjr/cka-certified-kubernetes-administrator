#
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "270. Solution - Mock Exam -1."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# ###################################################################################################################### 
# ###################################################################################################################### 
##  270. Solution - Mock Exam -1

### RECOMENDAÇÃO - CONFIGURAR ATALHOS

<https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/>
kubectl Cheat Sheet

Esta página contém uma lista de comandos kubectl e flags frequentemente usados.

Kubectl Autocomplete

~~~~BASH
source <(kubectl completion bash) # configuração de autocomplete no bash do shell atual, o pacote bash-completion precisa ter sido instalado primeiro.
echo "source <(kubectl completion bash)" >> ~/.bashrc # para adicionar o autocomplete permanentemente no seu shell bash.
~~~~


Você também pode usar uma abreviação para o atalho para kubectl que também funciona com o auto completar:

~~~~BASH
alias k=kubectl
complete -o default -F __start_kubectl k
~~~~








### 1 / 12
Weight: 6

Deploy a pod named nginx-pod using the nginx:alpine image.

Once done, click on the Next Question button in the top right corner of this panel. You may navigate back and forth freely between all questions. Once done with all questions, click on End Exam. Your work will be validated at the end and score shown. Good Luck!

Name: nginx-pod

Image: nginx:alpine


- Ideia é fornecer resposta rápida, usando comando imperativo:
k run nginx-pod --image=nginx:alpine






### 2 / 12
Weight: 8

Deploy a messaging pod using the redis:alpine image with the labels set to tier=msg.

Pod Name: messaging

Image: redis:alpine

Labels: tier=msg




controlplane ~ ➜  k run --help
Create and run a particular image in a pod.

Examples:
  # Start a nginx pod
  kubectl run nginx --image=nginx
  
  # Start a hazelcast pod and let the container expose port 5701
  kubectl run hazelcast --image=hazelcast/hazelcast --port=5701
  
  # Start a hazelcast pod and set environment variables "DNS_DOMAIN=cluster" and "POD_NAMESPACE=default" in the
container
  kubectl run hazelcast --image=hazelcast/hazelcast --env="DNS_DOMAIN=cluster" --env="POD_NAMESPACE=default"
  
  # Start a hazelcast pod and set labels "app=hazelcast" and "env=prod" in the container
  kubectl run hazelcast --image=hazelcast/hazelcast --labels="app=hazelcast,env=prod"
  
  # Dry run; print the corresponding API objects without creating them
  kubectl run nginx --image=nginx --dry-run=client
  
  # Start a nginx pod, but overload the spec with a partial set of values parsed from JSON
  kubectl run nginx --image=nginx --overrides='{ "apiVersion": "v1", "spec": { ... } }'
  
  # Start a busybox pod and keep it in the foreground, don't restart it if it exits
  kubectl run -i -t busybox --image=busybox --restart=Never
  
  # Start the nginx pod using the default command, but use custom arguments (arg1 .. argN) for that command
  kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>
  
  # Start the nginx pod using a different command and custom arguments
  kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>

Options:
    --allow-missing-template-keys=true:
        If true, ignore any errors in templates when a field or map key is missing in the template. Only applies to
        golang and jsonpath output formats.

    --annotations=[]:
        Annotations to apply to the pod.

    --attach=false:
        If true, wait for the Pod to start running, and then attach to the Pod as if 'kubectl attach ...' were called.
        Default false, unless '-i/--stdin' is set, in which case the default is true. With '--restart=Never' the exit
        code of the container process is returned.

    --cascade='background':
        Must be "background", "orphan", or "foreground". Selects the deletion cascading strategy for the dependents
        (e.g. Pods created by a ReplicationController). Defaults to background.

    --command=false:
        If true and extra arguments are present, use them as the 'command' field in the container, rather than the
        'args' field which is the default.

    --dry-run='none':
        Must be "none", "server", or "client". If client strategy, only print the object that would be sent, without
        sending it. If server strategy, submit server-side request without persisting the resource.

    --env=[]:
        Environment variables to set in the container.

    --expose=false:
        If true, create a ClusterIP service associated with the pod.  Requires `--port`.

    --field-manager='kubectl-run':
        Name of the manager used to track field ownership.

    -f, --filename=[]:
        to use to replace the resource.

    --force=false:
        If true, immediately remove resources from API and bypass graceful deletion. Note that immediate deletion of
        some resources may result in inconsistency or data loss and requires confirmation.

    --grace-period=-1:
        Period of time in seconds given to the resource to terminate gracefully. Ignored if negative. Set to 1 for
        immediate shutdown. Can only be set to 0 when --force is true (force deletion).

    --image='':
        The image for the container to run.

    --image-pull-policy='':
        The image pull policy for the container.  If left empty, this value will not be specified by the client and
        defaulted by the server.

    -k, --kustomize='':
        Process a kustomization directory. This flag can't be used together with -f or -R.

    -l, --labels='':
        Comma separated labels to apply to the pod. Will override previous values.

    --leave-stdin-open=false:
        If the pod is started in interactive mode or with stdin, leave stdin open after the first attach completes. By
        default, stdin will be closed after the first attach completes.

    -o, --output='':
        Output format. One of: (json, yaml, name, go-template, go-template-file, template, templatefile, jsonpath,
        jsonpath-as-json, jsonpath-file).

    --override-type='merge':
        The method used to override the generated object: json, merge, or strategic.

    --overrides='':
        An inline JSON override for the generated object. If this is non-empty, it is used to override the generated
        object. Requires that the object supply a valid apiVersion field.

    --pod-running-timeout=1m0s:
        The length of time (like 5s, 2m, or 3h, higher than zero) to wait until at least one pod is running

    --port='':
        The port that this container exposes.

    --privileged=false:
        If true, run the container in privileged mode.

    -q, --quiet=false:
        If true, suppress prompt messages.

    -R, --recursive=false:
        Process the directory used in -f, --filename recursively. Useful when you want to manage related manifests
        organized within the same directory.

    --restart='Always':
        The restart policy for this Pod.  Legal values [Always, OnFailure, Never].

    --rm=false:
        If true, delete the pod after it exits.  Only valid when attaching to the container, e.g. with '--attach' or
        with '-i/--stdin'.

    --save-config=false:
        If true, the configuration of current object will be saved in its annotation. Otherwise, the annotation will
        be unchanged. This flag is useful when you want to perform kubectl apply on this object in the future.

    --show-managed-fields=false:
        If true, keep the managedFields when printing objects in JSON or YAML format.

    -i, --stdin=false:
        Keep stdin open on the container in the pod, even if nothing is attached.

    --template='':
        Template string or path to template file to use when -o=go-template, -o=go-template-file. The template format
        is golang templates [http://golang.org/pkg/text/template/#pkg-overview].

    --timeout=0s:
        The length of time to wait before giving up on a delete, zero means determine a timeout from the size of the
        object

    -t, --tty=false:
        Allocate a TTY for the container in the pod.

    --wait=false:
        If true, wait for resources to be gone before returning. This waits for finalizers.

Usage:
  kubectl run NAME --image=image [--env="key=value"] [--port=port] [--dry-run=server|client] [--overrides=inline-json]
[--command] -- [COMMAND] [args...] [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  






# ###################################################################################################################### 
# ###################################################################################################################### 
## RESUMO

### 1 / 12
- Ideia é fornecer resposta rápida, usando comando imperativo:
k run nginx-pod --image=nginx:alpine

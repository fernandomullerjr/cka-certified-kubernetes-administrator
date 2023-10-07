

# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# push

git status
git add .
git commit -m "156. Practice Test - KubeConfig."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status


# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# 156. Practice Test - KubeConfig


Where is the default kubeconfig file located in the current environment?

Find the current home directory by looking at the HOME environment variable.


controlplane ~ ✖ ls $HOME
CKA  my-kube-config  sample.yaml

controlplane ~ ➜  echo $HOME
/root

controlplane ~ ➜  kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED

controlplane ~ ➜  


controlplane ~ ➜  ps -ef | grep kubectl
root        4651       1  0 20:19 ?        00:00:00 /usr/bin/kubectl proxy --port=8888 --address=0.0.0.0 --accept-hosts=^.*$ --kubeconfig /root/.kube/config
root        8628    7412  0 20:26 pts/0    00:00:00 grep --color=auto kubectl

controlplane ~ ➜  
controlplane ~ ➜  ls -lhasp $HOME
total 60K
8.0K drwx------ 1 root root 4.0K Sep 26 20:24 ./
4.0K drwxr-xr-x 1 root root 4.0K Sep 26 20:19 ../
4.0K -rw-r--r-- 1 root root 1.3K Sep 26 20:19 .bash_profile
4.0K -rw-r--r-- 1 root root 3.2K Apr 17 04:10 .bashrc
4.0K drwxr-xr-x 1 root root 4.0K Sep 26 20:24 .cache/
4.0K drwxr-xr-x 2 root root 4.0K Sep 26 20:24 CKA/
4.0K drwxr-xr-x 1 root root 4.0K Apr 17 04:05 .config/
4.0K drwxr-xr-x 3 root root 4.0K Sep 26 20:24 .kube/
4.0K -rw-rw-rw- 1 root root 1.5K Sep 26 20:24 my-kube-config
4.0K -rw-r--r-- 1 root root  161 Dec  5  2019 .profile
   0 -rw-rw-rw- 1 root root    0 Sep 14 07:07 sample.yaml
4.0K drwx------ 2 root root 4.0K Sep 26 20:24 .ssh/
4.0K drwxr-xr-x 4 root root 4.0K Apr 17 04:08 .vim/
4.0K -rw-r--r-- 1 root root  132 Apr 17 04:08 .vimrc
4.0K -rw-r--r-- 1 root root  165 Apr 17 04:09 .wget-hsts

controlplane ~ ✖ ls -lhasp $HOME/.kube/
total 24K
4.0K drwxr-xr-x 3 root root 4.0K Sep 26 20:24 ./
8.0K drwx------ 1 root root 4.0K Sep 26 20:24 ../
4.0K drwxr-x--- 4 root root 4.0K Sep 26 20:24 cache/
8.0K -rw------- 1 root root 5.6K Sep 26 20:19 config

controlplane ~ ➜  


- RESPOSTA
/root/.kube/config
















How many clusters are defined in the default kubeconfig file?


controlplane ~ ➜  cat $HOME/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJek1Ea3lOekF3TVRreU5sb1hEVE16TURreU5EQXdNVGt5Tmxvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBS3NkCnd1TXNaVlUrOEFSZTFIQXcyVGI5aDFJdlRLWlpRMFlqdW1FMmxlQmxyVEpRR1RGcXVwU016a2ZRT1ZDUS9uNTcKMUwxQ1RUSUxIdWdGQS9iVFV2clZhbmJZb1ZTUkxkcVRMaDNKMmMvTTQ2QUdkOGxMdFJlcnFqQnVqQUxJeHorSAphMWJEdGRMcE5nY0ZNcVg0bStUQUg2djR1VDFNQ0ZsVDEvTk12L2gzc0V3RFZBd01qZzNqYVFzMHlrc2kvVEc3CkFSSUxKUnVaZURzQ3RjZWNhTzVQUGxSdm1QUGdGRXJsei9UMXhzcnJjRVJhUDhzbCtObVpzSmZTM2FkWGhhRmwKd0U4RTZENUt6M2Z2N2RQRVlzVE9CeEZnNzBLNDdWZnUvVkRoWTJFMnB3YnhnTTVhNTBYRVR2QmF6RitYWGZXQgpOM01VUXJJVlpnR0FuYkV3STVNQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZFVUNoeXZJV040SHVwS0pCSnBnbE5hYlNXQXlNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBRjdCeTQwZmc5eEhJTXJMN2xvegpVdjJnUk9CQ2RCdHRSSDZqQ2Rlcm5td0JQNUVzOXpTV292OXhhbU95YmdBWVRhZW1STUlzN21IU09YWWY0ejhECldlejZJZTc0Y01GeTBwNmhwVFVEL0RjOUdzdDVSVjFEbDBUNm05RllJVS9SeGxVd3hqNlovckFkcXFjQTh2dXMKdUk3OXo3a2R3cFloZWxNS2xiZjRQMG9CQ0JzWmhDTzF1VXRsQmNtLzZxK0ErT1ppUHJCeGZ4ZHBYYzhrMmtKSQoySWwwd2t2N1FYMUhqdXZQdlh0MkYrNlZ1ZURMa0dZK3lJSCtKb01HYnN6QWMyRENaM2FWNzVVR09oRkl6S25lCjUrSXhzeFBKajYrQjNVREtKRU5Hd0ZKbXVCbkdmaUFhNlF6U0pjU1RlRUtQYXV5aXBCUUFaMGJLb0lKSjhPZUUKL0g0PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJTlU0aEowZUorOEV3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpBNU1qY3dNREU1TWpaYUZ3MHlOREE1TWpZd01ERTVNamhhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQThVQWs5Sk1tMU1MV3hVV3cKMUFPeDBYS2t0Skh4UXljeEJoenllTVl5RVl3VU51bHE2b2x4OHJMa1JneWtvWkNGUkFLR3VEUnQyeXdpSHRTQgp3OXBlcERjTE5VYVU4SEZIclJwK0psUU9aOGY0UnNFenVrL1R4US91NWdKMUM3V0hsaXNMTU5lMXlQdXJrY3dLCnBlYndMTUE3cUd4dCtOL09SOUdZUlRDdy9KRmdJbmRMMU1iNmpjemlSTXFjMzJRQXhjZ2JLWGMrMVRzcWN0ajkKWHlKaVV5TE5jS0hieStuMEJ4MlMybUR2Z0FIWGJ1MWtNZlIvSHJlOVpwb3NCb0ptU2NNcGZwNk5YQzRXb0JFKwplcmczbUwyRmJuQUFiZGlBWGFMcTc5MzBtSmt4R0NLSVprRWNoQXlkRVFnRVJVYmMxSTJEUDZyRlZzNTN6U05HCjZwZkdjd0lEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JSRkFvY3J5RmplQjdxU2lRU2FZSlRXbTBsZwpNakFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBbGg4U0FTcHoyV1VlSFZ1OGhUUUoyVTFVeElQNXBvbHBDMVR3CjNVWFRtTHJDZXRtRzU1cTlqZHBOK1Mvam1OQjhMSlU2SVluQjJDUkVPWjFsSzRDMXl1TVRDenNSZE5vZGN5UG0KL1IyR0duU1c5b2pESERncGI4TnJraUU1S0Q5Z2F1b3Baa3ZIUGpqbnUzRU5DT3pxU0MxR3JHZ3MwM1Q4eHRwcgowSFZkbWV4WU1uVDVFOWVyNjZWZzV4NHZQKy9lTjQ5c296R2N0Y2xGYk9xYlQxaHNpQlROZW5lR2hMQzdPdUtqCmhLUWt4clBQRmJtVzhZcXhHZFhyNTZlOWZuM0RXdkh2cm1MZVNrREZyekJCV2pyYVlGbFpJdHpFcGpQRExkN3EKSFZvNTROWVlFNGk1QkdyS3RVM05JakZPTHNPTC9wNnkvR0J5aVJFNWtFeEhWSi9vMGc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBOFVBazlKTW0xTUxXeFVXdzFBT3gwWEtrdEpIeFF5Y3hCaHp5ZU1ZeUVZd1VOdWxxCjZvbHg4ckxrUmd5a29aQ0ZSQUtHdURSdDJ5d2lIdFNCdzlwZXBEY0xOVWFVOEhGSHJScCtKbFFPWjhmNFJzRXoKdWsvVHhRL3U1Z0oxQzdXSGxpc0xNTmUxeVB1cmtjd0twZWJ3TE1BN3FHeHQrTi9PUjlHWVJUQ3cvSkZnSW5kTAoxTWI2amN6aVJNcWMzMlFBeGNnYktYYysxVHNxY3RqOVh5SmlVeUxOY0tIYnkrbjBCeDJTMm1EdmdBSFhidTFrCk1mUi9IcmU5WnBvc0JvSm1TY01wZnA2TlhDNFdvQkUrZXJnM21MMkZibkFBYmRpQVhhTHE3OTMwbUpreEdDS0kKWmtFY2hBeWRFUWdFUlViYzFJMkRQNnJGVnM1M3pTTkc2cGZHY3dJREFRQUJBb0lCQVFEalZCaytxYWJPbDZaLwpqNUwzeFY5NnlMZXhPMUNIZ2RldE5mdTVtTEUzWGJMeXAzTEsvS2IyRm1JS0xBRzZDSSs3TFZJN0k1UmRFYkk1Ck1PL3lXTVFUbzVhWkppQlVqYm9Id000Y1dkcVZLcGFtUFluN3h4cjdOMjliSi9lWkIvNXluNjdVNEg3NG0wWHAKaGNhRzNCMTNYZEVaZk1zSDJBVHVJZStGUzBPTFNiRlpVdTBISk5FR25OZnBieWJFWXZyaGxUMDdmY1RPNGo1MwpTK050QUZvOGRtb0luUUJtUE9ITDZOTDhGMDh4S1pZcWdmcTQrVzdLNHYvc1VyakwwR1lMaVdwblpqbkpOQ2I5CmY0MzlhZUpYb0lWTTNKTDR6enZ0SzlvTjhSazVNVHozSncyamt4RVFja0tqZjNDWWxTMnBzeEZpL0VUV2ZyZFgKZi9HSTV5SFpBb0dCQVBhb0xFN0tJZlVsVXpoZ3hlcktoVjhKYVlsdjFuWFlacTIrUi9tWXF1SEE0RkJtY0pIMgpRc242OXJwY2htaU9UOWVENlUxK2s3dGlXekRxMXo0R3BrY091SkJRVUgreXhLT3lzNWxLcFMwQm05QmlZcDlRClkwbjJXMGRodk9BdXN0UHFIVVdmR3RkdHRiZVJMa3VORTJXSmdWZkUxRjNCN3pIeWViWEtLaG5kQW9HQkFQcGoKaThBeTladDFOZU5hYjVyaHJkS1VNaG9tMndYVXoxdVpDeWtXcldWUTVYTnNIcGFocXhnTmwzNWFwa2tUZGVzNQpSdEVDR1VjazRYU2xYdFIwQklZV1BxdE5Ib214NU1oUHpmOFNxdGJROEtXRVMyMjRQUXNTNnQ0a3B4WjhORDlTCnFGck9hTW5tYUtqREJzMXpYZzBCV092Ny9ETDIrOGNFRzJaWnpXU1BBb0dBQzA5SXdOQVo0SUMyb1NZbXpRNCsKTVU1Z0xYSVlWa3oyNEU2U1JFcVF3MHN4dmQ0RW1WeStVVDZWbzVQc2djek1zbWdWQVgybFRubEREeW9sZG0yZApvREozbWY1a3dvWXk2QUtnbzQyOXB5T2t2bGhVaDFPTFNlL20zWTRJdUFyTUhsVmt4RFY0YUpwYU03R1BldDFjCkgxSy93SU9BN1UrZ0pSMG1JWVRFaTIwQ2dZQlZWQ05HQnBmSXVMTDZuZEUyMlAzaHEzcy9pa3BOdkc1RjZ1dncKdnJlc3RWcmNjTllqdzBpSlUraHl1UFcrSlpHajdjc0NZMUsxK2cyVE1PQVdTc3RYM3JEUXMrRmFUM09HQ0J4TgpkdEVkaityU25Ua1BWU0FJYkJQNlRFZGMxRXNCNFd0YU5zbGpOTkFwNHZ5b2UwNXI1QytuakNJd1JCY2RoWHJJCjhJV2NaUUtCZ1FDQ01RR1BzN015SXFFN1R5Z0VRN0U5aytNZXBKVGFiNW5DdzhZTGhhL3M5UE5rQnlIdVVmaU0Ka2JUTUJ6NVgyZ3FTcWt6YzlDMThxQlBOMFJzRGNBa2xTb3ZsMUZ4blJxaFFMV1NqNTF5OUVYNVZrVnBraVB1awo1eU54N1NrSDFPNmtSeEdTYWg4UG5MUVI1QlZGcy9uNDk4T0VXcjVDNlV6dHE5V05aejF0YWc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=

controlplane ~ ➜  


controlplane ~ ➜  kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED

controlplane ~ ➜  








How many Users are defined in the default kubeconfig file?

1

How many contexts are defined in the default kubeconfig file?




What is the user configured in the current context?


What is the name of the cluster configured in the default kubeconfig file?









A new kubeconfig file named my-kube-config is created. It is placed in the /root directory. How many clusters are defined in that kubeconfig file?



controlplane ~ ➜  cat /root/
.bash_profile   .cache/         .config/        my-kube-config  sample.yaml     .vim/           .wget-hsts      
.bashrc         CKA/            .kube/          .profile        .ssh/           .vimrc          

controlplane ~ ➜  cat /root/my-kube-config 
apiVersion: v1
kind: Config

clusters:
- name: production
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: development
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: kubernetes-on-aws
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: test-cluster-1
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

contexts:
- name: test-user@development
  context:
    cluster: development
    user: test-user

- name: aws-user@kubernetes-on-aws
  context:
    cluster: kubernetes-on-aws
    user: aws-user

- name: test-user@production
  context:
    cluster: production
    user: test-user

- name: research
  context:
    cluster: test-cluster-1
    user: dev-user

users:
- name: test-user
  user:
    client-certificate: /etc/kubernetes/pki/users/test-user/test-user.crt
    client-key: /etc/kubernetes/pki/users/test-user/test-user.key
- name: dev-user
  user:
    client-certificate: /etc/kubernetes/pki/users/dev-user/developer-user.crt
    client-key: /etc/kubernetes/pki/users/dev-user/dev-user.key
- name: aws-user
  user:
    client-certificate: /etc/kubernetes/pki/users/aws-user/aws-user.crt
    client-key: /etc/kubernetes/pki/users/aws-user/aws-user.key

current-context: test-user@development
preferences: {}


controlplane ~ ➜  










How many contexts are configured in the my-kube-config file?




What user is configured in the research context?


What is the name of the client-certificate file configured for the aws-user?




What is the current context set to in the my-kube-config file?








I would like to use the dev-user to access test-cluster-1. Set the current context to the right one so I can do that.

Once the right context is identified, use the kubectl config use-context command.

    Current context set




kubectl config --kubeconfig=/root/my-kube-config set-context research
kubectl config use-context



controlplane ~ ✖ kubectl config --kubeconfig=/root/my-kube-config set-context research
Context "research" modified.

controlplane ~ ➜  


controlplane ~ ➜  kubectl config use-context
Set the current-context in a kubeconfig file.

Aliases:
use-context, use

Examples:
  # Use the context for the minikube cluster
  kubectl config use-context minikube

Usage:
  kubectl config use-context CONTEXT_NAME [options]

Use "kubectl options" for a list of global command-line options (applies to all commands).
error: Unexpected args: []

controlplane ~ ✖ 




kubectl config use-context research

controlplane ~ ✖ kubectl config use-context research
error: no context exists with the name: "research"



controlplane ~ ➜  kubectl config get-contexts 
CURRENT   NAME                          CLUSTER      AUTHINFO           NAMESPACE
*         kubernetes-admin@kubernetes   kubernetes   kubernetes-admin   

controlplane ~ ➜  


controlplane ~ ➜  kubectl config -h
Modify kubeconfig files using subcommands like "kubectl config set current-context my-context"

 The loading order follows these rules:

  1.  If the --kubeconfig flag is set, then only that file is loaded. The flag may only be set once and no merging takes
place.
  2.  If $KUBECONFIG environment variable is set, then it is used as a list of paths (normal path delimiting rules for
your system). These paths are merged. When a value is modified, it is modified in the file that defines the stanza. When
a value is created, it is created in the first file that exists. If no files in the chain exist, then it creates the
last file in the list.
  3.  Otherwise, ${HOME}/.kube/config is used and no merging takes place.

Available Commands:
  current-context   Display the current-context
  delete-cluster    Delete the specified cluster from the kubeconfig
  delete-context    Delete the specified context from the kubeconfig
  delete-user       Delete the specified user from the kubeconfig
  get-clusters      Display clusters defined in the kubeconfig
  get-contexts      Describe one or many contexts
  get-users         Display users defined in the kubeconfig
  rename-context    Rename a context from the kubeconfig file
  set               Set an individual value in a kubeconfig file
  set-cluster       Set a cluster entry in kubeconfig
  set-context       Set a context entry in kubeconfig
  set-credentials   Set a user entry in kubeconfig
  unset             Unset an individual value in a kubeconfig file
  use-context       Set the current-context in a kubeconfig file
  view              Display merged kubeconfig settings or a specified kubeconfig file

Usage:
  kubectl config SUBCOMMAND [options]

Use "kubectl <command> --help" for more information about a given command.
Use "kubectl options" for a list of global command-line options (applies to all commands).

controlplane ~ ➜  ps -ef | grep kubectl
root        4651       1  0 20:19 ?        00:00:00 /usr/bin/kubectl proxy --port=8888 --address=0.0.0.0 --accept-hosts=^.*$ --kubeconfig /root/.kube/config
root       12115    7412  0 20:40 pts/0    00:00:00 grep --color=auto kubectl

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  cp /root/my-kube-config /root/.kube/config 

controlplane ~ ➜  

controlplane ~ ➜  cat /root/.kube/config 
apiVersion: v1
kind: Config

clusters:
- name: production
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: development
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: kubernetes-on-aws
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: test-cluster-1
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

contexts:
- name: test-user@development
  context:
    cluster: development
    user: test-user

- name: aws-user@kubernetes-on-aws
  context:
    cluster: kubernetes-on-aws
    user: aws-user

- name: test-user@production
  context:
    cluster: production
    user: test-user

- name: research
  context:
    cluster: test-cluster-1
    user: dev-user

users:
- name: test-user
  user:
    client-certificate: /etc/kubernetes/pki/users/test-user/test-user.crt
    client-key: /etc/kubernetes/pki/users/test-user/test-user.key
- name: dev-user
  user:
    client-certificate: /etc/kubernetes/pki/users/dev-user/developer-user.crt
    client-key: /etc/kubernetes/pki/users/dev-user/dev-user.key
- name: aws-user
  user:
    client-certificate: /etc/kubernetes/pki/users/aws-user/aws-user.crt
    client-key: /etc/kubernetes/pki/users/aws-user/aws-user.key

current-context: test-user@development
preferences: {}


controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl config use-context research 
Switched to context "research".

controlplane ~ ➜  

controlplane ~ ➜  kubectl config current-context
research

controlplane ~ ➜  


- ERRO
questão consta como incompleta, resposta não é aceita, apesar do context ok.
verificando


controlplane ~ ✖ kubectl get pods
error: unable to read client-cert /etc/kubernetes/pki/users/dev-user/developer-user.crt for dev-user due to open /etc/kubernetes/pki/users/dev-user/developer-user.crt: no such file or directory

controlplane ~ ✖ 


controlplane ~ ✖ ls /etc/kubernetes/pki/users/dev-user/
dev-user.crt  dev-user.csr  dev-user.key

controlplane ~ ➜  
controlplane ~ ➜  vi /root/.kube/c
cache/  config  

controlplane ~ ➜  vi /root/.kube/config 

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  date
Tue 26 Sep 2023 08:47:07 PM EDT

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  kubectl get pods -A
NAMESPACE      NAME                                   READY   STATUS    RESTARTS   AGE
kube-flannel   kube-flannel-ds-v6xcb                  1/1     Running   0          27m
kube-system    coredns-5d78c9869d-4xl4l               1/1     Running   0          27m
kube-system    coredns-5d78c9869d-jk7ks               1/1     Running   0          27m
kube-system    etcd-controlplane                      1/1     Running   0          27m
kube-system    kube-apiserver-controlplane            1/1     Running   0          27m
kube-system    kube-controller-manager-controlplane   1/1     Running   0          27m
kube-system    kube-proxy-mx58r                       1/1     Running   0          27m
kube-system    kube-scheduler-controlplane            1/1     Running   0          27m

controlplane ~ ➜  date
Tue 26 Sep 2023 08:47:20 PM EDT

controlplane ~ ➜  


controlplane ~ ➜  kubectl config use-context research
Switched to context "research".

controlplane ~ ➜  

- ERRO
questão consta como incompleta, resposta não é aceita, apesar do context ok.
verificando







# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# #################################################################################################################################################
# Dia 06/10/2023

Where is the default kubeconfig file located in the current environment?

Find the current home directory by looking at the HOME environment variable.


/root/.kube/config











How many clusters are defined in the default kubeconfig file?


controlplane ~ ➜  cat /root/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUMvakNDQWVhZ0F3SUJBZ0lCQURBTkJna3Foa2lHOXcwQkFRc0ZBREFWTVJNd0VRWURWUVFERXdwcmRXSmwKY201bGRHVnpNQjRYRFRJek1UQXdOekF4TlRNek5Wb1hEVE16TVRBd05EQXhOVE16TlZvd0ZURVRNQkVHQTFVRQpBeE1LYTNWaVpYSnVaWFJsY3pDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRGdnRVBBRENDQVFvQ2dnRUJBTE5iCmVDT2V4UCtqbVJRUDhnYTI2WXJXQlRFZ1cwKzNwNW1xQXFCNzV1c1JwWExIQXRFTFVJc2liNmh0c0hQYzlQV28Kb2k2S3lwQkNBL3NpNG05QU54em9xeGhBOGNHQ0hvaWFxa25EajJ5cW5MUXRPVndHaEFpcjd5TnNRSDlXTjBXZApxcEV4LzJ5bTRtMk5NTklSczRmU2lsaUFzcnFjQ2orVENiU2lmRzhURVR0MmQwSkxyMjkwYXB2Yzc4d2ZXbDV3CmR0ZGZzdjFNUkJXd2RrQjFBSE5Sdi9NcG5BcURpQ2NvMnhESTNPckJOM2hGUG9kdG9WZnQxWHIySCtvMmx5bW0KNVBYd1hkbHJOYTUwQStnQkdkVmd4eElZZDNWN3Y5ZDhrNStnTVdDT01jdVExMjdiZUxvSHlGUzJOSk5hN2lHVgpEU1dyOVFEbWdwdEtobGxlK3JNQ0F3RUFBYU5aTUZjd0RnWURWUjBQQVFIL0JBUURBZ0trTUE4R0ExVWRFd0VCCi93UUZNQU1CQWY4d0hRWURWUjBPQkJZRUZPeDdzQU9IOWR6Uk5tREo3S1hySkxhbk5FNFRNQlVHQTFVZEVRUU8KTUF5Q0NtdDFZbVZ5Ym1WMFpYTXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBQWcxSjNFSlV6b1NCNzJHUzI3WQpaNVQvRFF2YnJTbG0xU0dSaUhhZXFSdHVHNkE3cWs0anJCZmxCejZZck14dU9rQkIrSjV3R0ltMWNtaGlNQ0d0CjllSG5XNVhNK3VIZ2Z5eUZqbjhsdkdCZlg2NHFGVFlQS1kySHR2Q2RMc1R5MDlwQTVqcmhHLzBNdURRWDljcTUKN01PZGFYWDlpVHVVWTFaOTdHQ1NQS2lSR0VRWVNreUhaTnV4VmovYTMwWWtkNzk5aTAram0rSG4vWC9kZ0ZRbwpEazQ0ZWdORVhGQW1zdzZ0cUZNREJkOExFbm9id1oxeHFRc3pyOSsyTUNGeThVeEdLSFVCM1dzMy9NTkNRUjY3CmsrSld3eXA0WVdKZ0VxOThkb201bWgrTXJRRlQrS0lSczh1NXRvSEtpYlBBak5LUklHcG93MHJOUE96SzRHRkoKZis4PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURJVENDQWdtZ0F3SUJBZ0lJT2tCMlAzTjR5S0V3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TXpFd01EY3dNVFV6TXpWYUZ3MHlOREV3TURZd01UVXpNemhhTURReApGekFWQmdOVkJBb1REbk41YzNSbGJUcHRZWE4wWlhKek1Sa3dGd1lEVlFRREV4QnJkV0psY201bGRHVnpMV0ZrCmJXbHVNSUlCSWpBTkJna3Foa2lHOXcwQkFRRUZBQU9DQVE4QU1JSUJDZ0tDQVFFQXMzS3dOSVQ5QUNBSnZ5ZUUKVU9FTTFnZkZ0REUzQjhvcHVSVHZYZ2NzcDZQTUs0VzdmY0JwcHdqMEtOcktVL2xRYUJ2a3JtcG1GOHdpNmo4egpXbjQ1Yk96OW5kcVAzTldMd1k0aUhocnNBV2ExRVFPWUl5MVdQNU9Vc2pjRzJiaGhYOUdJMHFQeW1TUCs0WXAwCmkweUkvSFgxd0xjeWxMeXZiSkFnZ2lIYnJ6R0FOWTY4MzM0ak1mMUVmYWJGQTJEUWtTaW9tcXMxOHFZdjdFY2kKbWNsdnk0YkZ1ZlFQVGtxcW5PS0hSZU5Cb1hVK1FmSnFMdFc5bDU2eDYxK1MxSGZoVDMvYVowMjZYdlY4NlVxZQpSS0RUV1FKeTJMdHAra3JZZUgyNnVwdGtMYjk2MnZLKzN3d1ZhZkRSMFI2MnNkV1ordWd2ZGdvVk1EK1A3MEV2CmtOcStRd0lEQVFBQm8xWXdWREFPQmdOVkhROEJBZjhFQkFNQ0JhQXdFd1lEVlIwbEJBd3dDZ1lJS3dZQkJRVUgKQXdJd0RBWURWUjBUQVFIL0JBSXdBREFmQmdOVkhTTUVHREFXZ0JUc2U3QURoL1hjMFRaZ3lleWw2eVMycHpSTwpFekFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBSW1qV1pqdDFMTk9DeEZ6L1RNaVBjM3RqQjRXQUhLSkhUV3NRCkluYUFEdmtlNThEN1BBVkUycy9CVHZQdW0zeGVUbmY4OWdwMkI5Z0l6V1dxTlhFVUhMSVBKU0xmdVlWQkRwVmsKRjY4dEdjWllaeUNUZmptaXFrL042RWtiRzdnQ2pjb21iK0d4RWpQYjUrTnVmVHlOYkx1THVsQnlZNk01R1dHbwpNTzJvZm1FdVhWN1hYZ3lsRndDOHljZ1ArbWNRbVNLM3NvZHNFWnpubFhrcCtXYVE2M25nSVRENDFST2pGcnRHCkpOTGRVQ09VZVpTOE5SSDZwN1NndmdzODd5N3ZFczVVQTF6Ti83MUUrdkJrRS94dXY0N0xmZHgwV3kyYURBaHUKMkNKUFpTbUdNZEJ0eVRRTENXRDJOZDk0TVQ2enhUQjFycU10OXRVd0RJZ0ZnRE9Fdnc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBczNLd05JVDlBQ0FKdnllRVVPRU0xZ2ZGdERFM0I4b3B1UlR2WGdjc3A2UE1LNFc3CmZjQnBwd2owS05yS1UvbFFhQnZrcm1wbUY4d2k2ajh6V240NWJPejluZHFQM05XTHdZNGlIaHJzQVdhMUVRT1kKSXkxV1A1T1VzamNHMmJoaFg5R0kwcVB5bVNQKzRZcDBpMHlJL0hYMXdMY3lsTHl2YkpBZ2dpSGJyekdBTlk2OAozMzRqTWYxRWZhYkZBMkRRa1Npb21xczE4cVl2N0VjaW1jbHZ5NGJGdWZRUFRrcXFuT0tIUmVOQm9YVStRZkpxCkx0VzlsNTZ4NjErUzFIZmhUMy9hWjAyNlh2Vjg2VXFlUktEVFdRSnkyTHRwK2tyWWVIMjZ1cHRrTGI5NjJ2SysKM3d3VmFmRFIwUjYyc2RXWit1Z3ZkZ29WTUQrUDcwRXZrTnErUXdJREFRQUJBb0lCQVFDTGlZWU5BTkIvRldxZQowc3FuM2FnT2tqS2hBSmdMSForK0JOSnhLbUVGNW0rdjlDaXNDei9jbkRESHlBSUd0RnBhNmoyemhwYm1zRjBDCkM2MFNGQTd4YllOMUNPeFBTMXFHWXRDUzJscGthSW9wdGNMS3I4bGVYSk1HMVpVbEhhUFNUMnYyWjNnUXJ4WFcKS2NTZ1FSNVFPaVdqK3BDQmFndDYvc1BZalIxM3AxZXVraFlibThwR3lUTGZWd0xkcU52NnZvZG1GVk90VmtWMgpNSmlHSGdlWVZUSGJGV0ZsZUJnSWtaUjYyd3VGRkVpUFBBNUF2OGFveXZyY3ZiUGkrYjBhcUFqcEJQbitPWEJjCjErVWFnSDE4UkRiUVRrcFJ0dWU2b0hzalV1cnE3dUVydG5aT25oK0o1N1B0U1VSUkNsaWRQZzh2WkordHk4Z0MKQll2a2NWWFpBb0dCQU45VkNLZ25wRXNiVVVJYjZQTjY2VWE2WjBPR1NtTnlHMW5oclVuVFVpSHUzR3FxM1gwcQpYSG9wTzlPTGlMeXk3R3FLODVla0hXVkN0aHVZcU0wS2hhWmFiRDZ1Yk9CSVd6V0E3Z3RlaUdpblhZN0lUamJYCksyZFBkYXZRV3M5WkxtbHVuNktIK3JCM0h0MktIZWwrUG5RQ3lHWUMzWFJyWXRNSUNxdlFwUUJsQW9HQkFNMnkKV3JtanVQWVBndGdHd2VHbEdodnV6aCtnbVdDaDI2eXBNM1hVYnZkM2hQU0dIMlVIMFJYOWE5VCsvY29lZm8wRQphSisxNkJOb055a2p6QkJaTjRTeHpwQXJBR29IZVpGOHIya29MNWhVQWk1U3ZaZUdtZDhPUEQrQXVYSEFtWGQ4CmtvUStwdDNFY1VPQjIxMGh3UHcvSExjbStEVThKRW15UmViamZsV0hBb0dBVHFMK1hWYzMva29zSG43OVUxNGYKN1l1TStMVzhVNi9GK2F3QS9GR3dSY3A1U2dYSDMxNmZHVlNUZ0RWTmZFUDBBci9TYmI2WHF5UUdRMGxKaG9rQgo3a1ZBZ0FHaXpJWXR0M1VpWEZaNDZZQ2s3TFdTOUxSbTBBV21oVXpqN01hV0ZRR2lxL1A5VFUxa1ROVnBHdUljCjAzUjNZNVAycmh0eHZLVEVQU05HTmhFQ2dZRUFuWWN2citmUXFMQ3NWZUNtN3JYUVR3QU4zMjdReDQ1dGU4ZUEKMzRZM0RWSDlBbjhNNEFTaWZhSzh5RHdZQkloaUJvRVAxdkFxc1dJb2pGc2IxcEZjMFVTU214b3prUC8wZkJUdgpDU3Q3ZDc4dWhHZGRSd1FRSnlEeHh2aEFEUHVoREQ3Y3ZtWjB5SFcvQUNJYzZ6QUVhYW16eGhnVUVrRGkwWVd6CnZ1VU9SVlVDZ1lBVmhNTWtlL0YyRUhycHdxMHY1MFFYK2lUaFF1eEZYV1duTzdQeVlQWkp0RXVRZFlEUU8vbUYKeUJDeW16UFRHemVNYTZ5djJOMmtHVk9WaGZMU3FxcENIaXVrZUN1dE1oanEzSDhwVndwbjMzdk1qTExUVnlLUwp6Tm9JNGFhR1plR3NTVWx2WmxQVTdudkNGSkVta3MyVmVIc3VWai9rSzRvZnhWNjE1Mm9DSmc9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=

controlplane ~ ➜  



1









How many Users are defined in the default kubeconfig file?

1





How many contexts are defined in the default kubeconfig file?

1









What is the user configured in the current context?

kubernetes-admin






What is the name of the cluster configured in the default kubeconfig file?

kubernetes









A new kubeconfig file named my-kube-config is created. It is placed in the /root directory. How many clusters are defined in that kubeconfig file?


controlplane ~ ➜  

controlplane ~ ➜  ls
CKA  my-kube-config  sample.yaml

controlplane ~ ➜  cat my-kube-config 
apiVersion: v1
kind: Config

clusters:
- name: production
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: development
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: kubernetes-on-aws
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

- name: test-cluster-1
  cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443

contexts:
- name: test-user@development
  context:
    cluster: development
    user: test-user

- name: aws-user@kubernetes-on-aws
  context:
    cluster: kubernetes-on-aws
    user: aws-user

- name: test-user@production
  context:
    cluster: production
    user: test-user

- name: research
  context:
    cluster: test-cluster-1
    user: dev-user

users:
- name: test-user
  user:
    client-certificate: /etc/kubernetes/pki/users/test-user/test-user.crt
    client-key: /etc/kubernetes/pki/users/test-user/test-user.key
- name: dev-user
  user:
    client-certificate: /etc/kubernetes/pki/users/dev-user/developer-user.crt
    client-key: /etc/kubernetes/pki/users/dev-user/dev-user.key
- name: aws-user
  user:
    client-certificate: /etc/kubernetes/pki/users/aws-user/aws-user.crt
    client-key: /etc/kubernetes/pki/users/aws-user/aws-user.key

current-context: test-user@development
preferences: {}


controlplane ~ ➜  


4











How many contexts are configured in the my-kube-config file?

4







What user is configured in the research context?

dev-user






What is the name of the client-certificate file configured for the aws-user?

aws-user.crt






What is the current context set to in the my-kube-config file?

test-user@development









I would like to use the dev-user to access test-cluster-1. Set the current context to the right one so I can do that.

Once the right context is identified, use the kubectl config use-context command.

    Current context set



controlplane ~ ➜  kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: DATA+OMITTED
    client-key-data: DATA+OMITTED

controlplane ~ ➜  cp my-kube-config /root/.kube/config

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl config use-context research
Switched to context "research".

controlplane ~ ➜  


- ERRO
Apresentou questão incompleta


- FÓRUM

https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/learn/lecture/14298928#questions/11383472
<https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/learn/lecture/14298928#questions/11383472>

KodeKloud
0 votos a favor
3 anos atrás

Q12: kubectl config --kubeconfig=/root/my-kube-config use-context research

Q13: cp /root/my-kube-config ~/.kube/config 


- Ao usar o comando abaixo, acusou como completa:
kubectl config --kubeconfig=/root/my-kube-config use-context research


- Gerada pergunta
https://www.udemy.com/course/certified-kubernetes-administrator-with-practice-tests/learn/lecture/14298928#questions/20637478













We don't want to have to specify the kubeconfig file option on each command. Make the my-kube-config file the default kubeconfig.



controlplane ~ ➜  cat /root/.kube/config
apiVersion: v1
clusters:
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443
  name: development
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443
  name: kubernetes-on-aws
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443
  name: production
- cluster:
    certificate-authority: /etc/kubernetes/pki/ca.crt
    server: https://controlplane:6443
  name: test-cluster-1
contexts:
- context:
    cluster: kubernetes-on-aws
    user: aws-user
  name: aws-user@kubernetes-on-aws
- context:
    cluster: test-cluster-1
    user: dev-user
  name: research
- context:
    cluster: development
    user: test-user
  name: test-user@development
- context:
    cluster: production
    user: test-user
  name: test-user@production
current-context: research
kind: Config
preferences: {}
users:
- name: aws-user
  user:
    client-certificate: /etc/kubernetes/pki/users/aws-user/aws-user.crt
    client-key: /etc/kubernetes/pki/users/aws-user/aws-user.key
- name: dev-user
  user:
    client-certificate: /etc/kubernetes/pki/users/dev-user/developer-user.crt
    client-key: /etc/kubernetes/pki/users/dev-user/dev-user.key
- name: test-user
  user:
    client-certificate: /etc/kubernetes/pki/users/test-user/test-user.crt
    client-key: /etc/kubernetes/pki/users/test-user/test-user.key

controlplane ~ ➜  











With the current-context set to research, we are trying to access the cluster. However something seems to be wrong. Identify and fix the issue.

Try running the kubectl get pods command and look for the error. All users certificates are stored at /etc/kubernetes/pki/users.

    Issue fixed


controlplane ~ ➜  kubectl get pods
error: unable to read client-cert /etc/kubernetes/pki/users/dev-user/developer-user.crt for dev-user due to open /etc/kubernetes/pki/users/dev-user/developer-user.crt: no such file or directory

controlplane ~ ✖ 
controlplane ~ ✖ ls /etc/kubernetes/pki/users/
aws-user  dev-user  test-user

controlplane ~ ➜  ls /etc/kubernetes/pki/users/dev-user/
dev-user.crt  dev-user.csr  dev-user.key

controlplane ~ ➜  
controlplane ~ ➜  vi /root/.kube/config

controlplane ~ ➜  

controlplane ~ ➜  

controlplane ~ ➜  kubectl get pods
No resources found in default namespace.

controlplane ~ ➜  



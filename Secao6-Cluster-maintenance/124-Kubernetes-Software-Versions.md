
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "124. Kubernetes Software Versions."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 124. Kubernetes Software Versions

- Verificando a versão do Kubernetes:

~~~~bash
fernando@debian10x64:~$ kubectl get node
NAME       STATUS   ROLES                  AGE    VERSION
minikube   Ready    control-plane,master   160d   v1.22.2
fernando@debian10x64:~$


~~~~










https://kubernetes.io/blog/2020/08/21/moving-forward-from-beta/

Usually, alpha features aren't enabled by default. You turn them on by setting a feature gate; usually, by setting a command line flag on each of the components that use the feature.

(If you use Kubernetes through a managed service offering such as AKS, EKS, GKE, etc then the vendor who runs that service may have decided what feature gates are enabled for you).

There's a defined process for graduating an existing, alpha feature into the beta phase. This is important because beta features are enabled by default, with the feature flag still there so cluster operators can opt out if they want.

A similar but more thorough set of graduation criteria govern the transition to general availability (GA), also known as "stable". GA features are part of Kubernetes, with a commitment that they are staying in place throughout the current major version.







# RESUMO

- Alpha
features não vem ativadas por padrão

- Beta
features vem ativadas por padrão, com a feature flag disponível, caso o operador deseja remover elas

- GA(General Availability)
conhecida como stable
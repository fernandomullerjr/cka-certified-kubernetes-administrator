
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# push

git status
git add .
git commit -m "127. Demo - Cluster upgrade."
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------
# 127. Demo - Cluster upgrade

- Acessar o Kubernetes Playground
iniciar um lab do Kubernetes 1.24


- Material
<https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/>


## RESUMO

1. Determine which version to upgrade to
2. Upgrading control plane nodes
    Call "kubeadm upgrade" 
    Drain the node
    Upgrade kubelet and kubectl 
    Uncordon the node
    Do the same For the other control plane nodes.
3. Upgrade worker nodes  
    Upgrade kubeadm
    Call "kubeadm upgrade"
    Drain the node
    Upgrade kubelet and kubectl
    Uncordon the node
4. Verify the status of the cluster
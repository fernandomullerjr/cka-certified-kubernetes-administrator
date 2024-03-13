
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "216. Solution - Explore CNI (optional)"
eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github
git push
git status



# ###################################################################################################################### 
# ###################################################################################################################### 
##  216. Solution - Explore CNI (optional)

# Practice Test - CNI weave

  - Take me to [Practice Test](https://kodekloud.com/topic/practice-test-cni-weave/)

#### Solution

  1. <details>
      <summary>Inspect the kubelet service and identify the container runtime value is set for Kubernetes.</summary>

      Check kubelet unit file

      ```bash
      systemctl cat kubelet
      ```

      Note from the output this line

      ```
      EnvironmentFile=-/var/lib/kubelet/kubeadm-flags.env
      ```

      Inspect this file

      ```bash
      cat /var/lib/kubelet/kubeadm-flags.env
      ```

      Answer can be found as value of `--container-runtime`

      > REMOTE

      </details>

  2. <details>
      <summary>What is the path configured with all binaries of CNI supported plugins?</summary>

      This is the standard location for the installation of CNI plugins

      | `/opt/cni/bin`

     </details>

  3. <details>
      <summary>Identify which of the below plugins is not available in the list of available CNI plugins on this host?</summary>

      ```bash
      ls -l /opt/cni/bin
      ```

      Find the option from the given answers not in the output opf the above

      > cisco

     </details>

  4. <details>
      <summary>What is the CNI plugin configured to be used on this kubernetes cluster?</summary>

      From the available options, we need to recognise which of the four is not the name of a container networking provider. Of the three that are, only one of them is present in `/opt/cni/bin`

      > flannel

      Note that `bridge` is a mechanism for connecting networks together, and not a network _provider_.
     </details>

  5. <details>
      <summary>What binary executable file will be run by kubelet after a container and its associated namespace are created.</summary>

      Following on from Q4...

      > flannel

      All the files in `/opt/cni/bin` are binary executables with tasks related to configuring network namespaces. After the network namespace is configured using the other programs, `flannel` implements the network.

      [This is a great article](https://tonylixu.medium.com/k8s-network-cni-introduction-b035d42ad68f) on what the programs in `/opt/cni/bin` are for.
     </details>






# ###################################################################################################################### 
# ###################################################################################################################### 
##  RESUMO

- Inspect the kubelet service and identify the container runtime endpoint value is set for Kubernetes.

~~~~BASH
controlplane ~ ➜  ps -ef | grep kubelet | grep runtime
root        4281       1  0 23:21 ?        00:00:08 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime-endpoint=unix:///var/run/containerd/containerd.sock --pod-infra-container-image=registry.k8s.io/pause:3.9

controlplane ~ ➜  
~~~~

--container-runtime-endpoint=unix:///var/run/containerd/containerd.sock



- What is the path configured with all binaries of CNI supported plugins?
/opt/cni/bin/


- What is the CNI plugin configured to be used on this kubernetes cluster?

~~~~BASH
controlplane ~ ➜  ls /etc/cni/net.d/
10-flannel.conflist
~~~~




- What binary executable file will be run by kubelet after a container and its associated namespace are created?

~~~~bash

root@debian10x64:/etc/cni# ls -lhasp net.d/
total 20K
4.0K drwx------ 2 root root 4.0K Feb 25 13:17 ./
4.0K drwxr-xr-x 3 root root 4.0K Sep  3  2023 ../
4.0K -rw-r--r-- 1 root root  191 Sep  3  2023 05-cilium.conflist
4.0K -rw-r--r-- 1 root root  438 Jan 10  2023 100-crio-bridge.conf
4.0K -rw-r--r-- 1 root root   54 Jan 10  2023 200-loopback.conf
root@debian10x64:/etc/cni# date
Wed 13 Mar 2024 07:23:25 PM -03
root@debian10x64:/etc/cni#
root@debian10x64:/etc/cni#
root@debian10x64:/etc/cni# cd net.d/
root@debian10x64:/etc/cni/net.d# cat 05-cilium.conflist

{
  "cniVersion": "0.3.1",
  "name": "cilium",
  "plugins": [
    {
       "type": "cilium-cni",
       "enable-debug": false,
       "log-file": "/var/run/cilium/cilium-cni.log"
    }
  ]
}root@debian10x64:/etc/cni/net.d#
root@debian10x64:/etc/cni/net.d# pwd
/etc/cni/net.d
root@debian10x64:/etc/cni/net.d#

~~~~
ssh cluster1-controlplane

ETCDCTL_API=3 etcdctl snapshot save \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  --cert /etc/kubernetes/pki/etcd/server.crt \
  --key /etc/kubernetes/pki/etcd/server.key \
  cluster1.db

# Return to student node
exit

scp cluster1-controlplane:~/cluster1.db /opt/
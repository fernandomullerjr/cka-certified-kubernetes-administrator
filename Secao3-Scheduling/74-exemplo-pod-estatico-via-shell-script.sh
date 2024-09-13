# Create multiple YAML objects from stdin.
cat <<EOF >/etc/kubernetes/manifests/static-busybox.yaml
apiVersion: v1
kind: Pod
metadata:
  name: static-busybox
spec:
  containers:
    - name: busybox
      image: busybox
      args:
      - sleep
      - "1000"
EOF
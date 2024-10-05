
# ###################################################################################################################### 
# ###################################################################################################################### 
#  push

git status
git add .
git commit -m "JSON PATH IN KUBERNETES - Use cases."
git push
git status


eval $(ssh-agent -s)
ssh-add /home/fernando/.ssh/chave-debian10-github


# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## JSON PATH IN KUBERNETES

Objectives
• JSON PATH in KubeCtl
• Why JSON PATH?
• View and interpret KubeCtl output in JSON Format
• How to use JSON PATH with KubeCtl
• JSON PATH Examples
• Loops – Range
• Custom Columns
• Sort
• Practice Tests and Exercises




Why JSON PATH?
• Large Data sets
• 100s of Nodes
• 1000s of PODs, Deployments, ReplicaSets



kubectl get nodes -o wide




KubeCtl - JSON PATH
NAME CPU
master 4
node01 4
NAME TAINTS
master node-role.kubernetes.io/master
node01
NAME ARCHITECTURE
master amd64
node01 amd64
NAME IMAGE
red nginx
blue ubuntu
yellow redis



How to JSON PATH in KubeCtl?
1
2
3
Identify the kubectl command
kubectl get nodes 
kubectl get pods 

Familiarize with JSON output
kubectl get nodes -o json
kubectl get pods -o json


{
"apiVersion": "v1",
"kind": "List",
"items": [
{
"apiVersion": "v1",
"kind": "Pod",
"metadata": {
"name": "nginx-5557945897-gznjp",
},
"spec": {
"containers": [
{
"image": "nginx:alpine",
"name": "nginx"
}
],
"nodeName": "node01"
}
}
]
}


Form the JSON PATH query
.items[0].spec.containers[0].image

.items[0].spec.containers[0].image.items[0].spec.containers[0].image


4 Use the JSON PATH query with kubectl command
kubectl get pods –o=jsonpath=kubectl get pods –o=jsonpath=.items[0].spec.containers[0].image
‘{



- Exemplo dos meus Pods:
kubectl get pods -o json

~~~~json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Pod",
            "metadata": {
                "annotations": {
                    "kubectl.kubernetes.io/last-applied-configuration": "{\"apiVersion\":\"v1\",\"kind\":\"Pod\",\"metadata\":{\"annotations\":{},\"name\":\"broken-pod\",\"namespace\":\"default\"},\"spec\":{\"containers\":[{\"image\":\"nginx:latest\",\"livenessProbe\":{\"httpGet\":{\"path\":\"/\",\"port\":81},\"initialDelaySeconds\":3,\"periodSeconds\":3},\"name\":\"broken-pod\"}]}}\n"
                },
                "creationTimestamp": "2024-09-28T19:10:28Z",
                "name": "broken-pod",
                "namespace": "default",
                "resourceVersion": "102730",
                "uid": "8c40592c-60c4-415a-91f5-f2a83c5af63d"
            },
            "spec": {
                "containers": [
                    {
                        "image": "nginx:latest",
                        "imagePullPolicy": "IfNotPresent",
                        "livenessProbe": {
                            "failureThreshold": 3,
                            "httpGet": {
                                "path": "/",
                                "port": 81,
                                "scheme": "HTTP"
                            },
                            "initialDelaySeconds": 3,
                            "periodSeconds": 3,
                            "successThreshold": 1,
                            "timeoutSeconds": 1
                        },
                        "name": "broken-pod",
                        "resources": {},
                        "terminationMessagePath": "/dev/termination-log",
                        "terminationMessagePolicy": "File",
                        "volumeMounts": [
                            {
                                "mountPath": "/var/run/secrets/kubernetes.io/serviceaccount",
                                "name": "kube-api-access-8q9zf",
                                "readOnly": true
                            }
                        ]
                    }
                ],
                "dnsPolicy": "ClusterFirst",
                "enableServiceLinks": true,
                "nodeName": "wsl2",
                "preemptionPolicy": "PreemptLowerPriority",
                "priority": 0,
                "restartPolicy": "Always",
                "schedulerName": "default-scheduler",
                "securityContext": {},
                "serviceAccount": "default",
                "serviceAccountName": "default",
                "terminationGracePeriodSeconds": 30,
                "tolerations": [
                    {
                        "effect": "NoExecute",
                        "key": "node.kubernetes.io/not-ready",
                        "operator": "Exists",
                        "tolerationSeconds": 300
                    },
                    {
                        "effect": "NoExecute",
                        "key": "node.kubernetes.io/unreachable",
                        "operator": "Exists",
                        "tolerationSeconds": 300
                    }
                ],
                "volumes": [
                    {
                        "name": "kube-api-access-8q9zf",
                        "projected": {
                            "defaultMode": 420,
                            "sources": [
                                {
                                    "serviceAccountToken": {
                                        "expirationSeconds": 3607,
                                        "path": "token"
                                    }
                                },
                                {
                                    "configMap": {
                                        "items": [
                                            {
                                                "key": "ca.crt",
                                                "path": "ca.crt"
                                            }
                                        ],
                                        "name": "kube-root-ca.crt"
                                    }
                                },
                                {
                                    "downwardAPI": {
                                        "items": [
                                            {
                                                "fieldRef": {
                                                    "apiVersion": "v1",
                                                    "fieldPath": "metadata.namespace"
                                                },
                                                "path": "namespace"
                                            }
                                        ]
                                    }
                                }
                            ]
                        }
                    }
                ]
            },
            "status": {
                "conditions": [
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-10-05T16:27:41Z",
                        "status": "True",
                        "type": "PodReadyToStartContainers"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-09-28T19:17:02Z",
                        "status": "True",
                        "type": "Initialized"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-10-05T16:44:59Z",
                        "message": "containers with unready status: [broken-pod]",
                        "reason": "ContainersNotReady",
                        "status": "False",
                        "type": "Ready"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-10-05T16:44:59Z",
                        "message": "containers with unready status: [broken-pod]",
                        "reason": "ContainersNotReady",
                        "status": "False",
                        "type": "ContainersReady"
                    },
                    {
                        "lastProbeTime": null,
                        "lastTransitionTime": "2024-09-28T19:17:02Z",
                        "status": "True",
                        "type": "PodScheduled"
                    }
                ],
                "containerStatuses": [
                    {
                        "containerID": "containerd://126fb0bddf2c60053adfb086a48b6c3e22a9fc3dcd5403538009ca01eefd4998",
                        "image": "docker.io/library/nginx:latest",
                        "imageID": "docker.io/library/nginx@sha256:b5d3f3e104699f0768e5ca8626914c16e52647943c65274d8a9e63072bd015bb",
                        "lastState": {
                            "terminated": {
                                "containerID": "containerd://126fb0bddf2c60053adfb086a48b6c3e22a9fc3dcd5403538009ca01eefd4998",
                                "exitCode": 0,
                                "finishedAt": "2024-10-05T16:44:58Z",
                                "reason": "Completed",
                                "startedAt": "2024-10-05T16:44:49Z"
                            }
                        },
                        "name": "broken-pod",
                        "ready": false,
                        "restartCount": 164,
                        "started": false,
                        "state": {
                            "waiting": {
                                "message": "back-off 5m0s restarting failed container=broken-pod pod=broken-pod_default(8c40592c-60c4-415a-91f5-f2a83c5af63d)",
                                "reason": "CrashLoopBackOff"
                            }
                        }
                    }
                ],
                "hostIP": "192.168.0.107",
                "hostIPs": [
                    {
                        "ip": "192.168.0.107"
                    }
                ],
                "phase": "Running",
                "podIP": "10.0.0.206",
                "podIPs": [
                    {
                        "ip": "10.0.0.206"
                    }
                ],
                "qosClass": "BestEffort",
                "startTime": "2024-09-28T19:17:02Z"
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}

~~~~





- Nodes

~~~~json
{
    "apiVersion": "v1",
    "items": [
        {
            "apiVersion": "v1",
            "kind": "Node",
            "metadata": {
                "annotations": {
                    "kubeadm.alpha.kubernetes.io/cri-socket": "unix:///var/run/containerd/containerd.sock",
                    "node.alpha.kubernetes.io/ttl": "0",
                    "volumes.kubernetes.io/controller-managed-attach-detach": "true"
                },
                "creationTimestamp": "2024-09-21T21:23:12Z",
                "labels": {
                    "beta.kubernetes.io/arch": "amd64",
                    "beta.kubernetes.io/os": "linux",
                    "kubernetes.io/arch": "amd64",
                    "kubernetes.io/hostname": "wsl2",
                    "kubernetes.io/os": "linux",
                    "node-role.kubernetes.io/control-plane": "",
                    "node.kubernetes.io/exclude-from-external-load-balancers": ""
                },
                "name": "wsl2",
                "resourceVersion": "104148",
                "uid": "d54bd298-16c0-41ee-a65b-0c81d2245499"
            },
            "spec": {
                "podCIDR": "192.168.0.0/24",
                "podCIDRs": [
                    "192.168.0.0/24"
                ]
            },
            "status": {
                "addresses": [
                    {
                        "address": "192.168.0.107",
                        "type": "InternalIP"
                    },
                    {
                        "address": "wsl2",
                        "type": "Hostname"
                    }
                ],
                "allocatable": {
                    "cpu": "16",
                    "ephemeral-storage": "972991057538",
                    "hugepages-1Gi": "0",
                    "hugepages-2Mi": "0",
                    "memory": "16218460Ki",
                    "pods": "110"
                },
                "capacity": {
                    "cpu": "16",
                    "ephemeral-storage": "1055762868Ki",
                    "hugepages-1Gi": "0",
                    "hugepages-2Mi": "0",
                    "memory": "16320860Ki",
                    "pods": "110"
                },
                "conditions": [
                    {
                        "lastHeartbeatTime": "2024-09-21T21:42:57Z",
                        "lastTransitionTime": "2024-09-21T21:42:57Z",
                        "message": "Cilium is running on this node",
                        "reason": "CiliumIsUp",
                        "status": "False",
                        "type": "NetworkUnavailable"
                    },
                    {
                        "lastHeartbeatTime": "2024-10-05T16:58:02Z",
                        "lastTransitionTime": "2024-09-21T21:23:12Z",
                        "message": "kubelet has sufficient memory available",
                        "reason": "KubeletHasSufficientMemory",
                        "status": "False",
                        "type": "MemoryPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-10-05T16:58:02Z",
                        "lastTransitionTime": "2024-09-21T21:23:12Z",
                        "message": "kubelet has no disk pressure",
                        "reason": "KubeletHasNoDiskPressure",
                        "status": "False",
                        "type": "DiskPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-10-05T16:58:02Z",
                        "lastTransitionTime": "2024-09-21T21:23:12Z",
                        "message": "kubelet has sufficient PID available",
                        "reason": "KubeletHasSufficientPID",
                        "status": "False",
                        "type": "PIDPressure"
                    },
                    {
                        "lastHeartbeatTime": "2024-10-05T16:58:02Z",
                        "lastTransitionTime": "2024-09-21T21:23:13Z",
                        "message": "kubelet is posting ready status",
                        "reason": "KubeletReady",
                        "status": "True",
                        "type": "Ready"
                    }
                ],
                "daemonEndpoints": {
                    "kubeletEndpoint": {
                        "Port": 10250
                    }
                },
                "images": [
                    {
                        "names": [
                            "quay.io/cilium/cilium@sha256:0b4a3ab41a4760d86b7fc945b8783747ba27f29dac30dd434d94f2c9e3679f39"
                        ],
                        "sizeBytes": 223002645
                    },
                    {
                        "names": [
                            "docker.io/library/nginx@sha256:b5d3f3e104699f0768e5ca8626914c16e52647943c65274d8a9e63072bd015bb",
                            "docker.io/library/nginx:latest"
                        ],
                        "sizeBytes": 71027638
                    },
                    {
                        "names": [
                            "quay.io/cilium/cilium-envoy@sha256:bd5ff8c66716080028f414ec1cb4f7dc66f40d2fb5a009fff187f4a9b90b566b"
                        ],
                        "sizeBytes": 62107958
                    },
                    {
                        "names": [
                            "registry.k8s.io/etcd@sha256:a6dc63e6e8cfa0307d7851762fa6b629afb18f28d8aa3fab5a6e91b4af60026a",
                            "registry.k8s.io/etcd:3.5.15-0"
                        ],
                        "sizeBytes": 56909194
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-apiserver@sha256:b88538e7fdf73583c8670540eec5b3620af75c9ec200434a5815ee7fba5021f3",
                            "registry.k8s.io/kube-apiserver:v1.29.9"
                        ],
                        "sizeBytes": 35210641
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-controller-manager@sha256:f2f18973ccb6996687d10ba5bd1b8f303e3dd2fed80f831a44d2ac8191e5bb9b",
                            "registry.k8s.io/kube-controller-manager:v1.29.9"
                        ],
                        "sizeBytes": 33739229
                    },
                    {
                        "names": [
                            "quay.io/cilium/operator-generic@sha256:3bc7e7a43bc4a4d8989cb7936c5d96675dd2d02c306adf925ce0a7c35aa27dc4"
                        ],
                        "sizeBytes": 31082413
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-proxy@sha256:124040dbe6b5294352355f5d34c692ecbc940cdc57a8fd06d0f38f76b6138906",
                            "registry.k8s.io/kube-proxy:v1.29.9"
                        ],
                        "sizeBytes": 28600769
                    },
                    {
                        "names": [
                            "quay.io/cilium/hubble-relay@sha256:2e1b4c739a676ae187d4c2bfc45c3e865bda2567cc0320a90cb666657fcfcc35"
                        ],
                        "sizeBytes": 28282791
                    },
                    {
                        "names": [
                            "quay.io/cilium/hubble-ui-backend@sha256:0e0eed917653441fded4e7cdb096b7be6a3bddded5a2dd10812a27b1fc6ed95b"
                        ],
                        "sizeBytes": 20027102
                    },
                    {
                        "names": [
                            "registry.k8s.io/kube-scheduler@sha256:9c164076eebaefdaebad46a5ccd550e9f38c63588c02d35163c6a09e164ab8a8",
                            "registry.k8s.io/kube-scheduler:v1.29.9"
                        ],
                        "sizeBytes": 18851030
                    },
                    {
                        "names": [
                            "registry.k8s.io/coredns/coredns@sha256:1eeb4c7316bacb1d4c8ead65571cd92dd21e27359f0d4917f1a5822a73b75db1",
                            "registry.k8s.io/coredns/coredns:v1.11.1"
                        ],
                        "sizeBytes": 18182961
                    },
                    {
                        "names": [
                            "quay.io/cilium/hubble-ui@sha256:e2e9313eb7caf64b0061d9da0efbdad59c6c461f6ca1752768942bfeda0796c6"
                        ],
                        "sizeBytes": 11081180
                    },
                    {
                        "names": [
                            "registry.k8s.io/pause@sha256:7031c1b283388d2c2e09b57badb803c05ebed362dc88d84b480cc47f72a21097",
                            "registry.k8s.io/pause:3.9"
                        ],
                        "sizeBytes": 321520
                    },
                    {
                        "names": [
                            "registry.k8s.io/pause@sha256:9001185023633d17a2f98ff69b6ff2615b8ea02a825adffa40422f51dfdcde9d",
                            "registry.k8s.io/pause:3.8"
                        ],
                        "sizeBytes": 311286
                    }
                ],
                "nodeInfo": {
                    "architecture": "amd64",
                    "bootID": "52899cae-d5bb-41d9-9218-2b644c93bad9",
                    "containerRuntimeVersion": "containerd://1.7.22",
                    "kernelVersion": "5.15.153.1-microsoft-standard-WSL2",
                    "kubeProxyVersion": "v1.29.9",
                    "kubeletVersion": "v1.29.9",
                    "machineID": "d4bf456d750e40f6b35f8ca7b26985ba",
                    "operatingSystem": "linux",
                    "osImage": "Ubuntu 22.04.5 LTS",
                    "systemUUID": "d4bf456d750e40f6b35f8ca7b26985ba"
                }
            }
        }
    ],
    "kind": "List",
    "metadata": {
        "resourceVersion": ""
    }
}

~~~~






# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## JSON PATH Examples

kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'

kubectl get nodes -o=jsonpath='{.items[*].status.nodeInfo.architecture}'

kubectl get pods -o=jsonpath='{.items[*].status.capacity.cpu}'



- Testando

~~~~bash
> kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'
wsl2%

> kubectl get nodes -o=jsonpath='{.items[*].status.nodeInfo.architecture}'
amd64%
> kubectl get pods -o=jsonpath='{.items[*].status.capacity.cpu}'
>
~~~~






{"\n"} New line

{"\t"} Tab



kubectl get nodes -o=jsonpath='{.items[*].metadata.name}'

kubectl get nodes -o=jsonpath='{.items[*].status.nodeInfo.architecture}'

kubectl get pods -o=jsonpath='{.items[*].status.capacity.cpu}'

kubectl get nodes -o=jsonpath='{.items[*].metadata.name}
master node01
4 4
{.items[*].status.capacity.cpu}'



kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\n"} {.items[*].status.nodeInfo.architecture}'

- Testando

~~~~bash

>
> kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\n"} {.items[*].status.nodeInfo.architecture}'
wsl2
 amd64%
~~~~




kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\n"} {.items[*].status.nodeInfo.osImage}'
kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\t"} {.items[*].status.nodeInfo.osImage}'

- Testando

~~~~bash

>
> kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\n"} {.items[*].status.nodeInfo.osImage}'
wsl2
 Ubuntu 22.04.5 LTS%
>
>
> kubectl get nodes -o=jsonpath='{.items[*].metadata.name} {"\t"} {.items[*].status.nodeInfo.osImage}'
wsl2     Ubuntu 22.04.5 LTS%

~~~~












# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
# ###################################################################################################################### 
## Loops - Range
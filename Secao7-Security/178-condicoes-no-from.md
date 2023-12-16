


## Behavior of to and from selectors

<https://kubernetes.io/docs/concepts/services-networking/network-policies/#behavior-of-to-and-from-selectors>

There are four kinds of selectors that can be specified in an ingress from section or egress to section:

podSelector: This selects particular Pods in the same namespace as the NetworkPolicy which should be allowed as ingress sources or egress destinations.

namespaceSelector: This selects particular namespaces for which all Pods should be allowed as ingress sources or egress destinations.

namespaceSelector and podSelector: A single to/from entry that specifies both namespaceSelector and podSelector selects particular Pods within particular namespaces. Be careful to use correct YAML syntax. For example:

~~~~YAML
  ...
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          user: alice
      podSelector:
        matchLabels:
          role: client
  ...
~~~~


This policy contains a single from element allowing connections from Pods with the label role=client in namespaces with the label user=alice. But the following policy is different:

~~~~YAML
  ...
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          user: alice
    - podSelector:
        matchLabels:
          role: client
  ...
~~~~

It contains two elements in the from array, and allows connections from Pods in the local Namespace with the label role=client, or from any Pod in any namespace with the label user=alice.

When in doubt, use kubectl describe to see how Kubernetes has interpreted the policy.
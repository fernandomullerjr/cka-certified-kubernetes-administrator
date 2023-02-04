

# Scheduling plugins

The following plugins, enabled by default, implement one or more of these extension points:

    ImageLocality: Favors nodes that already have the container images that the Pod runs. Extension points: score.
    TaintToleration: Implements taints and tolerations. Implements extension points: filter, preScore, score.
    NodeName: Checks if a Pod spec node name matches the current node. Extension points: filter.
    NodePorts: Checks if a node has free ports for the requested Pod ports. Extension points: preFilter, filter.
    NodeAffinity: Implements node selectors and node affinity. Extension points: filter, score.
    PodTopologySpread: Implements Pod topology spread. Extension points: preFilter, filter, preScore, score.
    NodeUnschedulable: Filters out nodes that have .spec.unschedulable set to true. Extension points: filter.
    NodeResourcesFit: Checks if the node has all the resources that the Pod is requesting. The score can use one of three strategies: LeastAllocated (default), MostAllocated and RequestedToCapacityRatio. Extension points: preFilter, filter, score.
    NodeResourcesBalancedAllocation: Favors nodes that would obtain a more balanced resource usage if the Pod is scheduled there. Extension points: score.
    VolumeBinding: Checks if the node has or if it can bind the requested volumes. Extension points: preFilter, filter, reserve, preBind, score.
    Note: score extension point is enabled when VolumeCapacityPriority feature is enabled. It prioritizes the smallest PVs that can fit the requested volume size.
    VolumeRestrictions: Checks that volumes mounted in the node satisfy restrictions that are specific to the volume provider. Extension points: filter.
    VolumeZone: Checks that volumes requested satisfy any zone requirements they might have. Extension points: filter.
    NodeVolumeLimits: Checks that CSI volume limits can be satisfied for the node. Extension points: filter.
    EBSLimits: Checks that AWS EBS volume limits can be satisfied for the node. Extension points: filter.
    GCEPDLimits: Checks that GCP-PD volume limits can be satisfied for the node. Extension points: filter.
    AzureDiskLimits: Checks that Azure disk volume limits can be satisfied for the node. Extension points: filter.
    InterPodAffinity: Implements inter-Pod affinity and anti-affinity. Extension points: preFilter, filter, preScore, score.
    PrioritySort: Provides the default priority based sorting. Extension points: queueSort.
    DefaultBinder: Provides the default binding mechanism. Extension points: bind.
    DefaultPreemption: Provides the default preemption mechanism. Extension points: postFilter.

You can also enable the following plugins, through the component config APIs, that are not enabled by default:

    CinderLimits: Checks that OpenStack Cinder volume limits can be satisfied for the node. Extension points: filter.


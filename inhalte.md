# Inhalte Cloud-Native Core

🏗️👷🚧 Work in Progress 🚧🏗️👷

## Kubernetes allgemein
- Organisation
    - Pro Mandant ein Cluster
        - Teuer, aufwändig
    - Alle Mandanten in einem Cluster, Isolation durch K8s Namespaces
        - Hohe Anforderungen an die Cluster-Konfiguration bzgl. Mandantenisolation
- Update / Ausfallsicherheit
    - Scheduling, Preemption and Eviction ([Docs](https://kubernetes.io/docs/concepts/scheduling-eviction/))
    - (optional) Pod Topology ([Docs](https://kubernetes.io/docs/concepts/scheduling-eviction/topology-spread-constraints/))
        - Stellt z.B. sicher, dass Pods sinnvoll über die Nodes verteilt werden.
    - Hochverfügbarkeit (High Availability oder HA)
    - Was sind die Schwachstellen von Kubernetes?
        - ?
- Mandantenfähigkeit (Multi-Tenancy)
    - [Docs](https://kubernetes.io/docs/concepts/security/multi-tenancy/)


## Installation und Betrieb
- Distributionen
    - kubeadm ([Docs](https://kubernetes.io/docs/reference/setup-tools/kubeadm/), [Tutorial](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/))
        - Das Original, ohne Schnörkel 
    - Entwicklungscluster
        - [kind](https://kind.sigs.k8s.io/)
        - [minikube](https://minikube.sigs.k8s.io/docs/)
        - [docker-desktop](https://docs.docker.com/desktop/kubernetes/)
    - [microk8s](https://microk8s.io/docs) (Canonical/Ubuntu)
    - [Rancher](https://rancher.com/docs/) (SUSE)
    - [K3s](https://docs.k3s.io/) (SUSE)
        - abgespeckte "Lightweight" Variante für den Betrieb nahe am Kunden.
        - "Edge Computing"
    - [OpenShift](https://docs.openshift.com/)/[OKD](https://docs.okd.io/latest/welcome/index.html) (RedHat)
    - [Talos Linux](https://www.talos.dev/)
    - und viele mehr
- [Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
- Continuous Delivery
    - [ArgoCD](https://argo-cd.readthedocs.io/en/stable/)
    - [FluxCD](https://fluxcd.io/)
- (optional) Multicluster - clusterapi - [https://cluster-api.sigs.k8s.io/](https://cluster-api.sigs.k8s.io/ "https://cluster-api.sigs.k8s.io/")
    - K8s Cluster erstellen, verwalten, dekomissionieren aus einem Verwaltungs-K8s-Cluster heraus.
- (optional) VMs und Kubernetes - [https://kubevirt.io/](https://kubevirt.io/ "https://kubevirt.io/") - in CNCA?


## Kubernetes Architekturkomponenten ([Docs](https://kubernetes.io/docs/concepts/architecture/))

- Control-Plane Komponenten ([Docs](https://kubernetes.io/docs/concepts/architecture/#control-plane-components))
    - kube-apiserver
    - etcd
    - kube-scheduler
    - kube-controller-manager
    - cloud-controller-manager (optionale Komponente)
        - Kommuniziert mit Cloudanbieter, falls vorhanden
- Node Komponenten ([Docs 1](https://kubernetes.io/docs/concepts/architecture/#node-components), [Docs 2](https://kubernetes.io/docs/concepts/architecture/nodes/))
    - kubelet ([Docs](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/))
        - Kommuniziert mit Container-Runtime und verwaltet Container
    - kube-proxy ([Docs](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/))
        - Teil der Netzwerkinfrastruktur
        - Verwaltet und dirigiert Netzwerktraffic und port-forwardings
        - Nicht notwendig bei ausreichender Funktionalität des Network Fabrics.
    - Container Runtime ([Docs](https://kubernetes.io/docs/setup/production-environment/container-runtimes/))
        - containerd
        - CRI-O
        - etc.
- Kommunikation zwischen Nodes und Control-Plane ([Docs](https://kubernetes.io/docs/concepts/architecture/control-plane-node-communication/))
    - Node zu Control-Plane
        - Nabe-und-Speichen API Muster
        - Jede API Anfrage von einem Node ist an den API server gerichtet
    - Control-Plane zu Node
        - Vom API Server zu Kubelets auf den Nodes
            - Logs abholen
            - An Container anhängen (vergleichbar mit `docker exec`)
            - Port-Forwarding
        - Vom API Server zu Nodes, Pods, und Services
            - Beliebige HTTP/HTTPS Verbindungen
            - Erst nach zusätzlichem Aufwand sicher
    - (optional) Sicherheit
        - HTTPS API
        - Konnectivity ([Docs](https://kubernetes.io/docs/tasks/extend-kubernetes/setup-konnectivity/))
- Controllers ([Docs](https://kubernetes.io/docs/concepts/architecture/controller/))
    - Komponenten die K8s Resourcen überwachen und bei Veränderungen entsprechend reagieren
    - Werden im Normalfall vom *kube-controller-manager* verwaltet 
    - Können auch Dinge ausserhalb des Clusters anstossen
        - z.B. der Cluster Autoscaler vom Kubernetes Team ([Github](https://github.com/kubernetes/autoscaler/))
    - Beispiele:
        - Job controller
        - Node controller
        - ServiceAccount controller
        - Ingress controller (wird nicht vom kube-controller-manager verwaltet)

## Kubernetes Resourcentypen

- Allgemeine Konzepte zu K8s-Resourcen
    - Labels
    - Annotations
- Workloads ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/))
    - Pods ([Docs](https://kubernetes.io/docs/concepts/workloads/pods/))
        - Containers ([Docs](https://kubernetes.io/docs/concepts/containers/))
        - (optional) InitContainers ([Docs](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/))
        - (optional) SidecarContainers ([Docs](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/))
        - (optional) Ephemeral ("Temporäre") Containers ([Docs](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/), [Tutorial](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/))
        - (optional) Pod Health ([Docs](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/))
            - "Liveness"
            - "Readiness"
    - Deployments ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/))
        - steuert ReplicaSet ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/))
        - Deployment-Strategien
            - Rolling-Update
            - Blue/Green (nur mit zusätzlicher Software machbar)
            - Canary (nur mit zusätzlicher Software machbar)
    - StatefulSet ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/))
    - DaemonSet ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/daemonset/))
    - (optional) Jobs ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/job/))
    - (optional) CronJobs ([Docs](https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/))
    - (optional) Workload Autoscaling ([Docs](https://kubernetes.io/docs/concepts/workloads/autoscaling/#scaling-workloads-vertically))
        - HorizontalPodAutoscaler (ist Teil von K8s)
        - VerticalPodAutoscaler ([Separates Projekt vom Kubernetes Team](https://github.com/kubernetes/autoscaler/tree/master/vertical-pod-autoscaler))
- Authorisierung und Mandantenfähigkeit
    - ServiceAccounts ([Docs](https://kubernetes.io/docs/concepts/security/service-accounts/))
    - Roles/ClusterRoles ([Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#role-and-clusterrole))
    - RoleBindings/ClusterRoleBindings ([Docs](https://kubernetes.io/docs/reference/access-authn-authz/rbac/#rolebinding-and-clusterrolebinding))
    - Namespaces ([Docs](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/))
    - ResourceQuotas ([Docs](https://kubernetes.io/docs/concepts/policy/resource-quotas/))
- Netzwerk (Kategorie)
    - Services ([Docs](https://kubernetes.io/docs/concepts/services-networking/service/))
        - fixe IP
        - agiert als LoadBalancer, falls mehr als ein zugehöriger Pod vorhanden ist.
        - Servicetypen
            - ClusterIP
            - NodePort
            - (optional) LoadBalancer (extern)
            - (optional) ExternalName
    - IngressController ([Docs](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/))
    - Ingress ([Docs](https://kubernetes.io/docs/concepts/services-networking/ingress/))
    - (optional) Service Discovery ([Docs](https://kubernetes.io/docs/concepts/services-networking/service/#discovering-services))
    - (optional) Gateway, GatewayClass ([Docs](https://kubernetes.io/docs/concepts/services-networking/gateway/))
    - (optional) NetworkPolicies ([Docs](https://kubernetes.io/docs/concepts/services-networking/network-policies/))
    - (optional) Netzwerk Plugins ([Docs](https://kubernetes.io/docs/concepts/extend-kubernetes/compute-storage-net/network-plugins/))
- Storage ([Docs](https://kubernetes.io/docs/concepts/storage/))
    - PersistentVolumeClaims, PersistentVolumes ([Docs](https://kubernetes.io/docs/concepts/storage/persistent-volumes/))
    - (optional) StorageClasses ([Docs](https://kubernetes.io/docs/concepts/storage/storage-classes/))
    - (optional) VolumeSnapshots ([Docs](https://kubernetes.io/docs/concepts/storage/volume-snapshots/))
        - Sehr nützlich z.B. zum konsistente Backups machen 

## Unsortiertes zu K8s

- (optional) Empfehlungen der Amerikanischen NSA zum Absichern einer K8s Installation 
    - Aufbereitete Zusammenfassung (2021): https://kubernetes.io/blog/2021/10/05/nsa-cisa-kubernetes-hardening-guidance/
    - Originales Dokument (aufdatiert in 2022): https://www.nsa.gov/Press-Room/News-Highlights/Article/Article/2716980/nsa-cisa-release-kubernetes-hardening-guidance/

## (optional) Kubernetes-Erweiterungen ([Docs](https://kubernetes.io/docs/concepts/extend-kubernetes/))

- (optional) Operator Pattern, Operators ([Docs](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/))
- (optional) Plugins
    - Netzwerk
    - Storage
        - Network-Attached Storage (NAS)
        - Storage Area Network (SAN), z.B. Ceph
    - Compute
        - z.B. um Grafikkarten einzubinden
- Übersicht des Software Stacks https://thenewstack.io/cloud-native/the-cloud-native-landscape-the-runtime-layer-explained/

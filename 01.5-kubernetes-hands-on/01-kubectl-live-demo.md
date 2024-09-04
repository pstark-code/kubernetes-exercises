# Live Demo

Aufgabe:

Vorgesetzter gibt uns den Auftrag die Software Gitea zu testen und ein Proof-of-Concept Deployment erstellen auf unserem Kubernetes Cluster.

Grobe to-do Liste: 

- [x] Gitea Proof-of-Concept
  - [x] Gitea Container läuft (Pod)
  - [x] auf Gitea zugreifen (Service + Port-Forwarding)
  - [x] ohne separates Port-Forwarding auf Gitea zugreifen (Service vom Typ "NodePort")
  - [x] Account erstellen


Ungelöste Themen für ein production-ready Deployment:

- [ ] Mehrere Replicas (Deployment)
- [ ] Zugriff per Hostnamen (Ingress)


### Unsortierte, aber interessante Befehle oder Links:

- [Vergleich Docker vs. Kubectl](https://kubernetes.io/docs/reference/kubectl/docker-cli-to-kubectl/)
- [Verschiedene Kubernetes Objektverwaltungsstile](https://kubernetes.io/docs/concepts/overview/working-with-objects/object-management/)
- [Kubectl Referenzdoku](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
- [K9s Commands](https://k9scli.io/topics/commands/):

```shell
# Alle Resourcen Typen auf dem Cluster nachschlagen
kubectl api-resources

# Gerade bei den subkommandos gibt es gute Hilfe und Beispiele
#  mit der --help Option.
kubectl expose --help
kubectl run --help
etc.
```


### Vorbereitung: Image finden

- Google "gitea docker image"
    - https://hub.docker.com/r/gitea/gitea
    - `docker pull gitea/gitea`
- https://docs.gitea.com/installation/install-with-docker
    - Port: 3000


### 1. Pod

Pod starten, Pod-Status nachschauen, Details des Pods anschauen. 

```shell
kubectl run my-gitea --image=docker.io/gitea/gitea:1.22.1
kubectl get pods
kubectl describe pod/my-gitea
```


### 2. Service

Service (IP, Load Balancer) erstellen.

- https://kubernetes.io/docs/concepts/services-networking/service/

```shell
kubectl expose pod my-gitea --port=80 --target-port=3000
kubectl get Services
kubectl describe Service/my-gitea
```


### 3. Port-Forwarding

Wir erstellen einen temporären Port-Forward um das Deployment zu testen.

```shell
kubectl port-forward service/my-gitea 9000:80
```


### 4. (Bonus!) Service mit type NodePort

```shell
kubectl expose pod/my-gitea --name my-first-nodeport --type=NodePort --port=8001 --target-port=3000
```

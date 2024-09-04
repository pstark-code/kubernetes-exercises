# Theorie Block 1

---
### Namespace (kubectl)
`kubectl create namespace gitea-staging`
```plain
Erstellt einen Namespace mit dem angegebenen Namen

Beispiel:
  # Erstellt einen Namespace mit dem Namen "my-namespace"
  kubectl create namespace my-namespace
```
--- 
### Namespace (YAML)
`kubectl create namespace gitea-staging --dry-run=client --output yaml`
```yaml
apiVersion: v1
kind: Namespace
metadata:
  creationTimestamp: null
  name: my-gitea
spec: {}
status: {}
```
---
### Pod (kubectl)
`kubectl run my-cool-pod-name --image=docker.io/library/example:v1.2.3`
```plain
$ kubectl run --help
Create and run a particular image in a pod.

Examples:
  # Start a nginx pod
  kubectl run nginx --image=nginx
...
```
--- 
### Pod (yaml)
```yaml
# kubectl run nginx --image=nginx --dry-run=client --output yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
  dnsPolicy: ClusterFirst
  restartPolicy: Always
```
--- 
### Service (kubectl)
```plain
$ kubectl expose

$ kubectl run --help
Create and run a particular image in a pod.

Examples:
  # Start a nginx pod
  kubectl run nginx --image=nginx
...
```
--- 
### Service (YAML)
```plain
$ kubectl expose pod nginx --port=80 --target-port=8080 --dry-run=client --output yaml
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  ports:
  - port: 80
    protocol: TCP
    targetPort: 8080
  selector:
    run: nginx
```
--- 
### Port-Forwarding
```plain
kubectl port-forward service/nginx 9000:80
```
--- 
### Übung
1. VPN einrichten/starten
2. Cluster auswählen
3. Namespace erstellen 
    - Mit kubens in den Namespace wechseln
4. Pod starten
    - Vorschlag: `docker.io/gitea/gitea:1.22.1`
5. Service erstellen
6. Mit Port-Forward auf den Container verbinden
- Wenn ihr nicht weiterwisst: `kubectl kommando --help`
- Für YAML output: `--dry-run -o yaml`
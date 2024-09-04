# Theorie Block 2

---
### Resourcen Löschen (kubectl)
`kubectl delete resource-type resource-name`
```plain
  kubectl delete pod nginx

  # Delete all pods (Achtung!!)
  kubectl delete pods --all
```
--- 
### Deployment (kubectl)
`kubectl create deployment nginx --image=nginx:latest --replicas=4`
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
### Deployment (YAML)
`kubectl create deployment podinfo-test --image=nginx:latest --replicas=5 --port=80`
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: my-nginx
  name: my-nginx
spec:
  replicas: 5
  selector:
    matchLabels:
      app: my-nginx
  template:
    metadata:
      labels:
        app: my-nginx
    spec:
      containers:
      - image: nginx
        name: nginx
        ports:
        - containerPort: 80
```
---
### Service - NodePort (kubectl)

- `kubectl expose deployment/my-nginx --name my-nginx --type=NodePort --target-port=3000`
- `--type=NodePort`

--- 
### Übung
1. Frischen Namespace erstellen 
    - Mit kubens in den Namespace wechseln
2. Deployment erstellen
3. Service mit Type NodePort erstellen
4. Per Browser auf den Container verbinden
- Wenn ihr nicht weiterwisst: `kubectl kommando --help`
- Für YAML output: `--dry-run -o yaml`



# Notes on Bootstrapping a Kubernetes Cluster Using Kind

Attention: These are personal notes. You are free to use them, but
don't be surprised if you need to adjust something for your 
particular setup. Be careful. Caveat Emptor!


## Start Kind with Multiple Nodes

```sh
kind create cluster --name=kind-ingress --config=kind-cluster.conf --kubeconfig=./kubeconfig.yml
```

## Deploy everything declared in kustomization.yml 

- Nginx Ingress
- Cert-Manager
- Example Service
- Certificate Issuer

```sh
kubectl apply -k .
```




# Old Notes (Archive)

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml
```

## Verify CA

```
openssl verify -CAfile \
<(kubectl -n cert-manager get Secret/ca-root-cert-secret -o jsonpath='{.data.ca\.crt}' | base64 -d) \
<(kubectl -n default get Secret/example-tls -o jsonpath='{.data.tls\.crt}' | base64 -d)
```

## Install CA locally

```
kubectl -n cert-manager get Secret/ca-root-cert-secret -o jsonpath='{.data.ca\.crt}' | base64 -d >custom-ca.crt

```

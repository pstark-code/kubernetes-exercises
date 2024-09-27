# Ingresscontroller mit ingress-nginx

Für Details siehe https://docs.k0sproject.io/stable/examples/nginx-ingress/

Für unsere

```shell
kubectl apply -f "https://raw.githubusercontent.com/pstark-code/kubernetes-homelab/refs/heads/main/04-neuer-cluster/resourcen/ingress-controller-with-hostnetwork.yaml"
kubectl label nodes wsXY-YZ-cnc-worker-01 ingress="true"
```

Aufgabe 
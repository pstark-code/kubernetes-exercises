# Ingresscontroller mit ingress-nginx

Wir verwenden den [ingress-nginx](https://kubernetes.github.io/ingress-nginx/) ingress-controller. Das ist einer der stabilsten und weit-verbreiteten ingress-controllern. 


## Installation

Bitte lest diesen Abschnitt zuerst durch und klickt dann auf Links oder kopiert Code. 

Details zu verschiedenen Installationsprozessen auf k0s findet ihr [hier](https://docs.k0sproject.io/stable/examples/nginx-ingress/#install-nginx-using-host-network).

Wir werden die [Install NGINX using host network](https://docs.k0sproject.io/stable/examples/nginx-ingress/#install-nginx-using-host-network) Variante verwenden. Das ist ein bisschen geschummelt, weil wir damit die Service-Abstraktionsschicht von Kubernetes aushebeln. Aber es ist die reibungsloseste Variante. Da unser Set-up ein bisschen speziell ist, habe ich für euch etwas vorbereitet. Ihr könnt also statt dem Link aus der Dokumentation direkt folgenden Link mit `kubectl apply -f` verwenden

- `https://raw.githubusercontent.com/pstark-code/kubernetes-homelab/refs/heads/main/04-neuer-cluster/resourcen/ingress-controller-with-hostnetwork.yaml`

Um dafür zu sorgen, dass der Ingress sicher auf dem ersten worker-node läuft, müsst ihr diesen noch mit einem `label` versehen. Das könnt ihr mit dem Kommando `kubectl label`. Das würde dann etwa so aussehen: 

```sh
# Ergänzt den richtigen Node-Namen!
# Ihr findet eure Node-Namen mit kubectl get nodes
kubectl label nodes ws00-00-cnc-worker-01 ingress="true"
```

Mit dem folgenden Befehl könnt ihr alle Nodes und deren labels anzeigen:

```sh
kubectl get nodes --show-labels
```

Beispielausgabe:

```
NAME                 STATUS   ROLES    AGE     VERSION       LABELS
ws99-cnc-worker-01   Ready    <none>   6d15h   v1.30.4+k0s   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,ingress=true,kubernetes.io/arch=amd64,kubernetes.io/hostname=ws99-cnc-worker-01,kubernetes.io/os=linux
ws99-cnc-worker-02   Ready    <none>   6d15h   v1.30.4+k0s   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=ws99-cnc-worker-02,kubernetes.io/os=linux
ws99-cnc-worker-03   Ready    <none>   6d15h   v1.30.4+k0s   beta.kubernetes.io/arch=amd64,beta.kubernetes.io/os=linux,kubernetes.io/arch=amd64,kubernetes.io/hostname=ws99-cnc-worker-03,kubernetes.io/os=linux
```


## Für Interessierte: Was habe ich denn genau geändert?

(Unten findet ihr das komplette Diff.)

1. Ich habe den NodePort Service herausgelöscht, da wir uns direkt ins Host Netzwerk einwählen. 
2. Ich habe wie in der Doku beschrieben `.spec.template.spec.hostNetwork` auf `true` gesetzt. 
3. Ich habe den Pod auf einen bestimmten worker-node beschränkt indem ich `.spec.template.spec.nodeSelector.ingress: true` gesetzt habe. Das bedeutet, dass der Pod nur auf einem Node "scheduled" wird, wo das `label` `ingress=true` gesetzt ist. 



```diff
--- orig.yaml   2024-10-02 12:46:50.188624387 +0200
+++ new.yaml    2024-10-02 12:46:28.097966222 +0200
@@ -318,35 +318,6 @@
     app.kubernetes.io/name: ingress-nginx
     app.kubernetes.io/part-of: ingress-nginx
     app.kubernetes.io/version: 1.1.3
-  name: ingress-nginx-controller
-  namespace: ingress-nginx
-spec:
-  ports:
-  - appProtocol: http
-    name: http
-    port: 80
-    protocol: TCP
-    targetPort: http
-  - appProtocol: https
-    name: https
-    port: 443
-    protocol: TCP
-    targetPort: https
-  selector:
-    app.kubernetes.io/component: controller
-    app.kubernetes.io/instance: ingress-nginx
-    app.kubernetes.io/name: ingress-nginx
-  type: NodePort
----
-apiVersion: v1
-kind: Service
-metadata:
-  labels:
-    app.kubernetes.io/component: controller
-    app.kubernetes.io/instance: ingress-nginx
-    app.kubernetes.io/name: ingress-nginx
-    app.kubernetes.io/part-of: ingress-nginx
-    app.kubernetes.io/version: 1.1.3
   name: ingress-nginx-controller-admission
   namespace: ingress-nginx
 spec:
@@ -387,6 +358,7 @@
         app.kubernetes.io/instance: ingress-nginx
         app.kubernetes.io/name: ingress-nginx
     spec:
+      hostNetwork: true
       containers:
       - args:
         - /nginx-ingress-controller
@@ -464,6 +436,7 @@
           readOnly: true
       dnsPolicy: ClusterFirst
       nodeSelector:
+        ingress: "true"
         kubernetes.io/os: linux
       serviceAccountName: ingress-nginx
       terminationGracePeriodSeconds: 300
```


## Für Interessierte: Alternativen

Alternativen dazu sind unter anderem:

- [caddy](https://caddyserver.com/docs/install)
- [traefik](https://doc.traefik.io/traefik/getting-started/quick-start-with-kubernetes/)

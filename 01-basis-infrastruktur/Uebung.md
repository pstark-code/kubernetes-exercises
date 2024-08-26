# Basis Infrastruktur

## 1. Kind - Cluster erstellen

Im Ordner [./kind](./kind) findest du eine Kind Cluster Konfiguration. Du kannst einen Cluster damit erstellen mit dem `kind cluster create` Kommando.

Versuche es zuerst selber. Den Namen kannst du frei wählen. Das wird potentiell später relevant. Du musst potentiell gewisse Sachen mit dem Namen anpassen. 

Falls du nicht weiter weisst, findest du ein vollständiges Beispiel-Kommando im `kind` Ordner. Das solltest du direkt ausführen können. 

Am Ende solltest du einen Kind Cluster haben worauf du dich per kubectl verbinden kannst.

Kommando zum ausprobieren:

```
kubectl get all -A
```

Falls du die kubeconfig in eine separate Datei ausgegeben hast, kannst du diese entweder mit der `--kubeconfig=` option von kubectl verwenden, oder du kannst die Umgebungsvariable "KUBECONFIG" setzen. Diese funktioniert sowohl mit kubectl, aber auch mit vielen verwandten Werkzeugen wie z.B. `helm`.

Beispiel Bash:

```shell
export KUBECONFIG="./kubeconfig.yml"
# oder
kubectl --kubeconfig="./kubeconfig.yml"
```

Umgebungsvariable setzen in der PowerShell:
```powershell
$Env:KUBECONFIG=".\kubeconfig.yml"
kubectl get all -A
```

Hoffentlich läuft der Cluster jetzt. Alles ab jetzt sollte für beliebige "certified kubernetes" cluster funktionieren, nicht nur mit eurem lokalen Kind-cluster. 

## 2. Kustomize - Kern-Komponenten für HTTP-Anwendungen auf dem Cluster

Wir haben einen Cluster. Aber es fehlt noch ein wichtiges Stück in diesem Puzzle um Web-Applikationen deployen zu können. Und das ist ein Reverse-Proxy. Damit mehrere Webapplikationen auf einer IP koexistieren können, müssen wir Anfragen an die verschiedenen Backends verteilen können. In Kubernetes gibt es das Konzept eines "Ingress". Dies beschreibt einen oder mehrere Einträge in der Konfiguration des Reverse-Proxy's.

Die einfachste Variante sieht so aus:

```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  namespace: example-namespace
spec:
  rules:
  - host: "mein-domain-name.tbz.ch"
    http:
      paths:
      - pathType: Prefix
        path: /
        backend:
          service:
            name: example-service
            port:
              number: 8080

```

Dieser *Ingress* leitet alle Anfragen mit dem Hostnamen "mein-domain-name.tbz.ch" an den *Service* "example-service" weiter, an den Port 8080.

Die Dokumentation zum Thema *Ingress* findet ihr hier: https://kubernetes.io/docs/concepts/services-networking/ingress/

**Zur Erinnerung**: Ein Kubernetes-*Service* ist quasi eine Cluster-weit ansprechbare IP, gekoppelt mit einem Load-Balancer. Wenn ihr euer Wissen über Services auffrischen möchtet, findet ihr die Dokumentation dazu hier: https://kubernetes.io/docs/concepts/services-networking/service/



Im Ordner "kustomize" findet ihr eine Handvoll Kubernetes Manifests und eine Datei namens "kustomization.yml"

Bisher hatten wir gesehen, dass wir Kubernetes Manifests mit `kubectl apply -f <Dateiname oder URL>` hochladen können. wenn wir jetzt aber mehr als nur eine Datei haben, wird das schnell unübersichtlich. 

Da kommt uns das Werkzeug "kustomize" sehr gelegen. Ursprünglich war dies ein separates Programm, heute ist das in kubectl eingebaut. Mit kustomize können beliebig viele YAML Dateien gleichzeitig verarbeitet werden, solange sie im zugehörigen "kustomization.yml" unter dem Key namens "Resources:" vermerkt sind. Das ist jetzt alles etwas abstrakt. Am besten schaut ihr jetzt mal in dieses kustomization.yml rein, dann wird es hoffentlich klarer. Den "Patches:" Key könnt ihr vorerst zur Seite lassen.


## Helm



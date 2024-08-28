# Übung 1 - Basis Infrastruktur

## 1. Kind - Cluster erstellen

Im Ordner [./kind](./kind) findest du eine Kind Cluster Konfiguration. Du kannst einen Cluster damit erstellen mit dem `kind cluster create` Kommando.

Versuche es zuerst selber. Den Namen kannst du frei wählen. Das wird potentiell später relevant. Du musst potentiell gewisse Sachen mit dem Namen anpassen. 

Falls du nicht weiter weisst, findest du ein vollständiges Beispiel-Kommando im `kind` Ordner. Das solltest du direkt ausführen können. 

Am Ende solltest du einen Kind Cluster haben worauf du dich per kubectl verbinden kannst.

Kommando zum ausprobieren:

```
kubectl get all -A
```


### Verwaltung der kubectl Konfiguration

**Anmerkung:** Ich hatte in der ersten Lektion empfohlen, die kubeconfig in eine separate Datei auszugeben, damit die System-weite Konfigurationsdatei nicht so ein durcheinander wird. Ich würde dies nicht mehr empfehlen, da es bei vielen zu Verwirrung geführt hat. Stattdessen schlage ich vor, die Werkzeuge `kubectx` und `kubens` zu verwenden um Ordnung in die Sache zu bringen. Falls ihr noch eine separate kubeconfig Datei habt, findet ihr hier eine Anleitung wie man diese zusammenführen kann: https://dev.to/akyriako/merge-multiple-kubeconfig-files-20gb

Ich lasse den Rest dieses Abschnitts zur Vollständigkeit hier.

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

Wir haben jetzt einen Cluster. Aber es fehlt noch ein wichtiges Stück in diesem Puzzle um Web-Applikationen deployen zu können. Und das ist ein Reverse-Proxy. Damit mehrere Webapplikationen auf einer IP koexistieren können, müssen wir Anfragen an die verschiedenen Backends verteilen können. In Kubernetes gibt es das Konzept eines "Ingress". Dies beschreibt einen oder mehrere Einträge in der Konfiguration des Reverse-Proxy's.

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

Da kommt uns das Werkzeug "kustomize" sehr gelegen. Ursprünglich war dies ein separates Programm, heute ist das in kubectl eingebaut. Mit kustomize können beliebig viele YAML Dateien gleichzeitig verarbeitet werden, solange sie im zugehörigen "kustomization.yml" unter dem Key namens "Resources:" vermerkt sind. Das ist jetzt alles etwas abstrakt. Am besten schaut ihr jetzt mal in dieses kustomization.yml rein, dann wird es hoffentlich klarer. 

Ihr könnt diese Manifeste so an Kubernetes übermitteln:

```
kubectl apply -k ./kustomize
# oder falls ihr in den "kustomize" Ordner gewechselt habt:
kubectl apply -k .
```

Das -k steht für Kustomize und als Argument danach wird der Ordner erwartet, in dem sich die kustomization.yaml Datei befindet.


## 3. Helm

Wir werden Helm später noch etwas genauer studieren, für den Moment verwenden wir es einfach einmal zum das Kubernetes Dashboard und die Kubeview Visualisierung auf unserem Cluster zu installieren. 

Dafür macht ihr eine Konsole im "helm" Unterordner auf, und führt dort entweder das Shell- oder PowerShell-Script aus. Die heissen `deploy-helm.sh` oder `deploy-helm.ps1` respektive.

Dabei ist es wichtig, dass ihr den richtigen Cluster aktiviert habt. Das könnt ihr  mit `kubectl cluster-info` oder `kubectl auth whoami` herausfinden.


## 4. Administratives

Jetzt haben wir einen Cluster, mit einem Reverse-Proxy und mehreren Beispiel-Applikationen. Jetzt funktioniert der Reverse-Proxy aber nur wenn wir auch die entsprechenden DNS Einträge haben. Dafür setzen wir jetzt eine Handvoll Einträge in unserer `/etc/hosts` Datei. 

Diese Datei enthält IPs und zugehörige Hostnamen, die von Windows zuerst aufgelöst werden sollen (oder die gar nicht im öffentlichen DNS System vorkommen können)

Ich habe für den Moment folgende Hostnamen eingetragen. Anleitungen zum editieren dieser Datei findet ihr weiter unten.

```
# Linux / MacOS
127.0.0.2 homelab.local dashboard.homelab.local kubeview.homelab.local git.homelab.local idm.homelab.local runner.homelab.local wiki.homelab.local app-a.homelab.local app-b.homelab.local app-c.homelab.local app-d.homelab.local app-e.homelab.local
```

Achtung, auf Windows dürfen nur 9 Hostnamen pro Zeile eingetragen werden. Dafür ist es aber auch kein Problem mehrere Zeilen mit der gleichen IP am Zeilenbeginn zu haben. (Ich habe die IP trotzdem auf `127.0.0.2` gesetzt, weil es scheinbar Probleme geben könnte, wenn `127.0.0.1` auf etwas anderes als `localhost` zeigt.)

```
# Windows
127.0.0.2 homelab.local dashboard.homelab.local kubeview.homelab.local git.homelab.local idm.homelab.local runner.homelab.local wiki.homelab.local app-a.homelab.local app-b.homelab.local 
127.0.0.2 app-c.homelab.local app-d.homelab.local app-e.homelab.local
```

Wenn ihr das alles eingetragen habt, schaut euer Werk an auf https://kubeview.homelab.local/ oder https://dashboard.homelab.local/ 

Das Token fürs Dashboard kriegt ihr so. Am eifachsten kopiert ihr es euch gleich in eine Datei raus:

```shell
# PowerShell/Bash
kubectl get secret admin-user -n default -o template='{{ .data.token | base64decode }}{{ "\n" }}'
```


### Anleitungen zum Editieren der /etc/hosts Datei auf verschiedenen Betriebssystemen

**Wo?**

- Windows: `C:\Windows\System32\drivers\etc\hosts`
- MacOS und Linux: `/etc/hosts`

**Wie?**

Detaillierte Anleitungen findet ihr im Internet, zum Beispiel hier: https://www.howtogeek.com/27350/beginner-geek-how-to-edit-your-hosts-file/

Auf Windows gibt es eine spezialisierte Software dafür, die in den "Microsoft Windows Powertoys" enthalten ist. `winget install --id=Microsoft.PowerToys  -e`

**Pro-Tipp:** Die Powertoys /etc/hosts-Software hält auch automatisch die neun-Einträge-pro-Zeile Regel ein.



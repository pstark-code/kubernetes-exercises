# Basis Infrastruktur

## Kind Cluster erstellen

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
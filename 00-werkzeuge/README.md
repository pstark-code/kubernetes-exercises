# Empfehlenswerte Kubernetes Werkzeuge

Bei der Arbeit mit einem komplexen System wie Kubernetes sammelt sich schnell einiges an Werkzeugen an. Ich liste hier die Werkzeuge auf, die ich häufig und gerne verwende, wo ihr sie herkriegt und wo deren Dokumentation ist.

- Für Windows User kann ich diese Webseite sehr empfehle um die winget Repositories bequem zu durchsuchen: https://winstall.app/
- Linux User haben sowieso ihren Distributions-Paketmanager.
- MacOS User verwenden vermutlich Home-Brew, da könnt ihr die Repositories hier durchsuchen: https://formulae.brew.sh/

## kubectl

Das Basiswerkzeug für Kubernetes.

- Installation: https://kubernetes.io/docs/tasks/tools/#kubectl
- Dokumentation: https://kubernetes.io/docs/reference/kubectl/
- `winget install --id=Kubernetes.kubectl  -e`
- `brew install kubernetes-cli`

## kind

Schnell lokal einen cluster erstellen. 

- Doku: https://kind.sigs.k8s.io/
- `winget install --id=Kubernetes.kind  -e`
- `brew install kind`

## Helm

"Der Package-Manager für Kubernetes!"

- Doku: https://helm.sh/docs/intro/quickstart/
- `winget install --id=Helm.Helm  -e`
- `brew install helm`

## k9s

Eine mächtige Konsolen-Software um einen Kubernete Cluster zu managen. Er hat leider eine relativ steile Lernkurve.

- Doku: https://k9scli.io/
- `brew install k9s`
- `winget install --id=Derailed.k9s  -e`

## kubectx und kubens

Schnell zwischen Contexts in der Kubeconfig hin und her wechseln. Kann auch zwischen Namespaces innerhalb des selben Clusters wechseln. 

- Doku: 
- `winget install --id ahmetb.kubectx`
- `winget install --id ahmetb.kubens`
- `brew install kubectx`
  - Installiert soviel ich weiss gleich beide.




# Der Vollständigkeit halber erwähnt:

## Alternative zu kubectx und kubens: `kubie`

Alternativ zu kubectx und kubens gibt es `kubie`. Ich habe damit allerdings keine Erfahrung. 

- Doku: https://github.com/sbstp/kubie
- Doku: https://blog.sbstp.ca/introducing-kubie/
- *`kubie` scheint nicht via WinGet verfügbar zu sein.*
- `brew install kubie`

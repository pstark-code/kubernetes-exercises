# Inhalte des Cloud-Native Core Moduls

[inhalte.md](./inhalte.md)

# Einführung zur Übungsreihe "Kubernetes Homelab"

In dieser Übungsreihe werden wir über das Semester Schritt für Schritt die Werkzeuge und Konfigurationen erarbeiten um einen Homelab Kubernetes Cluster zu deployen. Darauf werden wir eine Handvoll nützliche Homelab-Service installieren. 

Schlussendlich können alle Cluster anders aussehen, je nach Anforderungen oder Laune. Ein paar Vorschläge für Service:

- Privates Git-Hosting
- Owncloud/Nextcloud
- Wiki
- Medienserver

In diesen Unterlagen werde ich einen Pfad vorstellen, der verschiedene Umsysteme etabliert, die bei einem frischen Kubernetes Cluster fehlen oder deren Vorhandensein zumindest praktisch ist. Dazu gehören z.B. Reverse-Proxy (nginx-ingress-controller), Zertifikatsmanagement (cert-manager), Dashboard, etc. Die genauen Systeme werden sich noch herauskristallisieren, je nach Interesse und Fokus.

## Übung 01 "Basis Infrastruktur"

In dieser ersten Etappe setzen wir einen Kind-Cluster auf, mit einem Control-Plane-Node und drei Worker-Nodes. Darauf installieren wir das Kubernetes-Dashboard und die Applikation "Kubeview", die eine visuelle Übersicht zur Verfügung stellt.

Für Details siehe Ordner [./01-basis-infrastruktur](./01-basis-infrastruktur/Uebung.md)

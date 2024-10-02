# Cloud-Native Core Cluster Designentscheidungen

Wir wollen einen Cluster erstellen, der ähnlich aufgebaut ist, wie ein Kubernetes Cluster, der in Produktion eingesetzt werden kann. 

## Grundanforderungen

Die folgenden Grundanforderungen braucht ein Cluster meiner Meinung nach bei einem üblichen Nutzungsmuster:

- [x] Deployments können darauf ausgerollt werden und bei Bedarf skaliert werden.
    - Wird mit Kubernetes automatisch erfüllt.
- [x] Applikationen können Daten aufbewahren mit Hilfe eines PersistentVolumeClaims, das automatisch bereitgestellt wird.
    - Wird mit dem csi-driver-nfs erfüllt. (siehe [nfs-storage.md](./01-grund-anforderungen/nfs-storage.md))
    - Achtung: NFS ist nicht wirklich production-grade Netzwerkstorage.
- [x] Webapplikationen können via IngressController verfügbar gemacht werden, indem ein Ingress erstellt wird.
    - Wird mit dem [ingress-nginx](https://github.com/kubernetes/ingress-nginx) ingress-controller erfüllt. (siehe [ingress.md](./01-grund-anforderungen/ingress.md))


### Für Produktionscluster wichtig, aber für uns nicht sinnvoll machbar

Aus praktischen Gründen werden wir folgende Dinge ausklammern oder uns mit einfacheren Varianten zufrieden geben:

- [ ] Control-Plane im High-Availability Modus
    - Aus Komplexitätsgründen ausgeklammert. Vielleicht Teil von CNA?
- [ ] High-Performance persistent Storage
    - Fehlende Infrastruktur. (Und der Kubernetes Teil würde sehr ähnlich aussehen wie bei unserer Lösung.)
- [ ] Automatische Zertifikatsignierung für TLS Ingresse
    - Wir haben leider keine öffentlichen IPs, und alternative Lösungen waren zeitlich nicht machbar.
- [ ] Automatische Backups
    - Fehlende Infrastruktur.
- [ ] Externe Loadbalancer
    - Fehlende Infrastruktur.


## Weitere Schritte?

Mit den Grundanforderungen haben wir einen Cluster, der sich schon einmal sehen lassen kann. Die unten beschriebenen Erweiterungen sind alles Vorschläge, die in einem Produktionscluster Sinn machen würden. Die meisten Vorschläge beinhalten ein Ausrollen von Software in einer Form wie auch Kundenapplikationen ausgerollt würden. Sprich also Deployment, Service, Ingress, etc. Das im Kontrast zum Storage-Driver, dessen Installation etwas tiefer greift. 


- Dashboard für einfache Operationen wie das Löschen eines Pods oder Anzeigen des Zustandes eines Deployments
    - falls es via Ingress exponiert wird, dann sollte es entsprechend geschützt werden
    - siehe [dashboard.md](./02-erweiterte-anforderungen/dashboard.md)
- Wir können den Clusterzustand visualisieren.
    - siehe [metrics-und-observability.md](./02-erweiterte-anforderungen/metrics-und-observability.md)
- Falls bestimmte vordefinierte Szenarien oder Probleme auftauchen werden wir per E-Mail informiert.
    - Die Daten zur Visualisierung sollen auch für das Alerting (Warnung) eingesetzt werden.
    - siehe [alerting.md](./02-erweiterte-anforderungen/alerting.md)
- GitOps - Automatisches Deployment von Kubernetes Manifesten aus einem Git Repository.
    - Für Fortgeschrittene.
    - Ich schlage [FluxCD](https://fluxcd.io/flux/get-started/) vor. Siehe [hier](https://docs.k0sproject.io/stable/examples/gitops-flux/) für einen Einstiegspunkt, der von k0s spezifisch unterstützt wird.
    - Alternativ [ArgoCD](https://argo-cd.readthedocs.io/en/stable/getting_started/)
- Automatische Provisionierung von TLS Zertifikaten für Ingress
    - siehe [cert-manager.md](./02-erweiterte-anforderungen/cert-manager.md)
- Automatisches Backup von PersistentVolumes
    - siehe [velero.io](https://velero.io/)
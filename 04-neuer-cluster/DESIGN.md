# Cloud-Native Core Cluster Designentscheidungen

## Grundanforderungen

Die folgenden Grundanforderungen braucht ein Cluster meiner Meinung nach bei einem üblichen Nutzungsmuster.


- Deployments können darauf ausgerollt werden und bei Bedarf skaliert werden.
- Applikationen können Daten aufbewahren mit Hilfe eines PersistentVolumeClaims, das automatisch bereitgestellt wird.
- Webapplikationen können via IngressController verfügbar gemacht werden, indem ein Ingress erstellt wird.


## Erweiterte Anforderungen


- Dashboard für einfache Operationen wie das Löschen eines Pods oder Anzeigen des Zustandes eines Deployments
    - Ich würde euch vorschlagen nach den Grundanforderungen hier weiter zu machen 
    - falls es via Ingress exponiert wird, dann sollte es entsprechend geschützt werden
    - siehe [dashboard.md](./erweiterte-anforderungen/dashboard.md)
- Wir können den Clusterzustand visualisieren.
    - siehe [metrics-und-observability.md](./erweiterte-anforderungen/metrics-und-observability.md)
- Falls bestimmte vordefinierte Szenarien oder Probleme auftauchen werden wir per E-Mail informiert.
    - Die Daten zur Visualisierung sollen auch für das Alerting (Warnung) eingesetzt werden.
    - siehe [alerting.md](./erweiterte-anforderungen/alerting.md)
- GitOps - Automatisches Deployment von Kubernetes Manifesten aus einem Git Repository.
    - Für Fortgeschrittene.
    - Dazu habe ich keine Anleitung geschrieben. Aber wenn ihr mutig seid, schaut [hier](https://docs.k0sproject.io/stable/examples/gitops-flux/) für einen Einstiegspunkt.
- TLS Zertifikate für den Gebrauch mit https können automatisch provisioniert werden. 
    - Das könnte auch in den Grundanforderungen sein. Das hängt dann vom Nutzungsmuster ab.
    - Für uns nicht so interessant, weil wir die Zertifikate leider nicht signieren lassen können.
    - Bei Interesse siehe [cert-manager.md](./erweiterte-anforderungen/cert-manager.md)

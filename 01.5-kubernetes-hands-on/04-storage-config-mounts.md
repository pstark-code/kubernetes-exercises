# YAML Editieren, 

---

### Resourcen editieren

- Wir können nicht alles mit `kubectl` Kommandos erreichen. 
- Also müssen wir das YAML editieren. 

`kubectl edit resource-type resource-name`

```plain
Examples:
  kubectl edit Deployment/nginx
  kubectl edit Service/nginx
  kubectl edit -n namespace Service/gitea
```

--- 

### Unveränderbare Felder

- Es gibt immutable / unveränderbare Felder
- Können nicht im laufenden Betrieb verändert werden (z.b. `metadata.name`) 

---

### Fazit? YAML Dateien! 

- Wir werden uns wohl oder übel mit YAML Dateien auseinandersetzen müssen. 
- Nachteile
  - YAML kann ziemlich fummelig sein.
  - Jetzt müssen wir so viel Text aufbewahren und organisieren...
- Vorteile
  - Reproduzierbar
  - Nachvollziehbar
  - Portabel
  - und es kann auch Resourcen anpassen statt neu machen!

#### Neu erstellen und Updaten/Anpassen

`kubectl apply -f my-nginx-deployment.yml`

#### Ganzer Ordner voller YAML Dateien

`kubectl apply -f ./my-kubernetes-folder/`

--- 

### Storage (YAML)

`kubectl create PersistentVolumeClaim my-first-pvc`

--- 

### Übung

In den bisherigen Übungen erstellt:

- Namespace
- Deployment
- Service mit Type NodePort

Ziel für diese Übung:

- Die obengenannten Resourcen (und allfällige weitere) lokal als YAML Dateien ablegen. 
- Diese YAML Dateien mit `kubectl apply -f ` deployen
- Zum Test auch wieder löschen
  - Bonusfrage: Wie macht man das am einfachsten?
    - Pro-Tipp: Schaut euch `kubectl delete --help` an.
- Statt jedes File individuell deployen, in einen Ordner packen und den ganzen Ordner deployen.

Bonus:

- Schaut euch 

Zur Erinnerung:
- Wenn ihr nicht weiterwisst: `kubectl kommando --help`
- Für YAML output: `--dry-run -o yaml`

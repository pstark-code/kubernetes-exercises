# Vorbereitung

Hier ist eine List aller Maschinen die wir im Einsatz haben (und ein paar die ausgeschaltet sind. Die haben entsprechend keine IP): 

```plain
ws01-10-cnc-controlplane-01.maas 10.0.22.127
ws01-11-cnc-controlplane-02.maas  
ws01-12-cnc-controlplane-03.maas  
ws01-13-cnc-worker-01.maas 10.0.22.151
ws01-14-cnc-worker-02.maas 10.0.22.130
ws01-15-cnc-worker-03.maas 10.0.22.145

ws02-16-cnc-controlplane-01.maas 10.0.22.153
ws02-17-cnc-controlplane-02.maas  
ws02-18-cnc-controlplane-03.maas  
ws02-19-cnc-worker-01.maas 10.0.22.157
ws02-20-cnc-worker-02.maas 10.0.22.165
ws02-21-cnc-worker-03.maas 10.0.22.166

ws03-22-cnc-controlplane-01.maas 10.0.22.154
ws03-23-cnc-controlplane-02.maas  
ws03-24-cnc-controlplane-03.maas  
ws03-25-cnc-worker-01.maas 10.0.22.168
ws03-26-cnc-worker-02.maas 10.0.22.169
ws03-27-cnc-worker-03.maas 10.0.22.167

ws04-28-cnc-controlplane-01.maas 10.0.22.155
ws04-29-cnc-controlplane-02.maas  
ws04-30-cnc-controlplane-03.maas  
ws04-31-cnc-worker-01.maas 10.0.22.170
ws04-32-cnc-worker-02.maas 10.0.22.171
ws04-33-cnc-worker-03.maas 10.0.22.146

ws05-34-cnc-controlplane-01.maas 10.0.22.149
ws05-35-cnc-controlplane-02.maas  
ws05-36-cnc-controlplane-03.maas 10.0.22.191
ws05-37-cnc-worker-01.maas 10.0.22.174
ws05-38-cnc-worker-02.maas 10.0.22.172
ws05-39-cnc-worker-03.maas 10.0.22.173

ws06-40-cnc-controlplane-01.maas 10.0.22.152
ws06-41-cnc-controlplane-02.maas 10.0.22.193
ws06-42-cnc-controlplane-03.maas 10.0.22.197
ws06-43-cnc-worker-01.maas 10.0.22.176
ws06-44-cnc-worker-02.maas 10.0.22.177
ws06-45-cnc-worker-03.maas 10.0.22.175

ws07-46-cnc-controlplane-01.maas 10.0.22.147
ws07-47-cnc-controlplane-02.maas 10.0.22.194
ws07-48-cnc-controlplane-03.maas 10.0.22.248
ws07-49-cnc-worker-01.maas 10.0.22.178
ws07-50-cnc-worker-02.maas 10.0.22.180
ws07-51-cnc-worker-03.maas 10.0.22.179

ws08-52-cnc-controlplane-01.maas 10.0.22.140
ws08-53-cnc-controlplane-02.maas 10.0.22.198
ws08-54-cnc-controlplane-03.maas 10.0.22.199
ws08-55-cnc-worker-01.maas 10.0.22.113
ws08-56-cnc-worker-02.maas 10.0.22.181
ws08-57-cnc-worker-03.maas 10.0.22.182

ws09-58-cnc-controlplane-01.maas 10.0.22.22
ws09-59-cnc-controlplane-02.maas 10.0.22.206
ws09-60-cnc-controlplane-03.maas 10.0.22.220
ws09-61-cnc-worker-01.maas 10.0.22.183
ws09-62-cnc-worker-02.maas 10.0.22.141
ws09-63-cnc-worker-03.maas 10.0.22.131

ws10-64-cnc-controlplane-01.maas 10.0.22.21
ws10-65-cnc-controlplane-02.maas 10.0.22.202
ws10-66-cnc-controlplane-03.maas 10.0.22.207
ws10-67-cnc-worker-01.maas 10.0.22.135
ws10-68-cnc-worker-02.maas 10.0.22.137
ws10-69-cnc-worker-03.maas 10.0.22.133

ws11-70-cnc-controlplane-01.maas 10.0.22.2
ws11-71-cnc-controlplane-02.maas 10.0.22.222
ws11-72-cnc-controlplane-03.maas 10.0.22.243
ws11-73-cnc-worker-01.maas 10.0.22.138
ws11-74-cnc-worker-02.maas 10.0.22.142
ws11-75-cnc-worker-03.maas 10.0.22.139

ws12-76-cnc-controlplane-01.maas 10.0.22.156
ws12-77-cnc-controlplane-02.maas 10.0.22.242
ws12-78-cnc-controlplane-03.maas 10.0.22.250
ws12-79-cnc-worker-01.maas 10.0.22.144
ws12-80-cnc-worker-02.maas 10.0.22.143
ws12-81-cnc-worker-03.maas 10.0.22.148
```

Notiert euch eure Hostnamen und IPs.

# Aufgabe 1

Entfernt microk8s von euren Maschinen:

```shell
sudo snap remove microk8s
```

Bei Fehlern meldet euch, ihr seid vermutlich nicht die einzigen. 


# Aufgabe 2

Installiert k0s auf eurem Cluster. Wie? Verwendet k0sctl: 

https://docs.k0sproject.io/stable/k0sctl-install/

## Teilaufgabe 2.1

K0sctl installieren: https://docs.k0sproject.io/stable/k0sctl-install/#install-k0s

Tipp: k0sctl muss auf eurem Laptop installiert werden, nicht auf den servern. 

## Teilaufgabe 2.2

Eure Konfiguration erstellen. In der Anleitung zeigen sie einen anderen Weg. Ich ueberlasse euch die Wahl. 

Legt auf eurem Laptop eine Datei namens `k0sctl.yaml` an. 

Ihr koennt dieses hier als Beispiel nehmen und fuer eure Maschinen anpassen:

```yaml
apiVersion: k0sctl.k0sproject.io/v1beta1
kind: Cluster
metadata:
  name: mein-lieblings-cluster
spec:
  hosts:
  - ssh:
      address: 10.0.0.1  <-- bitte anpassen!
      user: ubuntu
      port: 22
      keyPath: pfad/zu/meinem/ssh-key
    role: controller
  - ssh:
      address: 10.0.0.2  <-- bitte anpassen!
      user: ubuntu
      port: 22
      keyPath: pfad/zu/meinem/ssh-key
    role: worker
  - ssh:
      address: 10.0.0.3  <-- bitte anpassen!
      user: ubuntu
      port: 22
      keyPath: pfad/zu/meinem/ssh-key
    role: worker
  - ssh:
      address: 10.0.0.3  <-- bitte anpassen!
      user: ubuntu
      port: 22
      keyPath: pfad/zu/meinem/ssh-key
    role: worker
```

## Teilaufgabe 2.3

Mit k0sctl die Konfiguration ausrollen:

https://docs.k0sproject.io/stable/k0sctl-install/#3-deploy-the-cluster


# Aufgabe 3

Ingress installieren. 

Siehe https://docs.k0sproject.io/stable/examples/nginx-ingress/
 
```shell
kubectl apply -f "https://raw.githubusercontent.com/pstark-code/kubernetes-homelab/refs/heads/main/04-neuer-cluster/resourcen/ingress-controller-with-hostnetwork.yaml"
kubectl label nodes wsXY-YZ-cnc-worker-01 ingress="true"
```

Aufgabe 
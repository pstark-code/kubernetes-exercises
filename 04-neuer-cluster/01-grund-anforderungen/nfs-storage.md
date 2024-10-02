# NFS Storage Provisionierer

Helm Chart Readme für Neugierige: https://github.com/kubernetes-csi/csi-driver-nfs/blob/master/charts/README.md

## Installieren mit Helm

```shell
helm repo add csi-driver-nfs https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/charts
helm repo update
helm upgrade --install --namespace "kube-system" csi-driver-nfs csi-driver-nfs/csi-driver-nfs --set kubeletDir=/var/lib/k0s/kubelet
```

## StorageClass installieren

Wenn das läuft, diese StorageClass mit `kubectl apply -f` deployen:

Achtung: Das `$CLUSTER` noch mit eurem clusternamen ersetzen (z.b. "ws01")

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: "nfs-storage"
provisioner: nfs.csi.k8s.io
parameters:
  server: "10.0.22.8"
  share: "/data/storage/$CLUSTER"
reclaimPolicy: Delete
volumeBindingMode: Immediate
mountOptions:
  - hard
  - nfsvers=4.1
```

## Testen

Mit diesem PVC könnt ihr ausprobieren ob es geklappt hat. Per `kubectl apply -f` auf eurem Cluster ausrollen und dann mit kubectl describe bei den Events schauen ob es erfolgreich provisioniert wurde.


```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-persistent-data
  namespace: default
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 100Mi
  storageClassName: nfs-storage
```

Gratulation! Du hast erfolgreich Persistent Storage zu deinem Cluster hinzugefügt! 


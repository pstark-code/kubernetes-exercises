# Certificate Manager

[**Installation**](https://cert-manager.io/docs/installation/kubectl/)<br>
[**Docs**](https://cert-manager.io/docs/configuration/)<br>
[**Github**](https://github.com/cert-manager/cert-manager/)<br>
[**Tutorial für Nginx-Ingress**](https://cert-manager.io/docs/tutorials/acme/nginx-ingress/)

Mit dem cert-manager könnt ihr automatisch Zertifikate von "acme"-Providern wie **LetsEncrypt** signieren lassen. 

Leider klappt das nur wenn euer Ingress aus dem Internet erreichbar ist. Damit verifiziert LetsEncrypt dann ob diese Domäne wirklich zu diesem Cluster gehört. 

Auf internen Clustern kann cert-manager auch verwendet werden um automatisch Zertifikate zu generieren, die von der Firmen-internen Zertifikatsauthorität signiert sind.

Folgt der verlinkten Doku, wenn ihr es trotzdem gerne ausprobieren möchtet.


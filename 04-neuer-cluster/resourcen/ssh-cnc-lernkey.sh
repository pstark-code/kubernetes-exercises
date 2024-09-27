# for i in $(cnc/list-all-nodes.sh | grep -E "(cnc-worker|cnc-controlplane-01)" ); do printf "Host %s\n  HostName %s
#   User ubuntu\n  IdentityFile ~/.ssh/cnc-lernkey\n\n" "${i}" "$i" ; done
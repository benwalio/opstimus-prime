## 0.1.0 (2025-02-10)

### 💥 Boom

- **kprom**: turning off >>> ⏰ 1h

### ✨ Features

- **sys-upgrade**: init release
- **kromgo**: initial release

### 🐛🚑️ Fixes

- **prom**: pikvm node exporter port default
- **kprom**: back on >>> ⏰ 2m
- **prom-pvc**: moved from nfs to cepd

### ♻️ Refactorings

- **template**: tidied

### build

- **cz**: added version file ref
- **cz**: install conventional gitmoji
- **rennovate**: added tz

### chore

- **mise**: upgrade dependencies
- **mise**: upgrade dependencies
- **config**: migrate config .github/renovate.json5

### feat

- **container**: update app-template ( 3.6.1 → 3.7.0 )
- **container**: update app-template ( 3.6.1 → 3.7.0 )
- **minio**: gatus off
- **alertman**: hb url to uptimekuma
- **arc**: init release
- **idp**: activating
- **intel-dev**: plugin init release
- **atuin**: on
- **cnpg**: on
- **minio**: back on
- **gatus**: on
- **rook**: init release
- **pf**: off
- **nfd**: on
- **pinchflat**: rook ns
- **pinchflat**: init release
- **unpoller**: init release
- **atuin**: volsync
- **promtail**: init release
- **grafana**: init release
- **loki**: on
- **cnpg**: back on
- **container**: update ghcr.io/kiwigrid/k8s-sidecar ( 1.29.1 → 1.30.0 )
- **helm**: update tailscale-operator ( 1.78.3 → 1.80.0 )
- **container**: Update kube-prometheus-stack ( 68.3.2 → 69.2.0 )
- **gatus**: init release
- **ebs**: changed path mount to var
- **kpom**: init release
- **tailscale**: init release
- **cnpg**: init release
- **mini**: init release
- **csi-nfs**: init release
- **openebs**: init releaser
- **rook**: ingress off
- **container**: update docker.io/cloudflare/cloudflared ( 2025.1.1 → 2025.2.0 )
- **container**: update docker.io/cloudflare/cloudflared ( 2025.1.1 → 2025.2.0 )
- **container**: update external-secrets ( 0.13.0 → 0.14.0 )
- **container**: update external-secrets ( 0.13.0 → 0.14.0 )
- **helm**: update cilium ( 1.16.6 → 1.17.0 )
- **helm**: update cilium ( 1.16.6 → 1.17.0 )
- **container**: Update prometheus-operator-crds ( 17.0.2 → 18.0.0 )
- **container**: Update prometheus-operator-crds ( 17.0.2 → 18.0.0 )
- **rook**: dash
- **rook-haproxy**: init release
- **rook**: added mon sec
- **rook**: added admin sec
- **snapshot**: added ss controller
- **rook-ceph**: lighting the candle
- **le**: moving to prod
- **kube-ns**: moved to flux ns
- **atuin**: init release
- **flux**: adding new repos
- **op**: added onepass
- **taskfile**: added flux tasks

### fix

- **precommit**: set cz branch precommit to manual
- **rollout**: complete
- **talxonfig**: updated
- **talos**: bm metrics
- **ggshield**: added
- **container**: update external-secrets ( 0.14.0 → 0.14.1 )
- **container**: update external-secrets ( 0.14.0 → 0.14.1 )
- **pinchflat**: volsync on
- **settings**: updated
- **silentop**: init release
- **alertman**: sec ref
- **arc**: config url
- **arc**: dir spec and op ns
- **rennovate**: updated file for prettier
- **pf**: off
- **pf**: nfs filled folder
- **pf**: off
- **pf**: fix fook ns
- **volsync**: off for default
- **obs**: back on
- **comp-common**: ghub off until es
- **talos**: reconfig
- **rook**: ceph off
- **storage**: cnpg off
- **storage**: vol minio off
- **obs**: turning off
- **prep**: turning off in prep for talos metal migration
- **pf**: on
- **pf**: off
- **pf**: pvc on
- **pf**: nodeselect off
- **pinch**: pvc off
- **pinchflat**: volsync ns
- **atuin**: volsync comp
- **volsync**: repo name
- **volsync**: changed to 11
- **volsync**: init release
- **minio**: on
- **csi-nfs**: on
- **nfs-csi-minio**: off
- **comps**: ghub alert on
- **settings**: moved to comps
- **comp-common**: ghub off
- **certman**: dep of off
- **certman**: dep op off
- **exsec**: back on
- **exsec**: off
- **exsec**: gitrepo ns
- **haproxy**: ns
- **observe**: remove ns
- **sops**: filename
- **flux**: turning off alerts for now
- **components**: moving to knets dir
- **component-alerts**: turning back from common
- **common**: moving to flux ns
- **component-alert-ghub**: turned off
- **components**: moving around
- **es**: filename
- **component**: def and api
- **flux**: moving around defs and components
- **atuin**: pg-init 17 repo
- **atuin**: turning on
- **cnpg**: back on
- **cnpg**: off
- **openebs**: applied kubelet patch
- **container**: update ghcr.io/kiwigrid/k8s-sidecar ( 1.29.0 → 1.29.1 )
- **gatus**: tryin out env subbing
- **gatus**: config
- **ingresses**: tidying
- **gatus**: remove tls
- **edns**: tidying
- **gatus**: edns-target
- **gatus**: on
- **gatus**: off
- **gatus**: pvc typo
- **cnpg**: off
- **cnpg**: updating reqs
- **cnpg**: helm repo
- **minio**: chart ref
- **openeb**: fixed swapped ns
- **rook**: object store
- **container**: update quay.io/ceph/ceph ( v19.2.0 → v19.2.1 )
- **container**: update quay.io/ceph/ceph ( v19.2.0 → v19.2.1 )
- **rook**: ingress fiddling
- **haproxy**: dir miss
- **rook**: es cluster name
- **certman**: git ref
- **deps**: added deps to cloudflared
- **atuin**: turning off for now
- **echo**: moved deps to ks
- **settings**: updated api version
- **sops-age**: readded to settings
- **settings**: added cust
- **sops**: removing more sops refs
- **component**: removed sops ref
- **subs**: added optional flag
- **flux**: removed age sops
- **sops**: added ns flux
- **sops-age**: moved to flux
- **sops-age**: added to settings
- **depends**: fixed ns refs
- **kust**: added sops age to most
- **age**: added to kube ns
- **deps**: updated exdns ns
- **ns**: more ns moving
- **ns**: moving namespaces
- **settings**: moving settings to meta dir
- **ns-default**: updated to flux
- **security**: toggling back on
- **security**: toggling off
- **op**: token verifying it's correct
- **op**: changed creds to b64
- **op**: updated secret again
- **op-store**: added secret token
- **repo**: moved to flux meta
- **exsec**: updated kust order
- **op-store**: added dep for exsec
- **extsec**: added repo
- **certman**: moved ns to flux for ks
- **talos**: init
- **init**: commit

### refactor

- **precommit**: changed cz rev
- **taskfile**: adding in sops and gg
- **rook-external**: removed
- **ns**: big ns moves

### ⏪️ Reversions

- **scrape**: went back to port

### 💚👷 CI & Build

- **taskfile**: tried adding flux reboot
- **workflows**: added rennovate flow

### 📝💡 Documentation

- **readme**: updated talos badges
- **readme**: added kromgo badges >>> ⏰ 4m
- **readme**: stole a placeholder readme >>> ⏰ 2m

### 🩹 fix-simple

- **cz-env**: added gitmoji fix >>> ⏰ 10m

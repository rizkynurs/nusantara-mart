# NusantaraMart K8s Repo

## Cara Deploy (ringkas)
1. `kubectl apply -f k8s/namespaces/retail.yaml`
2. `kubectl apply -f k8s/gateways/istio-gw.yaml`
3. Untuk setiap service: apply DR, VS, Rollout → Helm chart (service) → KEDA ScaledObject
4. Gunakan `charts/*/values-{bdg|sby|jkt}.yaml` untuk override per cluster:
   ```bash
   helm upgrade --install order charts/order -n retail -f charts/order/values-bdg.yaml
   ```

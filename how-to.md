# NusantaraMart K8s Repo

## Cara Deploy (ringkas)
1. `kubectl apply -f k8s/namespaces/retail.yaml`
2. `kubectl apply -f k8s/gateways/istio-gw.yaml`
3. Untuk setiap service: apply DR, VS, Rollout → Helm chart (service) → KEDA ScaledObject
4. Gunakan `charts/*/values-{bdg|sby|jkt}.yaml` untuk override per cluster:
   ```bash
   helm upgrade --install order charts/order -n retail -f charts/order/values-bdg.yaml
   ```

Menambahkan secrets GCP_SA_JSON di GitHub Actions

## 1. Buat Service Account di GCP
1. Buka **Google Cloud Console → IAM & Admin → Service Accounts → Create Service Account**.  
2. Beri nama, misalnya `gh-actions-deploy`.  
3. Tambahkan **roles** minimal:
   - `roles/container.admin` (untuk akses GKE)
   - `roles/artifactregistry.reader` (jika perlu menarik image dari Artifact Registry)
   - (Opsional) `roles/logging.viewer`

## 2. Generate Key JSON
1. Masuk ke Service Account → tab **Keys** → **Add Key** → pilih **JSON**.  
2. Download file JSON (misalnya `gh-actions.json`).  
3. Simpan file ini di lokal (akan dipaste ke GitHub Secrets).

## 3. Tambahkan ke GitHub Secrets
1. Masuk ke **GitHub Repo → Settings → Secrets and variables → Actions → New repository secret**.  
2. Isi:
   - **Name**: `GCP_SA_JSON`
   - **Value**: paste isi penuh dari file JSON (bukan path).  
3. Simpan.

(Opsional) Tambahkan juga:
- `GCP_PROJECT_ID` → ID project GCP kamu
- `ARTIFACT_REPO` → lokasi Artifact Registry, contoh: `asia-docker.pkg.dev/<project>/nusmart`

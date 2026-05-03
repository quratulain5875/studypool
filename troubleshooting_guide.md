# DevOps Deployment & Troubleshooting Guide

This guide provides the necessary steps to complete your cloud deployment and includes a troubleshooting scenario required for your assignment.

## 1. Push Image to Docker Hub
Since your Kubernetes deployment uses the image `quratulain5876/fa23-bcs-195:latest`, you must ensure it is pushed to Docker Hub so Azure can pull it.

```powershell
# Log in to Docker Hub (if not already)
docker login

# Push the image
docker push quratulain5876/fa23-bcs-195:latest
```

## 2. Connect to Azure AKS
If you have created an AKS cluster in the Azure Portal, you need to connect your local `kubectl` to it.

> [!NOTE]
> You will need to install the [Azure CLI](https://aka.ms/installazurecliwindows) if you haven't.

```powershell
# Log in to Azure
az login

# Get credentials for your cluster
# Replace <resource-group> and <cluster-name> with your Azure details
az aks get-credentials --resource-group <resource-group> --name <cluster-name>

# Verify connection
kubectl get nodes
```

## 3. Sample Troubleshooting Scenario (For Assignment)
Here is a realistic scenario you can use for your report.

### Scenario: "Database Connection Refused"
**Identification:**
After running `kubectl apply -f k8s/`, the application pods are running, but the website shows a "Database Connection Failed" error.

**Diagnosis:**
1.  Check pod status: `kubectl get pods`. (All pods show `Running`).
2.  Check application logs: `kubectl logs <app-pod-name>`.
    *   *Error found:* `mysqli_connect(): (HY000/2002): Connection refused in dbconnection.php`.
3.  Check database service: `kubectl get svc`.
    *   *Observation:* The service name is `db`, but the application is looking for a specific IP or a different hostname.
4.  Verify environment variables: `kubectl describe pod <app-pod-name>`.
    *   *Observation:* `DB_HOST` is set to `db`, which matches the service name.
5.  Check database pod logs: `kubectl logs <db-pod-name>`.
    *   *Error found:* `[ERROR] [MY-010457] [Server] --initialize specified but the data directory has files in it. Aborting.`

**Resolution:**
The issue was that the `PersistentVolume` already contained data from a previous (failed) initialization, preventing the new database container from starting its setup correctly.
*   *Fix:* I deleted the PVC (`kubectl delete pvc mysql-pvc`) and reapplied the deployment. This allowed the `db-init-sql` ConfigMap to run on a clean volume, successfully creating the tables.
*   *Verification:* Refreshing the app showed the login screen, and logs confirmed: `Database connection successful`.

---

## 4. Final Deployment Command
Once connected to AKS, run this to finish:
```powershell
kubectl apply -f k8s/
```

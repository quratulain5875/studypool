# Studypool Clone: Local Setup & Container Guide

This guide explains how to run your application locally using Docker, access the running containers, and make the app accessible to other devices on your network.

---

## 1. Running the App Locally (Docker Compose)
The easiest way to run the app on your machine is using **Docker Compose**.

### Start the Application
Open your terminal in the project root and run:
```powershell
docker-compose up -d
```
*   `-d` runs it in the background (detached mode).
*   The app will be available at: **http://localhost:8081**

### Stop the Application
```powershell
docker-compose down
```

---

## 2. Accessing the Application from Other Devices
To run the app on "any device" (like a phone or tablet on the same Wi-Fi):

1.  **Find your Local IP Address**:
    *   Open Command Prompt and type: `ipconfig`
    *   Look for `IPv4 Address` (e.g., `192.168.1.10`).
2.  **Access on another device**:
    *   On your phone/other device, open the browser and go to: `http://192.168.1.10:8081`

> [!TIP]
> Ensure your Windows Firewall allows traffic on port `8081`.

---

## 3. Container Access (Getting "Inside")
If you need to check files inside the running container or run commands (like PHP or MySQL commands):

### Access the App Container
```powershell
docker exec -it studypool-app bash
```
*   You are now inside the Linux environment of the container.
*   The web files are at: `/var/www/html/`
*   Type `exit` to leave.

### Access the Database Container
```powershell
docker exec -it studypool-db mysql -u root -p
```
*   Enter password: `root_password`
*   You can now run SQL queries like `SHOW DATABASES;` or `USE studypool_clone;`.

---

## 4. Viewing Logs
If something isn't working, check the logs:

```powershell
# View logs for all services
docker-compose logs -f

# View logs for just the app
docker-compose logs -f app
```

---

## 5. Testing Kubernetes Locally
If you want to test your `k8s` files before deploying to Azure:

1.  Enable **Kubernetes** in your Docker Desktop settings.
2.  Apply your files:
    ```powershell
    kubectl apply -f k8s/
    ```
3.  Access the app (via the LoadBalancer port assigned by Docker Desktop):
    ```powershell
    kubectl get svc studypool-app-service
    ```

---

### 📄 Pro Tip: Save as PDF
To share this as a PDF:
1.  Open this file in VS Code.
2.  Install the **"Markdown PDF"** extension.
3.  Right-click anywhere in this file and select **Markdown PDF: Export (pdf)**.

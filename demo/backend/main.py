from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from datetime import datetime

app = FastAPI(title="Platform Academy API", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

SERVICES = [
    {
        "name": "Container Registry",
        "description": "Azure Container Registry for storing Docker images",
        "status": "active",
    },
    {
        "name": "CI/CD Pipeline",
        "description": "GitHub Actions pipeline for automated builds and deployments",
        "status": "active",
    },
    {
        "name": "Infrastructure as Code",
        "description": "Terraform modules for provisioning Azure resources",
        "status": "active",
    },
    {
        "name": "Monitoring",
        "description": "Observability stack for metrics, logs, and traces",
        "status": "pending",
    },
]


@app.get("/health")
def health():
    return {
        "status": "healthy",
        "service": "backend-api",
        "timestamp": datetime.now().isoformat(),
    }


@app.get("/api/services")
def get_services():
    return SERVICES


@app.get("/api/services/{service_id}")
def get_service(service_id: int):
    if 0 <= service_id < len(SERVICES):
        return SERVICES[service_id]
    return {"error": "Service not found"}

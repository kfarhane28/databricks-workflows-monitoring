import json
import os
from collections import defaultdict
from databricks.sdk import WorkspaceClient
import logging
import http.client


# Activer les logs détaillés
#ogging.basicConfig(level=logging.DEBUG)

# Activer les logs pour les connexions HTTP (utile pour voir les requêtes sortantes)
#http.client.HTTPConnection.debuglevel = 1

# Activer le mode debug pour le SDK Databricks
#os.environ["DATABRICKS_DEBUG"] = "true"
#os.environ["DATABRICKS_SDK_LOG_LEVEL"] = "DEBUG"

# 🔹 Récupération des credentials Azure depuis les variables d'environnement
DATABRICKS_WORKSPACE_URL = os.getenv("DATABRICKS_WORKSPACE_URL")  # Ex: "https://adb-xxxxxxxxxxxx.azuredatabricks.net"
ARM_CLIENT_ID = os.getenv("ARM_CLIENT_ID")
ARM_CLIENT_SECRET = os.getenv("ARM_CLIENT_SECRET")
ARM_TENANT_ID = os.getenv("ARM_TENANT_ID")

OUTPUT_FILE = os.getenv("OUTPUT_FILE", "jobs_par_code_appli.json")

if not all([DATABRICKS_WORKSPACE_URL, ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID]):
    raise ValueError("❌ Les variables d'environnement pour l'authentification Azure ne sont pas définies.")

# 🚀 Connexion au workspace Databricks avec OAuth (via Service Principal)
w = WorkspaceClient(
    host=DATABRICKS_WORKSPACE_URL,
    azure_tenant_id=ARM_TENANT_ID,
    azure_client_id=ARM_CLIENT_ID,
    azure_client_secret=ARM_CLIENT_SECRET
)

# Step 1: Get the list of all jobs
try:
    jobs_generator = w.jobs.list()  # ✅ Renvoie un générateur
    jobs = list(jobs_generator)  # ✅ Convertir en liste
except Exception as e:
    print(f"❌ Error retrieving jobs: {e}")
    exit(1)

# Step 2: Group jobs by code_appli and consigne
jobs_grouped = defaultdict(lambda: defaultdict(list))

for job in jobs:
    job_id = job.job_id  # ✅ Accès correct au job_id
    settings = job.settings if job.settings else {}  # ✅ Vérifie que settings existe
    tags = settings.tags if settings and settings.tags else {}  # ✅ Vérifie que tags existe

    code_appli = tags.get("code_appli")
    consigne = tags.get("consigne") or None  # If no consigne, set to None

    if code_appli:
        jobs_grouped[code_appli][consigne].append(job_id)

# Convert to formatted JSON
output_json = json.dumps(jobs_grouped, indent=4)

# Step 3: Write the JSON to the file
try:
    with open(OUTPUT_FILE, "w") as f:
        f.write(output_json)
    print(f"✅ JSON file generated successfully: {OUTPUT_FILE}")
except IOError as e:
    print(f"❌ Error writing to file: {e}")

# Print JSON content to stdout
print(output_json)
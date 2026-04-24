# 🚀 Simulated Cloud Migration (AWS + Terraform)

## 📌 Description
This project demonstrates an end-to-end migration from on-premise to AWS using Terraform. It implements rehost (EC2) and replatform (RDS) strategies with real-time data replication using AWS DMS (full load + CDC).

---

## 🧰 Tech Stack
- AWS (EC2, RDS, DMS, S3, CloudWatch, CloudTrail)
- Terraform
- MySQL (Docker)

---

## 🏗️ Architecture
See [architecture.md](architecture.md)

---

## ⚙️ Setup

```bash
cd env/dev
terraform init
terraform apply

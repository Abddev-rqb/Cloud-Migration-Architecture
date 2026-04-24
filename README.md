# 🚀 Simulated Cloud Migration (AWS + Terraform)

## 📌 Overview
This project implements an end-to-end migration from a simulated on-prem environment to AWS using Terraform. It demonstrates rehost (EC2) and replatform (RDS) strategies, with real-time data replication via AWS DMS (full load + CDC) to achieve near-zero downtime.

---

## 🧠 What This Project Gets Right

- **End-to-End Migration Flow**: Source (EC2 MySQL) → DMS → Target (RDS)
- **Near-Zero Downtime**: Implemented CDC using MySQL binlog + DMS
- **Production-Aligned Networking**:
  - VPC with public/private subnets across AZs
  - RDS isolated in private subnet
- **Modular Terraform Design**:
  - Clear separation of network, compute, database, DMS, storage, monitoring
- **Security Awareness**:
  - SG-based access control (no public DB exposure)
  - IAM role for DMS VPC integration
- **Audit & Observability**:
  - CloudTrail → S3 for API auditing
  - CloudWatch for operational visibility

---

## ⚠️ Known Limitations (Intentional Trade-offs)

This is a **simulation**, not a full enterprise deployment:

- ❌ No real Site-to-Site VPN (on-prem simulated via EC2)
- ❌ No secrets management (credentials hardcoded for simplicity)
- ❌ No CI/CD pipeline for Terraform
- ❌ No auto-scaling or load balancing
- ❌ No alerting (CloudWatch alarms not configured)
- ❌ No encryption policies (KMS not enforced)

---

## 🏗️ Architecture Flow


On-Prem (Simulated - EC2 MySQL)
│
│ (Full Load + CDC via DMS)
▼
AWS DMS Replication Instance
│
▼
Amazon RDS (MySQL - Private Subnet)


---

## 🔍 Key Engineering Decisions

- **Simulated Hybrid Setup**  
  Avoided real VPN to reduce setup complexity and focus on migration logic.

- **Private RDS Deployment**  
  Enforced internal-only access to reflect real production security patterns.

- **Binlog-Based CDC**  
  Explicitly enabled MySQL binlog (`ROW` format + `server-id`) to support continuous replication.

- **Module Isolation**  
  Separated storage and monitoring to avoid tightly coupled infrastructure.

---

## 📦 Tech Stack

- AWS: EC2, RDS, DMS, S3, CloudWatch, CloudTrail
- Terraform (modular IaC)
- MySQL (Docker-based source DB)

---

## ✅ Outcome

- Successfully migrated structured data using DMS (full load + CDC)
- Verified live replication from source to target
- Built a modular, reproducible cloud migration environment
- Demonstrated practical understanding of migration constraints and trade-offs

---

## 🚀 Future Improvements

- Integrate AWS Secrets Manager for credential handling
- Add CloudWatch alarms + dashboards
- Implement CI/CD pipeline for Terraform (GitHub Actions)
- Introduce multi-AZ / failover strategy
- Replace simulated on-prem with real hybrid (VPN/Direct Connect)
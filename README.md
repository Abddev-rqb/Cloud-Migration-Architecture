# Simulated Cloud Migration (AWS + Terraform)

## Description
This project demonstrates an end-to-end migration from on-premise to AWS using Terraform. It implements rehost (EC2) and replatform (RDS) strategies with real-time data replication using AWS DMS (full load + CDC).

---

## Tech Stack
- AWS (EC2, RDS, DMS, S3, CloudWatch, CloudTrail)
- Terraform
- MySQL (Docker)

---

## Architecture Flow


On-Prem (Simulated - EC2 MySQL)
│
│ (CDC via AWS DMS)
▼
AWS DMS Replication Instance
│
▼
Amazon RDS (MySQL - Private Subnet)


---

## Components

### 1. On-Prem Simulation
- EC2 instance running MySQL in Docker
- Binary logging enabled for CDC

### 2. Networking
- Custom VPC
- Public + Private subnets across multiple AZs
- Internet Gateway + routing

### 3. Compute (Rehost)
- EC2 instance representing application layer

### 4. Database (Replatform)
- Amazon RDS MySQL in private subnet
- Secure access via security groups

### 5. Data Migration
- AWS DMS with:
  - Full Load
  - Change Data Capture (CDC)
- Near-zero downtime migration

### 6. Security
- Least-privilege security groups
- IAM role for DMS VPC access

### 7. Observability & Audit
- CloudWatch (log groups)
- CloudTrail (API audit logs)
- S3 (centralized log storage)

---

## Key Design Decisions

- Hybrid architecture simulated within VPC (no real VPN)
- Private RDS (not publicly accessible)
- Modular Terraform structure for scalability
- Separation of storage and monitoring concerns

---

## Terraform Modules

- network
- security
- compute
- database
- dms
- storage
- monitoring

---

## Outcome

- Successfully migrated data from source (EC2 MySQL) to target (RDS)
- Verified replication using CDC
- Implemented secure, observable, and modular cloud architecture

---

## Future Improvements

- Add CloudWatch alarms & dashboards
- Implement CI/CD pipeline for Terraform
- Add multi-region failover
- Replace simulation with real hybrid VPN

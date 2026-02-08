# Private EKS with Internal Application (Terraform + Kubernetes)

---

## 1. Project Summary

This project demonstrates the design and deployment of a **secure, private Amazon EKS cluster** using **Terraform**, running an **internal application stack (HAProxy + Tomcat)** without exposing any public endpoints.

The focus is on:
- Security-first design  
- Controlled access  
- Production-style Kubernetes architecture  

🎥 **Loom Walkthrough Video**  
https://www.loom.com/share/4bd95cbdf6e24fe7bac61065a9ed60bc

---

## 2. Design Approach

The solution was designed with the following principles:

1. **Private by default**
   - No public EKS API endpoint
   - No public IPs on worker nodes

2. **Infrastructure as Code**
   - Entire infrastructure provisioned using Terraform
   - No manual AWS console configuration

3. **Clear access boundaries**
   - Admin access separated from node access
   - Application access isolated inside the cluster

4. **Internal-only applications**
   - HAProxy and Tomcat exposed using `ClusterIP` services only

This approach aligns with real **production Kubernetes environments**.

---

## 3. Architecture Overview

<img width="1536" height="1024" alt="ascendo-assessment-arch-diagram" src="https://github.com/user-attachments/assets/850c2484-aeb9-47ec-90b4-81ea75b5505d" />

### Key Architecture Decisions
- Custom AWS VPC with private subnets across two AZs
- Amazon EKS with private API endpoint only
- Worker nodes with no public IP addresses
- Dedicated Admin EC2 (same VPC) used as a control node
- AWS SSM used instead of SSH for node access
- HAProxy and Tomcat exposed via ClusterIP services

---

## 4. Infrastructure Provisioning (Terraform)

Terraform is used to provision all AWS infrastructure in a reproducible manner.

### Resources Created
- VPC, private subnets, and route tables
- NAT Gateway for outbound internet access
- Amazon EKS cluster (private endpoint)
- Managed node group
- IAM roles for:
  - EKS control plane
  - Worker nodes
  - AWS Systems Manager (SSM)

### Terraform Folder Structure
<img width="705" height="466" alt="Screenshot 2026-02-08 005750" src="https://github.com/user-attachments/assets/b1b208db-1a51-4f66-92a1-5d78ee643d92" />

### Terraform Apply Output
<img width="1132" height="755" alt="Screenshot 2026-02-08 000857" src="https://github.com/user-attachments/assets/549468fb-3eab-4d38-8d74-d9d9d8c658c9" />

### Worker Nodes (Private IP Only)
<img width="1869" height="803" alt="Screenshot 2026-02-08 010124" src="https://github.com/user-attachments/assets/d0c95631-0d75-4d80-8ef0-cc72c8743645" />

---

## 5. Kubernetes Application Deployment

### 5.1 Backend – Tomcat
- Deployed using a Kubernetes Deployment
- 2 replicas for high availability
- Exposed internally using a ClusterIP service

### 5.2 Frontend – HAProxy
- Deployed as an internal load balancer
- Routes traffic to the Tomcat service
- Configuration managed using a ConfigMap
- Exposed internally using a ClusterIP service

<img width="1144" height="479" alt="Screenshot 2026-02-07 235423" src="https://github.com/user-attachments/assets/5422fd51-0334-4e66-b9e7-6d813e1888a7" />

---

## 6. Application Access Flow (Internal Only)

Since the application is internal, access is validated from within the cluster.

### Traffic Flow

---bash
Client Pod
↓
HAProxy Service
↓
HAProxy Pod
↓
Tomcat Service
↓
Tomcat Pods (round-robin)
---

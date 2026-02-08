****Private EKS with Internal Application (Terraform + Kubernetes)****

***Project Summary***

This project demonstrates how to design and deploy a secure, private Amazon EKS cluster using Terraform, and run an internal application stack (HAProxy + Tomcat) without exposing any public endpoints.
The focus is on security, controlled access, and production-style architecture, not public demos.

***Loom Video*** :: https://www.loom.com/share/4bd95cbdf6e24fe7bac61065a9ed60bc

***Design Approach***

Instead of making everything publicly accessible, I followed these principles:

Private by default – No public EKS API, no public worker nodes

Infrastructure as Code – Everything created using Terraform

Clear access boundaries – Separate admin access, node access, and app access

Internal-only applications – Services exposed only inside the cluster

This matches how real production Kubernetes environments are designed.

***Architecture Diagram***

<img width="1536" height="1024" alt="ascendo-assessment-arch-diagram" src="https://github.com/user-attachments/assets/850c2484-aeb9-47ec-90b4-81ea75b5505d" />

*Key Points from the Architecture*

Custom AWS VPC with private subnets across two AZs

Amazon EKS with private API endpoint only

Worker nodes with no public IPs

Admin EC2 (same VPC) used as a control node

AWS SSM used instead of SSH

HAProxy and Tomcat exposed via ClusterIP services

**Infrastructure Provisioning (Terraform)**

What Terraform Creates

VPC, subnets, route tables

NAT Gateway for outbound access

EKS cluster (private endpoint)

Managed node group

IAM roles for:

EKS control plane

Worker nodes

SSM access

folder structure

<img width="705" height="466" alt="Screenshot 2026-02-08 005750" src="https://github.com/user-attachments/assets/b1b208db-1a51-4f66-92a1-5d78ee643d92" />

terraform apply 

<img width="1132" height="755" alt="Screenshot 2026-02-08 000857" src="https://github.com/user-attachments/assets/549468fb-3eab-4d38-8d74-d9d9d8c658c9" />

nodes created with private ip only

<img width="1869" height="803" alt="Screenshot 2026-02-08 010124" src="https://github.com/user-attachments/assets/d0c95631-0d75-4d80-8ef0-cc72c8743645" />


**Kubernetes Application Deployment**

*Backend – Tomcat*

Deployed using a Kubernetes Deployment

2 replicas for availability

Exposed internally using ClusterIP

*Frontend – HAProxy*

Deployed as an internal load balancer

Routes traffic to Tomcat service

Configuration managed using ConfigMap

Exposed internally using ClusterIP

<img width="1144" height="479" alt="Screenshot 2026-02-07 235423" src="https://github.com/user-attachments/assets/5422fd51-0334-4e66-b9e7-6d813e1888a7" />

**Application Access Flow**

curl pod
   ↓
   
haproxy-service
   ↓
   
HAProxy pod
   ↓
   
tomcat-service
   ↓
   
Tomcat pods (round-robin)


<img width="1891" height="429" alt="Screenshot 2026-02-08 000946" src="https://github.com/user-attachments/assets/57e42d66-7bdf-4608-9f25-2eff2e7e6e87" />


**Secure Access & Operations**

*Admin Access*

A dedicated Admin EC2 in the same VPC is used to:

Run Terraform

Run kubectl

This avoids exposing the EKS API publicly

*Node Access (No SSH)*

Worker nodes are accessed using AWS Systems Manager (SSM)

No port 22

No SSH keys

IAM-based and audited access

console output

<img width="1858" height="778" alt="Screenshot 2026-02-08 000015" src="https://github.com/user-attachments/assets/671eaf5b-58df-49e1-907f-5ac91a288333" />

ssm session start

<img width="1334" height="423" alt="Screenshot 2026-02-07 235644" src="https://github.com/user-attachments/assets/915879cc-6326-4017-80f9-fef18dba8d82" />

**Conclusion**

*This project demonstrates:*

Secure private EKS design

Proper use of Terraform for infrastructure

Internal Kubernetes service communication

IAM-based access control




****Private EKS with Internal Application (Terraform + Kubernetes)****

*Project Summary*

This project demonstrates how to design and deploy a secure, private Amazon EKS cluster using Terraform, and run an internal application stack (HAProxy + Tomcat) without exposing any public endpoints.
The focus is on security, controlled access, and production-style architecture, not public demos.

*Design Approach*

Instead of making everything publicly accessible, I followed these principles:

Private by default – No public EKS API, no public worker nodes

Infrastructure as Code – Everything created using Terraform

Clear access boundaries – Separate admin access, node access, and app access

Internal-only applications – Services exposed only inside the cluster

This matches how real production Kubernetes environments are designed.

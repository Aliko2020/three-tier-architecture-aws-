# 3-Tier Application Deployment on AWS (VPC, EC2, RDS, S3) Using Terraform

**Date:** 2025-11-25  
**Author:** Amos 

This repository documents the infrastructure and deployment process for a 3-tier e-commerce web application deployed on AWS using Terraform. The project includes:

- Presentation Tier: React frontend hosted on Amazon S3
- Application Tier: Node.js backend running on EC2
- Data Tier: PostgreSQL hosted on Amazon RDS
- Provisioning: Fully automated using Terraform modules

Public Endpoint
Frontend (S3 Static Hosting):
http://my-react-website-12345.s3-website-us-east-1.amazonaws.com

## 1. VPC and Networking Configuration

A dedicated Virtual Private Cloud (VPC) is provisioned to isolate and secure application resources, following AWS best practices for a modern 3-tier architecture.
VPC Setup


<img width="1851" height="879" alt="vpc" src="https://github.com/user-attachments/assets/7e072808-f63f-4313-b10e-c9d2d60e1f68" />


- VPC CIDR: 10.0.0.0/16
- Provisioned using Terraform modules for modularity and consistency
- Includes DNS support and DNS hostnames enabled

## Subnets
Public Subnet (server_sn)
Hosts the EC2 instance (Node.js backend)
Provides Internet access for:
- SSH administration
- Package installation
- API communications

Private Subnet (rds_sn)
Hosts Amazon RDS PostgreSQL
Fully isolated — no direct Internet exposure

## Internet Gateway & Routing
Internet Gateway (IGW)
- Attached to the VPC to allow outbound/inbound Internet access for resources in public subnets

## Route Tables
Public Route Table
- Route: 0.0.0.0/0 → IGW
- Associated with the public subnet

Private Route Table
- No default route to the Internet
- Associated with the private subnet

This design ensures complete isolation between tiers:
Frontend → Backend (EC2) → Database (RDS).


## 2. Security Groups
EC2 Security Group (ec2_sg)

Inbound:
- HTTP (80) — Open to public
- SSH (22) — Open to public (for admin access)

Outbound:
- All traffic allowed

RDS Security Group (rds_sg)

Inbound:
- PostgreSQL (5432) — Only from EC2 security group

Outbound:
- All traffic allowed

Security groups were passed between Terraform modules using input/output variables for clean module separation.

## 3. Application Tier — EC2 (Node.js Backend)

The backend API is deployed to an EC2 instance located in the public subnet.
EC2 Instance Configuration
- Public IP for SSH access
- Key pair: ecommerse.pem
- Node.js v18 + npm installed
- PM2 used to manage Node.js server processes
  

<img width="1717" height="1005" alt="ec2" src="https://github.com/user-attachments/assets/7e2181d4-a2ca-4ae0-8576-fd0e4585c31e" />

Backend Deployment

    npm install
    pm2 start index.js --name my-server
    pm2 status

API Test Example

    curl -X POST http://localhost:3000/api/auth/signup \
    -H "Content-Type: application/json" \
    -d '{"username":"alice","email":"alice@example.com","password":"mypassword"}'

Expected Response:

    {"message": "User registered successfully"}

## 4. Data Tier — Amazon RDS PostgreSQL

<img width="1566" height="246" alt="rds" src="https://github.com/user-attachments/assets/e7157590-624d-44ce-8337-f780882b9e06" />

RDS PostgreSQL is deployed in the private subnet for secure backend-only access.
Key Features
- Private-only accessibility (no public endpoints)
- Connected from EC2 using psql
- Tables verified (e.g., users)
- .env on EC2 securely stores database credentials

## 5. Presentation Tier — React Frontend on Amazon S3

The frontend React application is hosted using S3 static website hosting.
S3 Configuration
- Bucket name: my-react-website-12345

    Public access for static assets enabled

    index.html configured as the root document

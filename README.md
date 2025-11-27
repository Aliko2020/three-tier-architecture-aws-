# EC2 / VPC Setup & React + Node.js Deployment

**Date:** 2025-11-25  
**Author:** Amos  

This repository documents the steps taken to deploy a full-stack e-commerce website using AWS (EC2, RDS, S3) and Terraform.
- Public endpoint: http://my-react-website-12345.s3-website-us-east-1.amazonaws.com
---

## 1. VPC and Networking

- **Created a VPC** using Terraform with CIDR block `10.0.0.0/16`.
- **Created subnets:**
  - Public subnet (`server_sn`) for EC2 instances.
  - Private subnet (`rds_sn`) for RDS instances.
- **Created Internet Gateway** and attached it to the VPC.
- **Created route tables:**
  - Public route table → route `0.0.0.0/0` through IGW.
  - Private route table → no direct Internet access.
- **Associated subnets** with their respective route tables.

---

## 2. Security Groups

- **EC2 security group (`ec2_sg`)**
  - Inbound: HTTP (80) and SSH (22) from anywhere.
  - Outbound: All traffic allowed.
- **RDS security group (`rds_sg`)**
  - Inbound: PostgreSQL (5432) only from EC2 security group.
  - Outbound: All traffic allowed.
- **Passed security groups between modules** using Terraform outputs/inputs.

---

## 3. EC2 Instance

- Deployed EC2 in the **public subnet**.
- Assigned **public IP** for SSH access.
- Attached **key pair (`ecommerse.pem`)**.
- Associated **EC2 security group**.
- Installed **Node.js (v18)** and **npm**.
- Installed **PM2** for keeping the server running in the background.
- Started backend Node.js server:

bash
npm install
pm2 start index.js --name my-server
pm2 status

curl -X POST http://localhost:3000/api/auth/signup \
-H "Content-Type: application/json" \
-d '{"username":"alice","email":"alice@example.com","password":"mypassword"}'

 Response:
 {"message":"User registered successfully"}

## 4. PostgreSQL (RDS)

- Connected to RDS PostgreSQL (private subnet) from EC2.
- Verified database tables (users) exist.
- Ran test queries for user registration and password hashing.
- Ensured database credentials were stored in .env and accessed by Node.js.

## 5. Amazon S3 Hosting — React Website
---
- Created an S3 bucket named `my-react-website-12345`.
- Enabled **static website hosting**.
  Public endpoint: http://my-react-website-12345.s3-website-us-east-1.amazonaws.com



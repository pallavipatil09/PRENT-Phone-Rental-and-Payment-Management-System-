# 📱PRENT-Phone-Rental-and-Payment-Management-System

![MySQL](https://img.shields.io/badge/MySQL-Database-blue)
![SQL](https://img.shields.io/badge/SQL-Advanced-orange)
![Project](https://img.shields.io/badge/Project-End--to--End-success)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)


---

## 🚀 Summary
Designed and developed a **complete relational database system** for a Phone Rental Business using MySQL.

The project demonstrates:
- Database design & normalization  
- Real-world business logic implementation  
- Automation using triggers  
- Stored procedures for operations  
- Views for reporting  
- Indexes for performance optimization  

This project is structured like a **production-level database system** and organized for scalability and readability.

---

## 📌 Project Overview
PRent is a SQL-based system that manages the complete lifecycle of a phone rental business.

It handles:
- Users & customer details  
- Mobile models & stock  
- Rental plans  
- Orders & transactions  
- EMI tracking  
- Payments  
- Promo discounts  
- Complaints & feedback  
- Audit logs for tracking changes  

---

## 🛠️ Tools & Technologies
- MySQL  
- SQL (DDL, DML, DCL)  
- MySQL Workbench  
- GitHub  

---

## 📂 Project Structure

```text
employee-management-database-system/
│── sql/
│   ├── 1_create_database.sql
│   ├── 2_create_tables.sql
│   ├── 3_triggers.sql
│   ├── 4_stored_procedures.sql
│   ├── 5_views.sql
│   ├── 6_indexes.sql
│   └── 7_data_insertion.sql
│
│── outputs/
│   ├── active_rentals.csv
│   ├── emi_status.csv
│   ├── low_stock_models.csv
│   ├── monthly_revenue.csv
│   └── payment_history.csv
│   └── user_overview.csv
│
│── docs/
│   └── er_diagram.png
│
│── README.md
```

---

## 🗃️ Database Tables
- users  
- models  
- plans  
- rent_details  
- promos  
- orders  
- emi_details  
- payments  
- complains  
- feedback  
- audit_log  

---

## 🔗 Key Relationships
- One user → multiple rentals  
- One rental → one phone model  
- One rental → one plan  
- One rental → multiple EMIs  
- One order → linked to rental  
- Payments → linked with rentals & EMIs  
- Complaints & feedback → linked with users  

---

## ⚙️ Core Features

### 📦 Inventory Management
- Tracks available stock of phone models  
- Automatically updates stock using triggers  

### 💸 Payment & EMI System
- EMI tracking with due dates  
- Payment recording and status handling  
- Automatic rent completion when all EMIs are paid  

### 🎯 Promo Code System
- Validates promo codes  
- Applies discount automatically  
- Prevents invalid or expired codes  

### 🔐 Audit Logging
- Tracks important actions like:
  - User creation  
  - Address updates  
  - Price changes  
  - Stock updates  

### ⚡ Business Automation
- Prevents deletion of users with active rentals  
- Prevents negative stock  
- Auto updates next payment date  
- Auto updates EMI status on payment failure  

---

## 🚀 SQL Concepts Used
- Database creation  
- Table creation  
- Primary & foreign keys  
- Constraints (UNIQUE, CHECK, ENUM)  
- Joins  
- Views  
- Stored Procedures  
- Triggers  
- Indexes  
- Transactions  

---

## 📊 Sample Outputs

### 🔹 Active Rentals
| Rent ID | Name   | Model        | Outstanding Due |
|--------|--------|-------------|----------------|
| 1      | Sanika | iPhone 17   | 26400          |
| 2      | Tanvi  | iPhone 17 Pro | 15000        |

---

### 🔹 EMI Status
| EMI ID | Name   | Due Date   | Status |
|--------|--------|-----------|--------|
| 1      | Sanika | 2024-02-01 | Paid   |
| 2      | Tanvi  | 2024-03-01 | Paid   |

---

### 🔹 Payment History
| Payment ID | Name   | Amount | Method |
|-----------|--------|--------|--------|
| 1         | Sanika | 2200   | UPI    |
| 2         | Tanvi  | 2200   | GPay   |

📁 Full CSV outputs available in the `outputs/` folder.

---

## 🧩 ER Diagram
The ER diagram represents all relationships between entities.

---

## 📈 Business Use Cases
- Track active rentals
- Monitor pending EMIs
- Analyze customer payments
- Identify low-stock models
- Calculate monthly revenue
- Generate customer insights

---

## 🌟 Project Highlights
- Fully normalized relational database
- Real-world business logic implementation
- Automation using triggers
- Performance optimization using indexes
- Clean modular SQL structure 
- Includes outputs and ER diagram

---

## 💡 Learnings
- Database normalization & relationships
- Writing efficient SQL queries
- Implementing business logic using triggers & procedures
- Structuring real-world SQL projects
- Improving query performance with indexing

---

## 👩‍💻 Author  
**Pallavi Patil**  
Aspiring Data Analyst | SQL | Excel | Power BI | Python | Tableau

---

## 📬 Connect With Me  
- LinkedIn: www.linkedin.com/in/patilpallavianil

---

## ⭐ If you like this project  
Give it a ⭐ and share your feedback!

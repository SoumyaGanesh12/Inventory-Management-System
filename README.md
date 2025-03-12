
# Inventory Management System (IMS)

## Overview

The Inventory Management System (IMS) is an advanced solution aimed at addressing challenges faced by businesses using antiquated manual inventory methods. The system aims to provide real-time tracking, improve order fulfillment processes, reduce holding costs, and provide actionable insights through data analysis. The solution helps businesses improve inventory accuracy, supplier management, and operational efficiency, ultimately boosting customer satisfaction and competitiveness.

### Key Features:
- **Real-Time Inventory Visibility**
- **Supplier Management**
- **Optimized Order Fulfillment**
- **Data-Driven Insights** (Sales Reports, Stock Reports, etc.)
- **Support for Scalable Business Growth**

### Objectives:
- **Increase Inventory Accuracy**
- **Improve Supplier Management**
- **Minimize Holding Costs**
- **Optimize Order Fulfillment Procedures**
- **Provide Actionable Insights through Data Analysis**
- **Reduce Stockouts and Overstock Situations**
- **Promote Operational Efficiency**
- **Support Scalable Growth**

---

## Project Structure

### Business Solution

1. **Supplier Comparison Report**  
   Compares the performance of suppliers based on the quantity of products sold individually, helping improve supplier management.

2. **Stock Report**  
   Displays product stock information, including the quantity and restock details for each category, helping reduce holding costs and prevent overstock or stockout situations.

3. **Product Comparison Report**  
   Provides insights into the performance of products across the same supplier.

4. **Sales Report**  
   Indicates total sales based on product, category, and customers to improve efficiency and marketing strategy.

5. **Order History Report**  
   Tracks previous orders placed by customers, facilitating convenience, ease of reordering, and serving as a reminder of preferences.

---

## Requirements

- **Database**: Oracle SQL
- **Schema**: IMS Database
- **Roles & Privileges**: Role-based access management for secure operations

---

## Installation Instructions

Follow these steps to set up the IMS database on an Oracle SQL server:

### 1. Set up Application Admin User
Run the `Script1.sql` to create the **IMS_ADMIN** user and assign the necessary privileges.

### 2. Create Tables, Sequences, and Views
Login as **IMS_ADMIN** and run the `Script2.sql` to create the required tables, constraints, sequences, and views.

### 3. Create Users for Various Roles
Run `Script3.sql` to create users for different roles such as suppliers, customers, IMS_Manager, and Logistic_Admin, and grant necessary privileges.

### 4. Customer Onboarding
Login as **Customer** and run the `Script4.sql` to onboard a new customer (insert customer records).

### 5. Supplier Onboarding
Login as **Supplier** and run `Script5.sql` to onboard a new supplier (insert supplier records).

### 6. IMS Manager Data Insertion
Login as **IMS_MANAGER** and run `Script6.sql` to insert relevant data into tables.

### 7. Insert Orders and Products
Login as **IMS_ADMIN** and run `Script7.sql` to insert orders and products into the system.

### 8. Update Shipping Status
Login as **LOGISTIC_ADMIN** and run `Script8.sql` to update the shipping status of an order.

### 9. Generate Views for Customers
Login as **Customer** and run `Script9.sql` to generate views for the customer to access relevant data.

### 10. Generate Views for Suppliers
Login as **Supplier** and run `Script10.sql` to generate views for suppliers to access relevant data.

---

## Key Concepts and Features Used

### Functions and Procedures
- Functions to calculate total stock levels, sales statistics, and performance metrics.
- Procedures for automating tasks like inserting data, updating records, and generating reports.

### Role-Based Access Control
- **IMS_ADMIN**: Full administrative access to manage users, tables, and data.
- **IMS_MANAGER**: Insert and manage product data.
- **LOGISTIC_ADMIN**: Manage shipping status and logistics.
- **Customer**: View and manage their own order history and preferences.
- **Supplier**: View and manage their products and sales performance.

### Data Integrity
- **Constraints**: Primary and foreign keys, unique constraints, check constraints, etc., to ensure data integrity.
- **Sequences**: Used for generating unique order IDs, product IDs, etc.

### Reporting
- SQL views and functions are used to generate **Supplier Comparison Report**, **Stock Report**, **Sales Report**, and more.

---

## Contribution and Future Improvements

- Add more detailed reporting features like profit analysis, region-based stock levels, etc.
- Extend functionality to support automated reorder suggestions based on stock levels and sales trends.
- Implement more advanced analytics and machine learning features for forecasting inventory needs.


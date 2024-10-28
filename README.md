# Telco Customer Churn Analysis

## Overview

The **Telco Customer Churn** dataset contains information about a fictional telecommunications company that provided home phone and Internet services to customers in California during the third quarter (Q3). The dataset consists of **7,043** rows, each representing a unique customer, along with various attributes related to their demographics, account details, and service usage.

## Objective

The primary objective of this analysis is to understand the factors affecting customer churn, identify patterns, and derive actionable insights that could help improve customer retention strategies.

## Dataset Overview

The dataset includes the following key features:

- **CustomerID**: A unique identifier for each customer.
- **Gender**: The gender of the customer (Male, Female).
- **SeniorCitizen**: Indicates if the customer is a senior citizen (1 = Yes, 0 = No).
- **Partner**: Indicates if the customer has a partner (Yes, No).
- **Dependents**: Indicates if the customer has dependents (Yes, No).
- **TenureInMonths**: The number of months the customer has been with the company.
- **PhoneService**: Indicates if the customer has a phone service (Yes, No).
- **MultipleLines**: Indicates if the customer has multiple lines (Yes, No, No phone service).
- **InternetService**: The type of Internet service (DSL, Fiber optic, No).
- **OnlineSecurity**: Indicates if the customer has online security (Yes, No).
- **OnlineBackup**: Indicates if the customer has online backup (Yes, No).
- **DeviceProtection**: Indicates if the customer has device protection (Yes, No).
- **PremiumTechSupport**: Indicates if the customer has premium tech support (Yes, No).
- **StreamingTV**: Indicates if the customer has streaming TV (Yes, No).
- **StreamingMovies**: Indicates if the customer has streaming movies (Yes, No).
- **Contract**: The type of contract (Month-to-month, One year, Two year).
- **PaymentMethod**: The method of payment (Electronic check, Mailed check, Bank transfer (automatic), Credit card (automatic)).
- **MonthlyCharges**: The amount charged to the customer per month.
- **TotalCharges**: The total amount charged to the customer.
- **Churn**: Indicates if the customer has churned (Yes, No).

## SQL Analysis

The analysis includes various SQL queries to explore the dataset and derive insights related to customer churn. Key queries performed include:

1. Checking for duplicate CustomerID values.
2. Calculating the total number of customers, customers who have churned, and those who remain.
3. Analyzing churn rates by demographics, such as gender, age, and marital status.
4. Examining churn rates based on service usage, contract types, and payment methods.
5. Assessing the impact of customer satisfaction and revenue on churn rates.

## Acknowledgments
- **IBM**: The Telco Customer Churn dataset is sourced from IBM.



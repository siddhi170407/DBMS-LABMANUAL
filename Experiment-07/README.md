# Experiment 7: Normalization of Sales Database from UNF to BCNF

## Aim
To normalize a denormalized Sales table from Unnormalized Form (UNF) to First Normal Form (1NF), Second Normal Form (2NF), Third Normal Form (3NF) and Boyce-Codd Normal Form (BCNF).

## Objectives
- Understand database normalization.
- Identify data redundancy and anomalies.
- Convert an unnormalized table into 1NF.
- Remove partial dependencies to achieve 2NF.
- Remove transitive dependencies to achieve 3NF.
- Verify BCNF conditions.

## Theory

Normalization is the process of organizing relational database tables to reduce redundancy and prevent insertion, update and deletion anomalies.

### 1. Unnormalized Form (UNF)
An unnormalized table may contain repeating groups or multiple values in a single field.

For example, one sales record may contain multiple product names in a single column.

### 2. First Normal Form (1NF)
A relation is in 1NF when:
- Every attribute contains atomic values.
- Repeating groups are eliminated.
- Each row can be uniquely identified.

### 3. Second Normal Form (2NF)
A relation is in 2NF when:
- It is already in 1NF.
- Every non-prime attribute is fully functionally dependent on every candidate key.
- Partial dependencies are removed.

### 4. Third Normal Form (3NF)
A relation is in 3NF when:
- It is already in 2NF.
- For every nontrivial functional dependency X → A, either X is a superkey or A is a prime attribute.

In the common simplified case, 3NF eliminates transitive dependencies of non-key attributes on a key.

### 5. Boyce-Codd Normal Form (BCNF)
A relation is in BCNF when every determinant of a nontrivial functional dependency is a superkey.

BCNF is stricter than 3NF.

## Functional Dependencies

Consider the following Sales relation:

Sales(Order_ID, Product_ID, Order_Date, Customer_ID, Customer_Name, Product_Name, Price, Quantity)

Assume:
- Order_ID → Order_Date, Customer_ID
- Customer_ID → Customer_Name
- Product_ID → Product_Name, Price
- (Order_ID, Product_ID) → Quantity

The composite key is (Order_ID, Product_ID).

## Normalization Process

### UNF
A sales record contains repeating product information within one order.

### 1NF
Create one row for each order-product combination, with atomic column values.

### 2NF
Separate Order, Product and Order_Item tables to remove partial dependencies on the composite key.

### 3NF
Separate Customer details from the Order table to eliminate the transitive dependency:

Order_ID → Customer_ID → Customer_Name

### BCNF
Verify that every determinant in each resulting relation is a candidate key or superkey.

Under the stated functional dependencies, the resulting tables satisfy BCNF.

## Final Schema

| Table | Attributes |
|---|---|
| Customer | Customer_ID, Customer_Name |
| Orders | Order_ID, Order_Date, Customer_ID |
| Product | Product_ID, Product_Name, Price |
| Order_Item | Order_ID, Product_ID, Quantity |

## Procedure
1. Identify the unnormalized Sales relation.
2. Convert repeating groups into atomic records.
3. Identify candidate keys and functional dependencies.
4. Remove partial dependencies.
5. Remove transitive dependencies.
6. Verify BCNF requirements.
7. Create normalized tables in MySQL.
8. Insert records and retrieve the normalized data using joins.

## Expected Output
The normalized tables store customer, order, product and order-item information separately.

A JOIN query reconstructs the sales information without storing redundant customer and product details in every order-item record.

## Result
The Sales relation was normalized from UNF to 1NF, 2NF, 3NF and BCNF.

## Conclusion
Normalization reduces redundancy, improves consistency and prevents database modification anomalies.

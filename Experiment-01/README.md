# Experiment 1: ER Diagram for an Indian E-Commerce Platform

## Aim
To design an Entity-Relationship (ER) diagram for an Indian e-commerce platform that manages customers, products, sellers, orders, payments, and deliveries.

## Objective
- Identify the entities and attributes required for an e-commerce database.
- Define primary keys and relationships between entities.
- Understand cardinality and referential integrity.
- Design a database model that minimizes data redundancy.

## Theory
An Entity-Relationship (ER) diagram is a graphical representation of the entities in a database and the relationships between them.

An **entity** represents a real-world object, such as a customer or product.

An **attribute** represents a property of an entity, such as customer name or product price.

A **primary key** uniquely identifies each record in a table, while a **foreign key** establishes a relationship between tables.

### Entities and Attributes

| Entity | Attributes |
|---|---|
| Customer | Customer_ID (PK), Name, Email, Phone, Address |
| Seller | Seller_ID (PK), Seller_Name, GSTIN |
| Product | Product_ID (PK), Product_Name, Price, Stock, Seller_ID (FK) |
| Orders | Order_ID (PK), Order_Date, Customer_ID (FK), Total_Amount |
| Order_Item | Order_Item_ID (PK), Order_ID (FK), Product_ID (FK), Quantity, Unit_Price |
| Payment | Payment_ID (PK), Order_ID (FK), Payment_Mode, Payment_Status |
| Delivery | Delivery_ID (PK), Order_ID (FK), Delivery_Address, Delivery_Status |

### Relationships

1. **Customer–Orders:** One customer can place multiple orders (1:N).
2. **Seller–Product:** One seller can sell multiple products (1:N).
3. **Orders–Order_Item:** One order can contain multiple order items (1:N).
4. **Product–Order_Item:** One product can appear in multiple order items (1:N).
5. **Orders–Payment:** One order can have multiple payment attempts (1:N).
6. **Orders–Delivery:** Each order can have at most one delivery record (1:0..1).

The Order_Item entity resolves the many-to-many relationship between Orders and Product.

## Procedure
1. Identify the major entities of the e-commerce system.
2. Define the attributes of each entity.
3. Assign primary keys to uniquely identify records.
4. Establish foreign-key relationships between entities.
5. Determine relationship cardinalities.
6. Draw the ER diagram using the defined entities and relationships.

## Result
An ER diagram for an Indian e-commerce platform was designed, representing the entities, attributes, primary keys, foreign keys, and their relationships.

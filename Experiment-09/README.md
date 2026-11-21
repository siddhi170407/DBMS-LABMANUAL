# Experiment 9: Query Performance Benchmarking Using Indexing

## Aim
To benchmark query performance on a Railway Booking table before and after creating indexes.

## Objectives
- Create a Railway Booking database.
- Insert sample booking records.
- Execute queries without secondary indexes.
- Create indexes on frequently searched columns.
- Analyze execution plans using EXPLAIN.
- Compare query performance before and after indexing.

## Theory

### 1. Database Index
An index is a data structure that improves the speed of data retrieval operations.

MySQL InnoDB commonly uses B+ Tree indexes.

### 2. Query Performance
Query performance refers to the time and resources required to execute a database query.

Performance depends on:
- Number of records.
- Index availability.
- Query conditions.
- Data distribution.
- Database optimizer decisions.

### 3. Full Table Scan
A full table scan examines the table to locate records satisfying the query conditions.

### 4. Indexed Search
An indexed search uses an index to locate matching records without necessarily scanning the entire table.

### 5. EXPLAIN
EXPLAIN displays the query execution plan selected by MySQL.

Important fields include:
- type — Table access method.
- key — Index selected.
- rows — Estimated number of rows examined.
- Extra — Additional execution details.

### 6. EXPLAIN ANALYZE
EXPLAIN ANALYZE executes the query and displays actual execution timing and row information.

It is supported in MySQL 8.0.18 and later.

## Procedure
1. Create a Railway_Booking table.
2. Insert sample booking records.
3. Execute queries before creating secondary indexes.
4. Record the execution plans and actual timings.
5. Create indexes on Train_No and Journey_Date.
6. Execute the same queries again.
7. Compare access methods, estimated rows and execution timings.
8. Analyze whether indexing improves performance.

## Expected Output
The initial queries may use a full table scan.

After indexing, MySQL may choose an index-based access method for selective queries.

Actual performance improvements depend on table size, selectivity, caching and the optimizer.

## Result
Query performance was benchmarked before and after indexing using EXPLAIN and EXPLAIN ANALYZE.

## Conclusion
Indexing can improve data retrieval performance by reducing unnecessary row examination. However, indexes require storage and introduce additional maintenance costs during data modification.

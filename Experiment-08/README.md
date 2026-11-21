# Experiment 8: Banking Transactions and Isolation Levels

## Aim
To implement banking transactions using COMMIT, ROLLBACK and SAVEPOINT and demonstrate transaction isolation levels.

## Objectives
- Understand database transactions.
- Implement fund transfers between bank accounts.
- Demonstrate COMMIT and ROLLBACK.
- Create and use SAVEPOINT.
- Understand ACID properties.
- Demonstrate transaction isolation levels.

## Theory

### 1. Database Transaction
A transaction is a sequence of database operations treated as a single logical unit of work.

### 2. ACID Properties
- **Atomicity:** All operations of a transaction succeed together or are rolled back.
- **Consistency:** Transactions preserve defined database constraints.
- **Isolation:** Concurrent transactions are controlled to prevent undesirable interference.
- **Durability:** Committed changes remain stored even after a system failure.

### 3. COMMIT
COMMIT permanently saves the changes made by the current transaction.

### 4. ROLLBACK
ROLLBACK reverses uncommitted changes in the current transaction.

### 5. SAVEPOINT
SAVEPOINT creates a named point within a transaction. ROLLBACK TO SAVEPOINT undoes changes made after that point without cancelling the entire transaction.

### 6. Isolation Levels

**READ UNCOMMITTED:** Allows dirty reads.

**READ COMMITTED:** Prevents dirty reads but may allow non-repeatable reads.

**REPEATABLE READ:** Provides a consistent snapshot for repeated ordinary SELECT queries in MySQL InnoDB.

**SERIALIZABLE:** Provides the strongest standard isolation, with behavior equivalent to a serial execution of transactions.

## Procedure
1. Create a Bank_Account table.
2. Insert sample account balances.
3. Transfer funds between accounts.
4. Use COMMIT to save a valid transfer.
5. Use ROLLBACK to cancel a transaction.
6. Use SAVEPOINT to partially roll back a transaction.
7. Open two database sessions.
8. Execute transactions at different isolation levels.
9. Observe changes visible to each session.

## Expected Output
- COMMIT saves successful fund transfers.
- ROLLBACK restores the previous balance.
- SAVEPOINT allows partial rollback.
- Different isolation levels produce different concurrency and visibility behavior.

## Result
Banking transactions were implemented using COMMIT, ROLLBACK and SAVEPOINT. Transaction isolation levels were demonstrated using concurrent sessions.

## Conclusion
Transaction control commands help maintain reliable banking operations, while isolation levels determine how concurrent transactions interact.

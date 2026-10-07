SELECT * FROM banking_transactions;


## 1.Total Credit Amount ---

SELECT 
    ROUND(SUM(amount), 2) AS total_credit_amount
FROM banking_transactions
WHERE transaction_type = 'Credit';


## Total Credit Amount

SELECT 
    ROUND(SUM(amount), 2) AS total_debit_amount
FROM banking_transactions
WHERE transaction_type = 'Debit';


## Credit to Debit Ratio

SELECT 
    ROUND(
        SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) / 
        SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END), 
    4) AS credit_to_debit_ratio
FROM banking_transactions;



## Net Transaction Amount

SELECT 
    ROUND(
        SUM(CASE WHEN transaction_type = 'Credit' THEN amount ELSE 0 END) - 
        SUM(CASE WHEN transaction_type = 'Debit' THEN amount ELSE 0 END), 
    2) AS net_transaction_amount
FROM banking_transactions;


## Account Activity Ratio
## Per Account / Customer

SELECT 
    account_number,
    customer_name,
    COUNT(*) AS total_transactions,
    ROUND(AVG(balance), 2) AS current_balance,
    ROUND(COUNT(*) / AVG(balance), 6) AS account_activity_ratio
FROM banking_transactions
GROUP BY account_number, customer_name
ORDER BY account_activity_ratio DESC;

## Overall / Bank-wide

SELECT 
    COUNT(*) / SUM(balance) AS overall_activity_ratio
FROM banking_transactions;

## Transactions per Day / Week / Month
-- 1. Daily Transaction Counts
SELECT 
    transaction_date, 
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY transaction_date
ORDER BY transaction_date;
-- 2. Weekly Transaction Counts
SELECT 
    YEAR(transaction_date) AS txn_year,
    WEEK(transaction_date) AS txn_week,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY txn_year, txn_week
ORDER BY txn_year, txn_week;
-- 3. Monthly Transaction Counts
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY txn_month
ORDER BY txn_month;

## Total Transaction Amount by Branch

SELECT 
    branch,
    ROUND(SUM(amount), 2) AS total_amount,
    COUNT(*) AS total_transactions
FROM banking_transactions
GROUP BY branch
ORDER BY total_amount DESC;


## Transaction Volume by Bank

SELECT 
    bank_name,
    COUNT(*) AS transaction_volume,
    ROUND(SUM(amount), 2) AS total_amount
FROM banking_transactions
GROUP BY bank_name
ORDER BY transaction_volume DESC;
## 1 Total Loan Amount Funded
select  sum(loan_amount) from banking_data;


## 2 Total Loans
select  distinct count(account_id) from banking_data;


## 3 Total Collection:Reflects repayment performance, including principal and interest.
select sum(total_received_principal)+sum(total_received_interest) as total_collection from banking_data;


## 4 Total Interest: Captures revenue from loan interest.
select sum(total_received_interest) from banking_data;


## 5 Branch-Wise Performance: Analyzes revenue (interest, fees, total) by branch
select  branch_name,sum(total_payment),sum(total_received_interest),sum(total_fees) from banking_data
 group by branch_name order by sum(total_payment) desc;
 
 
## 6 State-Wise Loan: Shows geographic distribution of loans.
select  state_name,  count(*) as  loans from banking_data group by state_name order by loans desc;


## 7 Religion-Wise Loan: Monitors loan distribution across religious demographics
select religion,count(religion) as loans, round( count(religion)*100.0/(select count(religion) from banking_data),2)as loan_percentage 
from banking_data group by religion order by loans desc;


## 8 Product Group-Wise Loan: Categorizes loans by product types (e.g., personal, auto).
select purpose_category ,count(*) as total_loan ,sum(loan_amount) as total_loan_amount from banking_data 
group by purpose_category order by total_loan desc;


## 9 Disbursement Trend: Tracks changes in loan disbursements over time.
SELECT YEAR(STR_TO_DATE(disbursement_date, '%d-%m-%Y')) AS year,MONTHNAME(STR_TO_DATE(disbursement_date, '%d-%m-%Y')) AS month,
SUM(loan_amount) AS total_disbursed FROM banking_data GROUP BY YEAR(STR_TO_DATE(disbursement_date, '%d-%m-%Y')),MONTHNAME(STR_TO_DATE(disbursement_date, '%d-%m-%Y')),
MONTH(STR_TO_DATE(disbursement_date, '%d-%m-%Y')) ORDER BY year,MONTH(STR_TO_DATE(disbursement_date, '%d-%m-%Y'));


## 10 Grade-Wise Loan: Assesses portfolio risk by borrower credit grades.
select grade ,count(*) as total_loans, sum(case when is_default_loan="Y" then 1 else 0 end) as default_loans,
round(sum(case when is_default_loan="Y" then 1 else 0 end)*100.0/count(*),2) as default_rate from banking_data 
group by grade order by default_rate desc;


## 11 Default Loan Count: Counts loans in default.
select is_default_loan,count(*) as total_loans from banking_data group by is_default_loan having is_default_loan = "Y";


## 12 Delinquent Client Count: Tracks borrowers with missed payments.
select is_delinquent_loan,count(*) as total_loans from banking_data group by is_delinquent_loan having is_delinquent_loan = "Y";


## 13 Delinquent Loan Rate: Percentage of loans overdue in the portfolio.
select sum(case when is_delinquent_loan='Y' then 1 else 0 end) as delinquent_loan,count(*) as total_loans,
round(sum(case when is_delinquent_loan='Y' then 1 else 0 end)*100.0/count(*),2) AS is_delinquent_loan_rate FROM banking_data;



## 14 Default Loan Rate: Proportion of defaulted loans to the total portfolio.
SELECT SUM(CASE WHEN is_default_loan = 'Y' THEN 1 ELSE 0 END) AS defaulted_loans,COUNT(*) AS total_loans,
ROUND(SUM(CASE WHEN is_default_loan = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS default_loan_rate FROM banking_data;



##15 Loan Status-Wise Loan: Breaks down loans by status (active, delinquent, closed).
select loan_status,count(*) as loans from banking_data group by loan_status order by loans desc;


## 16 Age Group-Wise Loan: Categorizes loans by borrowers’ age groups.
select age_group,count(*) as loans from banking_data group by age_group order by loans desc;



## 17 Loan Maturity: Tracks the timeline until full repayment 
SELECT loan_status,
AVG(DATEDIFF(STR_TO_DATE(`Closed_Date`, '%d-%m-%Y'),STR_TO_DATE(`Disbursement_Date`, '%d-%m-%Y'))) AS average_loan_maturity_days
FROM banking_data WHERE Loan_Status = 'Fully Paid';


## 18 No Verified Loans: Identifies loans without proper verification.
select verification_status,count(*) as loans from banking_data group by verification_status having verification_status="not verified";
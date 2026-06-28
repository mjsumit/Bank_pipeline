create database bank;
use bank;
select * from lcustomers_raw;
select * from ltransactions_raw;
# joining customer and transaction tables 

# The High-Value Customer Search top 5 highest spending customers
select
c.CUST_ID,
c.CUST_NAME,
t.TXN_ID,
t.TXN_AMOUNT
from lcustomers_raw c 
inner join
ltransactions_raw t on c.CUST_ID = t.CUST_ID;

select
c.CUST_ID,
c.CUST_NAME
from lcustomers_raw c
inner join
ltransactions_raw t on c.CUST_ID = t.CUST_ID
group by c.CUST_ID,c.CUST_NAME;

select 
c.CUST_ID,
c.CUST_NAME,
sum(t.TXN_AMOUNT)  AS total_calculated_volume
from lcustomers_raw c
inner join 
ltransactions_raw t on c.CUST_ID = t.CUST_ID
group by c.CUST_ID , c.CUST_NAME
order by total_calculated_volume DESC limit 4;

# 2 . The Account Performance Audit
select 
c.ACC_TYPE,
count(t.TXN_ID) as total_transactions,
sum(t.TXN_AMOUNT) as Average_transaction_amount
from lcustomers_raw c
join
ltransactions_raw t on c.CUST_ID = t.CUST_ID
group by c.ACC_TYPE
order by Average_transaction_amount desc;


# Question 3: The Risk Management Check
# risk score 5 withdrawl or deposit

select 
t.TXN_TYPE,
count(*) as total_count_of_transactions,
sum(t.TXN_AMOUNT) as total_transaction_amount_bytype
from lcustomers_raw c
join 
ltransactions_raw t on c.CUST_ID = t.CUST_ID
group by t.TXN_TYPE
order by total_transaction_amount_bytype desc;


# top spending customers 
create view  top_spending_customers as
select 
c.CUST_ID,
c.CUST_NAME,
sum(t.TXN_AMOUNT)  AS total_calculated_volume
from lcustomers_raw c
inner join 
ltransactions_raw t on c.CUST_ID = t.CUST_ID
group by c.CUST_ID , c.CUST_NAME
order by total_calculated_volume DESC limit 4;

# view
select* from top_spending_customers;

# name automation
select 
CUST_ID,
concat(upper(left(CUST_NAME,1)),lower(substring(CUST_NAME,2))) as cleaned_customers
from lcustomers_raw;

create view cleaned_customers as
select
CUST_ID,
concat(upper(left(CUST_NAME,1)),lower(substring(CUST_NAME,2))) as cleaned_customers,
ACC_TYPE,
RISK_SCORE
from lcustomers_raw;

select * from cleaned_customers limit 10;



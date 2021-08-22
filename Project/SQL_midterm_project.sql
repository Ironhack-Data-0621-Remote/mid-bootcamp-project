use credit_card_classification;
SELECT * FROM credit_card_data;

-- How many rows do I have / how many customers are in the database ?
select count(customer_number) as count from credit_card_data;

-- find unique values in cat columns
select offer_accepted from credit_card_data
group by offer_accepted; -- uniques are Yes and No
select reward from credit_card_data
group by reward; -- uniques are Air Miles, Cash Back and Points
select mailer_type from credit_card_data
group by mailer_type; -- uniques are Letter and Postcard
select credit_cards_held from credit_card_data
group by credit_cards_held; -- uniques are 1 to 4 included
select household_size from credit_card_data
group by household_size; -- uniques are 1 to 9 included

-- top 10 customers having highest avg balance
select customer_number, round(sum(average_balance),0) as balance
from credit_card_data
group by customer_number
order by balance desc
limit 10;

-- average balance of all customers
select round(avg(average_balance),0) as overall_avg_balance
from credit_card_data;

-- average balance of income levels
select income_level, round(avg(average_balance),0) as avg_balance
from credit_card_data
group by income_level
order by avg_balance desc; -- we can see that the higher the ic level, the higher average balance is

-- average balance depending on nb of bank accounts
select bank_accounts_open, round(avg(average_balance),0) as avg_balance
from credit_card_data
group by bank_accounts_open
order by avg_balance desc;

-- average balance depending on nb of bank accounts
select credit_rating, round(avg(credit_cards_held),3) as avg_nb_credit_cards
from credit_card_data
group by credit_rating
order by avg_nb_credit_cards desc;

-- correlation between credit_cards_held and nb_bank_accounts_open
select credit_cards_held, round(avg(bank_accounts_open),3) as avg_bank_acc
from credit_card_data
group by credit_cards_held
order by avg_bank_acc desc; -- there does not seem to be any correlation between the two except when cards = 4, nb of bank acc is higher

-- customers with credit = med or high, credit cards > 1, owner and household > 2
select * 
from credit_card_data
where 
(credit_rating = 'medium' or  credit_rating = 'high') and
credit_cards_held < 3 and 
own_your_home = 'Yes' and
household_size > 2;

-- customers whose avg balance is less than overall avg balance
select customer_number, average_balance
from credit_card_data
where average_balance < (select avg(average_balance) from credit_card_data)
order by average_balance desc; -- avg(avg balance) was 941

-- creating a view for that
create view customers_balance_view1 as
select customer_number, average_balance
from credit_card_data
where average_balance < (select avg(average_balance) from credit_card_data)
order by average_balance desc;

-- nb of customers who accepted offer vs delined
with cte1 as (
select count(customer_number) as accepted
from credit_card_data
where offer_accepted = 'Yes'),
cte2 as (
select count(customer_number) as declined
from credit_card_data
where offer_accepted = 'No')
select * from cte1, cte2;

-- avg balance of customers with high credit rating vs low credit rating
with cte1 as (
select round(avg(average_balance),0) as avg_balance_high_rating
from credit_card_data
where credit_rating = 'High'),
cte2 as (
select round(avg(average_balance),0) as avg_balance_low_rating
from credit_card_data
where credit_rating = 'Low')
select * from cte1,cte2; -- customers having high credit rating have a higher average balance than low credit rating customers

-- number of customers adressed depending on type of communication
with cte1 as (
select count(customer_number) as letter
from credit_card_data
where mailer_type = 'letter'),
cte2 as (
select count(customer_number) as postcard
from credit_card_data
where mailer_type = 'postcard')
select * from cte1, cte2;

-- information on 11th least Q1 balance customer
with cte1 as (
select *, row_number() over(order by q1_balance) as ranked
from credit_card_data
order by q1_balance asc)
select *
from cte1
where ranked = '11';
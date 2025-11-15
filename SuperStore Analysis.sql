create database superstore_db;
use superstore_db;
SELECT * FROM `sample - superstore`;

## Query 1: Which categories generate the most sales or profit?
select category,round(sum(sales)) as totale_sales, round(sum(profit))
from `sample - superstore`
group by category;

## Query 2: Which cities or regions are most profitables?
select city ,round(sum(sales)) as total_revenue, round(sum(profit)) as total_profit
from `sample - superstore`
group by city
order by total_revenue desc
limit 5;

## Query 3: Is discount gieven on product reducing the profit?
select discount, avg(profit) as avg_profit, count(*) as order_count
from `sample - superstore`
group by discount
order by discount;

## Query 4: Find out top 5 states by sales?
select state, round(sum(sales)) as total_sales
from `sample - superstore`
group by State
order by total_sales desc
limit 5;

## Query 5: Which shipping mode gives the best profit to cost ratio?
select `Ship Mode`,
round(sum(profit)) as total_profit,
round(sum(sales)) as total_sales,
round((sum(profit) / sum(sales)) * 100 , 2) as profit_margin_percentage
from `sample - superstore`
group by `Ship Mode`
order by profit_margin_percentage desc;

## Query 6: What is the average delivery time for each shipping mode?
select `Ship Mode`,
round(avg(datediff(`Ship Date`,`Order Date`)),2) as Avg_Delivery_Days
from `sample - superstore`
where `Ship Date` is not null and `Order Date` is not null
group by `Ship Mode`
order by Avg_Delivery_Days desc;

## Query 7: Hoe many repeat customers are there?
select count(*) as RepeatCustomersCount
from(
select `Customer ID`
from `sample - superstore`
group by `Customer ID`
having count(distinct `Order ID`) > 1
) as RepeatCustomers;

## Query 8: Which customers have returned to order multiple times?
select `Customer ID`,
`Customer Name`,
count(distinct `Order ID`) as TotalOrders
from `sample - superstore`
group by `Customer ID`,`Customer Name`
having count(distinct `Order ID`) > 1
order by TotalOrders desc
limit 5;

## Query 9: Which customer segments are the most valuable?
select Segment,
round(sum(sales),2) as total_sales,
round(sum(profit),2) as total_profit,
round((sum(profit) / sum(sales)) * 100 , 2) as Profit_Margin_Percentage
from `sample - superstore`
group by Segment
order by total_profit desc;

## Query 10: Are there any months with negative profit?
select
date_format(`Order Date`,'%y-%m') as month,
sum(profit) as Total_Profit
from `sample - superstore`
group by month
having Total_Profit < 0;


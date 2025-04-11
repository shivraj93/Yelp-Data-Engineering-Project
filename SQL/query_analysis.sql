
Select * from tbl_yelp_reviews limit 10;
Select * from tbl_yelp_businesses limit 10;


-- 1. Find number of businesses in each category.

With cte
As(
Select business_id, trim(A.value) as Category
from tbl_yelp_businesses,
lateral split_to_table(categories, ',') as A
)
Select Category, count(*) as no_of_businesses
from cte
group by Category
order by no_of_businesses desc;


-- 2. Find top 10 users who have reviewed the most businesses in the 'Restaurants' category.

Select r.user_id, count(distinct r.business_id) as no_of_reviews
from tbl_yelp_businesses b
join tbl_yelp_reviews r
on b.business_id = r.business_id
where b.categories like '%Restaurants%'
group by r.user_id
order by no_of_reviews desc
limit 10;


-- 3. Find the most popular categories of businesses (based on the number of reviews).

With cte as (
Select business_id, trim(A.value) as Categories
from tbl_yelp_businesses,
lateral split_to_table(categories, ',') as A
)

Select b.Categories, count(*) as no_of_reviews
from cte b
join tbl_yelp_reviews r
on b.business_id = r.business_id
group by b.Categories
order by no_of_reviews desc;


-- 4. Find the top 3 most recent reviews for each business.

With cte as (
Select r.business_id, b.name, r.review_date,
row_number() over (partition by r.business_id order by r.review_date desc) as rn
from tbl_yelp_reviews r
join tbl_yelp_businesses b
on r.business_id = b.business_id
)

Select name, review_date
from cte
where rn < 4;


-- 5. Find the month with the highest number of reviews.

Select date_part(month, review_date) as review_month,
count(*) as no_of_reviews
from tbl_yelp_reviews
group by review_month
order by no_of_reviews desc
limit 1;


-- 6. Find the percentage of 5-star reviews for each business.

Select r.business_id, b.name, count(*) as total_reviews
,sum(case when r.review_stars = 5 then 1 else 0 end) as five_star_reviews
,round(((five_star_reviews * 100)/total_reviews), 2) as five_star_reviews_percentage
from tbl_yelp_businesses b
join tbl_yelp_reviews r on b.business_id = r.business_id
group by r.business_id, b.name;


-- 7. Find the top 5 most reviewed businesses in each city.

With cte as (
Select b.city, b.business_id, b.name, count(*) as review_count
from tbl_yelp_reviews r
join tbl_yelp_businesses b on r.business_id = b.business_id
group by b.city, b.business_id, b.name
)

Select *
from cte
qualify row_number() over (partition by city order by review_count desc) < 6;


-- 8. Find the average rating of businesses that have at least 100 reviews.

Select r.business_id, b.name, count(*) as total_reviews, avg(r.review_stars) as avg_rating
from tbl_yelp_reviews r
join tbl_yelp_businesses b
on r.business_id = b.business_id
group by r.business_id, b.name
having count(*) >= 100; 


-- 9. List the top 10 users who have written the most reviews, along with the businesses they reviewed.

With cte as (
Select user_id, count(*) as review_count
from tbl_yelp_reviews r
join tbl_yelp_businesses b
on r.business_id = b.business_id
group by user_id
order by review_count desc
limit 10)

Select distinct r.user_id, r.business_id, b.name
from tbl_yelp_reviews r
join tbl_yelp_businesses b on r.business_id = b.business_id
where r.user_id in (Select user_id from cte)
order by r.user_id;


-- 10. Find top 10 businesses with highest positive sentiment reviews.

Select r.business_id, b.name, 
sum(case when sentiments = 'Positive' then 1 else 0 end) as positive_review_count
from tbl_yelp_reviews r
join tbl_yelp_businesses b
on r.business_id = b.business_id
group by r.business_id, b.name
order by positive_review_count desc
limit 10;


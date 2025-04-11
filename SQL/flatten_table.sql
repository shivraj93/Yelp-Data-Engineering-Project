-- Flattening the JSON data stored in the 'review_text' column of the 'yelp_reviews' table.
-- This extracts nested elements from the 'review_text' VARIANT column into a more relational structure and
-- applies the user-defined function 'analyze_sentiment' to determine sentiment from the review text.

CREATE OR REPLACE TABLE tbl_yelp_reviews 
AS
Select review_text:business_id::string as business_id
,review_text:date::date as review_date
,review_text:user_id::string as user_id
,review_text:stars::number as review_stars
,review_text:text::string as review_text
,analyze_sentiment(review_text) as sentiments
from yelp_reviews;

-- Displaying a preview of the data from the newly created 'tbl_yelp_reviews' table

Select *
from tbl_yelp_reviews limit 10;



-- Flattening the JSON data stored in the 'business_text' column of the 'yelp_businesses' table.
-- This extracts nested elements from the 'business_text' VARIANT column into a more relational structure.

CREATE OR REPLACE TABLE tbl_yelp_businesses 
AS
Select business_text:business_id::string as business_id
,business_text:name::string as name
,business_text:state::string as state
,business_text:city::string as city
,business_text:review_count::number as review_count
,business_text:stars::number as stars
,business_text:categories::string as categories
from yelp_businesses;

-- Displaying a preview of the data from the newly created 'tbl_yelp_businesses' table

Select *
from tbl_yelp_businesses limit 10;




-- Creating a 'yelp_reviews' table with a single column 'review_text' of type VARIANT to store reviews related JSON semi-structured data. 

CREATE OR REPLACE TABLE yelp_reviews (review_text variant)


-- Copying data from the split 'yelp_academic_dataset_review.json' JSON files stored in the AWS S3 bucket into the 'yelp_reviews' table.

COPY INTO yelp_reviews
FROM 's3://shivs-aws-s3-bucket/yelp/'
CREDENTIALS = (
    AWS_KEY_ID = $AWS_ACCESS_KEY_ID
    AWS_SECRET_KEY = $AWS_SECRET_ACCESS_KEY
)
FILE_FORMAT = (TYPE = JSON);

Select * 
from yelp_reviews
limit 10;






-- Creating a 'yelp_businesses' table with a single column 'business_text' of type VARIANT to store business details related JSON  semi-structured data.

CREATE OR REPLACE TABLE yelp_businesses (business_text variant)


-- Copying data from 'yelp_academic_dataset_business.json' JSON file stored in the AWS S3 bucket into the 'yelp_businesses' table.

COPY INTO yelp_businesses
FROM 's3://shivs-aws-s3-bucket/yelp/yelp_academic_dataset_business.json'
CREDENTIALS = (
    AWS_KEY_ID = $AWS_ACCESS_KEY_ID
    AWS_SECRET_KEY = $AWS_SECRET_ACCESS_KEY
)
FILE_FORMAT = (TYPE = JSON);

Select * 
from yelp_businesses
limit 10;

<h2>🛠️ Yelp Data Engineering Pipeline Project</h2>
<h3>🚀 Objective:</h3>
This project showcases an end-to-end data engineering pipeline built using Python, AWS S3, and Snowflake. 
The goal is to ingest semi-structured Yelp data, transform it into a structured format, call a user-defined function to calculate sentiment analysis and perform SQL-based analysis. 
It demonstrates real-world data engineering tasks like data ingestion, storage, transformation, and querying.

<br><h3>🔧 Project Overview:</h3>

✅ Raw Data: Yelp business review dataset in JSON format <br>
🐍 Python: Script to split large JSON file into smaller chunks for easier handling <br>
☁️ AWS S3: Stores the split JSON files for ingestion into Snowflake <br>
❄️ Snowflake: 
  - Ingests JSON using `COPY INTO` into Variant data type
  - Flattens the semi-structured data into a tabular format
  - Created a User Defined Function for Sentiment Analysis
  - Runs analytical SQL queries for insights

<br>
<h3>⚙️ Tech Stack </h3>

| Tool/Service       | Purpose                            |
|--------------------|------------------------------------|
| Python             | File processing  	                |
| AWS S3             | Cloud storage for JSON files       |
| Snowflake          | Data warehousing and SQL analysis  |
| SQL          	     | Querying and transformation        |
| GitHub             | Version control and sharing        |

<br>
<h3>📦 Project Workflow</h3>

**Step 1:** 📥 **Split Yelp JSON File**  
- Use the Yelp business review and business details dataset in JSON format.  
- Split the large business review JSON file into smaller chunks using `python/yelp_file_split.ipynb`.

**Step 2:** ☁️ **Upload to AWS S3**  
- Upload the split JSON files and the business details JSON file to an S3 bucket.

**Step 3:** ❄️ **Ingest Data into Snowflake**  
- Use `sql/copy_into_snowflake_from_aws_s3.sql` to ingest JSON data into Snowflake tables with a `VARIANT` datatype column.

**Step 4:** 🔄 **Flatten the Data & Run Sentiment UDF**  
- Execute `sql/flatten_table.sql` to convert the semi-structured JSON data tables into a tabular format.  
- Run the UDF `sql/snowflake_python_udf.sql` within the same query as a final step to derive **sentiment analysis** for each review, adding it as the last column in the flattened reviews table.

 **Step 5:** 📊 **Perform Analysis** 
- Run queries from `sql/query_analysis.sql` to extract insights from the structured reviews and business detail datasets.
<br>
<h3> 📈 Sample Insights </h3>

Some of the insights generated from the structured Yelp data include:
- Top-rated businesses by category and city
- Average review counts per business type
- Sentiment trends across business types
<br>
<h3>📌 Key Highlights </h3>

- Full end-to-end pipeline built from scratch
- Hands-on with real JSON data and semi-structured ingestion
- Use of cloud services (AWS + Snowflake)
- Modular and production-ready code structure

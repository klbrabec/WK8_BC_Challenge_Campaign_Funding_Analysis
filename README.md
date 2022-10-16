# WK8_BC_Challenge_Campaign_Funding_Analysis
Week 8 Challenge Repo 

## Overview 
This challenge assignment is intended to exercise the following 
- ETL skills 
- Regex Skills
- Database schema development skills 
- Database loading skills 
- Query skills 

## Data Extracts
Source data was provided in the form of a series of CSV files which can be found here: 
[Resource Files] (https://github.com/klbrabec/WK8_BC_Challenge_Campaign_Funding_Analysis/tree/main/Resource%20FIles)

## Data Transformation
The only file that was not provided, but instead built during the extract/transform process is backer_info.  This file was extracted from a file provided as part of the assignment, and transformed to include campaign ID, contact ID, First and Last Name and email address.  Code for the data transformation was done in Jupyter Notebook using Python and its various libraries and modules.    
[Code for transformation:](https://github.com/klbrabec/WK8_BC_Challenge_Campaign_Funding_Analysis/blob/main/Extract-Transform_Final_code.ipynb)
This extract was done in two different methods, one using standard Pandas Python, and one using Regex expressions.
[Pandas Python Results](https://github.com/klbrabec/WK8_BC_Challenge_Campaign_Funding_Analysis/blob/main/Resource%20FIles/backer_info.csv)
[Regex Results](https://github.com/klbrabec/WK8_BC_Challenge_Campaign_Funding_Analysis/blob/main/r_backers_data.csv)

## Data Queries 
A number of queries were executed against the data to return various information. Queries can be found in this file: 
[SQL Analysis:](https://github.com/klbrabec/WK8_BC_Challenge_Campaign_Funding_Analysis/blob/4d39c892c1edf863505a3fd251ccb994ec2b792f/crowdfunding_SQL_Analysis.sql)

## Query Clarifications
One of the bonus assignments indicated that a query should be written that would return the count of backers for all 'live' campaigns.  Live can be interpreted in a number of ways, so the query was written to use both the Outcome column as well as the date the challenge ended.  (See below) 

~~~
SELECT cf_id, backers_count, launch_date, end_date
FROM campaign
WHERE end_date >= now() --will test for active status against current date. (No records are returned due to the data)
ORDER BY backers_count desc; 

~~~
Using the now() function will compare the list of records to the current date and time.  The goal of this is to filter out anything that end_dates in the past, which means the campaign has technically ended, although the data may not have caught up with it.  However, the data set that we were given did not include any dates in the future, everything was prior to 2/28/2022.  Therefore, to test the logic of the select statement, the end_date was compared to 2/1/2022, which returned records.  Further refinement of this query can be done by clarifying if the end_date should be considered as part of the query selection, or if just the outcome column should be used to filter. 

Bonus 3 and Bonus 4 queries asked for a table/list of records that included any outstanding differences between the goal and the pledges for the campaign.  The assumption made was that these lists were going to be made to contact backers for additional funding submissions.  Therefore, the queries were filtered to include only those records that had a non zero outstanding balance between the goal and the total amount of pledges.  This list of records could be expanded by removing the filter for non zero differences when confirmed.  A sample query is shown below.  The logic for both the contact and backers queries is identical.

~~~
SELECT c.contact_id, c.contact_id, c.first_name, c.last_name, c.email, cp.cf_id, cp.company_name, cp.launch_date, cp.end_date, cp.goal-cp.pledged as "outstanding_balance"
FROM contacts AS c 
INNER JOIN campaign AS cp
ON c.contact_id = cp.contact_id 
WHERE cp.goal - cp.pledged > 0
ORDER BY c.email DESC; 
~~~

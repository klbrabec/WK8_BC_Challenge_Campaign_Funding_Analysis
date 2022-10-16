--Rubric Check - Deliverable 3 
-- The crowdfunding_db relationship diagram has five tables, and the diagram is saved as crowdfunding_db_relationships.png. (5 pt) (done)
-- The crowdfunding_db_schema.sql file contains the table schema and the ALTER TABLE statement for each of the five tables. (10 pt)(done)
-- The backers.csv file is imported into the backers table without any errors. (5 pt)(done)

--validate backers import was correct 
select * from backers; ABORT

-- Deliverable Four - Bonus Code 
-- BONUS ONE A SQL query is written and successfully executed that retrieves the number of backer_counts in descending order for each cf_id and for all the live campaigns. (2.5 pt)
-- NOTE - none of the campaigns are active - the last one closed on 2/23/22.  
select * from campaign
order by end_date desc ;

SELECT cf_id, backers_count, launch_date, end_date
FROM campaign
WHERE end_date >= now() --will test for active status against current date. (No records are returned due to the data)
ORDER BY backers_count desc; 

-- Logic test - defining date as 2/1/2021
SELECT cf_id, backers_count, launch_date, end_date
FROM campaign
WHERE end_date >= '2/1/2021'
ORDER BY backers_count desc; 

-- BONUS TWO - A SQL query is written and successfully executed that retrieves the number of backers in descending order for each cf_id from the backers table. (2.5 pt)
-- review data
select * from backers; 

SELECT cf_id, count(cf_id)
INTO backer_count
FROM backers
GROUP BY cf_id 
ORDER BY COUNT DESC; 

-- BONUS THREE - A SQL query is written and successfully executed to create the email_contacts_remaining_goal_amount table, and the table is exported as email_contacts_remaining_goal_amount.csv.
-- review_data 
SELECT * FROM contacts; 

SELECT * from campaign; 

-- logic test 
SELECT c.contact_id, c.contact_id, c.first_name, c.last_name, c.email, cp.cf_id, cp.company_name, cp.launch_date, cp.end_date, cp.goal-cp.pledged as "outstanding_balance"
FROM contacts AS c 
INNER JOIN campaign AS cp
ON c.contact_id = cp.contact_id 
WHERE cp.goal - cp.pledged > 0
ORDER BY c.email DESC; 

-- add Select into to create table 
SELECT c.contact_id, c.first_name, c.last_name, c.email, cp.cf_id, cp.company_name, cp.launch_date, cp.end_date, cp.goal-cp.pledged as "outstanding_balance"
INTO email_contacts_remaining_goal_amount
FROM contacts AS c 
INNER JOIN campaign AS cp
ON c.contact_id = cp.contact_id 
WHERE cp.goal - cp.pledged > 0
ORDER BY c.email DESC; 


-- BONUS FOUR -A SQL query is written and successfully executed to create the email_contacts_remaining_goal_amount table, and the table is exported as email_contacts_remaining_goal_amount.csv.

-- review data
SELECT * FROM campaign; 

SELECT * FROM backers; 
--logic test 
SELECT b.first_name, b.last_name, b.email, c.cf_id, c.company_name, c.launch_date, c.end_date, c.goal - c.pledged as "outstanding_balance"
FROM campaign AS c
INNER JOIN backers AS b
ON c.cf_id = b.cf_id
WHERE c.goal - c.pledged > 0
ORDER BY b.email DESC; 

--add select into statement to create table 
SELECT b.first_name, b.last_name, b.email, c.cf_id, c.company_name, c.launch_date, c.end_date, c.goal - c.pledged as "outstanding_balance"
INTO email_backers_remaining_goal_amount
FROM campaign AS c
INNER JOIN backers AS b
ON c.cf_id = b.cf_id
WHERE c.goal - c.pledged > 0
ORDER BY b.email DESC; 


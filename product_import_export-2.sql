-- create table
CREATE TABLE product_export_imports (
    SentDate DATE,
    ReceivedDate DATE,
    TreatmentDate DATE
);

-- insert data into table
INSERT INTO product_export_imports(SentDate, ReceivedDate, TreatmentDate)
VALUES
    ('2023-09-01', '2023-09-10', '2023-09-20');

-- calculate the differences in days while excluding Sundays and company holidays.
SELECT
    SentDate AS "Raw Material sent date", -- the query selects the three date columns from the product_export_import
    ReceivedDate AS "Finished goods Received date",
    TreatmentDate AS "Treatment Date", 
    
    
    # Task-1:- Difference in number of days between sent date to recieved date.
    
    /* Approach:-
    * DATEDIFF():- Return the number of days between two date values
	* DATEDIFF(ReceivedDate, SentDate) / 7) :- Calculate the total number of days between @enddate and @startdate and then divide it by 7 
		to get the number of weeks.
    * The calculation by directly dividing the number of days by 7,which is the number of days in a week, and then rounding up (using CEIL())
		to ensure any partial week is counted as a whole week.*/
 
     DATEDIFF(ReceivedDate, SentDate) - 
     ( CEIL(DATEDIFF(ReceivedDate, SentDate) / 7)) as "No of days difference Between Received date to sent date",
 
 # Task-2: Difference in number of days between treatment date to recieved  date
 
 /* apply same Approach as same as column name "No of days difference Between Received date to sent date" 
 and -1 represent the number of company Holiday which are comes after the "CEIL(DATEDIFF(TreatmentDate,SentDate) / 7)" */
 DATEDIFF(TreatmentDate, ReceivedDate) - CEIL(DATEDIFF(TreatmentDate,ReceivedDate) / 7)-1  as "Number of days between treatment date to received date",
 
 # Task-3: calculate overall number of days taken during whole process (from sent date to tillTreatment date)

/* apply same Approach as same as  column name "Number of days between treatment date to received date" */
 DATEDIFF(TreatmentDate, SentDate) - 1 - (CEIL(DATEDIFF(TreatmentDate,SentDate) / 7)) -1 as  "Overall number of days taken during the whole process"
 FROM product_export_import;
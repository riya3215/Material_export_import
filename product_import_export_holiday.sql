

-- create table
CREATE TABLE product_export_import (
    SentDate DATE,
    ReceivedDate DATE,
    TreatmentDate DATE
);

-- insert sample data into table
INSERT INTO product_export_import(SentDate, ReceivedDate, TreatmentDate)
VALUES
    ('2023-09-01', '2023-09-10', '2023-09-20'),
    ('2023-12-01', '2023-12-10', '2023-12-20'),
    ('2023-08-01', '2023-08-10', '2023-08-20');
    
    
    
    -- Create a table for Holidays if not already created
    CREATE TABLE IF NOT EXISTS Holidays (
    HolidayDate DATE PRIMARY KEY
);

-- Insert the list of company holidays into the Holidays table
-- You should replace these dates with your actual holiday dates
INSERT INTO Holidays (HolidayDate) VALUES
('2023-01-01'), -- New Year's Day
('2023-01-26'),-- Republic Day
('2023-03-08'), -- Holi
('2023-03-30'), -- Ram navami
('2023-04-07'), -- good friday
('2023-04-22'), -- Eid-ul-fiter
('2023-04-14'), -- B.R. Ambedkar
('2023-06-29'),-- bakrid
('2023-07-29'),-- muharam
('2023-08-15'), -- Independence Day
('2023-09-19'), -- ganesh chathurti
('2023-10-02'), -- mahatma jayanti
('2023-10-23'), -- Dushera
('2023-10-24'), -- Dushera
('2023-11-12'), -- diwali
('2023-11-27'), --  guru nanak jayanti
('2023-12-25'); -- christmas

-- Calculate the differences in days while excluding Sundays and holidays
SELECT
	SentDate AS "Raw Material sent date", -- the query selects the three date columns from the product_export_import
    ReceivedDate AS "Finished goods Received date",
    TreatmentDate AS "Treatment Date", 
    
    
    # Task-1:- Difference in number of days between sent date to recieved date.
    DATEDIFF(ReceivedDate, SentDate) -
    (SELECT
        COUNT(*)
     FROM
        Holidays
     WHERE
        HolidayDate BETWEEN SentDate AND ReceivedDate
     ) -
    (SELECT
        FLOOR((DATEDIFF(ReceivedDate, SentDate) + WEEKDAY(SentDate) + 1) / 7)
     ) AS "No of days difference Between Received date to sent date",

   
   # Task-2: Difference in number of days between treatment date to recieved  date
 
   DATEDIFF(TreatmentDate, ReceivedDate) -
    (SELECT
        COUNT(*)
     FROM
        Holidays
     WHERE
        HolidayDate BETWEEN ReceivedDate AND TreatmentDate
     ) -
    (SELECT
        FLOOR((DATEDIFF(TreatmentDate, ReceivedDate) + WEEKDAY(ReceivedDate) + 1) / 7)
     ) AS "Number of days between treatment date to received date",
     
     
     
# Task-3: calculate overall number of days taken during whole process (from sent date to tillTreatment date)
    DATEDIFF(TreatmentDate, SentDate) -
    (SELECT
        COUNT(*)
     FROM
        Holidays
     WHERE
        HolidayDate BETWEEN SentDate AND TreatmentDate
     ) -
    (SELECT
       ceil((DATEDIFF(TreatmentDate, SentDate) + WEEKDAY(SentDate) + 1) / 7)
     ) AS "Overall number of days taken during the whole process"
FROM
    product_export_import; 
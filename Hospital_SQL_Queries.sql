CREATE TABLE hospital (
    hospital_name      VARCHAR(100),
    location           VARCHAR(100),
    department         VARCHAR(100),
    doctors_count      INT,
    patients_count     INT,
    admission_date     VARCHAR(20),
    discharge_date     VARCHAR(20),
    medical_expenses   DECIMAL(10,2)
);

    copy hospital(
    hospital_name,
    location,
    department,
    doctors_count,
    patients_count,
    admission_date,
    discharge_date,
    medical_expenses
)
  FROM 'C:\Your\File\Hospital_Data.csv'
  DELIMITER ','
  CSV HEADER;

--Total Number of Patients

  SELECT SUM("patients_count")AS total_patients 
   FROM hospital; 
   
--Average Doctors Per Hospital

   SELECT hospital_name, 
     AVG(doctors_count) AS avg_doctors 
     FROM hospital 
     GROUP BY hospital_name;

--Departments by Patient Count

	SELECT department, 
    SUM(patients_count) AS total_patients 
    FROM hospital 
    GROUP BY department 
    ORDER BY total_patients DESC 
    LIMIT 3;
	
--Hospital with the Maximum Medical Expenses  

	  SELECT hospital_name, 
      SUM(medical_expenses) AS total_expenses 
      FROM hospital 
      GROUP BY hospital_name 
      ORDER BY total_expenses DESC 
      LIMIT 1;


--Daily Average Medical Expenses

	  SELECT hospital_name, 
      SUM(medical_expenses) / SUM(discharge_date - admission_date) AS 
      avg_expense_per_day 
      FROM hospital 
      GROUP BY hospital_name;


--Longest Hospital Stay

	  SELECT patients_count, hospital_name, 
      (discharge_date - admission_date) AS stay_duration 
      FROM hospital 
      ORDER BY stay_duration DESC 
      LIMIT 1; 


--Total Patients Treated Per City


	SELECT location AS city, 
    SUM(patients_count) AS total_patients 
    FROM hospital 
    GROUP BY location; 


--Average Length of Stay Per Department 


	 SELECT department, 
     AVG(discharge_date - admission_date) AS avg_days_stay 
     FROM hospital 
     GROUP BY department;


-- Identify the Department with the Lowest Number of Patients 


	  SELECT department, 
      SUM(patients_count) AS total_patients 
      FROM hospital 
      GROUP BY department 
      ORDER BY total_patients ASC 
      LIMIT 1;

-- Monthly Medical Expenses Report  


	 SELECT TO_CHAR(admission_date, 'YYYY-MM') AS month, 
     SUM(medical_expenses) AS total_medical_expenses 
     FROM hospital 
     GROUP BY TO_CHAR(admission_date, 'YYYY-MM') 
     ORDER BY month; 
	  
SELECT * FROM hospital

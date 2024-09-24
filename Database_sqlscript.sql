REM   Script: Wolthers_ProjectPart4_SQL
REM   Turn this one in!!!!

CREATE TABLE Department ( 
    Dept_ID INT PRIMARY KEY, 
    Dept_Name VARCHAR(100) NOT NULL, 
    Dept_Location VARCHAR(255), 
    Dept_Phone_No VARCHAR(255), 
    Dept_Email VARCHAR(255), 
    Supervisor INT   
);

CREATE TABLE Employee ( 
    Employee_ID INT PRIMARY KEY, 
    F_Name VARCHAR(100) NOT NULL, 
    MI_Name VARCHAR(100), 
    L_Name VARCHAR(100) NOT NULL, 
    Badge_No VARCHAR(50) UNIQUE, 
    Phone_No VARCHAR(255), 
    Email VARCHAR(255), 
    Street_Address VARCHAR(255), 
    City_Address VARCHAR(50), 
    State_Address CHAR(2), 
    Zip_Address CHAR(5),    
    Job_Title VARCHAR(50), 
    Dept_ID INT  
);

CREATE TABLE Incident_Report ( 
    Report_ID INT PRIMARY KEY, 
    Report_Date DATE NOT NULL, 
    Location VARCHAR(255), 
    Crime_Type VARCHAR(100), 
    Suspect_Desc VARCHAR(255), 
    Witness_Statement VARCHAR(255), 
    Status VARCHAR(50), 
    SubmittedBy INT   
);

CREATE TABLE Investigation ( 
    Investigation_ID INT PRIMARY KEY, 
    Date_Opened DATE, 
    Status VARCHAR(50), 
    Progress_Notes VARCHAR(2000), 
    Lead_Investigator INT,  
    Incident_Report_ID INT   
);

CREATE TABLE Evidence ( 
    Evidence_ID INT PRIMARY KEY, 
    Incident_Report_ID INT,   
    Evidence_Type VARCHAR(100), 
    Description VARCHAR(1000), 
    File_Location VARCHAR(255), 
    Date_Uploaded DATE 
);

CREATE TABLE Suspect ( 
    Suspect_ID INT PRIMARY KEY, 
    F_Name VARCHAR(100), 
    MI_Name VARCHAR(100), 
    L_Name VARCHAR(100), 
    Height DECIMAL(5,2), 
    Weight DECIMAL(5,2), 
    Hair_Color VARCHAR(50), 
    Eye_Color VARCHAR(50), 
    Build VARCHAR(50), 
    Complexion VARCHAR(50), 
    Distinctive_Marks VARCHAR(1000), 
    Clothing_Desc VARCHAR(1000), 
    Accessories VARCHAR(1000), 
    Age_Range VARCHAR(50), 
    Gender VARCHAR(50), 
    Ethnicity VARCHAR(50), 
    Phone_No VARCHAR(255), 
    Email VARCHAR(255), 
    Street_Address VARCHAR(255), 
    City_Address VARCHAR(50), 
    State_Address CHAR(2), 
    Zip_Address CHAR(5) 
);

CREATE TABLE Investigation_Suspect ( 
    Investigation_ID INT, 
    Suspect_ID INT, 
    PRIMARY KEY (Investigation_ID, Suspect_ID)   
);

CREATE TABLE Forensic_Data ( 
    Forensic_ID INT PRIMARY KEY, 
    Collected_By VARCHAR(100), 
    Collected_Date DATE, 
    Incident_Report_ID INT,  
    Analysis_Type VARCHAR(100), 
    Result VARCHAR(2000), 
    Date_Received DATE, 
    Date_Conducted DATE, 
    Analyzed_By INT   
);

CREATE TABLE Witness ( 
    Witness_ID INT PRIMARY KEY, 
    F_Name VARCHAR(100), 
    MI_Name VARCHAR(100), 
    L_Name VARCHAR(100), 
    Phone_No VARCHAR(255), 
    Email VARCHAR(255), 
    Street_Address VARCHAR(255), 
    City_Address VARCHAR(50), 
    State_Address CHAR(2), 
    Zip_Address CHAR(5), 
    Investigation_ID INT  
);

CREATE TABLE Investigation_Outcome ( 
    Outcome_ID INT PRIMARY KEY, 
    Investigation_ID INT,   
    Outcome_Status VARCHAR(50), 
    Outcome_Details VARCHAR(2000), 
    Date_Closed DATE 
);

INSERT INTO Employee 
VALUES (1, 'John', 'A', 'Doe', 'B123', '555-1234', 'jdoe@police.gov', '123 Main St', 'Springfield', 'IL', '62701', 'Detective', NULL);

INSERT INTO Employee 
VALUES (2, 'Jane', 'B', 'Smith', 'B124', '555-1235', 'jsmith@police.gov', '456 Elm St', 'Springfield', 'IL', '62702', 'Detective', NULL);

INSERT INTO Employee 
VALUES (3, 'Emily', 'C', 'Davis', 'B125', '555-1236', 'edavis@police.gov', '789 Oak St', 'Springfield', 'IL', '62703', 'Forensic Analyst', NULL);

INSERT INTO Employee 
VALUES (4, 'Michael', 'D', 'Brown', 'B126', '555-1237', 'mbrown@police.gov', '101 Maple St', 'Springfield', 'IL', '62704', 'Cyber Crime Specialist', NULL);

INSERT INTO Employee 
VALUES (5, 'William', 'E', 'Johnson', 'B127', '555-1238', 'wjohnson@police.gov', '202 Pine St', 'Springfield', 'IL', '62705', 'Traffic Officer', NULL);

INSERT INTO Department  
VALUES (1, 'Homicide', 'Building A, Floor 3', '123-456-7890', 'homicide@police.gov', 1);

INSERT INTO Department  
VALUES (2, 'Narcotics', 'Building B, Floor 2', '123-456-7891', 'narcotics@police.gov', 2);

INSERT INTO Department  
VALUES (3, 'Forensics', 'Building C, Floor 1', '123-456-7892', 'forensics@police.gov', 3);

INSERT INTO Department  
VALUES (4, 'Cyber Crime', 'Building D, Floor 4', '123-456-7893', 'cybercrime@police.gov', 4);

INSERT INTO Department  
VALUES (5, 'Traffic', 'Building E, Floor 2', '123-456-7894', 'traffic@police.gov', 5);

INSERT INTO Incident_Report  
VALUES (1, TO_DATE('01-JUL-2024', 'DD-MON-YYYY'), 'Downtown', 'Robbery', 'Male, 6ft, Black Hair', 'Saw suspect fleeing the scene', 'Open', 1);

INSERT INTO Incident_Report   
VALUES (2, TO_DATE('02-JUL-2024', 'DD-MON-YYYY'), 'West End', 'Burglary', 'Female, 5ft5, Blonde Hair', 'Neighbor heard noises', 'Closed', 2);

INSERT INTO Incident_Report  
VALUES (3, TO_DATE('03-JUL-2024', 'DD-MON-YYYY'), 'East Side', 'Assault', 'Male, 5ft8, Brown Hair', 'Victim identified suspect', 'Open', 1);

INSERT INTO Incident_Report  
VALUES (4, TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), 'North Side', 'Vandalism', 'Unknown', 'No witnesses', 'Closed', 5);

INSERT INTO Incident_Report   
VALUES (5, TO_DATE('05-JUL-2024', 'DD-MON-YYYY'), 'South Side', 'Drug Trafficking', 'Multiple suspects', 'Anonymous tip-off', 'Open', 2);

INSERT INTO Investigation   
VALUES (1, TO_DATE('01-JUL-2024', 'DD-MON-YYYY'), 'Ongoing', 'Following up on leads', 1, 1);

INSERT INTO Investigation  
VALUES (2, TO_DATE('02-JUL-2024', 'DD-MON-YYYY'), 'Closed', 'Suspect apprehended', 2, 2);

INSERT INTO Investigation  
VALUES (3, TO_DATE('03-JUL-2024', 'DD-MON-YYYY'), 'Ongoing', 'Interviewing witnesses', 1, 3);

INSERT INTO Investigation  
VALUES (4, TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), 'Closed', 'Case closed due to lack of evidence', 5, 4);

INSERT INTO Investigation 
VALUES (5, TO_DATE('05-JUL-2024', 'DD-MON-YYYY'), 'Ongoing', 'Coordinating with DEA', 2, 5);

INSERT INTO Evidence   
VALUES (1, 1, 'Photo', 'Photo of suspect fleeing', '/images/evidence1.jpg', TO_DATE('01-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Evidence   
VALUES (2, 2, 'Fingerprint', 'Fingerprint on window', '/files/evidence2.pdf', TO_DATE('02-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Evidence  
VALUES (3, 3, 'Video', 'CCTV footage of the assault', '/videos/evidence3.mp4', TO_DATE('03-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Evidence  
VALUES (4, 4, 'Tool Mark', 'Tool mark on vandalized wall', '/images/evidence4.jpg', TO_DATE('04-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Evidence  
VALUES (5, 5, 'Substance', 'Seized drugs', '/files/evidence5.pdf', TO_DATE('05-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Suspect  
VALUES (1, 'Jake', 'P', 'Miller', 6.0, 180, 'Black', 'Brown', 'Athletic', 'Fair', 'Scar on left cheek', 'Black hoodie, jeans', 'Watch, ring', '25-30', 'Male', 'Caucasian', '555-9876', 'jmiller@example.com', '789 Cedar St', 'Springfield', 'IL', '62706');

INSERT INTO Suspect  
VALUES (2, 'Anna', 'Q', 'Taylor', 5.5, 130, 'Blonde', 'Blue', 'Slim', 'Light', 'Tattoo on right arm', 'Red dress', 'Necklace', '20-25', 'Female', 'Caucasian', '555-9877', 'ataylor@example.com', '234 Birch St', 'Springfield', 'IL', '62707');

INSERT INTO Suspect  
VALUES (3, 'Mike', 'R', 'Wilson', 5.8, 170, 'Brown', 'Green', 'Average', 'Medium', 'Mole on chin', 'Gray jacket, black pants', 'Sunglasses', '30-35', 'Male', 'African American', '555-9878', 'mwilson@example.com', '456 Willow St', 'Springfield', 'IL', '62708');

INSERT INTO Suspect  
VALUES (4, 'Sara', 'S', 'Johnson', 5.7, 140, 'Red', 'Hazel', 'Athletic', 'Fair', 'Piercing on left eyebrow', 'Blue jeans, white shirt', 'Earrings', '25-30', 'Female', 'Caucasian', '555-9879', 'sjohnson@example.com', '678 Spruce St', 'Springfield', 'IL', '62709');

INSERT INTO Suspect  
VALUES (5, 'Tom', 'T', 'Anderson', 6.1, 200, 'Black', 'Brown', 'Muscular', 'Dark', 'Tattoo on neck', 'Green jacket, brown pants', 'Bracelet', '35-40', 'Male', 'Hispanic', '555-9880', 'tanderson@example.com', '890 Maple St', 'Springfield', 'IL', '62710');

INSERT INTO Investigation_Suspect   
VALUES (1, 1);

INSERT INTO Investigation_Suspect   
VALUES(2, 2);

INSERT INTO Investigation_Suspect   
VALUES(3, 3);

INSERT INTO Investigation_Suspect   
VALUES(4, 4);

INSERT INTO Investigation_Suspect   
VALUES(5, 5);

INSERT INTO Forensic_Data  
VALUES (1, 'Emily Davis', TO_DATE('01-JUL-2024', 'DD-MON-YYYY'), 1, 'DNA Analysis', 'Match found in database', TO_DATE('02-JUL-2024', 'DD-MON-YYYY'), TO_DATE('03-JUL-2024', 'DD-MON-YYYY'), 3);

INSERT INTO Forensic_Data 
VALUES (2, 'Emily Davis', TO_DATE('02-JUL-2024', 'DD-MON-YYYY'), 2, 'Fingerprint Analysis', 'Partial match', TO_DATE('03-JUL-2024', 'DD-MON-YYYY'), TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), 3);

INSERT INTO Forensic_Data  
VALUES (3, 'Emily Davis', TO_DATE('03-JUL-2024', 'DD-MON-YYYY'), 3, 'Substance Analysis', 'Identified as cocaine', TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), TO_DATE('05-JUL-2024', 'DD-MON-YYYY'), 3);

INSERT INTO Forensic_Data   
VALUES (4, 'Emily Davis', TO_DATE('04-JUL-2024', 'DD-MON-YYYY'), 4, 'Tool Mark Analysis', 'Tool linked to previous case', TO_DATE('05-JUL-2024', 'DD-MON-YYYY'), TO_DATE('06-JUL-2024', 'DD-MON-YYYY'), 3);

INSERT INTO Forensic_Data  
VALUES (5, 'Emily Davis', TO_DATE('05-JUL-2024', 'DD-MON-YYYY'), 5, 'Chemical Analysis', 'Substance confirmed as heroin', TO_DATE('06-JUL-2024', 'DD-MON-YYYY'), TO_DATE('07-JUL-2024', 'DD-MON-YYYY'), 3);

INSERT INTO Witness 
VALUES (1, 'Tom', 'A', 'Carter', '555-8765', 'tcarter@example.com', '101 River Rd', 'Springfield', 'IL', '62711', 1);

INSERT INTO Witness 
VALUES(2, 'Laura', 'B', 'White', '555-8766', 'lwhite@example.com', '202 Lake Dr', 'Springfield', 'IL', '62712', 2);

INSERT INTO Witness 
VALUES(3, 'David', 'C', 'Clark', '555-8767', 'dclark@example.com', '303 Hill St', 'Springfield', 'IL', '62713', 3);

INSERT INTO Witness 
VALUES(4, 'Jessica', 'D', 'Lewis', '555-8768', 'jlewis@example.com', '404 Valley Rd', 'Springfield', 'IL', '62714', 4);

INSERT INTO Witness 
VALUES(5, 'Frank', 'E', 'Martin', '555-8769', 'fmartin@example.com', '505 Mountain Rd', 'Springfield', 'IL', '62715', 5);

INSERT INTO Investigation_Outcome   
VALUES (1, 1, 'Ongoing', 'Following up on additional leads', NULL);

INSERT INTO Investigation_Outcome 
VALUES (2, 2, 'Closed', 'Suspect convicted', TO_DATE('10-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Investigation_Outcome  
VALUES (3, 3, 'Ongoing', 'Witnesses cooperating', NULL);

INSERT INTO Investigation_Outcome   
VALUES (4, 4, 'Closed', 'Insufficient evidence', TO_DATE('11-JUL-2024', 'DD-MON-YYYY'));

INSERT INTO Investigation_Outcome   
VALUES (5, 5, 'Ongoing', 'DEA involved', NULL);

ALTER TABLE Employee 
ADD CONSTRAINT FK_Employee_Dept 
FOREIGN KEY (Dept_ID) REFERENCES Department(Dept_ID);

ALTER TABLE Department 
ADD CONSTRAINT FK_Dept_Supervisor 
FOREIGN KEY (Supervisor) REFERENCES Employee(Employee_ID);

ALTER TABLE Incident_Report 
ADD CONSTRAINT FK_IncidentReport_Employee 
FOREIGN KEY (SubmittedBy) REFERENCES Employee(Employee_ID);

ALTER TABLE Investigation 
ADD CONSTRAINT FK_Investigation_LeadInvestigator 
FOREIGN KEY (Lead_Investigator) REFERENCES Employee(Employee_ID);

ALTER TABLE Investigation 
ADD CONSTRAINT FK_Investigation_IncidentReport 
FOREIGN KEY (Incident_Report_ID) REFERENCES Incident_Report(Report_ID);

ALTER TABLE Evidence 
ADD CONSTRAINT FK_Evidence_IncidentReport 
FOREIGN KEY (Incident_Report_ID) REFERENCES Incident_Report(Report_ID);

ALTER TABLE Investigation_Suspect 
ADD CONSTRAINT FK_InvestigationSuspect_Investigation 
FOREIGN KEY (Investigation_ID) REFERENCES Investigation(Investigation_ID);

ALTER TABLE Investigation_Suspect 
ADD CONSTRAINT FK_InvestigationSuspect_Suspect 
FOREIGN KEY (Suspect_ID) REFERENCES Suspect(Suspect_ID);

ALTER TABLE Forensic_Data 
ADD CONSTRAINT FK_ForensicData_IncidentReport 
FOREIGN KEY (Incident_Report_ID) REFERENCES Incident_Report(Report_ID);

ALTER TABLE Forensic_Data 
ADD CONSTRAINT FK_ForensicData_AnalyzedBy 
FOREIGN KEY (Analyzed_By) REFERENCES Employee(Employee_ID);

ALTER TABLE Witness 
ADD CONSTRAINT FK_Witness_Investigation 
FOREIGN KEY (Investigation_ID) REFERENCES Investigation(Investigation_ID);

ALTER TABLE Investigation_Outcome 
ADD CONSTRAINT FK_InvestigationOutcome_Investigation 
FOREIGN KEY (Investigation_ID) REFERENCES Investigation(Investigation_ID);

UPDATE Employee 
SET Dept_ID = 1 
WHERE Employee_ID = 1;

UPDATE Employee 
SET Dept_ID = 2 
WHERE Employee_ID = 2;

UPDATE Employee 
SET Dept_ID = 3 
WHERE Employee_ID = 3;

UPDATE Employee 
SET Dept_ID = 4 
WHERE Employee_ID = 4;

UPDATE Employee 
SET Dept_ID = 5 
WHERE Employee_ID = 5;


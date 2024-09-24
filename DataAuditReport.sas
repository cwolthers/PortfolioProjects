libname sasdata '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4'; 

proc import datafile='/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4/fortune_credit.csv' 
		out=credit; run;

/* PROC CONTENTS */

proc contents data=sasdata.fortune_acct; run;
proc contents data=sasdata.fortune_attrition; run; 
proc contents data=credit; run; 
proc contents data=sasdata.fortune_hr; run;		
proc contents data =sasdata.fortune_survey; run;

/* PROC SQL count */

proc sql; select count(*) from sasdata.fortune_acct; run;
proc sql; select count(*) from sasdata.fortune_attrition; run;
proc sql; select count(*) from credit; run;
proc sql; select count(*) from sasdata.fortune_hr; run;
proc sql; select count(*) from sasdata.fortune_survey; run;

/* My Findings: fortune_acct

		Numeric => DailyRate HourlyRate MonthlyIncome PercentSalaryHike
		
		Categorical =>	Department OverTime	PerformanceRating StockOptionLevel
		
		Date =>					
		
		Character => employee_no ssn	
		
*/

ods select variables;
	proc contents data=sasdata.fortune_acct; run; 	

/*
Alphabetic List of Variables and Attributes
#	Variable			Type		Len		Format		Informat	Label
1	DailyRate			Num			8		BEST12.		BEST32.		DailyRate
2	Department			Char		28		$28.		$28.		Department
3	HourlyRate			Num			8		BEST12.		BEST32.		HourlyRate
4	MonthlyIncome		Num			8		BEST12.		BEST32.		MonthlyIncome
5	OverTime			Char		4		$4.			$4.			OverTime
6	PercentSalaryHike	Num			8		BEST12.		BEST32.		PercentSalaryHike
7	PerformanceRating	Num			8		BEST12.		BEST32.		PerformanceRating
8	StockOptionLevel	Num			8		BEST12.		BEST32.		StockOptionLevel
9	employee_no			Num			8	 	 	 
10	ssn					Char		29	 	 	 
*/
                                           	
		
proc print data=sasdata.fortune_acct (firstobs = 1 obs = 10); run;		
		
/*
Obs	DailyRate	Department				HourlyRate	MonthlyIncome	OverTime	PercentSalaryHike	PerformanceRating	StockOptionLevel	employee_no		ssn
1	1427		Research & Development	65			2693			No			19					3					0					2316			426-63-2008
2	1142		Research & Development	72			4069			Yes			18					3					0					2583			770-67-5241
3	397			Research & Development	54			7756			Yes			19					3					1					2807			847-95-2805
4	314			Human Resources			59			19189			No			12					3					1					3361			348-64-9455
5	1355		Human Resources			61			2942			No			23					4					1					3408			265-44-1378
6	926			Research & Development	36			5265			No			16					3					1					3466			755-99-4420
7	807			Research & Development	38			2437			Yes			16					3					1					3512			170-10-3276
8	458			Research & Development	74			3544			No			16					3					1					3870			760-88-6385
9	448			Sales					74			2033			No			18					3					1					4043			736-52-8184
10	288			Research & Development	99			4152			No			19					3					3					4259			787-67-1561
*/

%let anal_var 	= ssn;
	%let dsin 		= sasdata.fortune_acct;
	
	proc means data=&dsin n nmiss min mean max; var &anal_var; run;
	proc freq data=&dsin; tables &anal_var; run;
	proc sql; select count(distinct &anal_var) from &dsin; quit;
	proc sql; select count(*) from &dsin; quit;

/*	
DailyRate: (1) PROC PRINT suggestive of ratio numeric data ("rate" in variable name)
		   (2) PROC MEANS confirms analytic numeric (MIN: 10.2, MAX: 1499) - this machine numeric variable is not a candidate for 
			   an analytic categorical classification. Therefore, it should be classified as analytic numeric
		   (3) Classification: Analytic numeric	
	
Department: (1) PROC PRINT suggestive of categorical data => repeat category names
	        (2) PROC FREQ confirms analytic categorical => 4 distinct groups
	        (3) Classifictaion: Analytic categorical
	
HourlyRate: (1) PROC PRINT suggestive of ratio numeric data ("rate" in variable name)
		    (2) PROC MEANS confirms analytic numeric (MIN: 30, MAX: 100) - this machine numeric variable is not a candidate for 
			    an analytic categorical classification. Therefore, it should be classified as analytic numeric
		    (3) Classification: Analytic numeric	
	
MonthlyIncome: 	(1) PROC PRINT suggestive of ratio numeric data ("Income" in variable name)
		        (2) PROC MEANS confirms analytic numeric (MIN: 1009, MAX: 199999) - this machine numeric variable is not a candidate for 
			        an analytic categorical classification. Therefore, it should be classified as analytic numeric
		        (3) Classification: Analytic numeric	
	
OverTime: (1) PROC PRINT suggestive of a binary categorical ('Yes' and 'No')
		  (2) PROC FREQ confirms a binary categorical => two distinct values
		  (3) Classification: Analytic categorical
	
PercentSalaryHike: (1) PROC PRINT suggestive of ratio numeric data ("percent" in variable name)
		           (2) PROC MEANS confirms analytic numeric (MIN: 11, MAX: 25) - this machine numeric variable is not a candidate for 
			           an analytic categorical classification. Therefore, it should be classified as analytic numeric
		           (3) Classification: Analytic numeric		
	
PerformanceRating: 	(1) PROC PRINT suggestive of categorical data ("rating" in variable name)
			        (2) PROC FREQ confirms analytic categorical - 2 distinct values 
			        (3) Classification: Analytic categorical
	
StockOptionLevel: 	(1) PROC PRINT suggestive of categorical data ("level" in variable name)
			        (2) PROC FREQ confirms analytic categorical - 4 distinct values
			        (3) Classification: Analytic categorical
	
employee_no: (1) PROC PRINT suggests a number stored as a character
			 (2) PROC PRINT suggests there is a 1:1 relationship with row count
			 (3) PROC SQL => # distinct values = total row count
			 (4) Classification: Analytic character
	
ssn: (1) PROC PRINT suggests character data(ssn unique to the individual)
	 (2) PROC PRINT suggests there is a 1:1 relationship with row count
	 (3) PROC SQL => # distinct values = total row count
	 (4) Classification: Analytic character
*/	
	
/* Output Table */

libname sasdata '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4'; 
%let dataset		= sasdata.fortune_acct;

%let anal_var_num 	= DailyRate HourlyRate MonthlyIncome PercentSalaryHike;
	%let anal_var_cat 	= Department OverTime PerformanceRating StockOptionLevel;
	%let anal_var_char 	= employee_no ssn;
	%let anal_var_date 	= ;
		
%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditNumMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCatMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCharMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditDateMacro.sas';		
		
%let num_var_num = %sysfunc(countw(&anal_var_num)); 
	%let num_var_cat = %sysfunc(countw(&anal_var_cat)); 
	%let num_var_char = %sysfunc(countw(&anal_var_char)); 
	%let num_var_date = %sysfunc(countw(&anal_var_date)); 
	
	%auditnum(&dataset, &anal_var_num);
	%auditcat(&dataset, &anal_var_cat);
	%auditchar(&dataset, &anal_var_char);
	%auditdate(&dataset, &anal_var_date);	

/* My Findings: fortune_acct

		Numeric => 
		
		Categorical =>	
		
		Date =>	depart_dt		
		
		Character => employee_no 	
		
*/

ods select variables;	
proc contents data=sasdata.fortune_attrition; run; 	

/*
Alphabetic List of Variables and Attributes
#	Variable	Type	Len	Format
2	depart_dt	Num		8	MMDDYY8.
1	employee_no	Num		8	 
*/

proc print data=sasdata.fortune_attrition (firstobs = 1 obs = 10); run;	

/*
Obs	employee_no	depart_dt
1	4043		09/19/16
2	11513		10/10/17
3	15843		10/13/16
4	19410		02/19/15
5	20303		08/28/15
6	21550		12/27/15
7	28438		12/23/17
8	31234		08/20/16
9	36877		08/09/16
10	38032		09/01/17
*/

%let anal_var 	= depart_dt;
	%let dsin 	= sasdata.fortune_attrition;
	
	proc means data=&dsin n nmiss min mean max; var &anal_var; run;
	proc freq data=&dsin; tables &anal_var; run;
	proc sql; select count(distinct &anal_var) from &dsin; quit;
	proc sql; select count(*) from &dsin; quit;

/*

employee_no: (1) PROC PRINT suggests a number stored as a character
			 (2) PROC PRINT suggests there is a 1:1 relationship with row count
			 (3) PROC SQL confirms character (237 distinct values)
			 (4) Classification: Analytic character

depart_dt: (1) PROC CONTENTS reads it is a calendar date (format = MMDDYY8.)
		   (2) Confirm with PROC PRINT
		   (3) Classification: Analytic date

/* Output Table */

libname sasdata '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4'; 
%let dataset		= sasdata.fortune_attrition;

%let anal_var_num 	= ;
	%let anal_var_cat 	= ;
	%let anal_var_char 	= employee_no;
	%let anal_var_date 	= depart_dt;
		
%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditNumMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCatMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCharMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditDateMacro.sas';		
		
%let num_var_num = %sysfunc(countw(&anal_var_num)); 
	%let num_var_cat = %sysfunc(countw(&anal_var_cat)); 
	%let num_var_char = %sysfunc(countw(&anal_var_char)); 
	%let num_var_date = %sysfunc(countw(&anal_var_date)); 
	
	%auditnum(&dataset, &anal_var_num);
	%auditcat(&dataset, &anal_var_cat);
	%auditchar(&dataset, &anal_var_char);
	%auditdate(&dataset, &anal_var_date);	


/* My Findings: fortune_credit

		Numeric => fico_scr
		
		Categorical =>	
		
		Date =>			
		
		Character => ssn
		
*/

ods select variables;	
proc contents data=credit; run; 	

/*
Alphabetic List of Variables and Attributes
#	Variable	Type	Len		Format	Informat
2	fico_scr	Num		8		BEST12.	BEST32.
1	ssn			Num		8		BEST12.	BEST32.
*/

proc print data=credit (firstobs = 1 obs = 10); run;	

/*
Obs	ssn			fico_scr
1	736528184	743
2	677031476	790
3	445237643	800
4	624759543	733
5	341126760	722
6	387618865	788
7	117656421	709
8	381245380	788
9	765999887	785
10	457870540	792
*/ 

%let anal_var 	= fico_scr;
	%let dsin 	= credit;
	
	proc means data=&dsin n nmiss min mean max; var &anal_var; run;
	proc freq data=&dsin; tables &anal_var; run;
	proc sql; select count(distinct &anal_var) from &dsin; quit;
	proc sql; select count(*) from &dsin; quit;
	
/*

ssn: (1) PROC PRINT suggests character data(ssn unique to the individual)
	 (2) PROC PRINT suggests there is a 1:1 relationship with row count
	 (3) PROC SQL => # distinct values = total row count
	 (4) Classification: Analytic character
	
fico_scr: (1) PROC PRINT suggestive of numeric data (fico is a credit score)
		  (2) PROC MEANS confirms analytic numeric (MIN: 675, MAX: 820) - this machine numeric variable is not a candidate for 
			  an analytic categorical classification. Therefore, it should be classified as analytic numeric
		  (3) Classification: Analytic numeric	
*/

/* Output Table */

proc import datafile='/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4/fortune_credit.csv' 
		out=credit; 
%let dataset		= credit;

%let anal_var_num 	= fico_scr;
	%let anal_var_cat 	= ;
	%let anal_var_char 	= ssn;
	%let anal_var_date 	= ;
		
%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditNumMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCatMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCharMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditDateMacro.sas';		
		
%let num_var_num = %sysfunc(countw(&anal_var_num)); 
	%let num_var_cat = %sysfunc(countw(&anal_var_cat)); 
	%let num_var_char = %sysfunc(countw(&anal_var_char)); 
	%let num_var_date = %sysfunc(countw(&anal_var_date)); 
	
	%auditnum(&dataset, &anal_var_num);
	%auditcat(&dataset, &anal_var_cat);
	%auditchar(&dataset, &anal_var_char);
	%auditdate(&dataset, &anal_var_date);
	
	
/* My Findings: fortune_hr

		Numeric => 
		
		Categorical =>	Education EducationField Gender birth_state
		
		Date =>	birth_dt hire_dt
		
		Character => employee_no first_name
		
*/

ods select variables;	
proc contents data=sasdata.fortune_hr; run; 	

/*
Alphabetic List of Variables and Attributes
#	Variable		Type	Len	Format	Informat	Label
1	Education		Num		8	BEST12.	BEST32.		Education
2	EducationField	Char	16	$16.	$16.		EducationField
3	Gender			Char	7	$7.		$7.			Gender
7	birth_dt		Num		8	MMDDYY8.	 	 
5	birth_state		Char	2	 	 	 
6	employee_no		Num		8	 	 	 
4	first_name		Char	32	 	 	 
8	hire_dt			Num		8	MMDDYY8.	 	 
*/

proc print data=sasdata.fortune_hr (firstobs = 1 obs = 10); run;

/*
Obs	Education	EducationField		Gender	first_name	birth_state	employee_no	birth_dt	hire_dt
1	1			Other				Female	KALKIDAN	TX			2316		06/26/95	06/26/15
2	2			Life Sciences		Male	SAHMIR		AL			2583		07/26/76	03/06/15
3	2			Medical				Female	LINO		AL			2807		08/23/78	01/12/12
4	3			Human Resources		Male	ASHBY		AL			3361		06/29/75	08/06/94
5	1			Life Sciences		Female	MAZIE		KY			3408		10/14/90	10/14/08
6	2			Medical				Female	ANALY		TN			3466		06/03/74	06/03/11
7	3			Technical Degree	Male	ZYMEIR		OK			3512		03/10/74	03/09/16
8	2			Life Sciences		Male	HRIDAY		LA			3870		04/29/77	04/29/13
9	4			Life Sciences		Male	DILLION		AL			4043		08/06/86	09/19/15
10	3			Life Sciences		Male	RANDALL		IA			4259		02/10/87	02/10/06
*/	

%let anal_var 	= hire_dt;
	%let dsin 	= sasdata.fortune_hr;
	
	proc means data=&dsin n nmiss min mean max; var &anal_var; run;
	proc freq data=&dsin; tables &anal_var; run;
	proc sql; select count(distinct &anal_var) from &dsin; quit;
	proc sql; select count(*) from &dsin; quit;

/*

Education: (1) PROC PRINT suggestive of categorical data => repeat single digit numbers
	       (2) PROC FREQ confirms analytic categorical => 5 distinct groups
	       (3) Classifictaion: Analytic categorical

EducationField: (1) PROC PRINT suggestive of categorical data => repeat category names
	            (2) PROC FREQ confirms analytic categorical => 9 distinct groups
	            (3) Classifictaion: Analytic categorical

Gender: (1) PROC PRINT suggestive of a binary categorical ('Male' and 'Female')
		(3) PROC FREQ confirms a binary categorical with a possible missing (N/A) category
		(4) Classification: Analytic categorical

birth_dt: (1) PROC CONTENTS reads it is a calendar date (format = MMDDYY8.)
		  (2) Confirm with PROC PRINT
		  (3) Classification: Analytic date

birth_state: (1) PROC PRINT suggestive of categorical data => repeat values
	         (2) PROC SQL confirms analytic categorical => 46 distinct values
	         (3) Classifictaion: Analytic categorical

employee_no: (1) PROC PRINT suggests a number stored as a character
			 (2) PROC PRINT suggests there is a 1:1 relationship with row count
			 (3) PROC SQL => # distinct values = total row count
			 (4) Classification: Analytic character

first_name: (1) PROC PRINT reveals it is a first name		
			(2) PROC PRINT suggests there is a very large number, but < 1:1 with row count
			(3) PROC SQL confirms a large number of distinct values, too many to classify as categorical
			(4) Classification: Analytic character

hire_dt: (1) PROC CONTENTS reads it is a calendar date (format = MMDDYY8.)
		 (2) Confirm with PROC PRINT
		 (3) Classification: Analytic date
*/

/* Output Table */

libname sasdata '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4'; 
%let dataset		= sasdata.fortune_hr;

%let anal_var_num 	= ;
	%let anal_var_cat 	= Education EducationField Gender birth_state;
	%let anal_var_char 	= employee_no first_name;
	%let anal_var_date 	= birth_dt hire_dt;
		
%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditNumMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCatMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCharMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditDateMacro.sas';		
		
%let num_var_num = %sysfunc(countw(&anal_var_num)); 
	%let num_var_cat = %sysfunc(countw(&anal_var_cat)); 
	%let num_var_char = %sysfunc(countw(&anal_var_char)); 
	%let num_var_date = %sysfunc(countw(&anal_var_date)); 
	
	%auditnum(&dataset, &anal_var_num);
	%auditcat(&dataset, &anal_var_cat);
	%auditchar(&dataset, &anal_var_char);
	%auditdate(&dataset, &anal_var_date);	
	

/* My Findings: fortune_survey

		Numeric => DistanceFromHome TotalWorkingYears NumCompaniesWorked TrainingTimesLastYear YearsInCurrentRole YearsSinceLastPromotion
		
		YearsWithCurrManager
		
		Categorical =>	BusinessTravel EnvironmentSatisfaction JobInvolvement JobLevel JobSatisfaction MaritalStatus 
		
		RelationshipSatisfaction WorkLifeBalance
		
		Date =>			
		
		Character => employee_no	
		
*/

ods select variables;	
proc contents data=sasdata.fortune_survey; run; 

/*
Alphabetic List of Variables and Attributes
#	Variable					Type	Len	Format	Informat	Label
1	BusinessTravel				Char	19	$19.	$19.		BusinessTravel
2	DistanceFromHome			Num		8	BEST12.	BEST32.		DistanceFromHome
3	EnvironmentSatisfaction		Num		8	BEST12.	BEST32.		EnvironmentSatisfaction
4	JobInvolvement				Num		8	BEST12.	BEST32.		JobInvolvement
5	JobLevel					Num		8	BEST12.	BEST32.		JobLevel
6	JobSatisfaction				Num		8	BEST12.	BEST32.		JobSatisfaction
7	MaritalStatus				Char	9	$9.		$9.			MaritalStatus
8	NumCompaniesWorked			Num		8	BEST12.	BEST32.		NumCompaniesWorked
9	RelationshipSatisfaction	Num		8	BEST12.	BEST32.		RelationshipSatisfaction
10	TotalWorkingYears			Num		8	BEST12.	BEST32.		TotalWorkingYears
11	TrainingTimesLastYear		Num		8	BEST12.	BEST32.		TrainingTimesLastYear
12	WorkLifeBalance				Num		8	BEST12.	BEST32.		WorkLifeBalance
13	YearsInCurrentRole			Num		8	BEST12.	BEST32.		YearsInCurrentRole
14	YearsSinceLastPromotion		Num		8	BEST12.	BEST32.		YearsSinceLastPromotion
15	YearsWithCurrManager		Num		8	BEST12.	BEST32.		YearsWithCurrManager
16	employee_no					Num		8	 	 	 	
*/

proc print data=sasdata.fortune_survey (firstobs = 1 obs = 10); run;

/*
Obs	BusinessTravel		DistanceFromHome	EnvironmentSatisfaction	JobInvolvement	JobLevel	JobSatisfaction	MaritalStatus	NumCompaniesWorked	RelationshipSatisfaction	TotalWorkingYears	TrainingTimesLastYear	WorkLifeBalance	YearsInCurrentRole	YearsSinceLastPromotion	YearsWithCurrManager	employee_no
1	Non-Travel			8					4						3				2			4				Divorced		3					3							8					2						3				2					2						2						2583
2	Travel_Rarely		2					4						2				3			3				Married			3					4							10					6						4				4					0						2						2807
3	Travel_Rarely		1					4						2				5			3				Married			1					2							22					3						3				7					2						10						3361
4	Travel_Frequently	12					2						2				1			1				Married			1					3							1					2						4				0					0						0						4043
5	Travel_Rarely		1					2						2				1			2				Married			0					2							3					2						3				2					2						2						5089
6	Travel_Rarely		15					3						3				1			4				Single			1					1							6					1						3				5					1						5						5909
7	Travel_Rarely		10					4						4				1			3				Married			3					3							10					3						3				7					1						7						6289
8	Travel_Rarely		1					4						1				1			3				Married			3					3							7					2						3				2					0						2						6638
9	Travel_Rarely		26					3						3				1			4	 							1					3							4					2						2				2					0						2						7979
10	Travel_Rarely		4					4						2				5			2				Married			2					3							26					2						3				4					0						8						8563
*/

%let anal_var 	= employee_no;
	%let dsin 	= sasdata.fortune_survey;
	
	proc means data=&dsin n nmiss min mean max; var &anal_var; run;
	proc freq data=&dsin; tables &anal_var; run;
	proc sql; select count(distinct &anal_var) from &dsin; quit;
	proc sql; select count(*) from &dsin; quit;

/*

BusinessTravel: (1) PROC PRINT suggestive of categorical data => repeat category names
	            (2) PROC FREQ confirms analytic categorical => 3 distinct groups
	            (3) Classifictaion: Analytic categorical

DistanceFromHome: (1) PROC PRINT suggestive of ratio numeric data ("distance" in variable name)
		   		  (2) PROC MEANS suggests analytic numeric (MIN: 1, MAX: 29)
		   		  (3) No data dictionary provided. Will analyze as analytic numeric => distance is a measurement
		          (3) Classification: Analytic numeric	

EnvironmentSatisfaction: (1) PROC PRINT suggestive of categorical data => likert scale; repeat single digit numbers
	                     (2) PROC FREQ confirms analytic categorical => 4 distinct values
	                     (3) Classifictaion: Analytic categorical

JobInvolvement: (1) PROC PRINT suggestive of categorical data => likert scale; repeat single digit numbers
	            (2) PROC FREQ confirms analytic categorical => 4 distinct groups
	            (3) Classifictaion: Analytic categorical

JobLevel: (1) PROC PRINT suggestive of categorical data => repeat single digit numbers
	      (2) PROC FREQ confirms analytic categorical => 5 distinct groups
	      (3) Classifictaion: Analytic categorical

JobSatisfaction: (1) PROC PRINT suggestive of categorical data => likert scale; repeat single digit numbers
	             (2) PROC FREQ confirms analytic categorical => 4 distinct values
	             (3) Classifictaion: Analytic categorical 

MaritalStatus: 	(1) PROC PRINT suggestive of categorical data => repeat category names
	            (2) PROC FREQ confirms analytic categorical => 3 distinct groups
	            (3) Classifictaion: Analytic categorical
	            
NumCompaniesWorked: (1) PROC CONTENTS suggests possible numeric data ("num" in variable name) 
			   		(2) PROC MEANS suggests possible analytic numeric (MIN: 0, MAX: 9) - this machine numeric variable is a candidate for 
			   		    an analytic categorical classification. 
			   		(3) PROC CONTENTS label confirms analytic numeric based on variable name
			   		(4) Classification: analytic numeric
		            
RelationshipSatisfaction: (1) PROC PRINT suggestive of categorical data => likert scale; repeat single digit numbers
	                      (2) PROC FREQ confirms analytic categorical => 4 distinct values
	                      (3) Classifictaion: Analytic categorical
	                      
TotalWorkingYears: 	 (1) PROC CONTENTS suggests possible numeric data ("total" in variable name) 
			   		 (2) PROC MEANS suggests possible analytic numeric (MIN: 0, MAX: 40) - this machine numeric variable is a candidate for 
			   		     an analytic categorical classification. 
			   		 (3) PROC CONTENTS label confirms analytic numeric based on variable name
			   		 (4) Classification: analytic numeric
		             
TrainingTimesLastYear: (1) PROC MEANS suggests possible analytic numeric (MIN: 0, MAX: 6) - this machine numeric variable is a candidate for 
			   		       an analytic categorical classification. 
			   		   (2) PROC CONTENTS label confirms analytic numeric based on variable name
			   		   (3) Classification: analytic numeric
			   		   
		               
WorkLifeBalance: (1) PROC PRINT suggestive of categorical data => likert scale; repeat single digit numbers
	             (2) PROC FREQ confirms analytic categorical => 4 distinct values
	             (3) Classifictaion: Analytic categorical 	               
		               
YearsInCurrentRole: (1) PROC CONTENTS suggests possible numeric data ("years" in variable name) 
			   		(2) PROC MEANS suggests possible analytic numeric (MIN: 0, MAX: 18) - this machine numeric variable is a candidate for 
			   		    an analytic categorical classification. 
			   		(3) PROC CONTENTS label confirms analytic numeric based on variable name
			   		(4) Classification: analytic numeric
		               		               
YearsSinceLastPromotion: (1) PROC CONTENTS suggests possible numeric data ("years" in variable name) 
			   		     (2) PROC MEANS suggests possible analytic numeric (MIN: 0, MAX: 15) - this machine numeric variable is a candidate for 
			   		         an analytic categorical classification. 
			   		     (3) PROC CONTENTS label confirms analytic numeric based on variable name
			   		     (4) Classification: analytic numeric	               
		               
YearsWithCurrManager: (1) PROC CONTENTS suggests possible numeric data ("years" in variable name) 
			   		  (2) PROC MEANS suggests possible analytic numeric (MIN: 0, MAX: 17) - this machine numeric variable is a candidate for 
			   		      an analytic categorical classification. 
			   		  (3) PROC CONTENTS label confirms analytic numeric based on variable name
			   		  (4) Classification: analytic numeric	  		               
		               
employee_no: 1) PROC PRINT suggests a number stored as a character
			 (2) PROC PRINT suggests there is a 1:1 relationship with row count
			 (3) PROC SQL => # distinct values = total row count
			 (4) Classification: Analytic character              
		               
/* Output Table */

libname sasdata '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4'; 
%let dataset		= sasdata.fortune_survey;

%let anal_var_num 	= DistanceFromHome TotalWorkingYears NumCompaniesWorked TrainingTimesLastYear YearsInCurrentRole YearsSinceLastPromotion
		YearsWithCurrManager;
	%let anal_var_cat 	= BusinessTravel EnvironmentSatisfaction JobInvolvement JobLevel JobSatisfaction MaritalStatus 	
	RelationshipSatisfaction WorkLifeBalance;
	%let anal_var_char 	= employee_no;
	%let anal_var_date 	= ;
		
%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditNumMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCatMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditCharMacro.sas';
	%include '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Programs/Macros/AuditDateMacro.sas';		
		
%let num_var_num = %sysfunc(countw(&anal_var_num)); 
	%let num_var_cat = %sysfunc(countw(&anal_var_cat)); 
	%let num_var_char = %sysfunc(countw(&anal_var_char)); 
	%let num_var_date = %sysfunc(countw(&anal_var_date)); 
	
	%auditnum(&dataset, &anal_var_num);
	%auditcat(&dataset, &anal_var_cat);
	%auditchar(&dataset, &anal_var_char);
	%auditdate(&dataset, &anal_var_date);			               
		               
/* "merge-by" variable: employee_no and ssn */

libname sasdata '/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4'; 

proc import datafile='/home/u63807598/my_shared_file_links/kevinduffy-deno1/Datafiles/Homework 4/fortune_credit.csv' 
		out=credit; run;          
		               
 
ods select variables;
	proc contents data=sasdata.fortune_acct; run; 
ods select variables;
	proc contents data=sasdata.fortune_attrition; run; 
ods select variables;
	proc contents data=credit; run; 
ods select variables;
	proc contents data=sasdata.fortune_hr; run;               
ods select variables;
	proc contents data=sasdata.fortune_survey; run;               

data acct; set sasdata.fortune_acct; run;

proc sort data=acct; by ssn; run;
proc sort data=credit; by ssn; run;

/* Different ssn type */

data acct2; set acct;
    ssn_num = input(compress(ssn, '-'), best12.);
    drop ssn;
    rename ssn_num = ssn;
run;

data data610.fortune_acct2; set acct2; run;

/* merge using ssn */		               		               
proc sort data=data610.fortune_acct2; by ssn; run;
proc sort data=credit; by ssn; run;

data ssn_merge; merge data610.fortune_acct2 (in=a) credit (in=b); by ssn; if a; run;

/* merge by "employee_no" ===> left join*/
data attrition; set sasdata.fortune_attrition; run;
data hr; set sasdata.fortune_hr; run;
data survey; set sasdata.fortune_survey; run;

proc sort data=ssn_merge; by employee_no; run;
proc sort data=attrition; by employee_no; run;
proc sort data=hr; by employee_no; run;
proc sort data=survey; by employee_no; run;

data fortune_master; merge ssn_merge (in=a)	attrition hr survey; by employee_no; if a; run;		               
		               		               
data data610.fortune_master; set fortune_master; run; 		               

/* modeling sample */               
proc sql; select count(*) from attrition; quit;
	               
/* Deduplicate */

proc sort data=data610.fortune_master out=data610.new_fortune_master nodupkey;
    by employee_no;
run;		               	
		
proc sql;
    create table before_row_count as
    select count(*) as total_rows
    from data610.fortune_master; 
quit;		               

proc sql;
    create table after_row_count as
    select count(*) as total_rows
    from data610.new_fortune_master; 
quit;

proc print data=before_row_count; run; 		               
proc print data=after_row_count; run;

/* NEW VARIABLES ===> AGE and TENURE */
data fortune_dedup; set data610.new_fortune_master;
age	=	floor(yrdif(birth_dt,mdy(6,1,2018),'actual'));
analysis_dt = mdy(6,1,2018);
if missing(depart_dt) then tenure_date = analysis_dt;
    else tenure_date = depart_dt;
    tenure = floor(yrdif(hire_dt, tenure_date, 'ACT/ACT'));
    drop tenure_date;
    drop analysis_dt;
run;

proc means data=fortune_dedup n mean median; var age; run;
proc means data=fortune_dedup n mean median; var tenure; run;

/*===> findings

Age:

	ISSUE					FINDING
	Missing values			missing in 270 cases (5.9%)
	Low extreme values		None. MIN: 19 ==> OK
	High extreme values		None. MAX:61 ==> OK
	Skewness				Roughly normal distribution. Skewness: 0.422
*/

proc means data=fortune_dedup nmiss n min max std mean median skew; var age; run;
proc sgplot data=fortune_dedup;
  		histogram age;
  	 run;

/*===> findings

Tenure:

	ISSUE					FINDING
	Missing values			None
	Low extreme values  	Potential low extremes with values <1; using top/bottom1%
	High extreme values		Potential high extremes with values >30; using top/bottom1%
	Skewness				Rightward skew ==> 1.699
*/

proc means data=fortune_dedup nmiss n min max std mean median skew; var tenure; run;
proc sgplot data=fortune_dedup;
  		histogram tenure;
  	 run;

 /* Top/Bottom 1% */

%let anal_var = tenure; 

proc means data=fortune_dedup p1 p99; var &anal_var; output out = tbstats p1=bot1 p99=top1; run; 
 
 	proc print data=tbstats; run;
 	

data df_rows; set fortune_dedup; rows = _n_; run;  		
data stats_rows; set tbstats; rows = _n_; run;  		


data df_topbot; set fortune_dedup; if _n_ = 1 then set tbstats;  

	if &anal_var > top1 then ev_&anal_var. = 1; 	
	else if &anal_var < bot1 then ev_&anal_var. = 1; 
	else ev_&anal_var. = 0; 
	
	upper_cutoff = top1;
	lower_cutoff = bot1;
	
run; 

	proc freq data=df_topbot; tables ev_&anal_var.; run; 
	proc sql; select count(*) from df_topbot where &anal_var < lower_cutoff; 
	proc sql; select count(*) from df_topbot where &anal_var > upper_cutoff; 

/* CREATE TARGET VARIABLE ====> ATT_Q */

data fortune_dedup;
    set fortune_dedup;
 
if JobLevel ^= . and depart_dt ^= . then ATT_Q = 1;       /* Took survey and left */
    else if JobLevel ^= . then ATT_Q = 0;                 /* Took survey but didn't leave */
    else ATT_Q = .;                                       /* Did not take survey, so ATT_Q is missing */
run;

proc freq data = fortune_dedup; tables ATT_Q; run;

/* Impute using PMM for AGE */

data one; set fortune_dedup;
		age_mi		= age;
	    age_mi_dum 	= missing(age); 
	 run;
	 	
	 proc print data=one (firstobs=1 obs=25); var age age_mi age_mi_dum; run;	

proc mi data=one nimpute=1 seed=1234 out=dedup_imputed; 
		fcs regpmm(age_mi = Education hire_dt);
		var age_mi Education hire_dt; 
	run;   		

proc means data=dedup_imputed n nmiss min mean median max std; var age age_mi; run; 
	
	proc sgplot data=dedup_imputed; 
		    histogram age / binwidth=1 transparency=.5;
		    histogram age_mi / binwidth=1 transparency=.5; ; run;  

	proc sgplot data=dedup_imputed; 
			    hbox age / transparency=.5;
			    hbox age_mi / transparency=.5; 
			 run;

proc corr data=dedup_imputed; var age age_mi; with Education; run;	
proc corr data=dedup_imputed; var age age_mi; with hire_dt; run;	


/* ======> TASK #4 <====== */

%let anal_var 		= tenure;	
%let target_var  	= ATT_Q;				
%let dsn			= dedup_imputed;

/*Equal Height */
ods output mapping=mapping;
proc hpbin data=&dsn output=df_bin numbin=10 pseudo_quantile; input &anal_var; run;	
proc hpbin data=&dsn woe bins_meta=mapping; target &target_var; run;	

ods output mapping=mapping;
proc hpbin data=&dsn output=df_bin numbin=4 pseudo_quantile; input &anal_var; run;	
proc hpbin data=&dsn woe bins_meta=mapping; target &target_var; run;	

/*Equal Width */
ods output mapping=mapping;
proc hpbin data=&dsn numbin=10 bucket; input &anal_var; run;
proc hpbin data=&dsn woe bins_meta=mapping; target &target_var; run;      

ods output mapping=mapping;
proc hpbin data=&dsn numbin=2 bucket; input &anal_var; run;
proc hpbin data=&dsn woe bins_meta=mapping; target &target_var; run; 

/* Dummy Variables */

data bin1; set &dsn;
	if age in(.) then dum_age_miss = 1;					else dum_age_miss = 0;
	if age > 0    and age < 30 then dum_age_lt30 = 1; 		else dum_age_lt30 = 0;
	if age >= 30  and age < 35 then dum_age_30_35 = 1; 	else dum_age_30_35 = 0;
	if age >= 35  and age < 39 then dum_age_35_39 = 1; 	else dum_age_35_39 = 0;
	if age >= 39  and age < 46 then dum_age_39_46 = 1; 	else dum_age_39_46 = 0;
	if age >= 46               then dum_age_gt46 = 1; 	else dum_age_gt46 = 0;
run;

proc sort data=bin1; by &target_var; run; 
proc means data=bin1 sum;
	var dum_age_miss dum_age_lt30 dum_age_30_35 dum_age_35_39 dum_age_39_46 dum_age_gt46; 
	output out = age_mean_results sum= dum_age_miss dum_age_lt30 dum_age_30_35 dum_age_35_39 dum_age_39_46 dum_age_gt46 /autoname; 
	by &target_var; where &target_var ^= .; run;
proc transpose data=age_mean_results out=tenure_tall_skinny1(drop=_NAME_ );
    id &target_var; run;
proc print data=tenure_tall_skinny1;
run;

data bin2; set &dsn;
	if tenure in(.)                   then dum_tenure_miss = 1;	  else dum_tenure_miss = 0;
	if tenure < 4                     then dum_tenure_lt4 = 1; 	   else dum_tenure_lt4 = 0;
	if tenure >= 4  and tenure < 6    then dum_tenure_4_6 = 1; 	   else dum_tenure_4_6 = 0;
	if tenure >= 6  and tenure < 10   then dum_tenure_6_10 = 1;    else dum_tenure_6_10 = 0;
	if tenure >= 10                   then dum_tenure_gt10 = 1;   else dum_tenure_gt10 = 0;
run;

proc sort data=bin2; by &target_var; run; 
proc means data=bin2 sum; var dum_tenure_miss dum_tenure_lt4 dum_tenure_4_6 dum_tenure_6_10 dum_tenure_gt10; 
	output out = tenure_mean_results sum = dum_tenure_miss dum_tenure_lt4 dum_tenure_4_6 dum_tenure_6_10 dum_tenure_gt10 /autoname; 
	by &target_var; where &target_var ^= .;run;

proc transpose data=tenure_mean_results out=tenure_tall_skinny2(drop=_NAME_ );
    id &target_var; run;

proc print data=tenure_tall_skinny2;
run;

/* PROC CORR */

proc corr data=bin2; var dum_tenure_gt10; with ATT_Q; run;	
proc corr data=bin1; var dum_age_gt46; with ATT_Q; run;
LIBNAME mylib '/home/u63807598/my_courses/ANA625/Data';

DATA alc_df;
   SET mylib.df;
run;

proc freq data=alc_df; tables veteran3; run;

DATA vet_df;
   SET alc_df;
   WHERE veteran3 = 1;
RUN;

proc freq data=vet_df; tables veteran3; run;

/* New DF */

DATA bdvet_df;
    SET vet_df (KEEP = _SEX _RFHLTH _RFBING6 _SMOKER3 _MENT14D VETERAN3 _HLTHPLN _TOTINDA);
RUN;

DATA test_df;
    SET bdvet_df;
    IF _RFBING6 NE 9 AND _MENT14D NE 9 AND _SMOKER3 NE 9 AND _RFHLTH NE 9 AND _HLTHPLN NE 9
    AND _TOTINDA NE 9;
RUN;

PROC freq DATA=test_df;
RUN;

/* Recoding */
	
DATA bdvet_df;
    SET TEST_df;
    
    /* SEX */
    IF _SEX = 1 THEN SEX = 0;
    ELSE SEX = 1;
    
    /* GENHLTH */
    IF _RFHLTH = 2 THEN GENHLTH = 0;
    ELSE GENHLTH = 1;
    
    /* EXERCISE */
    IF _TOTINDA = 2 THEN EXERCISE = 0;
    ELSE EXERCISE = 1;
    
    /* BINGE */
    IF _RFBING6 = 1 THEN BINGE = 0;
    ELSE BINGE = 1;
    
    /* SMOKER */
    IF _SMOKER3 = 4 THEN SMOKER = 0;
    ELSE IF _SMOKER3 IN (1,2) THEN SMOKER = 2; 
    ELSE SMOKER = 1;
    
    /* MENTHLTH */
    IF _MENT14D IN (1,2) THEN MENTHLTH = 0;
    ELSE MENTHLTH = 1;
    
    /* HLTHINS */
    IF _HLTHPLN = 2 THEN HLTHINS = 0;
    ELSE HLTHINS = 1;
    
RUN;

proc freq data=BDVET_df; RUN;

/* PROC FORMAT */

proc format;
	value SEX 		        1="Female"
                			0="Male";       
	value GENHLTH		    1="Good or Better Health"
   							0="Fair or Poor Health";
    value BINGE 	        1="Yes"
                			0="No";
    value SMOKER		    0="Never smoked"
    						1="Former smoker"
    						2="Current smoker"; 		
    value MENTHLTH		    1="14+ days"
   							0="0-13 days";
   	value HLTHINS			1="Yes"
   							0="No";
   	value EXERCISE			1="Yes"
   							0="No";
run;
 
 /* Table 1 */
proc freq data=bdvet_df;
    tables SEX / nocum;
run;

proc freq data=bdvet_df;
    tables HLTHINS / nocum;
run;

proc freq data=bdvet_df;
    tables SMOKER / nocum;
run;

proc freq data=bdvet_df;
    tables GENHLTH / nocum;
run;

proc freq data=bdvet_df;
    tables EXERCISE / nocum;
run;

proc freq data=bdvet_df;
    tables BINGE / nocum;
run;

proc freq data=bdvet_df;
	tables SEX*BINGE / nocum nocol norow nopercent chisq;
run;

proc freq data=bdvet_df;
	tables HLTHINS*BINGE / nocum nocol norow nopercent chisq;
run;

proc freq data=bdvet_df;
	tables SMOKER*BINGE / nocum nocol norow nopercent chisq;
run;

proc freq data=bdvet_df;
	tables GENHLTH*BINGE / nocum nocol norow nopercent chisq;
run;

proc freq data=bdvet_df;
	tables EXERCISE*BINGE / nocum nocol norow nopercent chisq;
run;

/* Table 2 */

proc freq data=bdvet_df;
    tables MENTHLTH / nocum;
run;

proc freq data= bdvet_df; 
    tables (BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE)*MENTHLTH / norow nocol nopercent chisq; run;


/* Table 3 */

proc logistic data=bdvet_df; 
    class MENTHLTH (ref='0') BINGE (ref='0') SEX (ref='0') HLTHINS (ref='0') SMOKER (ref='0') GENHLTH (ref='0') EXERCISE (ref='0')/
    param=ref; 
    model MENTHLTH = BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE / aggregate scale=none lackfit; 
run;

/* deviance */

proc logistic data=bdvet_df;
	class MENTHLTH (ref='0') BINGE (ref='0') SEX (ref='0') HLTHINS (ref='0') SMOKER (ref='0') GENHLTH (ref='0') EXERCISE (ref='0')/
    param=ref; 
	model MENTHLTH = BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE / aggregate scale=none rsq;
run;

/* AUC */

proc logistic data=bdvet_df descending plots(only)=roc;
	model MENTHLTH = BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE / rsq;
run;


/* Confounding */

proc logistic data=bdvet_df; 
    class MENTHLTH (ref='0') BINGE (ref='0') SEX (ref='0') HLTHINS (ref='0') SMOKER (ref='0') GENHLTH (ref='0') EXERCISE (ref='0')/
    param=ref; 
    model MENTHLTH = BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE / aggregate scale=none lackfit; 
run;

/* machine curated */

proc logistic data=bdvet_df descending; 
	class MENTHLTH (ref='0') BINGE (ref='0') SEX (ref='0') HLTHINS (ref='0') SMOKER (ref='0') GENHLTH (ref='0') EXERCISE (ref='0')/
    param=ref; 
	model MENTHLTH = BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE binge*sex binge*hlthins binge*smoker binge*genhlth
	 binge*exercise / include = 1 selection = backward sls=.05; 
	oddsratio binge; 
run;		


/* hand curated */

proc logistic data=bdvet_df descending;
	model MENTHLTH = BINGE SEX HLTHINS SMOKER GENHLTH EXERCISE binge*sex binge*hlthins binge*smoker binge*genhlth
	binge*exercise / aggregate scale=none lackfit;
run; 
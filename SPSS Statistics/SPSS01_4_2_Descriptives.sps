* File:    SPSS01_4_2_Descriptives.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 4: Basic statistics
* Section: 2: Descriptives
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-12

* LOAD DATA **************************************************************

* You can navigate to the sample data folder and open the
* file "demo.sav." Or you can use one of the following 
* syntax commands, depending on your computer. If you're 
* using a different verson of SPSS, just change the number
* in the command to match your version.

* This format is for a Mac running SPSS 22.
GET 
  FILE='/Applications/IBM/SPSS/Statistics/22/Samples/English/demo.sav'.
DATASET NAME $data WINDOW=FRONT.
DATASET ACTIVATE $data.

* This format is for a Windows machine running SPSS 22.
GET 
  FILE='C:\Program Files\IBM\SPSS\Statistics\22\Samples\English\demo.sav'.
DATASET NAME $data WINDOW=FRONT.
DATASET ACTIVATE $data.

* Go to data window and check measurement scales for variables.

* DEFAULT DESCRIPTIVES ***************************************************

DESCRIPTIVES VARIABLES=age marital address income inccat car carcat ed  
    employ retire empcat jobsat reside wireless multline voice pager 
    internet callid callwait owntv ownvcr owncd ownpda ownpc ownfax news 
    response
  /STATISTICS=MEAN STDDEV MIN MAX.

* CHECK ERRORS ***********************************************************

* Browse the minimum and maximum values for a quick-and-dirty version of 
* data verification. (NOTE: This still can't replace more thorough
* checking of data. Do your homework.)

* PROPORTIONS ************************************************************

* If you have indicator variables – binary or dichotomous variables coded
* as 0 and 1, then the mean is the same as the proportion of 1s. (This 
* works best of 0 = "False" or "No" and 1 = "True" or "Yes." Strangely,
* that is NOT the case for the last two variables in the SPSS dataset
* demo.sav.)

* Z-SCORES ***************************************************************

* Oddly, this function is an option in DESCRIPTIVES and NOT in the
* TRANSFORM menu. Just check "Save standardized values as variables."

DESCRIPTIVES VARIABLES=age income
  /SAVE
  /STATISTICS=MEAN STDDEV MIN MAX.

DESCRIPTIVES VARIABLES=Zage Zincome
  /STATISTICS=MEAN STDDEV MIN MAX.

* Note: Don't save these new variables to the demonstration data set.

* SAVE FILES AND CLOSE WINDOWS *******************************************








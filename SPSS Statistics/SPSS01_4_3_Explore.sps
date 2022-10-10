* File:    SPSS01_4_3_Explore.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 4: Basic statistics
* Section: 3: Explore
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-13

* LOAD DATA ***************************************************************

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

* DEFAULTS ****************************************************************

EXAMINE VARIABLES=age inccat
  /PLOT BOXPLOT STEMLEAF
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* ADDITIONAL STATISTICS ***************************************************

EXAMINE VARIABLES=age inccat
  /PLOT NONE
  /MESTIMATORS HUBER(1.339) ANDREW(1.34) HAMPEL(1.7,3.4,8.5) TUKEY(4.685)
  /PERCENTILES(5,10,25,50,75,90,95) HAVERAGE
  /STATISTICS DESCRIPTIVES EXTREME
  /CINTERVAL 80
  /MISSING LISTWISE
  /NOTOTAL.

* ADDITIONAL PLOTS ********************************************************

EXAMINE VARIABLES=age inccat
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS NONE
  /CINTERVAL 80
  /MISSING LISTWISE
  /NOTOTAL.

* ANALYSIS BY GROUPS ******************************************************

EXAMINE VARIABLES=income BY gender
  /PLOT BOXPLOT HISTOGRAM NPPLOT SPREADLEVEL
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

* SAVE FILES AND CLOSE WINDOWS ********************************************


* File:    SPSS01_4_1_Frequencies.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 4: Basic statistics
* Section: 1: Frequencies
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-09

* LOAD DATA **********************************************************************

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

* SIMPLE FREQUENCIES *************************************************************

* Works for any kind of variable.
FREQUENCIES VARIABLES=gender jobsat
  /ORDER=ANALYSIS.

* BAR CHARTS FOR FREQUENCIES *****************************************************

* Can turn off tables and just do bar charts for frequencies.
FREQUENCIES VARIABLES=gender jobsat
  /FORMAT=NOTABLE
  /BARCHART FREQ
  /ORDER=ANALYSIS.

* CHARTS AND STATISTICS FOR SCALED VARIABLES *************************************

FREQUENCIES VARIABLES=age reside jobsat
  /FORMAT=NOTABLE
  /NTILES=4
  /NTILES=5
  /PERCENTILES=2.5 97.5 
  /STATISTICS=STDDEV VARIANCE MINIMUM MAXIMUM MEAN SKEWNESS SESKEW KURTOSIS SEKURT
  /HISTOGRAM NORMAL
  /ORDER=ANALYSIS.

* SAVE FILES AND CLOSE WINDOWS ***************************************************




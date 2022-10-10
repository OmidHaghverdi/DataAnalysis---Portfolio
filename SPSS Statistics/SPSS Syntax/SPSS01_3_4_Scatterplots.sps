* File:    SPSS01_3_4_Scatterplots.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 3: Basic graphics
* Section: 4: Scatterplots
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-09

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

* SIMPLE SCATTER *********************************************************

GRAPH
  /SCATTERPLOT(BIVAR)=age WITH income
  /MISSING=LISTWISE.

* MATRIX SCATTER *********************************************************

GRAPH
  /SCATTERPLOT(MATRIX)=income age address reside ed
  /MISSING=LISTWISE.

* SAVE FILES AND CLOSE WINDOWS *******************************************

* File:    SPSS01_3_2_BarCharts.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 3: Basic graphics
* Section: 2: Bar charts
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-09

* LOAD DATA ****************************************************************************

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

* SIMPLE BAR CHART FOR GROUPS OF CASES *************************************************

GRAPH
  /BAR(SIMPLE)=COUNT BY ed.

* Compare this to the code (and graph) from the Chart Builder.

GGRAPH 
  /GRAPHDATASET NAME="graphdataset" VARIABLES=ed MISSING=LISTWISE REPORTMISSING=NO 
  /GRAPHSPEC SOURCE=INLINE. 
BEGIN GPL 
  SOURCE: s=userSource(id("graphdataset")) 
  DATA: ed=col(source(s), name("ed")) 
  GUIDE: axis(dim(1), label("Level of education")) 
  GUIDE: axis(dim(2), label("Frequency")) 
  ELEMENT: interval(position(summary.count(bin.rect(ed))), shape.interior(shape.square)) 
END GPL.

* CLUSTERED BAR CHART FOR GROUPS OF CASES **********************************************

GRAPH
  /BAR(GROUPED)=COUNT BY ed BY gender.

* SIMPLE BAR CHART FOR SEPARATE VARIABLES **********************************************

GRAPH
  /BAR(SIMPLE)=MEAN(wireless) MEAN(multline) MEAN(voice) MEAN(pager) MEAN(internet)
    MEAN(callid) MEAN(callwait) MEAN(owntv) MEAN(ownvcr) MEAN(owncd) MEAN(ownpda) 
    MEAN(ownpc) MEAN(ownfax)
  /MISSING=LISTWISE.

* SAVE FILES AND CLOSE WINDOWS *********************************************************

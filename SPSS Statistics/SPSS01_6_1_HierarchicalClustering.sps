* File:    SPSS01_6_1_HierarchicalClustering.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 6: Analyzing data
* Section: 1: Hierarchical clustering
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-14

* LOAD DATA **********************************************************************

* We'll use a data set called "cars.sav," which I adapted from a sample data set
* in R called "mtcars." It contains road test data for several cars from 1974.
* I included most of the variables and then added variable and value labels for 
* SPSS, in addition to setting decimals and levels of measurement.

* Download the data set from the course files and save it to your desktop.
* To open it, you can just double-click on it or you can use one of the following
* syntax commands, depending on your computer.

* This format is for a Mac.
GET
  FILE='/Users/bart/Desktop/cars.sav'.
DATASET NAME CarsData WINDOW=FRONT.

* This format is for a Windows PC.
GET
  FILE='/Users/bart/Desktop/cars.sav'.
DATASET NAME CarsData WINDOW=FRONT.

* DEFAULT HIERARCHICAL CLUSTERING ************************************************

CLUSTER   mpg cyl disp hp wt qsec am gear carb
  /METHOD BAVERAGE
  /MEASURE=SEUCLID
  /ID=car
  /PRINT SCHEDULE
  /PLOT VICICLE.

* DENDROGRAM ONLY ****************************************************************

CLUSTER   mpg cyl disp hp wt qsec am gear carb
  /METHOD BAVERAGE
  /MEASURE=SEUCLID
  /ID=car
  /PLOT DENDROGRAM
  /PRINT NONE.

* SAVE CLUSTER MEMBERSHIP ********************************************************

* Use dendrogram to select the number of clusters to save.

CLUSTER   mpg cyl disp hp wt qsec am gear carb
  /METHOD BAVERAGE
  /MEASURE=SEUCLID
  /ID=car
  /PLOT NONE
  /PRINT NONE
  /SAVE CLUSTER(4).

* SAVE FILES AND CLOSE WINDOWS ***************************************************


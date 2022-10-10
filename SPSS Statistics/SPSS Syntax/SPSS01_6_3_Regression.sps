* File:    SPSS01_6_3_Regression.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 6: Analyzing data
* Section: 3: Regression
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-15

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

* This format is for a Windows PC (you may need to use backslashes instead).
GET
  FILE='/Users/bart/Desktop/cars.sav'.
DATASET NAME CarsData WINDOW=FRONT.

* DEFAULT REGRESSION *************************************************************

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT mpg
  /METHOD=ENTER cyl disp hp wt qsec am gear carb.

* REGRESSION WITH OPTIONS ********************************************************

* Uses stepwise model (but be careful!)
* Statistics: confidence intervals and R^2 change
* Plots: standardized residual plots

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA CHANGE
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT mpg
  /METHOD=STEPWISE cyl disp hp wt qsec am gear carb
  /RESIDUALS HISTOGRAM(ZRESID) NORMPROB(ZRESID).

* SAVE FILES AND CLOSE WINDOWS ***************************************************


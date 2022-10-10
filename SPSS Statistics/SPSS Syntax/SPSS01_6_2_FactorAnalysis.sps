* File:    SPSS01_6_2_FactorAnalysis.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 6: Analyzing data
* Section: 2: Factor analysis
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

* DEFAULT FACTOR ANALYSIS ********************************************************

* This is actually a principal components analysis.
FACTOR
  /VARIABLES mpg cyl disp hp wt qsec am gear carb
  /MISSING LISTWISE 
  /ANALYSIS mpg cyl disp hp wt qsec am gear carb
  /PRINT INITIAL EXTRACTION
  /CRITERIA MINEIGEN(1) ITERATE(25)
  /EXTRACTION PC
  /ROTATION NOROTATE
  /METHOD=CORRELATION.

* FACTOR ANALYSIS WITH OPTIONS ***************************************************

* Extraction: Use principal axis factoring, increase iterations to 50.
* Rotation: Orthogonal rotation (varimax) produces uncorrelated factors.  
*   Oblique methods, such as oblimin or promax, allow correlated factors.
* Show scree plot and loading plots.
* Increase iterations for convergence.
* Sort coefficients, suppress values below |.6|.

FACTOR
  /VARIABLES mpg cyl disp hp wt qsec am gear carb
  /MISSING LISTWISE 
  /ANALYSIS mpg cyl disp hp wt qsec am gear carb
  /FORMAT SORT BLANK(.6)
  /PLOT EIGEN ROTATION
  /CRITERIA MINEIGEN(1) ITERATE(50)
  /EXTRACTION PAF
  /CRITERIA ITERATE(50) DELTA(0)
  /ROTATION OBLIMIN
  /METHOD=CORRELATION.

* OUTPUT *************************************************************************

* Factor matrix: Assocation of variables with each factor. Analogous to r.

* Structure matrix: Degree to which variable is predicted by factor, using both
*   unique and common contributions.

* Pattern matrix: Unique contribution of each factor to variable's variance.

* SAVE FILES AND CLOSE WINDOWS ***************************************************





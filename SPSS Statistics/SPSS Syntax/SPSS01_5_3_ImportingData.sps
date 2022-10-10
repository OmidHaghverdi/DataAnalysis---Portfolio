* File:    SPSS01_5_3_ImportingData.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 5: Accessing data
* Section: 3: Importing data
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-14

* GET DATA ***********************************************************************

* If you are logged in, you can download the course files. Download and unzip the 
* folder "SPSS01_5_3_ImportingData_Datasets," which has three files in it:
* (1) mbb.csv; (2) mbb.txt; and (3) mbb.xlsx. Save these files to your desktop.
* (Note: "mbb" stands for "Mozart, Beethoven, Bach.")

* UPDATE FILE PATH ***************************************************************

* If you want to open the files using the syntax examples below, you'll need to
* change the file path to match your own computer. On a Mac, all you need to do 
* is changed "bart" to the name of your user folder. On a Windows computer, the
* file path is like this: C:/Users/bart/Desktop/mbb.csv (but still change "bart"
* to the name of your home directory). Also, depending on your version of Windows, 
* you may need to use backslashes instead of forward slashes, like this: 
* C:\Users\bart\Desktop\mbb.csv

* USING THE SPSS TEXT IMPORT WIZARD **********************************************

* The easiest way to import TXT or CSV files is with the SPSS Text Import Wizard.
* Simply go to File > Open > Data... and choose a file.

* IMPORT TXT FILE ****************************************************************

GET DATA  /TYPE=TXT
  /FILE="/Users/bart/Desktop/mbb.txt"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS="\t"
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  Month A7
  Mozart F3.0
  Beethoven F2.0
  Bach F2.0.
CACHE.
EXECUTE.
DATASET NAME TXTData WINDOW=FRONT.


* IMPORT CSV FILE ****************************************************************

* The only difference when importing CSV files, apart from the file name, is that
* the delimiter specified is a comma instead of a tab.

GET DATA  /TYPE=TXT
  /FILE="/Users/bart/Desktop/mbb.csv"
  /ENCODING='Locale'
  /DELCASE=LINE
  /DELIMITERS=","
  /ARRANGEMENT=DELIMITED
  /FIRSTCASE=2
  /IMPORTCASE=ALL
  /VARIABLES=
  Month A7
  Mozart F3.0
  Beethoven F2.0
  Bach F2.0.
CACHE.
EXECUTE.
DATASET NAME CSVData WINDOW=FRONT.

* IMPORT EXCEL XLS/XLSX FILE *****************************************************

* Make sure you have "tidy data." That means one sheet, column == variable, and
* row == case. Also no formulas, macros, graphics, formatting, comments, or 
* merged cells. (That is, as similar to a CSV as possible. It is possible to
* have multiple sheets and specify the sheet, but it's less likely to cause
* problems if the workbook only has one sheet. "Sheet1" is Excel's default
* name for the first sheet.)

GET DATA /TYPE=XLSX
  /FILE='/Users/bart/Desktop/mbb.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME ExcelData WINDOW=FRONT.

* SAVE FILES AND CLOSE WINDOWS ***************************************************


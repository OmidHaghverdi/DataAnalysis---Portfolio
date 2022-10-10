* File:    SPSS01_5_1_Labels.sps
* Course:  SPSS01: SPSS: An introduction
* Chapter: 5: Accessing data
* Section: 1: Labels & definitions
* Author:  Barton Poulson, datalab.cc, @bartonpoulson
* Date:    2016-09-13

* VARIABLE LABELS ****************************************************************

VARIABLE LABELS
  var01   "First variable"
  var02   "Second variable"
  male    "R is male"
  female  "R is female"
  rate01  "First rating scale variable"
  rate02  "Second rating scale variable"
  scale01 "First 0-10 variable"
  scale02 "Second 0-10 variable" .

* VALUE LABELS *******************************************************************

VALUE LABELS
  var01 var02 var3 TO var10
    0 "No"
    1 "Yes" /
  male
    0 "Female"
    1 "Male" /
  female 
    0 "Male"
    1 "Female" /
  rate01 TO rate10
    1 "Strongly Disagree"
    2 "Disagree"
    3 "Neutral"
    4 "Agree"
    5 "Strongly Agree" /
  scale01 scale02
    0  "Never/Not at all"
    10 "Always/Completely" .

* MISSING VALUES *****************************************************************

MISSING VALUES
  var01 var02 var3 TO var10 (99) /
  male female (2 THRU HI) /
  rate01 TO rate10 (7, 8, 9) .

* SAVE FILES AND CLOSE WINDOWS ***************************************************


        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut. *> for loop & while loop
AUTHOR. Yanling.
DATE-WRITTEN.July 6th 2022 
ENVIRONMENT DIVISION.
CONFIGURATION SECTION. 

DATA DIVISION. 
FILE SECTION. 
WORKING-STORAGE SECTION.
01 Indx PIC 9(1) VALUE 0.


PROCEDURE DIVISION.
*> while loop type
PERFORM OutputData WITH TEST AFTER UNTIL Indx > 5
        *> For loop type
        GO TO ForLoop.

OutputData.
        DISPLAY "Output Data : " Indx.
        ADD 1 TO Indx.

ForLoop.
        PERFORM OutputData2 VARYING Indx FROM 1 BY 1 UNTIL Indx = 5
        STOP RUN.

OutputData2.
        DISPLAY "Output Data 2 : "Indx.



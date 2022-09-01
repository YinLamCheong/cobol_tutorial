        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut-5Main. *>callProgram
AUTHOR. Yanling.
DATE-WRITTEN.July 6th 2022 
ENVIRONMENT DIVISION.
CONFIGURATION SECTION. 

DATA DIVISION. 
FILE SECTION. 
WORKING-STORAGE SECTION.
        01 Num1 PIC 9 VALUE 5.
        01 Num2 PIC 9 VALUE 4. 
        01 Sum1 PIC 99. 


PROCEDURE DIVISION.
CALL 'coboltut-5' USING Num1, Num2, Sum1.

DISPLAY Num1 " + " Num2 " = " Sum1.


STOP RUN. 

*> compile code:
*> cobc -m coboltut-5.cob
*> cobc -x coboltut-5Main.cob
*> ./coboltut-5Main

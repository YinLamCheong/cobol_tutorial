        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut-callSub.
AUTHOR. Yanling.
DATE-WRITTEN.July 6th 2022 
ENVIRONMENT DIVISION.
CONFIGURATION SECTION. 

DATA DIVISION. 
FILE SECTION. 
WORKING-STORAGE SECTION.

PROCEDURE DIVISION.
SubOne. 
        DISPLAY "In Paragraph 1"
        PERFORM SubTwo
        DISPLAY "Returned to Paragraph 1"
        PERFORM SubFour 2 TIMES. *> will only call one time bcause below subFour no other sub
        *> PERFORM 2 TIMES [will not be perform, unless below SubTwo has another sub]
        *>    DISPLAY "Repeat" 
        *> END-PERFORM
        STOP RUN.

SubThree. 
        DISPLAY "In Paragraph 3".

SubTwo. 
        DISPLAY "In Paragraph 2"
        PERFORM SubThree
        DISPLAY "Returned to Paragraph 2".

SubFour. 
        DISPLAY "Repeat".


STOP RUN. 

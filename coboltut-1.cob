        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut.
AUTHOR. Yanling.
DATE-WRITTEN.July 4th 2022 
ENVIRONMENT DIVISION.

DATA DIVISION. 
FILE SECTION. 
WORKING-STORAGE SECTION.
01 UserName PIC X(30) VALUE "You".
01 Num1 PIC 9 VALUE ZEROS.
01 Num2 PIC 9 VALUE ZEROS.
01 Total PIC 9 VALUE 0.
01 SSNum.
       02 SSArea PIC 999. 
       02 SSGroup PIC 99. 
       02 SSSerial PIC 9999. 
01 PIValue CONSTANT AS 3.142.


PROCEDURE DIVISION.
DISPLAY "What is your name " WITH NO ADVANCING
ACCEPT UserName
DISPLAY "Welcome to COBOL World! " UserName 

MOVE ZERO TO UserName
DISPLAY UserName

DISPLAY "Enter 2 values to sum "
ACCEPT Num1
ACCEPT Num2
COMPUTE Total = Num1 + Num2
DISPLAY Num1 " + " Num2 " = " Total

DISPLAY "Enter your social security number "
ACCEPT SSNum
DISPLAY "Area " SSArea
DISPLAY "Group " SSGroup



STOP RUN.

        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut. *> working with external file + gen the file from this program
AUTHOR. Yanling.
DATE-WRITTEN.July 7th 2022 
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
        SELECT CustomerFile ASSIGN TO "customer.txt"  *>will gen automatically
            ORGANIZATION IS LINE SEQUENTIAL
            ACCESS IS SEQUENTIAL.
DATA DIVISION. 
FILE SECTION. 
FD CustomerFile. *> FD = File Description
01 CustomerData.
        02 IDNum PIC 9(5).
        02 CustName.
            03 FirstName PIC X(15).
            03 LastName PIC X(15).

WORKING-STORAGE SECTION.
01 WsCustomerData.
        02 WsIDNum PIC 9(5).
        02 WsCustName.
            03 WsFirstName PIC X(15).
            03 WsLastName PIC X(15).


PROCEDURE DIVISION.
OPEN OUTPUT CustomerFile. *> use 'OUTPUT' will direct renew the data inside the .dat file, previous info will disappear
        MOVE 00001 TO IDNum.
        MOVE 'Doug' TO FirstName.
        MOVE 'Thomas' TO LastName.
        WRITE CustomerData
        END-WRITE.
CLOSE CustomerFile.


STOP RUN. 

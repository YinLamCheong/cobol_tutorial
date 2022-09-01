        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut. *> add on to + read data from external file
AUTHOR. Yanling.
DATE-WRITTEN.July 7th 2022 
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
        SELECT CustomerFile ASSIGN TO "Customer.dat"  *>Below using EXTEND so the .dat file must exist!!
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
01 WSEOF PIC A(1).

PROCEDURE DIVISION.
*> add on info into the file
OPEN EXTEND CustomerFile. *> will not rub the previous info in the .dat file, only add data
        DISPLAY "Customer ID " WITH NO ADVANCING *> 'WITH NO ADVANCING' means cursor will be placed after the last character of the display statement. Else, the cursor will be in the new line.
        ACCEPT IDNum
        DISPLAY "Customer First Name " WITH NO ADVANCING 
        ACCEPT FirstName
        DISPLAY "Customer Last Name " WITH NO ADVANCING 
        ACCEPT LastName
        WRITE CustomerData
        END-WRITE.
CLOSE CustomerFile.

*> read the data from the file
OPEN INPUT CustomerFile. *> will not rub the previous info in the .dat file, only add data
        PERFORM UNTIL WSEOF ='Y'
            READ CustomerFile INTO WsCustomerData
                AT END MOVE 'Y' TO WSEOF
                NOT AT END DISPLAY WsCustomerData
            END-READ
        END-PERFORM
CLOSE CustomerFile.

STOP RUN. 

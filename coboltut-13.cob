        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut. *> create menu & add, delete, edit file data
AUTHOR. Yanling.
DATE-WRITTEN.July 7th 2022 
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
        SELECT CustomerFile ASSIGN TO "customer.txt"  *> need create this file manually because inside program no code is create this file & it is based on ID
            ORGANIZATION IS INDEXED
            ACCESS MODE IS RANDOM
            RECORD KEY IS IDNum.  *> primary key (based on ID to do all Fn)
            
DATA DIVISION. 
FILE SECTION. 
FD CustomerFile. *> FD = File Description
01 CustomerData.
        02 IDNum PIC 99.
        02 FirstName PIC X(15).
        02 LastName PIC X(15).

WORKING-STORAGE SECTION.
01 Choice PIC 9.
01 StayOpen PIC X VALUE 'Y'.
01 CustExists PIC X. 

PROCEDURE DIVISION.
StartPara.
        OPEN I-O CustomerFile.
        PERFORM UNTIL StayOpen='N'
            DISPLAY " "
            DISPLAY "CUSTOMER RECORDS"
            DISPLAY "1            : Add Customer"
            DISPLAY "2            : Delete Customer"
            DISPLAY "3            : Update Customer"
            DISPLAY "4            : Get Customer"
            DISPLAY "Other Number : Quit"
            DISPLAY ":" WITH NO ADVANCING
            ACCEPT Choice
            EVALUATE Choice 
                WHEN 1 PERFORM AddCust
                WHEN 2 PERFORM DeleteCust
                WHEN 3 PERFORM UpdateCust
                WHEN 4 PERFORM GetCust
                WHEN OTHER move 'N' TO StayOpen
            END-EVALUATE
        END-PERFORM.
        CLOSE CustomerFile
        STOP RUN. 

AddCust.
        DISPLAY " "
        DISPLAY "Enter ID : " With NO ADVANCING.
        ACCEPT IDNum.
        DISPLAY "Enter First Name : " With NO ADVANCING.
        ACCEPT FirstName.
        DISPLAY "Enter Last Name : " With NO ADVANCING.
        ACCEPT LastName.
        DISPLAY " "
        WRITE CustomerData 
            INVALID KEY DISPLAY "ID Taken!"
        END-WRITE.

DeleteCust.
        DISPLAY " "
        DISPLAY "Enter Customer ID to Delete : " With NO ADVANCING.
        ACCEPT IDNum.
        DELETE CustomerFile  *> only delete the data that match the IDNum
            INVALID KEY DISPLAY "Key Doesn't Exist"
        END-DELETE.

UpdateCust.
        MOVE 'Y' To CustExists.
        DISPLAY " "
        DISPLAY "Enter ID to Update : " With NO ADVANCING.
        ACCEPT IDNum.
        READ CustomerFile   *> will direct read the ID
            INVALID KEY MOVE 'N' TO CustExists
        END-READ
        IF CustExists = 'N'
            DISPLAY "Customer Doesn't Exist"
        ELSE
            DISPLAY "Enter the New First Name : " With NO ADVANCING
            ACCEPT FirstName
            DISPLAY "Enter the New Last Name : " With NO ADVANCING
            ACCEPT LastName
        END-IF. 
        REWRITE CustomerData 
            INVALID KEY DISPLAY "Customer Not Updated"
        END-REWRITE.

GetCust.
        MOVE 'Y' To CustExists.
        DISPLAY " "
        DISPLAY "Enter Customer ID to Find : " With NO ADVANCING.
        ACCEPT IDNum.
        READ CustomerFile
            INVALID KEY MOVE 'N' to CustExists
        END-READ
        IF CustExists = 'N'
            DISPLAY "Customer Doesn't Exists"
        Else 
            DISPLAY "ID : " IDNum
            DISPLAY "First Name : " FirstName
            DISPLAY "Last Name : " LastName
        END-IF.


        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut.   *> work with table
AUTHOR. Yanling.
DATE-WRITTEN.July 11th 2022 
ENVIRONMENT DIVISION.
CONFIGURATION SECTION. 

DATA DIVISION. 
FILE SECTION. 
WORKING-STORAGE SECTION.
01 Table1.
        02 Friend PIC X(15) OCCURS 4 TIMES. *> "OCCURS 4 TIMES" means only can store 4 records

01 CustTable. 
        02 CustName OCCURS 5 TIMES. 
            03 FName PIC X(15). 
            03 LName PIC X(15).

01 OrderTable.
        02 Product OCCURS 2 TIMES INDEXED BY I.
            03 ProdName PIC X(10).
            03 ProdSize OCCURS 3 TIMES INDEXED BY J.
                04 SizeType PIC A. 


PROCEDURE DIVISION.
*> table with one data 
MOVE 'Joy' TO Friend(1).
MOVE 'Willow' TO Friend(2).
MOVE 'Ivy' TO Friend(3).
MOVE 'Yan' TO Friend(4).
DISPLAY Friend(1).
DISPLAY Table1.

*> table with multiple columns/data
MOVE 'Paul' TO FName(1).
MOVE 'Smith' TO LName(1).
MOVE 'Sally' TO FName(2).
MOVE 'Petch' TO LName(2). 
MOVE 'Howard' TO LName(3).
DISPLAY CustName(1).
DISPLAY CustTable.


*> Table with Indexed
SET I J TO 1. 
MOVE 'Blue Shirt' TO Product(I).
MOVE 'S' TO ProdSize(I, J). 
SET J UP BY 1. 
MOVE 'M' TO  ProdSize(I, J).
SET J DOWN BY 1. 
MOVE 'Blue ShirtSMLRed Shirt SML' TO OrderTable.
PERFORM GetProduct VARYING I FROM 1 BY 1 UNTIL I > 2.
GO TO LookUp.

GetProduct.
        DISPLAY Product(I).
        DISPLAY ProdName(I).
        PERFORM GetSizes VARYING J FROM 1 BY 1 UNTIL J > 3. 

GetSizes. 
        DISPLAY ProdSize(I, J).

LookUp.
        SET I TO 1. 
        SEARCH Product
            AT END DISPLAY 'Product Not Found'
            WHEN ProdName(I) = 'Red Shirt'
                DISPLAY 'Red Shirt Found'
            END-SEARCH. 

STOP RUN. 

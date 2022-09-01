       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. testPOS.
AUTHOR. Yanling.
DATE-WRITTEN.Aug 15th 2022 
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
        SELECT MenuFile ASSIGN TO "Menu.dat" 
            ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION. 
FILE SECTION. 
FD MenuFile. *> FD = File Description
01 MenuData.
        02 MenuID PIC X(4).
        02 MenuItemName PIC X(20).
        02 MenuItemPrice PIC X(5).
        88 ShowAllMenu VALUE HIGH-VALUE.
        88 LoopAllMenuID VALUE HIGH-VALUE.


WORKING-STORAGE SECTION.

*> Login variables
01 TempID PIC X(10).
01 Indx   PIC 9(1) VALUE 0.
01 UserID PIC X(10).
        88 Authorise_ID  VALUE "123", "111","222","333". *> LATER CAN TRY TAKE FROM FILE
        
01 IDCorrect PIC 9 VALUE 0. *> 0 or 1
01 UserPswd PIC X(30).
        88 Authorise_Pswd VALUE "AAA", "BBB","CCC","ABC". *> LATER CAN TRY TAKE FROM FILE
01 UserPswdCorrect PIC 9 VALUE 0. *> 0 or 1

*> 01 N PIC 9 VALUE 0.
*> 01 UserPswd_LEN PIC S9.

*> Menu variables
01 InputOrderNo PIC X(49).
01 OrderNo. 
        05 OrderItemID PIC X(4) OCCURS 10 TIMES. *> assume max order is 10 items
        
01 Num_Comma PIC 9 VALUE 0.
01 Temp_Count PIC 99.
01 Order_ItemID_Exist PIC X VALUE 'F'. *> T OR F 

*> 01 MenuList.
        *> 02 ItemName PIC X(30).
        *> 02 ItemPrice PIC $$9.99.



PROCEDURE DIVISION.
DISPLAY "            Login    "
DISPLAY "============================="
DISPLAY " ENTER USER ID (X TO EXIT): " WITH NO ADVANCING
ACCEPT UserID 

MOVE 0 TO IDCorrect
MOVE 0 TO UserPswdCorrect

PERFORM UNTIL IDCorrect = 1
        EVALUATE TRUE
            WHEN Authorise_ID 
                MOVE 1 TO IDCorrect
                
            WHEN OTHER 
                MOVE 0 TO IDCorrect
        END-EVALUATE

        IF IDCorrect = 0
            IF UserID = "X" OR UserID = "x"
                 STOP RUN
            END-IF
            DISPLAY "INVALID USER ID!"
            DISPLAY "PLS ENTER AGAIN USER ID : " WITH NO ADVANCING
            ACCEPT UserID

        ELSE IF IDCorrect = 1     
            DISPLAY "Password : " WITH NO ADVANCING
            ACCEPT UserPswd
        
        END-IF

END-PERFORM 

*> CHECK IF PASSWORD CORRECT - HAVEN'T CMP USER ID WITH PASSWORD
PERFORM UNTIL UserPswdCorrect = 1
    EVALUATE TRUE
        WHEN Authorise_Pswd
            MOVE 1 TO UserPswdCorrect
            
        WHEN OTHER 
            ADD 2 TO UserPswdCorrect
    END-EVALUATE

    *> FOR DEBUG >> DISPLAY UserPswdCorrect
    IF UserPswdCorrect = 1 
        *> DISPLAY MENU
        GO TO DISPLAY_MENU
    ELSE IF UserPswdCorrect = 6
        DISPLAY "SORRY, LOGIN THREE TIMES INCORRECTLY, SYSTEM LOGOUT ! "
        STOP RUN
    ELSE  
        DISPLAY "INVALID USER PASSWORD!"
        DISPLAY "PLS ENTER AGAIN USER PASSWORD : " WITH NO ADVANCING
        ACCEPT UserPswd
    END-IF
END-PERFORM. 

*> DISPLAY MENU 
DISPLAY_MENU.
    DISPLAY " "
    DISPLAY "                         M E N U                      "
    DISPLAY "======================================================"
    DISPLAY " Item ID           Menu Item(s)           Price       "
    DISPLAY " --------     ---------------------      -------"

    OPEN INPUT MenuFile.
        
        PERFORM UNTIL ShowAllMenu
            READ MenuFile   *> will read one line data only unless apply looping like the statement "PERFORM UNTIL.."
                AT END SET ShowAllMenu TO TRUE
                NOT AT END DISPLAY "   " MenuID "       " MenuItemName "        " MenuItemPrice
            END-READ
        END-PERFORM
        
    CLOSE MenuFile.    

*> ACCEPT INPUT FOR ORDER MENU  
RECEIVE_ORDER.
    DISPLAY " "
    DISPLAY "Pls enter item id for ordering (use ',' to continue next item) "  
    DISPLAY ">> " WITH NO ADVANCING
    ACCEPT InputOrderNo 

    *> calc how many comma
    INSPECT InputOrderNo TALLYING Num_Comma FOR ALL ','

    MOVE 1 TO Temp_Count
    IF Num_Comma < 5
            UNSTRING InputOrderNo DELIMITED BY ','
            INTO OrderItemID(1), OrderItemID(2), OrderItemID(3),OrderItemID(4),OrderItemID(5)

            *>PERFORM UNTIL Temp_Count > 5
            *>    DISPLAY OrderItemID(Temp_Count)
            *>    ADD 1 TO Temp_Count
            *>END-PERFORM

    ELSE
            UNSTRING InputOrderNo DELIMITED BY ','
            INTO OrderItemID(1), OrderItemID(2), OrderItemID(3),OrderItemID(4),OrderItemID(5),
                OrderItemID(6), OrderItemID(7), OrderItemID(8),OrderItemID(9),OrderItemID(10)

            *>PERFORM UNTIL Temp_Count > 10
            *>    DISPLAY OrderItemID(Temp_Count)
            *>    ADD 1 TO Temp_Count
            *>END-PERFORM
    END-IF.

*> CHECK IF THE ITEM ID FOR ORDER EXIST  *******************cont here for check item id -- GOT ERROR IN Check_Order_ItemID ************
*>Check_Order_ItemID.
    *>OPEN INPUT MenuFile.
        MOVE 1 TO Temp_Count
        IF Num_Comma < 5
            PERFORM Check_Order_ItemID UNTIL Temp_Count > 5
                
            *>END-PERFORM 
        ELSE
            PERFORM Check_Order_ItemID UNTIL Temp_Count > 5
        END-IF
    *>CLOSE MenuFile. 
    
DISPLAY InputOrderNo 
DISPLAY "done"

*> ================================ EXTRA KNOWLEDGE
*> ------Calculate the length of actual user password------------
*> INSPECT FUNCTION REVERSE(UserPswd) TALLYING N FOR LEADING SPACE.   
*> SUBTRACT N FROM FUNCTION LENGTH(UserPswd) GIVING UserPswd_LEN.  
*> FOR DEBUG >> DISPLAY 'Length is ' UserPswd_LEN.


STOP RUN.

*> function 
Check_Order_ItemID.  *>>>>>>>PENDING MODIFY
    MOVE 'F' TO Order_ItemID_Exist 

    DISPLAY "DEBUG:: ITEM ID : " OrderItemID(Temp_Count)
    OPEN INPUT MenuFile.   
        IF OrderItemID(Temp_Count) = SPACE OR OrderItemID(Temp_Count) = LOW-VALUE THEN 
            MOVE 'T' TO Order_ItemID_Exist 
        ELSE 
            DISPLAY "HELLO "
            
            *>>>>>>>>>>>>>>>>>>>>>>>>> STUCK HERE ._. WHY NO RUN IT?<<<<<<<<<<<
            PERFORM UNTIL LoopAllMenuID     
                DISPLAY "HELLO 1"         
                READ MenuFile   *> will read one line data only unless apply looping like the statement "PERFORM UNTIL.."
                    AT END SET LoopAllMenuID TO TRUE
                    NOT AT END DISPLAY "   " MenuID "       " MenuItemName "        " MenuItemPrice
                    
                    *>AT END SET WSEOF TO TRUE                    
                    *>NOT AT END GO TO Check_Order_ItemID_EXIST
                END-READ
                *>DISPLAY "DEBUG:: MENU ID: " MenuID 
            END-PERFORM

                *>DISPLAY "DEBUG:: MENU ID: " MenuID 

            DISPLAY "TEMP COUNT: " Temp_Count  " | ORDER ID EXIST? " Order_ItemID_Exist

        *>IF Order_ItemID_Exist = 'F'
        *>    GO TO Invalid_Order
        *>ELSE 
        *>    DISPLAY "Order_ItemID_Exist = " Order_ItemID_Exist
        *>END-IF

        END-IF.
    CLOSE MenuFile. 
    DISPLAY "Order_ItemID_Exist = " Order_ItemID_Exist
    ADD 1 TO Temp_Count.
    
Check_Order_ItemID_EXIST.
    DISPLAY "DEBUG:: MENU ID: " MenuID 
    DISPLAY "DEBUG:: MENU ID 1: " OrderItemID(Temp_Count)
    IF MenuID = OrderItemID(Temp_Count) THEN 
        MOVE 'T' TO Order_ItemID_Exist 
    END-IF.

Invalid_Order.
    DISPLAY " "
    DISPLAY "Invalid order ID, pls try again! "
    DISPLAY " "
    GO TO RECEIVE_ORDER.

ERROR_MSG.
    DISPLAY "ERROR".

    



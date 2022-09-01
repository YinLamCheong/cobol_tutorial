        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut. *> data sorting from a file and save to another file
AUTHOR. Yanling.
DATE-WRITTEN.July 11th 2022 
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
        SELECT WorkFile ASSIGN TO 'work.tmp'.
        SELECT File1 ASSIGN TO 'student.dat'
            ORGANIZATION IS LINE SEQUENTIAL.
        SELECT File2 ASSIGN TO 'student3.dat'
            ORGANIZATION IS LINE SEQUENTIAL.
        SELECT NewFile ASSIGN TO 'student4.dat'
            ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION. 
FILE SECTION.
FD File1.  *> FD = file description
01 StudData. 
        02 IDNum PIC 9.
        02 StudName PIC X(10).

FD File2.  
01 StudData2. 
        02 IDNum2 PIC 9.
        02 StudName2 PIC X(10).

SD WorkFile. *> SD = sorted file description
01 WStudData. 
        02 WIDNum PIC 9.
        02 WStudName PIC X(10).

FD NewFile. 
01 NStudData. 
        02 NIDNum PIC 9.
        02 NStudName PIC X(10).

WORKING-STORAGE SECTION.

PROCEDURE DIVISION.
*> Data merging from different files & sorting into new file
MERGE WorkFile ON ASCENDING KEY NIDNum
        USING File1, File2
        GIVING NewFile. 

STOP RUN. 

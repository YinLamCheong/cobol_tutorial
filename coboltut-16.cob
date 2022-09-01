        >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. coboltut. *> data sorting from a file and save to another file
AUTHOR. Yanling.
DATE-WRITTEN.July 11th 2022 
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION. 
FILE-CONTROL.
        SELECT WorkFile ASSIGN TO 'work.tmp'.
        SELECT OrgFile ASSIGN TO 'student.dat'
            ORGANIZATION IS LINE SEQUENTIAL.
        SELECT SortedFile ASSIGN TO 'student2.dat'
            ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION. 
FILE SECTION.
FD OrgFile.  *> FD = file description
01 StudData. 
        02 IDNum PIC 9.
        02 StudName PIC X(10).

SD WorkFile. *> SD = sorted file description
01 WStudData. 
        02 WIDNum PIC 9.
        02 WStudName PIC X(10).

FD SortedFile. 
01 SStudData. 
        02 SIDNum PIC 9.
        02 SStudName PIC X(10).

WORKING-STORAGE SECTION.

PROCEDURE DIVISION.
*> Data Sorting and save to another file
SORT WorkFile ON ASCENDING KEY SIDNum
        USING OrgFile
        GIVING SortedFile.  *> AUTO gen this file

STOP RUN. 

**************************************************************
      *
      *  PROGRAM ID INOUTDEM
      *  DATE CREATED:  25JAN2026
      *
      *  DEMO PROG SHOWS YOU HOW TO 
      *  INPUT AND OUTPUT FILES FROM COBOL
      *  AND USE THE DATA IN BETWEEN
      *
      *  CHANGE LOG
      *  USER ID     DATE     CHANGE DESCRIPTION
      * ---------   ------    -------------------------------------
      *  DAN BIEG   25JAN2026 CODE PROG
      **************************************************************
       IDENTIFICATION DIVISION.                               
       PROGRAM-ID. INOUTDEM.  

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SOURCE-COMPUTER. IBM-370.
       OBJECT-COMPUTER. IBM-370. 

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.                                                    
           SELECT FILE-INVT-MSTR ASSIGN TO UT-S-INVMAST.  
           SELECT FILE-TRANSACTIONS ASSIGN TO UT-S-TRANFILE.
           SELECT FILE-INVT-OUT ASSIGN TO UT-S-INVOUT.

       DATA DIVISION.       

       FILE SECTION.                                                    
       FD     FILE-INVT-MSTR                                            
              LABEL RECORDS ARE OMITTED                                 
              BLOCK CONTAINS 0 RECORDS                                  
              DATA RECORD IS FIL-INVENTORY-MASTER. 

       01  FIL-INVENTORY-MASTER.                                        
           05  FIL-ITEM-NUMBER          PIC 9(6).                       
           05  FIL-ITEM-DESCRIPTION     PIC X(29).                      
           05  FIL-QUANTITY-ON-HAND     PIC 9(7).                       
           05  FILLER                  PIC X(38).   

       FD     FILE-TRANSACTIONS        
              LABEL RECORDS ARE OMITTED            
              BLOCK CONTAINS 0 RECORDS               
              DATA RECORD IS FIL-TRANSACTIONS. 
       
       01  FIL-TRANSACTIONS.                 
           05  FIL-ITEM-NUMBER          PIC 9(6).      
           05  FIL-TRANS-TYPE           PIC X(1).      
               88  FIL-RECEIPT          VALUE 'R'.     
               88  FIL-ISSUE            VALUE 'I'.     
           05  FIL-QUANTITY             PIC 9(7).      
           05  FIL-TRANS-DATE           PIC X(10).     
           05  FILLER                  PIC X(56).

       FD     FILE-INVT-OUT
              LABEL RECORDS ARE OMITTED
              BLOCK CONTAINS 0 RECORDS
              DATA RECORD IS FIL-INVENTORY-OUT.

       01  FIL-INVENTORY-OUT            PIC X(80).


       WORKING-STORAGE SECTION. 
      * USE THE COPYBOOK                                                
       01  INVENTORY-REC COPY INVMASTC.                                 
       01  TRANSACTIONS-REC COPY TRANFILC.                                 

      * FLAGS
       01 WS-VAL.
          02 WS-EOF-INVENTORY           PIC X VALUE 'N'.
          02 WS-EOF-TRANSACTIONS        PIC X VALUE 'N'.
                 
       PROCEDURE DIVISION.                                    
          
           PERFORM R2000-OPEN-DATASETS.

           PERFORM R2100-READ-INVENTORY.
           PERFORM R2200-READ-TRANSACTION.

           MOVE SPACES TO FIL-INVENTORY-OUT.
           MOVE '== START OF DEMO REPORT ==' TO FIL-INVENTORY-OUT.
           WRITE FIL-INVENTORY-OUT.

           PERFORM R3000-PROCESS-FILES
              UNTIL WS-EOF-TRANSACTIONS = 'Y'.

           MOVE SPACES TO FIL-INVENTORY-OUT.
           MOVE '== END OF DEMO REPORT ==' TO FIL-INVENTORY-OUT.
           WRITE FIL-INVENTORY-OUT.

           PERFORM R4000-CLOSE-DATASETS.

           STOP RUN.     

        R2000-OPEN-DATASETS.
           OPEN INPUT FILE-INVT-MSTR.
           OPEN INPUT FILE-TRANSACTIONS.
           OPEN OUTPUT FILE-INVT-OUT.

        R2100-READ-INVENTORY.
           READ FILE-INVT-MSTR INTO INVENTORY-REC
              AT END MOVE 'Y' TO WS-EOF-INVENTORY.

        R2200-READ-TRANSACTION.
           READ FILE-TRANSACTIONS INTO TRANSACTIONS-REC
              AT END MOVE 'Y' TO WS-EOF-TRANSACTIONS.

        R3000-PROCESS-FILES.
           MOVE SPACES TO FIL-INVENTORY-OUT.
           MOVE ' IM DESCRIPTION: ' TO FIL-INVENTORY-OUT.
           WRITE FIL-INVENTORY-OUT.
           MOVE SPACES TO FIL-INVENTORY-OUT.
           MOVE IM-ITEM-DESCRIPTION 
                TO FIL-INVENTORY-OUT.
           WRITE FIL-INVENTORY-OUT.
           MOVE SPACES TO FIL-INVENTORY-OUT.
           MOVE '--- --- ---' TO FIL-INVENTORY-OUT.
           WRITE FIL-INVENTORY-OUT.
           MOVE SPACES TO FIL-INVENTORY-OUT.

           DISPLAY '---'.                                   
           DISPLAY ' '.                                     
           DISPLAY ' IM ITEM NUMBER: ' IM-ITEM-NUMBER.      
           DISPLAY ' IM DESCRIPTION: ' IM-ITEM-DESCRIPTION .
           DISPLAY ' '.                                     
           DISPLAY ' TR ITEM NUMBER: ' TR-ITEM-NUMBER.      
           DISPLAY ' '.                                     
           DISPLAY '---'.                       
           DISPLAY '---'.                                   
           DISPLAY ' '.                                     
           DISPLAY ' IM ITEM NUMBER: ' IM-ITEM-NUMBER.      
           DISPLAY ' IM DESCRIPTION: ' IM-ITEM-DESCRIPTION .
           DISPLAY ' '.                                     
           DISPLAY ' TR ITEM NUMBER: ' TR-ITEM-NUMBER.      
           DISPLAY ' '.                                     
           DISPLAY '---'.                       
           PERFORM R2200-READ-TRANSACTION.

        R4000-CLOSE-DATASETS.
           CLOSE FILE-INVT-MSTR.
           CLOSE FILE-TRANSACTIONS.
           CLOSE FILE-INVT-OUT.
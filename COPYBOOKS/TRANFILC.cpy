      **********************************************  
      * DAILY TRANSACTION FILE RECORD LAYOUT          
      * FILE: TRANFILE.DAT                            
      * RECORD LENGTH: 80 BYTES                       
      **********************************************  
       01  TRANSACTION-COPYBOOK-RECORD.                 
           05  TR-ITEM-NUMBER          PIC 9(6).      
           05  TR-TRANS-TYPE           PIC X(1).      
               88  TR-RECEIPT          VALUE 'R'.     
               88  TR-ISSUE            VALUE 'I'.     
           05  TR-QUANTITY             PIC 9(7).      
           05  TR-TRANS-DATE           PIC X(10).     
           05  FILLER                  PIC X(56).     
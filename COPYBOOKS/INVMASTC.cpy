      *****************************************************************
      * INVENTORY MASTER FILE RECORD LAYOUT                           *
      * FILE: INVMAST.DAT                                             *
      * RECORD LENGTH: 80 BYTES                                       *
      *****************************************************************
       01  INVENTORY-COPYBOOK-RECORD.               
           05  IM-ITEM-NUMBER          PIC 9(6).  
           05  IM-ITEM-DESCRIPTION     PIC X(29). 
           05  IM-QUANTITY-ON-HAND     PIC 9(7).  
           05  FILLER                  PIC X(38). 


//RUNINOUT JOB  'RUN INOUTDEM',          
//        CLASS=A,
//        MSGCLASS=X,
//        MSGLEVEL=(1,1),                            
//        NOTIFY=&SYSUID               
//********************************************************************
//* DELETE OLD OUTPUT IF EXISTS (DO THIS FIRST)
//********************************************************************
//BR14A    EXEC PGM=IEFBR14 
//INVOUT   DD DSN=WEEK4.DEV.OUTPUT1,DISP=(MOD,DELETE,DELETE),
//         SPACE=(TRK,(0,0)),UNIT=SYSDA
//********************************************************************
//* STEP 2: RUN INOUTDEM BINARY
//* INPUT FROM WEEK4.DEV.INPUT   
//* OUTPUT RESULTS TO OUTPUT1                         
//********************************************************************
//STEP1    EXEC PGM=INOUTDEM             
//STEPLIB  DD DSN=WEEK4.DEV.LOADLIB,DISP=SHR 
//         DD DSN=SYS1.COBLIB,DISP=SHR
//INVMAST  DD DSN=WEEK4.DEV.INPUT.INVMAST,DISP=SHR   
//TRANFILE DD DSN=WEEK4.DEV.INPUT.TRANFILE,DISP=SHR 
//INVOUT   DD DSN=WEEK4.DEV.OUTPUT1,DISP=(NEW,CATLG,DELETE),
//         SPACE=(TRK,(1,1)),UNIT=SYSDA,
//         DCB=(RECFM=FB,LRECL=80,BLKSIZE=800)   
//SYSOUT   DD SYSOUT=*      
//SYSUDUMP DD SYSOUT=*
//
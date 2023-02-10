/PROG  BGLOGIC1
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 784;
CREATE		= DATE 17-05-10  TIME 12:41:36;
MODIFIED	= DATE 17-09-11  TIME 19:49:24;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 33;
MEMORY_SIZE	= 1184;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= 1,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN
   1:  //!ustawienie predkosci ;
   2:  //IF (DO[115:AUTO MODE]=ON) THEN ;
   3:  //$MCR.$GENOVERRIDE=75 ;
   4:  //ELSE ;
   5:  //$MCR.$GENOVERRIDE=10 ;
   6:  //ENDIF ;
   7:   ;
   8:  !kiedy robot w poz bezpiecznej ;
   9:  IF (DO[10:poz HOME]=ON OR DO[11:poz bezp CNC]=ON) THEN ;
  10:  DO[112:poz bezp]=ON ;
  11:  ELSE ;
  12:  DO[112:poz bezp]=OFF ;
  13:  ENDIF ;
  14:   ;
  15:  !obsluga koszy na dobre detale ;
  16:  IF (DI[130:kosz 1 dobre pelny]=ON AND DI[131:kosz 2 dobre pelny]=OFF) THEN ;
  17:  F[6:akt skrzynka 2]=(ON) ;
  18:  F[5:akt skrzynka 1]=(OFF) ;
  19:  ENDIF ;
  20:   ;
  21:  IF (DI[131:kosz 2 dobre pelny]=ON AND DI[130:kosz 1 dobre pelny]=OFF) THEN ;
  22:  F[5:akt skrzynka 1]=(ON) ;
  23:  F[6:akt skrzynka 2]=(OFF) ;
  24:  ENDIF ;
  25:   ;
  26:  IF (DI[130:kosz 1 dobre pelny]=ON AND DI[131:kosz 2 dobre pelny]=ON) THEN ;
  27:  F[5:akt skrzynka 1]=(OFF) ;
  28:  F[6:akt skrzynka 2]=(OFF) ;
  29:  ENDIF ;
  30:   ;
  31:  IF (DI[130:kosz 1 dobre pelny]=OFF AND DI[131:kosz 2 dobre pelny]=OFF AND F[5:akt skrzynka 1]=OFF AND F[6:akt skrzynka 2]=OFF) THEN ;
  32:  F[5:akt skrzynka 1]=(ON) ;
  33:  ENDIF ;
/POS
/END

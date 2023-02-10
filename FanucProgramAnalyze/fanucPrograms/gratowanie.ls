/PROG  GRATOWANIE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1000;
CREATE		= DATE 18-06-14  TIME 11:25:36;
MODIFIED	= DATE 18-06-14  TIME 11:25:36;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 29;
MEMORY_SIZE	= 1264;
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
   1:  UFRAME_NUM=7 ;
   2:  CALL STANCHWYTAKA(1) ;
   3:  CALL STANCHWYTAKA(3) ;
   4:   ;
   5:  !gratowanie dla chwytaka 1 ;
   6:  IF (R[1:stan chwytaka 1]=1) THEN ;
   7:  UTOOL_NUM=1 ;
   8:J P[1] 25% CNT10 Offset,PR[5:gratow offset]    ;
   9:  DO[108:wl gratownik]=ON ;
  10:  WAIT (DI[108:gratownik wl]=ON)    ;
  11:L P[1] R[25:posuw L]mm/sec FINE Offset,PR[24:offset Y-4]    ;
  12:L P[1] R[26:posuw gratow]mm/sec FINE    ;
  13:  WAIT    .30(sec) ;
  14:L P[1] R[25:posuw L]mm/sec CNT10 Offset,PR[5:gratow offset]    ;
  15:  ENDIF ;
  16:   ;
  17:  !gratowanie dla chwytaka 3 ;
  18:  IF (R[3:stan chwytaka 3]=1) THEN ;
  19:  UTOOL_NUM=3 ;
  20:J P[2] 100% CNT10 Offset,PR[5:gratow offset]    ;
  21:  DO[108:wl gratownik]=ON ;
  22:  WAIT (DI[108:gratownik wl]=ON)    ;
  23:L P[2] R[25:posuw L]mm/sec FINE Offset,PR[24:offset Y-4]    ;
  24:L P[2] R[26:posuw gratow]mm/sec FINE    ;
  25:  WAIT    .30(sec) ;
  26:L P[2] R[25:posuw L]mm/sec CNT10 Offset,PR[5:gratow offset]    ;
  27:  ENDIF ;
  28:   ;
  29:  DO[108:wl gratownik]=OFF ;
/POS
P[1]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   856.686  mm,	Y =   197.400  mm,	Z =   172.511  mm,
	W =  -126.099 deg,	P =    87.946 deg,	R =   142.594 deg
};
P[2]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   854.819  mm,	Y =   196.400  mm,	Z =   172.374  mm,
	W =   -90.855 deg,	P =    56.541 deg,	R =   176.212 deg
};
/END

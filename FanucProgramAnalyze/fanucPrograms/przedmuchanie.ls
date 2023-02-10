/PROG  PRZEDMUCHANIE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1486;
CREATE		= DATE 18-04-27  TIME 10:54:18;
MODIFIED	= DATE 18-07-06  TIME 11:23:38;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 53;
MEMORY_SIZE	= 1806;
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
   2:   ;
   3:  CALL STANCHWYTAKA(3) ;
   4:  IF (R[3:stan chwytaka 3]<>1) THEN ;
   5:  CALL ALARM2(1,3) ;
   6:  ENDIF ;
   7:   ;
   8:  CALL STANCHWYTAKA(3) ;
   9:  IF (R[3:stan chwytaka 3]=1) THEN ;
  10:  UTOOL_NUM=3 ;
  11:  DO[103:zamknij przechwyt]=OFF ;
  12:  WAIT DI[103:przechwyt otwarty]=OFF    ;
  13:J P[1] 100% CNT20 Tool_Offset,PR[6:przechwyt offse]    ;
  14:L P[1] R[25:posuw L]mm/sec FINE    ;
  15:  CALL ZALOZPRZEDMUCH(3) ;
  16:L P[1] R[25:posuw L]mm/sec CNT50 Tool_Offset,PR[23:offs Z80]    ;
  17:J P[1] 100% CNT20 Tool_Offset,PR[6:przechwyt offse]    ;
  18:  DO[102:wl przedmuch]=PULSE,1.0sec ;
  19:  WAIT   1.20(sec) ;
  20:  DO[102:wl przedmuch]=PULSE,1.0sec ;
  21:  WAIT DI[104:przedmuch wl]=OFF    ;
  22:J P[1] 100% CNT20 Tool_Offset,PR[23:offs Z80]    ;
  23:L P[1] R[25:posuw L]mm/sec FINE    ;
  24:  CALL ODBIERZPRZEDMUCH(3) ;
  25:L P[1] R[25:posuw L]mm/sec CNT20 Tool_Offset,PR[9:przedmuch offs]    ;
  26:  //DO[103:zamknij przechwyt]=ON ;
  27:  ENDIF ;
  28:   ;
  29:  CALL STANCHWYTAKA(1) ;
  30:  IF (R[1:stan chwytaka 1]<>1) THEN ;
  31:  CALL ALARM2(1,1) ;
  32:  ENDIF ;
  33:   ;
  34:  CALL STANCHWYTAKA(1) ;
  35:  IF (R[1:stan chwytaka 1]=1) THEN ;
  36:  UTOOL_NUM=1 ;
  37:  DO[103:zamknij przechwyt]=OFF ;
  38:  WAIT DI[103:przechwyt otwarty]=OFF    ;
  39:J P[2] 100% CNT10 Tool_Offset,PR[6:przechwyt offse]    ;
  40:L P[2] R[25:posuw L]mm/sec FINE    ;
  41:  CALL ZALOZPRZEDMUCH(1) ;
  42:L P[2] R[25:posuw L]mm/sec CNT50 Tool_Offset,PR[23:offs Z80]    ;
  43:J P[2] 100% CNT10 Tool_Offset,PR[9:przedmuch offs]    ;
  44:  DO[102:wl przedmuch]=PULSE,1.0sec ;
  45:  WAIT   1.20(sec) ;
  46:  DO[102:wl przedmuch]=PULSE,1.0sec ;
  47:  WAIT DI[104:przedmuch wl]=OFF    ;
  48:J P[2] 100% CNT20 Tool_Offset,PR[23:offs Z80]    ;
  49:L P[2] R[25:posuw L]mm/sec FINE    ;
  50:  CALL ODBIERZPRZEDMUCH(1) ;
  51:L P[2] R[25:posuw L]mm/sec CNT20 Tool_Offset,PR[9:przedmuch offs]    ;
  52:  //DO[103:zamknij przechwyt]=ON ;
  53:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   658.760  mm,	Y =   236.228  mm,	Z =   350.827  mm,
	W =    86.482 deg,	P =   -89.816 deg,	R =    23.379 deg
};
P[2]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   656.884  mm,	Y =   239.189  mm,	Z =   349.767  mm,
	W =     9.614 deg,	P =   -86.473 deg,	R =    99.463 deg
};
/END

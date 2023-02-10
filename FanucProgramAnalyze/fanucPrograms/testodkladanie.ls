/PROG  TESTODKLADANIE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1428;
CREATE		= DATE 17-03-06  TIME 14:33:44;
MODIFIED	= DATE 17-03-07  TIME 08:04:26;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 45;
MEMORY_SIZE	= 1764;
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
   3:   ;
   4:  IF (F[10:detal z belki 1]=ON) THEN ;
   5:  CALL STANCHWYTAKA(3) ;
   6:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=1) THEN ;
   7:  UTOOL_NUM=3 ;
   8:J P[1] 100% CNT100 Offset,PR[14:offset Z70 Y-30]    ;
   9:L P[1] R[25:posuw L]mm/sec FINE    ;
  10:  CALL OTWORZCHWYTAK(3) ;
  11:L P[1] R[25:posuw L]mm/sec CNT50 Offset,PR[14:offset Z70 Y-30]    ;
  12:  ENDIF ;
  13:   ;
  14:  CALL STANCHWYTAKA(1) ;
  15:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=1) THEN ;
  16:  UTOOL_NUM=1 ;
  17:J P[2] 100% CNT100 Offset,PR[14:offset Z70 Y-30]    ;
  18:L P[2] R[25:posuw L]mm/sec FINE    ;
  19:  CALL OTWORZCHWYTAK(1) ;
  20:L P[2] R[25:posuw L]mm/sec CNT50 Offset,PR[14:offset Z70 Y-30]    ;
  21:  ENDIF ;
  22:  ENDIF ;
  23:   ;
  24:  IF (F[11:detal z belki 2]=ON) THEN ;
  25:  CALL STANCHWYTAKA(3) ;
  26:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=1) THEN ;
  27:  UTOOL_NUM=3 ;
  28:J P[3] 100% CNT100 Offset,PR[20:offset Y-100 Z70]    ;
  29:L P[3] R[25:posuw L]mm/sec FINE    ;
  30:  CALL OTWORZCHWYTAK(3) ;
  31:L P[3] R[25:posuw L]mm/sec CNT50 Offset,PR[20:offset Y-100 Z70]    ;
  32:  ENDIF ;
  33:   ;
  34:  CALL STANCHWYTAKA(1) ;
  35:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=1) THEN ;
  36:  UTOOL_NUM=1 ;
  37:J P[4] 100% CNT100 Offset,PR[21:offset Y-90 Z100]    ;
  38:L P[4] R[25:posuw L]mm/sec FINE    ;
  39:  CALL OTWORZCHWYTAK(1) ;
  40:L P[4] R[25:posuw L]mm/sec CNT100 Offset,PR[21:offset Y-90 Z100]    ;
  41:  ENDIF ;
  42:  ENDIF ;
  43:   ;
  44:  F[10:detal z belki 1]=(OFF) ;
  45:  F[11:detal z belki 2]=(OFF) ;
/POS
P[1]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =  1117.427  mm,	Y =   -88.872  mm,	Z =    42.695  mm,
	W =    52.224 deg,	P =    -2.477 deg,	R =     4.439 deg
};
P[2]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   878.282  mm,	Y =   -88.803  mm,	Z =    41.979  mm,
	W =    52.200 deg,	P =    -2.506 deg,	R =     4.500 deg
};
P[3]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   663.717  mm,	Y =   -43.865  mm,	Z =    52.292  mm,
	W =    46.858 deg,	P =     7.756 deg,	R =    -4.165 deg
};
P[4]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, -1',
	X =   470.423  mm,	Y =   -58.745  mm,	Z =    61.054  mm,
	W =    58.010 deg,	P =     5.528 deg,	R =   -17.752 deg
};
/END

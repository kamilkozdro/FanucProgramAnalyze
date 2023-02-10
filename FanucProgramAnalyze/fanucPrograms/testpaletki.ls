/PROG  TESTPALETKI
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1022;
CREATE		= DATE 17-02-06  TIME 12:37:38;
MODIFIED	= DATE 18-01-05  TIME 08:23:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 30;
MEMORY_SIZE	= 1414;
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
   1:  LBL[1] ;
   2:  IF ((DI[101:paletka gorna]=ON) AND (DI[102:paletka dolna]=OFF)) THEN ;
   3:  UFRAME_NUM=4 ;
   4:  UTOOL_NUM=1 ;
   5:  IF (R[15:aktualny detal]<=179) THEN ;
   6:  CALL OBLOFFSET    ;
   7:J P[1] 100% CNT50 Offset,PR[3:modyf offset]    ;
   8:  PR[3,3:modyf offset]=0    ;
   9:L P[1] R[25:posuw L]mm/sec FINE Offset,PR[3:modyf offset]    ;
  10:  PR[3,3:modyf offset]=50    ;
  11:L P[1] R[25:posuw L]mm/sec CNT50 Offset,PR[3:modyf offset]    ;
  12:  R[15:aktualny detal]=R[15:aktualny detal]+40    ;
  13:  JMP LBL[1] ;
  14:  ENDIF ;
  15:  ENDIF ;
  16:   ;
  17:  IF ((DI[102:paletka dolna]=ON) AND (DI[101:paletka gorna]=OFF)) THEN ;
  18:  UFRAME_NUM=5 ;
  19:  UTOOL_NUM=1 ;
  20:  IF (R[15:aktualny detal]<=179) THEN ;
  21:  CALL OBLOFFSET    ;
  22:J P[2] 100% CNT50 Offset,PR[3:modyf offset]    ;
  23:  PR[3,3:modyf offset]=0    ;
  24:L P[2] R[25:posuw L]mm/sec FINE Offset,PR[3:modyf offset]    ;
  25:  PR[3,3:modyf offset]=50    ;
  26:L P[2] R[25:posuw L]mm/sec CNT50 Offset,PR[3:modyf offset]    ;
  27:  R[15:aktualny detal]=R[15:aktualny detal]+20    ;
  28:  JMP LBL[1] ;
  29:  ENDIF ;
  30:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     7.799  mm,	Y =     6.060  mm,	Z =    22.676  mm,
	W =      .509 deg,	P =      .357 deg,	R =     -.526 deg
};
P[2]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     7.935  mm,	Y =     5.580  mm,	Z =    22.387  mm,
	W =      .551 deg,	P =      .515 deg,	R =     -.346 deg
};
/END

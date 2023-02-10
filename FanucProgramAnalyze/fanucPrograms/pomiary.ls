/PROG  POMIARY
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 2035;
CREATE		= DATE 17-09-26  TIME 16:55:48;
MODIFIED	= DATE 17-12-04  TIME 21:28:36;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 74;
MEMORY_SIZE	= 2507;
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
   1:  //IF (F[10:detal z belki 1]=ON AND (F[12:pom szczeki 1]=ON OR R[13:stan det 3]<>1)),JMP LBL[99] ;
   2:  //IF (F[10:detal z belki 1]=ON AND (F[13:pom szczeki 2]=ON OR R[11:stan det 1]<>1)),JMP LBL[99] ;
   3:  //IF (F[11:detal z belki 2]=ON AND (F[14:pom szczeki 3]=ON OR R[13:stan det 3]<>1)),JMP LBL[99] ;
   4:  //IF (F[11:detal z belki 2]=ON AND (F[15:pom szczeki 4]=ON OR R[11:stan det 1]<>1)),JMP LBL[99] ;
   5:   ;
   6:  IF (F[10:detal z belki 1]=ON) THEN ;
   7:  IF ((F[12:pom szczeki 1]=ON OR R[13:stan det 3]<>1) AND (F[13:pom szczeki 2]=ON OR R[11:stan det 1]<>1)) THEN ;
   8:  JMP LBL[99] ;
   9:  ENDIF ;
  10:  ENDIF ;
  11:   ;
  12:  IF (F[11:detal z belki 2]=ON) THEN ;
  13:  IF ((F[14:pom szczeki 3]=ON OR R[13:stan det 3]<>1) AND (F[15:pom szczeki 4]=ON OR R[11:stan det 1]<>1)) THEN ;
  14:  JMP LBL[99] ;
  15:  ENDIF ;
  16:  ENDIF ;
  17:   ;
  18:  UFRAME_NUM=4 ;
  19:  UTOOL_NUM=1 ;
  20:J P[5] 100% CNT100    ;
  21:   ;
  22:  IF (F[10:detal z belki 1]=ON) THEN ;
  23:  IF (F[12:pom szczeki 1]=OFF AND R[11:stan det 1]=1) THEN ;
  24:  UTOOL_NUM=1 ;
  25:J P[1] 100% CNT50 Offset,PR[27:offs Y-120 Z50]    ;
  26:L P[1] R[25:posuw L]mm/sec FINE    ;
  27:  CALL OTWORZCHWYTAK(1) ;
  28:J P[1] 100% CNT10 Offset,PR[27:offs Y-120 Z50]    ;
  29:  F[12:pom szczeki 1]=(ON) ;
  30:  ENDIF ;
  31:   ;
  32:  IF (F[13:pom szczeki 2]=OFF AND R[13:stan det 3]=1) THEN ;
  33:  UTOOL_NUM=3 ;
  34:J P[2] 100% CNT50 Offset,PR[27:offs Y-120 Z50]    ;
  35:L P[2] R[25:posuw L]mm/sec FINE    ;
  36:  CALL OTWORZCHWYTAK(3) ;
  37:J P[2] 100% CNT10 Offset,PR[27:offs Y-120 Z50]    ;
  38:  F[13:pom szczeki 2]=(ON) ;
  39:  ENDIF ;
  40:  ENDIF ;
  41:   ;
  42:  IF (F[11:detal z belki 2]=ON) THEN ;
  43:  IF (F[14:pom szczeki 3]=OFF AND R[11:stan det 1]=1) THEN ;
  44:  UTOOL_NUM=1 ;
  45:J P[3] 100% CNT50 Offset,PR[27:offs Y-120 Z50]    ;
  46:L P[3] R[25:posuw L]mm/sec FINE    ;
  47:  CALL OTWORZCHWYTAK(1) ;
  48:J P[3] 100% CNT10 Offset,PR[27:offs Y-120 Z50]    ;
  49:  F[14:pom szczeki 3]=(ON) ;
  50:  ENDIF ;
  51:   ;
  52:  IF (F[15:pom szczeki 4]=OFF AND R[13:stan det 3]=1) THEN ;
  53:  UTOOL_NUM=3 ;
  54:J P[4] 100% CNT50 Offset,PR[27:offs Y-120 Z50]    ;
  55:L P[4] R[25:posuw L]mm/sec FINE    ;
  56:  CALL OTWORZCHWYTAK(3) ;
  57:J P[4] 100% CNT10 Offset,PR[27:offs Y-120 Z50]    ;
  58:  F[15:pom szczeki 4]=(ON) ;
  59:  ENDIF ;
  60:  ENDIF ;
  61:   ;
  62:  IF ((F[12:pom szczeki 1]=ON) AND (F[13:pom szczeki 2]=ON) AND F[14:pom szczeki 3]=ON AND F[15:pom szczeki 4]=ON) THEN ;
  63:  F[12:pom szczeki 1]=(OFF) ;
  64:  F[13:pom szczeki 2]=(OFF) ;
  65:  F[14:pom szczeki 3]=(OFF) ;
  66:  F[15:pom szczeki 4]=(OFF) ;
  67:  DO[113:pomiary]=PULSE,1.0sec ;
  68:  ENDIF ;
  69:   ;
  70:  UFRAME_NUM=4 ;
  71:  UTOOL_NUM=1 ;
  72:J P[5] 100% CNT100    ;
  73:   ;
  74:  LBL[99] ;
/POS
P[1]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   781.418  mm,	Y =   667.853  mm,	Z =   569.111  mm,
	W =    50.365 deg,	P =   -11.558 deg,	R =   -18.799 deg
};
P[2]{
   GP1:
	UF : 4, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   663.461  mm,	Y =   672.367  mm,	Z =   557.962  mm,
	W =    46.283 deg,	P =   -11.042 deg,	R =   -23.414 deg
};
P[3]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   547.897  mm,	Y =   664.735  mm,	Z =   562.655  mm,
	W =    50.369 deg,	P =   -11.557 deg,	R =   -18.800 deg
};
P[4]{
   GP1:
	UF : 4, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   431.780  mm,	Y =   664.678  mm,	Z =   556.338  mm,
	W =    46.279 deg,	P =   -11.043 deg,	R =   -23.415 deg
};
P[5]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   279.189  mm,	Y =   254.949  mm,	Z =   401.776  mm,
	W =    32.618 deg,	P =      .104 deg,	R =     3.073 deg
};
/END

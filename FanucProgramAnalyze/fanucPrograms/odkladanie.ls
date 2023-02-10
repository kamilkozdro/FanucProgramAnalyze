/PROG  ODKLADANIE
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3613;
CREATE		= DATE 17-12-19  TIME 19:07:44;
MODIFIED	= DATE 17-12-19  TIME 19:07:44;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 145;
MEMORY_SIZE	= 3941;
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
   3:  !obsluga pelnych koszy ;
   4:  IF (F[5:akt skrzynka 1]=OFF AND F[6:akt skrzynka 2]=OFF) THEN ;
   5:  CALL ALARM2(4) ;
   6:  ENDIF ;
   7:  IF (DI[132:kosz 3 sele mitut pelny]=ON) THEN ;
   8:  CALL ALARM2(4) ;
   9:  ENDIF ;
  10:  IF (DI[133:kosz 4 sele wym11 pelny]=ON) THEN ;
  11:  CALL ALARM2(4) ;
  12:  ENDIF ;
  13:  IF (DI[134:kosz 5 zle pelny]=ON) THEN ;
  14:  CALL ALARM2(4) ;
  15:  ENDIF ;
  16:   ;
  17:  !kosz 1 dobre ;
  18:  CALL STANCHWYTAKA(1) ;
  19:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=1 AND F[5:akt skrzynka 1]=ON) THEN ;
  20:  UTOOL_NUM=1 ;
  21:J P[1] 100% CNT100 Offset,PR[25:offs Y-120 Z120]    ;
  22:L P[1] R[28:posuw odkladanie]mm/sec FINE    ;
  23:  CALL OTWORZCHWYTAK(1) ;
  24:L P[1] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[25:offs Y-120 Z120]    ;
  25:  DO[117:kosz 1]=PULSE,1.0sec ;
  26:  ENDIF ;
  27:   ;
  28:  CALL STANCHWYTAKA(3) ;
  29:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=1 AND F[5:akt skrzynka 1]=ON) THEN ;
  30:  UTOOL_NUM=3 ;
  31:J P[2] 100% CNT100 Offset,PR[25:offs Y-120 Z120]    ;
  32:L P[2] R[28:posuw odkladanie]mm/sec FINE    ;
  33:  CALL OTWORZCHWYTAK(3) ;
  34:L P[2] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[25:offs Y-120 Z120]    ;
  35:  DO[117:kosz 1]=PULSE,1.0sec ;
  36:  ENDIF ;
  37:   ;
  38:  !kosz 2 dobre ;
  39:  CALL STANCHWYTAKA(1) ;
  40:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=1 AND F[6:akt skrzynka 2]=ON) THEN ;
  41:  UTOOL_NUM=1 ;
  42:J P[3] 100% CNT100 Offset,PR[25:offs Y-120 Z120]    ;
  43:L P[3] R[28:posuw odkladanie]mm/sec FINE    ;
  44:  CALL OTWORZCHWYTAK(1) ;
  45:L P[3] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[25:offs Y-120 Z120]    ;
  46:  DO[118:kosz 2]=PULSE,1.0sec ;
  47:  ENDIF ;
  48:   ;
  49:  CALL STANCHWYTAKA(3) ;
  50:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=1 AND F[6:akt skrzynka 2]=ON) THEN ;
  51:  UTOOL_NUM=3 ;
  52:J P[4] 100% CNT100 Offset,PR[25:offs Y-120 Z120]    ;
  53:L P[4] R[28:posuw odkladanie]mm/sec FINE    ;
  54:  CALL OTWORZCHWYTAK(3) ;
  55:L P[4] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[25:offs Y-120 Z120]    ;
  56:  DO[118:kosz 2]=PULSE,1.0sec ;
  57:  ENDIF ;
  58:   ;
  59:  !kosz 3 selekcja grube ;
  60:  CALL STANCHWYTAKA(1) ;
  61:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=3) THEN ;
  62:  UTOOL_NUM=1 ;
  63:J P[5] 100% CNT100 Offset,PR[21:offset Y-90 Z100]    ;
  64:L P[5] R[28:posuw odkladanie]mm/sec FINE    ;
  65:  CALL OTWORZCHWYTAK(1) ;
  66:L P[5] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[21:offset Y-90 Z100]    ;
  67:  DO[119:kosz 3]=PULSE,1.0sec ;
  68:  ENDIF ;
  69:   ;
  70:  CALL STANCHWYTAKA(3) ;
  71:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=3) THEN ;
  72:  UTOOL_NUM=3 ;
  73:J P[6] 100% CNT100 Offset,PR[21:offset Y-90 Z100]    ;
  74:L P[6] R[28:posuw odkladanie]mm/sec FINE    ;
  75:  CALL OTWORZCHWYTAK(3) ;
  76:L P[6] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[21:offset Y-90 Z100]    ;
  77:  DO[119:kosz 3]=PULSE,1.0sec ;
  78:  ENDIF ;
  79:   ;
  80:  !kosz 4 selekcja WYM11 ;
  81:  CALL STANCHWYTAKA(1) ;
  82:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=2) THEN ;
  83:  UTOOL_NUM=1 ;
  84:J P[7] 100% CNT100 Offset,PR[21:offset Y-90 Z100]    ;
  85:L P[7] R[28:posuw odkladanie]mm/sec FINE    ;
  86:  CALL OTWORZCHWYTAK(1) ;
  87:L P[7] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[21:offset Y-90 Z100]    ;
  88:  DO[120:kosz 4]=PULSE,1.0sec ;
  89:  ENDIF ;
  90:   ;
  91:  CALL STANCHWYTAKA(3) ;
  92:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=2) THEN ;
  93:  UTOOL_NUM=3 ;
  94:J P[8] 100% CNT100 Offset,PR[21:offset Y-90 Z100]    ;
  95:L P[8] R[28:posuw odkladanie]mm/sec FINE    ;
  96:  CALL OTWORZCHWYTAK(3) ;
  97:L P[8] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[21:offset Y-90 Z100]    ;
  98:  DO[120:kosz 4]=PULSE,1.0sec ;
  99:  ENDIF ;
 100:   ;
 101:  !kosz 5 zle ;
 102:  IF (R[11:stan det 1]=0 OR R[13:stan det 3]=0) THEN ;
 103:  UFRAME_NUM=7 ;
 104:  UTOOL_NUM=1 ;
 105:J P[11] 100% CNT100    ;
 106:   ;
 107:   ;
 108:  UFRAME_NUM=4 ;
 109:  CALL STANCHWYTAKA(1) ;
 110:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]=0) THEN ;
 111:  UTOOL_NUM=1 ;
 112:J P[9] 100% CNT100 Offset,PR[27:offs Y-120 Z50]    ;
 113:L P[9] R[28:posuw odkladanie]mm/sec FINE    ;
 114:  CALL OTWORZCHWYTAK(1) ;
 115:L P[9] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[27:offs Y-120 Z50]    ;
 116:   ;
 117:  DO[121:kosz 5]=PULSE,1.0sec ;
 118:  IF (F[10:detal z belki 1]=ON) THEN ;
 119:  DO[123:szczeki 1]=PULSE,1.0sec ;
 120:  ENDIF ;
 121:  IF (F[11:detal z belki 2]=ON) THEN ;
 122:  DO[125:szczeki 3]=PULSE,1.0sec ;
 123:  ENDIF ;
 124:   ;
 125:  ENDIF ;
 126:   ;
 127:  CALL STANCHWYTAKA(3) ;
 128:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]=0) THEN ;
 129:  UTOOL_NUM=3 ;
 130:J P[10] 100% CNT100 Offset,PR[27:offs Y-120 Z50]    ;
 131:L P[10] R[28:posuw odkladanie]mm/sec FINE    ;
 132:  CALL OTWORZCHWYTAK(3) ;
 133:L P[10] R[28:posuw odkladanie]mm/sec CNT50 Offset,PR[27:offs Y-120 Z50]    ;
 134:   ;
 135:  DO[121:kosz 5]=PULSE,1.0sec ;
 136:  IF (F[10:detal z belki 1]=ON) THEN ;
 137:  DO[124:szczeki 2]=PULSE,1.0sec ;
 138:  ENDIF ;
 139:  IF (F[11:detal z belki 2]=ON) THEN ;
 140:  DO[126:szczeki 4]=PULSE,1.0sec ;
 141:  ENDIF ;
 142:   ;
 143:  ENDIF ;
 144:  ENDIF ;
 145:   ;
/POS
P[1]{
   GP1:
	UF : 7, UT : 1,	
	J1=    58.559 deg,	J2=     7.534 deg,	J3=   -29.486 deg,
	J4=    10.882 deg,	J5=   -76.512 deg,	J6=    29.056 deg
};
P[2]{
   GP1:
	UF : 7, UT : 3,	
	J1=    58.896 deg,	J2=     7.874 deg,	J3=   -29.961 deg,
	J4=    10.803 deg,	J5=   -76.106 deg,	J6=   148.511 deg
};
P[3]{
   GP1:
	UF : 7, UT : 1,	
	J1=    71.125 deg,	J2=   -10.974 deg,	J3=   -34.739 deg,
	J4=    -2.547 deg,	J5=   -47.601 deg,	J6=    22.003 deg
};
P[4]{
   GP1:
	UF : 7, UT : 3,	
	J1=    70.008 deg,	J2=    -9.926 deg,	J3=   -34.218 deg,
	J4=    -4.774 deg,	J5=   -51.155 deg,	J6=   146.878 deg
};
P[5]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   330.079  mm,	Y =   -52.949  mm,	Z =    -1.285  mm,
	W =    29.348 deg,	P =      .215 deg,	R =      .079 deg
};
P[6]{
   GP1:
	UF : 7, UT : 3,	
	J1=    90.946 deg,	J2=   -15.011 deg,	J3=   -33.491 deg,
	J4=    -2.305 deg,	J5=   -50.796 deg,	J6=   124.465 deg
};
P[7]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    88.165  mm,	Y =   -52.008  mm,	Z =    -2.909  mm,
	W =    29.344 deg,	P =      .215 deg,	R =      .079 deg
};
P[8]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =    92.857  mm,	Y =   -56.049  mm,	Z =    -4.503  mm,
	W =    27.385 deg,	P =    -2.945 deg,	R =     2.444 deg
};
P[9]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   316.406  mm,	Y =   666.286  mm,	Z =   561.655  mm,
	W =    53.061 deg,	P =   -10.554 deg,	R =   -22.792 deg
};
P[10]{
   GP1:
	UF : 4, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   316.579  mm,	Y =   663.726  mm,	Z =   556.642  mm,
	W =    52.166 deg,	P =    -7.729 deg,	R =   -24.401 deg
};
P[11]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   688.025  mm,	Y =  -271.847  mm,	Z =   215.628  mm,
	W =      .313 deg,	P =    -2.122 deg,	R =      .819 deg
};
/END

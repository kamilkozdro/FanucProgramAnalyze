/PROG  PALETKI
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 3079;
CREATE		= DATE 17-08-08  TIME 10:25:04;
MODIFIED	= DATE 18-04-11  TIME 11:07:48;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 134;
MEMORY_SIZE	= 3615;
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
   1:  IF ((DI[101:paletka gorna]=OFF) AND (DI[102:paletka dolna]=OFF)) THEN ;
   2:  CALL ZMIENPALETKI    ;
   3:  R[15:aktualny detal]=0    ;
   4:  ENDIF ;
   5:   ;
   6:  LBL[1] ;
   7:   ;
   8:  CALL POZBEZP    ;
   9:   ;
  10:  !zmiana paletki ;
  11:  IF (R[15:aktualny detal]>=R[16:max wierszy]*R[17:max kolumn]) THEN ;
  12:  CALL HOME    ;
  13:J P[5] 100% FINE    ;
  14:  CALL ZMIENPALETKI    ;
  15:  R[15:aktualny detal]=0    ;
  16:  ENDIF ;
  17:   ;
  18:  IF (DI[112:paletki gotowe]=OFF) THEN ;
  19:  CALL STANCHWYTAKA(1) ;
  20:  CALL STANCHWYTAKA(2) ;
  21:  IF (((R[1:stan chwytaka 1]<>1) OR (R[2:stan chwytaka 2]<>1))) THEN ;
  22:  WAIT DI[112:paletki gotowe]=ON    ;
  23:  ENDIF ;
  24:  ENDIF ;
  25:   ;
  26:  IF (DI[112:paletki gotowe]=ON) THEN ;
  27:  PAYLOAD[1] ;
  28:  CALL OBLOFFSET    ;
  29:   ;
  30:  IF ((DI[101:paletka gorna]=ON) AND (DI[102:paletka dolna]=OFF)) THEN ;
  31:  UFRAME_NUM=4 ;
  32:   ;
  33:  CALL STANCHWYTAKA(1) ;
  34:  IF (R[1:stan chwytaka 1]<>1) THEN ;
  35:  UTOOL_NUM=1 ;
  36:  CALL OTWORZCHWYTAK(1) ;
  37:J P[1] 100% CNT20 Offset,PR[3:modyf offset]    ;
  38:  PR[3,3:modyf offset]=0    ;
  39:L P[1] R[25:posuw L]mm/sec FINE Offset,PR[3:modyf offset]    ;
  40:  SOFTFLOAT[1] ;
  41:  CALL ZAMKNIJCHWYTAK(1) ;
  42:  WAIT    .10(sec) ;
  43:  CALL STANCHWYTAKA(1) ;
  44:  IF (R[1:stan chwytaka 1]<>1) THEN ;
  45:  CALL OTWORZCHWYTAK(1) ;
  46:  WAIT    .10(sec) ;
  47:  ENDIF ;
  48:  SOFTFLOAT END ;
  49:  PR[10:kompen paletki]=LPOS    ;
  50:  PR[10,3:kompen paletki]=PR[10,3:kompen paletki]+50    ;
  51:L PR[10:kompen paletki] R[25:posuw L]mm/sec CNT50    ;
  52:  R[15:aktualny detal]=R[15:aktualny detal]+1    ;
  53:  JMP LBL[1] ;
  54:  ENDIF ;
  55:   ;
  56:  CALL STANCHWYTAKA(2) ;
  57:  IF (R[2:stan chwytaka 2]<>1) THEN ;
  58:  UTOOL_NUM=2 ;
  59:  CALL OTWORZCHWYTAK(2) ;
  60:J P[2] 100% CNT20 Offset,PR[3:modyf offset]    ;
  61:  PR[3,3:modyf offset]=0    ;
  62:L P[2] R[25:posuw L]mm/sec FINE Offset,PR[3:modyf offset]    ;
  63:  SOFTFLOAT[1] ;
  64:  CALL ZAMKNIJCHWYTAK(2) ;
  65:  WAIT    .10(sec) ;
  66:  CALL STANCHWYTAKA(2) ;
  67:  IF (R[2:stan chwytaka 2]<>1) THEN ;
  68:  CALL OTWORZCHWYTAK(2) ;
  69:  WAIT    .10(sec) ;
  70:  ENDIF ;
  71:   ;
  72:  SOFTFLOAT END ;
  73:  PR[10:kompen paletki]=LPOS    ;
  74:  PR[10,3:kompen paletki]=PR[10,3:kompen paletki]+50    ;
  75:L PR[10:kompen paletki] R[25:posuw L]mm/sec CNT50    ;
  76:  R[15:aktualny detal]=R[15:aktualny detal]+1    ;
  77:  JMP LBL[1] ;
  78:  ENDIF ;
  79:  ENDIF ;
  80:   ;
  81:  IF ((DI[102:paletka dolna]=ON) AND (DI[101:paletka gorna]=OFF)) THEN ;
  82:  UFRAME_NUM=5 ;
  83:   ;
  84:  CALL STANCHWYTAKA(1) ;
  85:  IF (R[1:stan chwytaka 1]<>1) THEN ;
  86:  UTOOL_NUM=1 ;
  87:  CALL OTWORZCHWYTAK(1) ;
  88:J P[3] 100% CNT50 Offset,PR[3:modyf offset]    ;
  89:  PR[3,3:modyf offset]=0    ;
  90:L P[3] R[25:posuw L]mm/sec FINE Offset,PR[3:modyf offset]    ;
  91:  SOFTFLOAT[1] ;
  92:  CALL ZAMKNIJCHWYTAK(1) ;
  93:  WAIT    .10(sec) ;
  94:  CALL STANCHWYTAKA(1) ;
  95:  IF (R[1:stan chwytaka 1]<>1) THEN ;
  96:  CALL OTWORZCHWYTAK(1) ;
  97:  WAIT    .10(sec) ;
  98:  ENDIF ;
  99:   ;
 100:  SOFTFLOAT END ;
 101:  PR[10:kompen paletki]=LPOS    ;
 102:  PR[10,3:kompen paletki]=PR[10,3:kompen paletki]+50    ;
 103:L PR[10:kompen paletki] R[25:posuw L]mm/sec CNT50    ;
 104:   ;
 105:  R[15:aktualny detal]=R[15:aktualny detal]+1    ;
 106:  JMP LBL[1] ;
 107:  ENDIF ;
 108:   ;
 109:   ;
 110:  CALL STANCHWYTAKA(2) ;
 111:  IF (R[2:stan chwytaka 2]<>1) THEN ;
 112:  UTOOL_NUM=2 ;
 113:  CALL OTWORZCHWYTAK(2) ;
 114:J P[4] 100% CNT50 Offset,PR[3:modyf offset]    ;
 115:  PR[3,3:modyf offset]=0    ;
 116:L P[4] R[25:posuw L]mm/sec FINE Offset,PR[3:modyf offset]    ;
 117:  SOFTFLOAT[1] ;
 118:  CALL ZAMKNIJCHWYTAK(2) ;
 119:  WAIT    .10(sec) ;
 120:  CALL STANCHWYTAKA(2) ;
 121:  IF (R[2:stan chwytaka 2]<>1) THEN ;
 122:  CALL OTWORZCHWYTAK(2) ;
 123:  WAIT    .10(sec) ;
 124:  ENDIF ;
 125:  SOFTFLOAT END ;
 126:  PR[10:kompen paletki]=LPOS    ;
 127:  PR[10,3:kompen paletki]=PR[10,3:kompen paletki]+50    ;
 128:L PR[10:kompen paletki] R[25:posuw L]mm/sec CNT50    ;
 129:   ;
 130:  R[15:aktualny detal]=R[15:aktualny detal]+1    ;
 131:  JMP LBL[1] ;
 132:  ENDIF ;
 133:  ENDIF ;
 134:  ENDIF ;
/POS
P[1]{
   GP1:
	UF : 4, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     7.805  mm,	Y =     6.052  mm,	Z =    22.688  mm,
	W =      .506 deg,	P =      .355 deg,	R =     -.525 deg
};
P[2]{
   GP1:
	UF : 4, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =     8.938  mm,	Y =     6.229  mm,	Z =    23.045  mm,
	W =      .898 deg,	P =     -.014 deg,	R =    -1.959 deg
};
P[3]{
   GP1:
	UF : 5, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     7.924  mm,	Y =     5.580  mm,	Z =    22.380  mm,
	W =      .553 deg,	P =      .515 deg,	R =     -.344 deg
};
P[4]{
   GP1:
	UF : 5, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =     9.406  mm,	Y =     5.110  mm,	Z =    24.663  mm,
	W =      .438 deg,	P =      .296 deg,	R =    -1.589 deg
};
P[5]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   685.766  mm,	Y =   110.444  mm,	Z =   239.785  mm,
	W =     3.996 deg,	P =     1.344 deg,	R =   -87.468 deg
};
/END

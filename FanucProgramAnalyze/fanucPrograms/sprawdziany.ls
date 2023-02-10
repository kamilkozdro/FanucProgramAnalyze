/PROG  SPRAWDZIANY
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 4747;
CREATE		= DATE 18-04-27  TIME 10:32:12;
MODIFIED	= DATE 18-06-15  TIME 13:24:24;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 198;
MEMORY_SIZE	= 5267;
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
   1:  !stan detalu = 0 -> zly ;
   2:  !stan detalu = 1 -> dobry ;
   3:  !stan detalu = 2 -> wada wym11 ;
   4:  !stan detalu = 3 -> wada mitut ;
   5:  PAYLOAD[1] ;
   6:  UFRAME_NUM=7 ;
   7:  R[11:stan det 1]=1    ;
   8:  R[12:stan det 2]=1    ;
   9:  R[13:stan det 3]=1    ;
  10:   ;
  11:  !spr GO ;
  12:  SKIP CONDITION DI[114:spr GO zly]=ON    ;
  13:  CALL STANCHWYTAKA(1) ;
  14:  IF ((R[1:stan chwytaka 1]=1) AND (R[11:stan det 1]<>0)) THEN ;
  15:  UTOOL_NUM=1 ;
  16:J P[1] 100% CNT10 Offset,PR[17:offset GO]    ;
  17:  DO[105:wl spr GO]=ON ;
  18:L P[1] R[24:szybki posuw spw]mm/sec CNT0 Offset,PR[29:offs Z17]    ;
  19:  CALL OTWORZCHWYTAK(1) ;
  20:L P[1] R[27:posuw sprawdz]mm/sec FINE Skip,LBL[3]    ;
  21:  R[11:stan det 1]=0    ;
  22:  LBL[3] ;
  23:  DO[105:wl spr GO]=OFF ;
  24:  SOFTFLOAT[1] ;
  25:  CALL ZAMKNIJCHWYTAK(1) ;
  26:  PR[30:poz na spr GO]=LPOS    ;
  27:  SOFTFLOAT END ;
  28:L PR[30:poz na spr GO] R[24:szybki posuw spw]mm/sec CNT25 Tool_Offset,PR[17:offset GO]    ;
  29:  ENDIF ;
  30:  CALL STANCHWYTAKA(1) ;
  31:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
  32:   ;
  33:  CALL STANCHWYTAKA(3) ;
  34:  IF ((R[3:stan chwytaka 3]=1) AND (R[13:stan det 3]<>0)) THEN ;
  35:  UTOOL_NUM=3 ;
  36:J P[2] 100% CNT10 Offset,PR[17:offset GO]    ;
  37:  DO[105:wl spr GO]=ON ;
  38:L P[2] R[24:szybki posuw spw]mm/sec CNT0 Offset,PR[29:offs Z17]    ;
  39:  CALL OTWORZCHWYTAK(3) ;
  40:L P[2] R[27:posuw sprawdz]mm/sec FINE Skip,LBL[1]    ;
  41:  R[13:stan det 3]=0    ;
  42:  LBL[1] ;
  43:  DO[105:wl spr GO]=OFF ;
  44:  SOFTFLOAT[1] ;
  45:  CALL ZAMKNIJCHWYTAK(3) ;
  46:  PR[30:poz na spr GO]=LPOS    ;
  47:  SOFTFLOAT END ;
  48:L PR[30:poz na spr GO] R[24:szybki posuw spw]mm/sec CNT25 Tool_Offset,PR[17:offset GO]    ;
  49:  ENDIF ;
  50:  CALL STANCHWYTAKA(3) ;
  51:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
  52:   ;
  53:  IF (R[11:stan det 1]=0 AND R[13:stan det 3]=0),JMP LBL[99] ;
  54:   ;
  55:  !spr NOGO ;
  56:  CALL STANCHWYTAKA(3) ;
  57:  IF (R[3:stan chwytaka 3]=1 AND R[13:stan det 3]<>0) THEN ;
  58:  UTOOL_NUM=3 ;
  59:J P[3] 100% CNT50 Offset,PR[7:NOGO offset]    ;
  60:  DO[106:wl spr NOGO]=ON ;
  61:L P[3] R[36:posow go]mm/sec FINE    ;
  62:  WAIT    .30(sec) ;
  63:  DO[106:wl spr NOGO]=OFF ;
  64:  WAIT ((DI[113:spr NOGO zly]=ON) OR (DI[106:spr NOGO ok]=ON))    ;
  65:  IF (DI[113:spr NOGO zly]=ON) THEN ;
  66:  R[13:stan det 3]=0    ;
  67:  ENDIF ;
  68:  DO[106:wl spr NOGO]=OFF ;
  69:L P[3] R[25:posuw L]mm/sec CNT50 Offset,PR[7:NOGO offset]    ;
  70:  CALL STANCHWYTAKA(3) ;
  71:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
  72:  ENDIF ;
  73:   ;
  74:  CALL STANCHWYTAKA(1) ;
  75:  IF (R[1:stan chwytaka 1]=1 AND R[11:stan det 1]<>0) THEN ;
  76:  UTOOL_NUM=1 ;
  77:J P[4] 100% CNT50 Offset,PR[7:NOGO offset]    ;
  78:  DO[106:wl spr NOGO]=ON ;
  79:L P[4] R[36:posow go]mm/sec FINE    ;
  80:  WAIT    .30(sec) ;
  81:  DO[106:wl spr NOGO]=OFF ;
  82:  WAIT ((DI[113:spr NOGO zly]=ON) OR (DI[106:spr NOGO ok]=ON))    ;
  83:  IF (DI[113:spr NOGO zly]=ON) THEN ;
  84:  R[11:stan det 1]=0    ;
  85:  ENDIF ;
  86:  DO[106:wl spr NOGO]=OFF ;
  87:L P[4] R[25:posuw L]mm/sec CNT50 Offset,PR[7:NOGO offset]    ;
  88:  CALL STANCHWYTAKA(1) ;
  89:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
  90:  ENDIF ;
  91:   ;
  92:  UTOOL_NUM=1 ;
  93:J P[5] 100% CNT50    ;
  94:  CALL POZBEZP    ;
  95:  UFRAME_NUM=7 ;
  96:  UTOOL_NUM=1 ;
  97:J P[5] 100% CNT50    ;
  98:   ;
  99:  !spr WYM11 ;
 100:  CALL STANCHWYTAKA(1) ;
 101:  IF ((R[1:stan chwytaka 1]=1) AND (R[11:stan det 1]<>0)) THEN ;
 102:  UTOOL_NUM=1 ;
 103:J P[6] 100% CNT50 Offset,PR[22:offset Z30]    ;
 104:L P[6] R[27:posuw sprawdz]mm/sec FINE TB   1.00sec,DO[129:przedmuch 11]=PULSE,0.6sec    ;
 105:  DO[109:wl spr WYM11]=PULSE,1.0sec ;
 106:  WAIT ((DI[115:spr WYM11 zly]=ON) OR (DI[111:spr WYM11 dobry]=ON) OR (DI[124:wym11 popraw]=ON))    ;
 107:  IF (DI[115:spr WYM11 zly]=ON) THEN ;
 108:  R[11:stan det 1]=0    ;
 109:  ENDIF ;
 110:  IF (DI[124:wym11 popraw]=ON) THEN ;
 111:  R[11:stan det 1]=2    ;
 112:  ENDIF ;
 113:L P[6] R[25:posuw L]mm/sec CNT50 Offset,PR[22:offset Z30]    ;
 114:  ENDIF ;
 115:   ;
 116:  CALL STANCHWYTAKA(3) ;
 117:  IF ((R[3:stan chwytaka 3]=1) AND (R[13:stan det 3]<>0)) THEN ;
 118:  UTOOL_NUM=3 ;
 119:J P[7] 100% CNT50 Offset,PR[22:offset Z30]    ;
 120:L P[7] R[27:posuw sprawdz]mm/sec FINE TB   1.00sec,DO[129:przedmuch 11]=PULSE,0.6sec    ;
 121:  DO[109:wl spr WYM11]=PULSE,1.0sec ;
 122:  WAIT ((DI[115:spr WYM11 zly]=ON) OR (DI[111:spr WYM11 dobry]=ON) OR (DI[124:wym11 popraw]=ON))    ;
 123:   ;
 124:  IF (DI[115:spr WYM11 zly]=ON) THEN ;
 125:  R[13:stan det 3]=0    ;
 126:  ENDIF ;
 127:  IF (DI[124:wym11 popraw]=ON) THEN ;
 128:  R[13:stan det 3]=2    ;
 129:  ENDIF ;
 130:   ;
 131:L P[7] R[25:posuw L]mm/sec CNT50 Offset,PR[22:offset Z30]    ;
 132:  ENDIF ;
 133:   ;
 134:  IF (R[11:stan det 1]=0 AND R[13:stan det 3]=0),JMP LBL[99] ;
 135:   ;
 136:  //CALL POZBEZP    ;
 137:  UFRAME_NUM=7 ;
 138:  UTOOL_NUM=3 ;
 139:J P[8] 100% CNT20    ;
 140:   ;
 141:  !spr mitutoyo ;
 142:   ;
 143:  CALL STANCHWYTAKA(1) ;
 144:  IF ((R[1:stan chwytaka 1]=1) AND (R[11:stan det 1]<>0)) THEN ;
 145:  UTOOL_NUM=1 ;
 146:J P[10] 100% CNT20 Offset,PR[23:offs Z80]    ;
 147:L P[10] R[27:posuw sprawdz]mm/sec FINE    ;
 148:  CALL OTWORZCHWYTAK(1) ;
 149:L P[10] R[24:szybki posuw spw]mm/sec FINE Offset,PR[28:offs Z20]    ;
 150:  DO[104:wl mitutoyo]=ON ;
 151:  IF (F[10:detal z belki 1]=ON),DO[123:szczeki 1]=PULSE,1.0sec ;
 152:  IF (F[11:detal z belki 2]=ON),DO[125:szczeki 3]=PULSE,1.0sec ;
 153:  WAIT (DI[117:mitutoyo zly]=ON OR DI[107:mitutoyo ok]=ON OR DI[123:mitutoyo popraw]=ON)    ;
 154:  IF (DI[117:mitutoyo zly]=ON) THEN ;
 155:  R[11:stan det 1]=0    ;
 156:  ENDIF ;
 157:  IF (DI[123:mitutoyo popraw]=ON) THEN ;
 158:  R[11:stan det 1]=3    ;
 159:  ENDIF ;
 160:  DO[104:wl mitutoyo]=OFF ;
 161:  WAIT    .50(sec) ;
 162:L P[10] R[24:szybki posuw spw]mm/sec FINE    ;
 163:  CALL ZAMKNIJCHWYTAK(1) ;
 164:L P[10] R[25:posuw L]mm/sec CNT20 Offset,PR[23:offs Z80]    ;
 165:  CALL STANCHWYTAKA(1) ;
 166:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
 167:  ENDIF ;
 168:   ;
 169:  CALL STANCHWYTAKA(3) ;
 170:  IF ((R[3:stan chwytaka 3]=1) AND (R[13:stan det 3]<>0)) THEN ;
 171:  UTOOL_NUM=3 ;
 172:J P[9] 100% CNT20 Offset,PR[23:offs Z80]    ;
 173:L P[9] R[27:posuw sprawdz]mm/sec FINE    ;
 174:  CALL OTWORZCHWYTAK(3) ;
 175:L P[9] R[24:szybki posuw spw]mm/sec FINE Offset,PR[28:offs Z20]    ;
 176:  DO[104:wl mitutoyo]=ON ;
 177:  IF (F[10:detal z belki 1]=ON),DO[124:szczeki 2]=PULSE,1.0sec ;
 178:  IF (F[11:detal z belki 2]=ON),DO[126:szczeki 4]=PULSE,1.0sec ;
 179:  WAIT (DI[117:mitutoyo zly]=ON OR DI[107:mitutoyo ok]=ON OR DI[123:mitutoyo popraw]=ON)    ;
 180:  IF (DI[117:mitutoyo zly]=ON) THEN ;
 181:  R[13:stan det 3]=0    ;
 182:  ENDIF ;
 183:  IF (DI[123:mitutoyo popraw]=ON) THEN ;
 184:  R[13:stan det 3]=3    ;
 185:  ENDIF ;
 186:  DO[104:wl mitutoyo]=OFF ;
 187:  WAIT    .50(sec) ;
 188:L P[9] R[24:szybki posuw spw]mm/sec FINE    ;
 189:  CALL ZAMKNIJCHWYTAK(3) ;
 190:L P[9] R[25:posuw L]mm/sec CNT20 Offset,PR[23:offs Z80]    ;
 191:  CALL STANCHWYTAKA(3) ;
 192:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
 193:  ENDIF ;
 194:   ;
 195:  UTOOL_NUM=1 ;
 196:J P[11] 100% CNT100    ;
 197:   ;
 198:  LBL[99] ;
/POS
P[1]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   312.589  mm,	Y =   205.829  mm,	Z =   272.284  mm,
	W =      .866 deg,	P =     1.403 deg,	R =    -1.044 deg
};
P[2]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   313.612  mm,	Y =   205.073  mm,	Z =   272.165  mm,
	W =      .544 deg,	P =      .638 deg,	R =     -.330 deg
};
P[3]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   313.003  mm,	Y =    97.550  mm,	Z =   244.500  mm,
	W =     1.927 deg,	P =     1.081 deg,	R =    -1.005 deg
};
P[4]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   311.780  mm,	Y =    98.534  mm,	Z =   244.000  mm,
	W =     1.099 deg,	P =     1.330 deg,	R =     -.516 deg
};
P[5]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   168.892  mm,	Y =  -124.838  mm,	Z =   239.117  mm,
	W =     1.095 deg,	P =      .175 deg,	R =      .143 deg
};
P[6]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     1.500  mm,	Y =    71.926  mm,	Z =    63.000  mm,
	W =    -1.672 deg,	P =     -.486 deg,	R =    -1.020 deg
};
P[7]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =     1.500  mm,	Y =    72.059  mm,	Z =    64.200  mm,
	W =      .225 deg,	P =     1.696 deg,	R =    -1.217 deg
};
P[8]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -77.540  mm,	Y =    67.558  mm,	Z =   239.263  mm,
	W =    -1.026 deg,	P =     -.481 deg,	R =      .313 deg
};
P[9]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =     5.011  mm,	Y =   284.288  mm,	Z =    95.097  mm,
	W =     -.362 deg,	P =    -1.388 deg,	R =    89.503 deg
};
P[10]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =     5.236  mm,	Y =   283.720  mm,	Z =    92.763  mm,
	W =      .277 deg,	P =      .968 deg,	R =    90.465 deg
};
P[11]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =    74.610  mm,	Y =  -146.001  mm,	Z =   214.085  mm,
	W =     -.076 deg,	P =     3.118 deg,	R =     -.426 deg
};
/END

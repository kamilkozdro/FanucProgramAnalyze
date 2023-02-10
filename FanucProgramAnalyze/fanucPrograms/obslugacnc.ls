/PROG  OBSLUGACNC
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 6105;
CREATE		= DATE 18-04-27  TIME 10:47:52;
MODIFIED	= DATE 18-07-23  TIME 13:23:54;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 255;
MEMORY_SIZE	= 6517;
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
   1:  UTOOL_NUM=3 ;
   2:  UFRAME_NUM=6 ;
   3:   ;
   4:  !czekaj na aktywna belke ;
   5:  WAIT (DI[119:belka 1]=ON OR DI[120:belka 2]=ON)    ;
   6:   ;
   7:  IF (DI[119:belka 1]=ON) THEN ;
   8:  F[10:detal z belki 1]=(ON) ;
   9:  F[11:detal z belki 2]=(OFF) ;
  10:  ENDIF ;
  11:  IF (DI[120:belka 2]=ON) THEN ;
  12:  F[10:detal z belki 1]=(OFF) ;
  13:  F[11:detal z belki 2]=(ON) ;
  14:  ENDIF ;
  15:   ;
  16:J P[1] 100% CNT20    ;
  17:   ;
  18:  CALL STANCHWYTAKA(3) ;
  19:  IF R[3:stan chwytaka 3]<>0,CALL ALARM2(2,3) ;
  20:   ;
  21:  IF (DI[119:belka 1]=ON) THEN ;
  22:  !pobranie z lewej szczeki ;
  23:  UTOOL_NUM=3 ;
  24:J P[2] 100% CNT5 Offset,PR[4:offset cnc]    ;
  25:  CALL OTWORZCHWYTAK(3) ;
  26:L P[2] R[25:posuw L]mm/sec FINE    ;
  27:  CALL ZAMKNIJCHWYTAK(3) ;
  28:  WAIT    .20(sec) ;
  29:  CALL STANCHWYTAKA(3) ;
  30:   ;
  31:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
  32:  DO[132:przedmuch imadel]=ON ;
  33:   ;
  34:L P[2] R[25:posuw L]mm/sec CNT10 Offset,PR[8:offset Y3]    ;
  35:L P[2] R[25:posuw L]mm/sec CNT50 Offset,PR[18:offset cnc2]    ;
  36:  CALL STANCHWYTAKA(3) ;
  37:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
  38:   ;
  39:  //    ;
  40:  !wstawienie do lewej szczeki ;
  41:  CALL STANCHWYTAKA(1) ;
  42:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
  43:  UTOOL_NUM=1 ;
  44:J P[3] 100% FINE Offset,PR[4:offset cnc]    ;
  45:L P[3] R[25:posuw L]mm/sec FINE    ;
  46:  DO[132:przedmuch imadel]=OFF ;
  47:   ;
  48:  CALL OTWORZCHWYTAK(1) ;
  49:L P[3] R[25:posuw L]mm/sec CNT50 Offset,PR[4:offset cnc]    ;
  50:   ;
  51:  !pobranie z prawej szczeki ;
  52:  UTOOL_NUM=1 ;
  53:J P[4] 100% FINE Offset,PR[4:offset cnc]    ;
  54:  CALL OTWORZCHWYTAK(1) ;
  55:L P[4] R[25:posuw L]mm/sec FINE    ;
  56:  CALL ZAMKNIJCHWYTAK(1) ;
  57:  WAIT    .20(sec) ;
  58:  CALL STANCHWYTAKA(1) ;
  59:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
  60:  DO[132:przedmuch imadel]=ON ;
  61:   ;
  62:L P[4] R[25:posuw L]mm/sec CNT10 Offset,PR[8:offset Y3]    ;
  63:L P[4] R[25:posuw L]mm/sec CNT50 Offset,PR[18:offset cnc2]    ;
  64:  CALL STANCHWYTAKA(1) ;
  65:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
  66:   ;
  67:   ;
  68:  !wstaienie do prawej szczeki ;
  69:  CALL STANCHWYTAKA(2) ;
  70:  IF R[2:stan chwytaka 2]<>1,CALL ALARM2(1,2) ;
  71:  UTOOL_NUM=2 ;
  72:J P[5] 100% FINE Offset,PR[4:offset cnc]    ;
  73:L P[5] R[25:posuw L]mm/sec FINE    ;
  74:  DO[132:przedmuch imadel]=OFF ;
  75:   ;
  76:  CALL OTWORZCHWYTAK(2) ;
  77:L P[5] R[25:posuw L]mm/sec CNT50 Offset,PR[4:offset cnc]    ;
  78:   ;
  79:  DO[131:zamk/otworz imadla]=PULSE,1.0sec ;
  80:  WAIT DI[135:imadla zamk]=ON    ;
  81:  WAIT   1.00(sec) ;
  82:   ;
  83:  !sprawzenie szczeki 1 ;
  84:  IF (DI[135:imadla zamk]=ON) THEN ;
  85:  UTOOL_NUM=2 ;
  86:J P[13] 100% CNT10 Offset,PR[23:offs Z80]    ;
  87:J P[13] 20% FINE    ;
  88:  WAIT    .10(sec) ;
  89:  IF (RI[7:czuj indukc]=ON) THEN ;
  90:  !niezamk imadla ;
  91:J P[13] 100% CNT10 Offset,PR[22:offset Z30]    ;
  92:J P[11] 100% CNT20    ;
  93:  CALL ALARM2(3) ;
  94:  JMP LBL[99] ;
  95:  ENDIF ;
  96:   ;
  97:J P[17] 20% FINE    ;
  98:  WAIT    .10(sec) ;
  99:  IF (RI[7:czuj indukc]=OFF) THEN ;
 100:  !puste imadla ;
 101:J P[17] 100% CNT10 Offset,PR[22:offset Z30]    ;
 102:  !odjazd przed CNC ;
 103:J P[11] 100% CNT20    ;
 104:  CALL ALARM2(3) ;
 105:  JMP LBL[99] ;
 106:  ENDIF ;
 107:   ;
 108:J P[13] 100% CNT10 Offset,PR[22:offset Z30]    ;
 109:  ENDIF ;
 110:   ;
 111:  !sprawdzenie szczeki 2 ;
 112:  IF (DI[135:imadla zamk]=ON) THEN ;
 113:  UTOOL_NUM=2 ;
 114:J P[14] 100% CNT100 Offset,PR[22:offset Z30]    ;
 115:J P[14] 20% FINE    ;
 116:  WAIT    .10(sec) ;
 117:  IF (RI[7:czuj indukc]=ON) THEN ;
 118:  !niezamk imadla ;
 119:J P[14] 100% CNT10 Offset,PR[22:offset Z30]    ;
 120:J P[11] 100% CNT20    ;
 121:  CALL ALARM2(3) ;
 122:  JMP LBL[99] ;
 123:  ENDIF ;
 124:   ;
 125:J P[18] 20% FINE    ;
 126:  WAIT    .10(sec) ;
 127:  IF (RI[7:czuj indukc]=OFF) THEN ;
 128:  !puste imadla ;
 129:J P[18] 100% CNT10 Offset,PR[22:offset Z30]    ;
 130:  !odjazd przed CNC ;
 131:J P[11] 100% CNT20    ;
 132:  CALL ALARM2(3) ;
 133:  JMP LBL[99] ;
 134:  ENDIF ;
 135:   ;
 136:J P[14] 100% CNT10 Offset,PR[22:offset Z30]    ;
 137:  ENDIF ;
 138:   ;
 139:  ENDIF ;
 140:   ;
 141:  IF (DI[120:belka 2]=ON) THEN ;
 142:  !pobranie z lewej szczeki ;
 143:  UTOOL_NUM=3 ;
 144:J P[6] 100% CNT50 Offset,PR[4:offset cnc]    ;
 145:  CALL OTWORZCHWYTAK(3) ;
 146:L P[6] R[25:posuw L]mm/sec FINE    ;
 147:  CALL ZAMKNIJCHWYTAK(3) ;
 148:  WAIT    .20(sec) ;
 149:  CALL STANCHWYTAKA(3) ;
 150:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
 151:  DO[132:przedmuch imadel]=ON ;
 152:   ;
 153:L P[6] 100mm/sec CNT10 Offset,PR[8:offset Y3]    ;
 154:L P[6] R[25:posuw L]mm/sec CNT50 Offset,PR[18:offset cnc2]    ;
 155:  CALL STANCHWYTAKA(3) ;
 156:  IF R[3:stan chwytaka 3]<>1,CALL ALARM2(1,3) ;
 157:   ;
 158:  !wstawienie do lewej szczeki ;
 159:  CALL STANCHWYTAKA(1) ;
 160:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
 161:  UTOOL_NUM=1 ;
 162:J P[7] 100% CNT50 Offset,PR[4:offset cnc]    ;
 163:L P[7] R[25:posuw L]mm/sec FINE    ;
 164:  DO[132:przedmuch imadel]=OFF ;
 165:  CALL OTWORZCHWYTAK(1) ;
 166:L P[7] R[25:posuw L]mm/sec CNT50 Offset,PR[4:offset cnc]    ;
 167:   ;
 168:  !pobranie z prawej szczeki ;
 169:  UTOOL_NUM=1 ;
 170:J P[8] 100% CNT50 Offset,PR[4:offset cnc]    ;
 171:  CALL OTWORZCHWYTAK(1) ;
 172:L P[8] R[25:posuw L]mm/sec FINE    ;
 173:  CALL ZAMKNIJCHWYTAK(1) ;
 174:  WAIT    .20(sec) ;
 175:  CALL STANCHWYTAKA(1) ;
 176:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
 177:  DO[132:przedmuch imadel]=ON ;
 178:L P[8] R[25:posuw L]mm/sec CNT10 Offset,PR[8:offset Y3]    ;
 179:L P[8] R[25:posuw L]mm/sec CNT50 Offset,PR[18:offset cnc2]    ;
 180:  CALL STANCHWYTAKA(1) ;
 181:  IF R[1:stan chwytaka 1]<>1,CALL ALARM2(1,1) ;
 182:   ;
 183:  !wstawienie do prawej szczeki ;
 184:  CALL STANCHWYTAKA(2) ;
 185:  IF R[2:stan chwytaka 2]<>1,CALL ALARM2(1,2) ;
 186:  UTOOL_NUM=2 ;
 187:J P[9] 100% CNT20 Offset,PR[4:offset cnc]    ;
 188:L P[9] R[25:posuw L]mm/sec FINE    ;
 189:  DO[132:przedmuch imadel]=OFF ;
 190:  CALL OTWORZCHWYTAK(2) ;
 191:L P[9] R[25:posuw L]mm/sec CNT50 Offset,PR[4:offset cnc]    ;
 192:   ;
 193:  DO[131:zamk/otworz imadla]=PULSE,1.0sec ;
 194:  WAIT DI[135:imadla zamk]=ON    ;
 195:  WAIT   1.00(sec) ;
 196:   ;
 197:  !sprawdzenie szczeki 3 ;
 198:  IF (DI[135:imadla zamk]=ON) THEN ;
 199:  UTOOL_NUM=2 ;
 200:J P[10] 100% CNT10 Offset,PR[22:offset Z30]    ;
 201:J P[10] 20% FINE    ;
 202:  WAIT    .10(sec) ;
 203:  IF (RI[7:czuj indukc]=ON) THEN ;
 204:  !niezamk imadla ;
 205:J P[10] 100% CNT10 Offset,PR[22:offset Z30]    ;
 206:  !odjazd przed CNC ;
 207:J P[11] 100% CNT20    ;
 208:  CALL ALARM2(3) ;
 209:  JMP LBL[99] ;
 210:  ENDIF ;
 211:   ;
 212:J P[15] 20% FINE    ;
 213:  WAIT    .10(sec) ;
 214:  IF (RI[7:czuj indukc]=OFF) THEN ;
 215:  !puste imadla ;
 216:J P[15] 100% CNT10 Offset,PR[22:offset Z30]    ;
 217:  !odjazd przed CNC ;
 218:J P[11] 100% CNT20    ;
 219:  CALL ALARM2(3) ;
 220:  JMP LBL[99] ;
 221:  ENDIF ;
 222:   ;
 223:J P[10] 100% CNT10 Offset,PR[22:offset Z30]    ;
 224:  ENDIF ;
 225:   ;
 226:  !sprawdzenie szczeki 4 ;
 227:  IF (DI[135:imadla zamk]=ON) THEN ;
 228:  UTOOL_NUM=2 ;
 229:J P[12] 100% CNT10 Offset,PR[22:offset Z30]    ;
 230:J P[12] 20% FINE    ;
 231:  WAIT    .10(sec) ;
 232:  IF (RI[7:czuj indukc]=ON) THEN ;
 233:  !niezamk imadla ;
 234:J P[12] 100% CNT10 Offset,PR[22:offset Z30]    ;
 235:J P[11] 100% CNT20    ;
 236:  CALL ALARM2(3) ;
 237:  JMP LBL[99] ;
 238:  ENDIF ;
 239:   ;
 240:J P[16] 20% FINE    ;
 241:  WAIT    .10(sec) ;
 242:  IF (RI[7:czuj indukc]=OFF) THEN ;
 243:  !puste imadla ;
 244:J P[16] 100% CNT10 Offset,PR[22:offset Z30]    ;
 245:J P[11] 100% CNT20    ;
 246:  CALL ALARM2(3) ;
 247:  JMP LBL[99] ;
 248:  ENDIF ;
 249:   ;
 250:J P[12] 100% CNT10 Offset,PR[23:offs Z80]    ;
 251:  ENDIF ;
 252:   ;
 253:J P[19] 100% CNT50    ;
 254:  ENDIF ;
 255:  LBL[99] ;
/POS
P[1]{
   GP1:
	UF : 6, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   120.740  mm,	Y =   -16.233  mm,	Z =   259.706  mm,
	W =      .026 deg,	P =     2.451 deg,	R =    -1.180 deg
};
P[2]{
   GP1:
	UF : 6, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -66.434  mm,	Y =   110.700  mm,	Z =   127.226  mm,
	W =      .042 deg,	P =     -.063 deg,	R =    -1.467 deg
};
P[3]{
   GP1:
	UF : 6, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -67.267  mm,	Y =   114.292  mm,	Z =   127.321  mm,
	W =     -.039 deg,	P =     -.034 deg,	R =    -1.104 deg
};
P[4]{
   GP1:
	UF : 6, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   252.852  mm,	Y =   111.200  mm,	Z =   126.541  mm,
	W =     -.033 deg,	P =     -.035 deg,	R =    -1.175 deg
};
P[5]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   253.797  mm,	Y =   114.297  mm,	Z =   127.438  mm,
	W =      .000 deg,	P =      .039 deg,	R =    -1.711 deg
};
P[6]{
   GP1:
	UF : 6, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   -66.383  mm,	Y =   110.177  mm,	Z =   126.849  mm,
	W =     -.019 deg,	P =      .061 deg,	R =    -1.202 deg
};
P[7]{
   GP1:
	UF : 6, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   -67.335  mm,	Y =   114.390  mm,	Z =   127.804  mm,
	W =     -.018 deg,	P =      .011 deg,	R =    -1.661 deg
};
P[8]{
   GP1:
	UF : 6, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   252.661  mm,	Y =   110.481  mm,	Z =   125.600  mm,
	W =     1.320 deg,	P =     1.208 deg,	R =     -.639 deg
};
P[9]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   253.896  mm,	Y =   113.400  mm,	Z =   129.233  mm,
	W =      .009 deg,	P =     -.003 deg,	R =    -1.501 deg
};
P[10]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   253.766  mm,	Y =    24.000  mm,	Z =   108.969  mm,
	W =     -.010 deg,	P =      .001 deg,	R =    -2.274 deg
};
P[11]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   179.439  mm,	Y =  -362.677  mm,	Z =   382.863  mm,
	W =      .824 deg,	P =      .642 deg,	R =      .022 deg
};
P[12]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -61.742  mm,	Y =    23.500  mm,	Z =   108.850  mm,
	W =     -.019 deg,	P =      .009 deg,	R =    -2.278 deg
};
P[13]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   244.324  mm,	Y =    24.235  mm,	Z =   108.975  mm,
	W =     -.059 deg,	P =      .639 deg,	R =      .004 deg
};
P[14]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -66.193  mm,	Y =    24.598  mm,	Z =   108.986  mm,
	W =     -.046 deg,	P =      .641 deg,	R =      .001 deg
};
P[15]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   253.764  mm,	Y =    25.300  mm,	Z =   108.981  mm,
	W =     -.006 deg,	P =      .002 deg,	R =    -2.274 deg
};
P[16]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -61.754  mm,	Y =    25.100  mm,	Z =   108.862  mm,
	W =     -.023 deg,	P =      .009 deg,	R =    -2.279 deg
};
P[17]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   244.320  mm,	Y =    25.682  mm,	Z =   108.987  mm,
	W =     -.058 deg,	P =      .638 deg,	R =      .004 deg
};
P[18]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   -66.229  mm,	Y =    25.641  mm,	Z =   108.769  mm,
	W =     -.062 deg,	P =      .637 deg,	R =     -.001 deg
};
P[19]{
   GP1:
	UF : 6, UT : 2,		CONFIG : 'N U T, 0, 0, 0',
	X =   153.570  mm,	Y =  -120.717  mm,	Z =   265.772  mm,
	W =     -.004 deg,	P =     -.004 deg,	R =    -2.271 deg
};
/END

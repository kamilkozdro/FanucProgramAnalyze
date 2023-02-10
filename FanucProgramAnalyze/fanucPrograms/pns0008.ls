/PROG  PNS0008
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "MAIN";
PROG_SIZE	= 2153;
CREATE		= DATE 17-05-29  TIME 11:22:58;
MODIFIED	= DATE 18-02-08  TIME 17:57:18;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 84;
MEMORY_SIZE	= 2657;
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
   1:  LBL[99] ;
   2:  !glowny program ;
   3:  TIMER[1]=START ;
   4:   ;
   5:  UFRAME_NUM=0 ;
   6:  UTOOL_NUM=1 ;
   7:  LBL[1] ;
   8:  !prosba o zatrzym ;
   9:  CALL POZBEZP    ;
  10:J P[1] 100% CNT100    ;
  11:  CALL PALETKI    ;
  12:  UFRAME_NUM=0 ;
  13:  UTOOL_NUM=1 ;
  14:J P[1] 100% CNT100    ;
  15:  !prosba o zatrzym ;
  16:  CALL POZBEZP    ;
  17:J P[2] 100% CNT100    ;
  18:  //CALL POZBEZP    ;
  19:  WAIT DI[100:CNC gotowe]=ON    ;
  20:  CALL OBSLUGACNC    ;
  21:  UFRAME_NUM=0 ;
  22:  UTOOL_NUM=1 ;
  23:J P[2] 100% CNT10    ;
  24:  DO[100:start cykl]=PULSE,1.0sec ;
  25:  CALL POZBEZP    ;
  26:J P[1] 100% CNT100    ;
  27:   ;
  28:   ;
  29:  !jezeli nie ma zadnego detalu ;
  30:  !przejdz do paletek ;
  31:  CALL STANCHWYTAKA(1) ;
  32:  CALL STANCHWYTAKA(3) ;
  33:  IF (R[1:stan chwytaka 1]<>1 AND R[3:stan chwytaka 3]<>1),JMP LBL[1] ;
  34:   ;
  35:  UFRAME_NUM=7 ;
  36:  UTOOL_NUM=1 ;
  37:  !manewr Iversona ;
  38:J P[3] 100% FINE    ;
  39:  CALL IVERSON    ;
  40:J P[15] 100% CNT100    ;
  41:  CALL GRATOWANIE    ;
  42:J P[6] 100% CNT20    ;
  43:J P[5] 100% CNT20    ;
  44:  CALL PRZEDMUCHANIE    ;
  45:J P[7] 100% CNT50    ;
  46:   ;
  47:  !manewr Iversona ;
  48:J P[3] 100% FINE    ;
  49:  WAIT    .50(sec) ;
  50:  CALL IVERSON    ;
  51:   ;
  52:  UFRAME_NUM=7 ;
  53:  UTOOL_NUM=1 ;
  54:J P[4] 100% CNT50    ;
  55:  //!prosba o zatrzym ;
  56:  CALL POZBEZP    ;
  57:  UFRAME_NUM=7 ;
  58:  UTOOL_NUM=1 ;
  59:J P[4] 100% CNT50    ;
  60:   ;
  61:  CALL SPRAWDZIANY    ;
  62:  //!prosba o zatrzym ;
  63:  CALL POZBEZP    ;
  64:  //    ;
  65:  UFRAME_NUM=7 ;
  66:  UTOOL_NUM=1 ;
  67:J P[13] 100% CNT40    ;
  68:   ;
  69:  IF (DI[121:pomiary]=ON) THEN ;
  70:  CALL POMIARY    ;
  71:  ENDIF ;
  72:   ;
  73:  CALL ODKLADANIE    ;
  74:  UFRAME_NUM=7 ;
  75:  UTOOL_NUM=1 ;
  76:J P[13] 100% CNT100    ;
  77:   ;
  78:  R[35:czas cyklu]=(TIMER[1]) ;
  79:  TIMER[1]=STOP ;
  80:  TIMER[1]=RESET ;
  81:   ;
  82:  CALL POZBEZP    ;
  83:   ;
  84:  JMP LBL[99] ;
/POS
P[1]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   430.291  mm,	Y =    24.486  mm,	Z =   282.316  mm,
	W =      .568 deg,	P =     1.060 deg,	R =   -90.260 deg
};
P[2]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   134.763  mm,	Y =  -279.662  mm,	Z =   299.904  mm,
	W =     1.296 deg,	P =     2.066 deg,	R =   176.289 deg
};
P[3]{
   GP1:
	UF : 7, UT : 1,	
	J1=    61.985 deg,	J2=   -35.882 deg,	J3=   -22.660 deg,
	J4=  -179.240 deg,	J5=  -112.932 deg,	J6=  -113.280 deg
};
P[4]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   316.531  mm,	Y =  -299.421  mm,	Z =   293.921  mm,
	W =    -1.857 deg,	P =    -2.991 deg,	R =   -11.091 deg
};
P[5]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   678.050  mm,	Y =   143.552  mm,	Z =   379.466  mm,
	W =   -92.559 deg,	P =   -87.420 deg,	R =  -157.003 deg
};
P[6]{
   GP1:
	UF : 7, UT : 3,		CONFIG : 'N U T, 0, 0, 0',
	X =   605.018  mm,	Y =    48.754  mm,	Z =   291.793  mm,
	W =   -90.654 deg,	P =   -60.397 deg,	R =  -141.770 deg
};
P[7]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   677.078  mm,	Y =    -9.720  mm,	Z =   374.468  mm,
	W =  -175.375 deg,	P =   -83.545 deg,	R =   -67.621 deg
};
P[13]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   385.643  mm,	Y =  -283.626  mm,	Z =   188.422  mm,
	W =      .116 deg,	P =     1.969 deg,	R =    -2.453 deg
};
P[15]{
   GP1:
	UF : 7, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   788.848  mm,	Y =   -51.404  mm,	Z =   247.902  mm,
	W =    24.235 deg,	P =    72.338 deg,	R =   -31.756 deg
};
/END

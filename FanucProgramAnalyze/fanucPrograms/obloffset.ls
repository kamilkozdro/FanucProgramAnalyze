/PROG  OBLOFFSET
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 1108;
CREATE		= DATE 17-09-25  TIME 21:38:08;
MODIFIED	= DATE 17-09-25  TIME 21:38:08;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 44;
MEMORY_SIZE	= 1432;
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
   1:  !pierwszy element = 0 ;
   2:  !wyznaczenie akt. kol i wiersza ;
   3:  R[18:kolumna]=R[15:aktualny detal] MOD R[17:max kolumn]    ;
   4:  R[19:wiersz]=R[15:aktualny detal] DIV R[17:max kolumn]    ;
   5:  PR[3:modyf offset]=LPOS-LPOS    ;
   6:   ;
   7:  IF (DI[102:paletka dolna]=ON AND DI[101:paletka gorna]=OFF) THEN ;
   8:  !offset x ;
   9:  PR[3,1:modyf offset]=(PR[2,1:offs pale doln]*R[18:kolumna]) ;
  10:  !offset y ;
  11:  PR[3,2:modyf offset]=(PR[2,2:offs pale doln]*R[19:wiersz]) ;
  12:  !offset z ;
  13:  PR[3,3:modyf offset]=PR[2,3:offs pale doln]    ;
  14:   ;
  15:  //!wyjatek ;
  16:  //IF (R[18:kolumna]>=7 AND R[19:wiersz]>=11) THEN ;
  17:  //PR[3,1:modyf offset]=(PR[3,1:modyf offset]-1.6) ;
  18:  //ENDIF ;
  19:  //!wyjatek ;
  20:  //IF (R[18:kolumna]>=3 AND R[18:kolumna]<=7) THEN ;
  21:  //PR[3,2:modyf offset]=(PR[3,2:modyf offset]+1) ;
  22:  //ENDIF ;
  23:   ;
  24:  ENDIF ;
  25:   ;
  26:  IF (DI[101:paletka gorna]=ON AND DI[102:paletka dolna]=OFF) THEN ;
  27:  !offset x ;
  28:  PR[3,1:modyf offset]=(PR[1,1:offs pale gorn]*R[18:kolumna]) ;
  29:  !offset y ;
  30:  PR[3,2:modyf offset]=(PR[1,2:offs pale gorn]*R[19:wiersz]) ;
  31:  !offset z ;
  32:  PR[3,3:modyf offset]=PR[1,3:offs pale gorn]    ;
  33:   ;
  34:  //!wyjatek dla kol >= 7 ;
  35:  //IF (R[18:kolumna]>=7) THEN ;
  36:  //PR[3,1:modyf offset]=(PR[3,1:modyf offset]-1.5) ;
  37:  //PR[3,2:modyf offset]=(PR[3,2:modyf offset]+1) ;
  38:  //ENDIF ;
  39:  //!wyjatek la wiersz>= 6 ;
  40:  //IF (R[19:wiersz]>=6) THEN ;
  41:  //PR[3,1:modyf offset]=(PR[3,1:modyf offset]-.6) ;
  42:  //PR[3,2:modyf offset]=(PR[3,2:modyf offset]+1) ;
  43:  //ENDIF ;
  44:  ENDIF ;
/POS
/END

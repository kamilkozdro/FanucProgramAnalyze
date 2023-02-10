/PROG  STANCHWYTAKA
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 606;
CREATE		= DATE 17-12-21  TIME 21:29:42;
MODIFIED	= DATE 17-12-21  TIME 21:29:42;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 23;
MEMORY_SIZE	= 894;
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
   1:  R[6:pomocniczy1]=(2*AR[1]-1) ;
   2:  R[7:pomocniczy2]=(2*AR[1]) ;
   3:  R[5:aktywny chwytak]=AR[1]    ;
   4:   ;
   5:  !detal poprawnie w uchwycie ;
   6:  IF ((RI[R[6]]=ON) AND (RI[R[7]]=ON)) THEN ;
   7:  R[R[5]]=1    ;
   8:  ENDIF ;
   9:   ;
  10:  !zamkniety/zly chwyt ;
  11:  IF ((RI[R[6]]=OFF) AND (RI[R[7]]=ON)) THEN ;
  12:  R[R[5]]=2    ;
  13:  ENDIF ;
  14:   ;
  15:  !otwarty/zly chwyt ;
  16:  IF ((RI[R[6]]=ON) AND (RI[R[7]]=OFF)) THEN ;
  17:  R[R[5]]=0    ;
  18:  ENDIF ;
  19:   ;
  20:  !blad czujnika chwytaka ;
  21:  IF ((RI[R[6]]=OFF) AND (RI[R[7]]=OFF)) THEN ;
  22:  CALL ALARM2(5) ;
  23:  ENDIF ;
/POS
/END

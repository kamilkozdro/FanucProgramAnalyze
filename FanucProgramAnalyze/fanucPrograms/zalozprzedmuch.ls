/PROG  ZALOZPRZEDMUCH
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 208;
CREATE		= DATE 17-07-06  TIME 16:01:24;
MODIFIED	= DATE 17-09-01  TIME 17:12:16;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 4;
MEMORY_SIZE	= 572;
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
   1:  DO[103:zamknij przechwyt]=ON ;
   2:  WAIT (DI[103:przechwyt otwarty]=OFF)    ;
   3:  WAIT    .20(sec) ;
   4:  CALL OTWORZCHWYTAK(AR[1]) ;
/POS
/END

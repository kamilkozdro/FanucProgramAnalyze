/PROG  TESTCHWYTAK
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 196;
CREATE		= DATE 17-02-06  TIME 10:04:12;
MODIFIED	= DATE 17-02-24  TIME 07:12:20;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 2;
MEMORY_SIZE	= 576;
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
   1:  CALL ZAMKNIJCHWYTAK(1) ;
   2:  CALL OTWORZCHWYTAK(1) ;
/POS
/END

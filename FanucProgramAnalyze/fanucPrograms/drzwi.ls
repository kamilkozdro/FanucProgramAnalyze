/PROG  DRZWI	  Macro
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 146;
CREATE		= DATE 17-12-07  TIME 21:24:24;
MODIFIED	= DATE 17-12-07  TIME 21:26:12;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 1;
MEMORY_SIZE	= 514;
PROTECT		= READ_WRITE;
TCD:  STACK_SIZE	= 0,
      TASK_PRIORITY	= 50,
      TIME_SLICE	= 0,
      BUSY_LAMP_OFF	= 0,
      ABORT_REQUEST	= 0,
      PAUSE_REQUEST	= 0;
DEFAULT_GROUP	= *,*,*,*,*;
CONTROL_CODE	= 00000000 00000000;
/APPL
/MN
   1:  DO[133:zamk/otw drzwi]=PULSE,1.0sec ;
/POS
/END
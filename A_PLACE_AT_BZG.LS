/PROG  A_PLACE_AT_BZG
/ATTR
OWNER		= MNEDITOR;
COMMENT		= "";
PROG_SIZE	= 2905;
CREATE		= DATE 25-11-18  TIME 19:42:52;
MODIFIED	= DATE 25-12-01  TIME 00:02:18;
FILE_NAME	= ;
VERSION		= 0;
LINE_COUNT	= 102;
MEMORY_SIZE	= 3385;
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
/APPL

AUTO_SINGULARITY_HEADER;
  ENABLE_SINGULARITY_AVOIDANCE   : TRUE;
  CYCLE_REFERENCE = 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0;
  CYCLE_TARGET =   0.00 ;
/MN
   1:  UFRAME_NUM=0 ;
   2:  UTOOL_NUM=1 ;
   3:   ;
   4:  R[173:offset]=0    ;
   5:  R[174:color offset]=0    ;
   6:  R[178:speed]=1250    ;
   7:   ;
   8:  !tells tower pos and hieght ;
   9:  R[172:bzg_mod1]=R[68:LOOP_COUNT] MOD 3    ;
  10:  R[171:bzg_div]=R[68:LOOP_COUNT] DIV 3    ;
  11:   ;
  12:  !detects current tower ;
  13:  SELECT R[172:bzg_mod1]=0,JMP LBL[1] ;
  14:         =1,JMP LBL[2] ;
  15:         =2,JMP LBL[3] ;
  16:   ;
  17:  !left grab ;
  18:  LBL[1] ;
  19:  PR[167:TOWER_POS]=P[1:left pre]    ;
  20:  PR[168:PLACE_POS]=P[2:left grab]    ;
  21:  JMP LBL[4] ;
  22:   ;
  23:  !center grab ;
  24:  LBL[2] ;
  25:  PR[167:TOWER_POS]=P[3:center pre]    ;
  26:  PR[168:PLACE_POS]=P[4:center grab]    ;
  27:  JMP LBL[4] ;
  28:   ;
  29:  !right grab ;
  30:  LBL[3] ;
  31:  PR[167:TOWER_POS]=P[5:right pre]    ;
  32:  PR[168:PLACE_POS]=P[6:right grab]    ;
  33:  JMP LBL[4] ;
  34:   ;
  35:  !pickup ;
  36:  LBL[4] ;
  37:  R[173:offset]=40*R[171:bzg_div]    ;
  38:  PR[168,3:PLACE_POS]=PR[168,3:PLACE_POS]-R[173:offset]    ;
  39:L PR[167:TOWER_POS] 1250mm/sec FINE    ;
  40:L PR[168:PLACE_POS] 1250mm/sec FINE    ;
  41:  RO[1:Close Gripper]=ON ;
  42:  WAIT   1.00(sec) ;
  43:L PR[167:TOWER_POS] 1250mm/sec FINE    ;
  44:   ;
  45:  !detects where to place ;
  46:  SELECT R[67:BLOCK_BZG]=1,JMP LBL[5] ;
  47:         =2,JMP LBL[6] ;
  48:         =3,JMP LBL[7] ;
  49:   ;
  50:  !yellow place ;
  51:  LBL[5] ;
  52:  PR[167:TOWER_POS]=P[7:yellow pre]    ;
  53:  PR[168:PLACE_POS]=P[8:yellow place]    ;
  54:  R[174:color offset]=R[175:yellow]    ;
  55:  R[175:yellow]=R[175:yellow]+1    ;
  56:  R[178:speed]=250    ;
  57:  JMP LBL[8] ;
  58:   ;
  59:  !red place ;
  60:  LBL[6] ;
  61:  PR[167:TOWER_POS]=P[9:red pre]    ;
  62:  PR[168:PLACE_POS]=P[14:sing temp]    ;
  63:  R[174:color offset]=R[176:red]    ;
  64:  R[176:red]=R[176:red]+1    ;
  65:  JMP LBL[8] ;
  66:   ;
  67:  !green place ;
  68:  LBL[7] ;
  69:  PR[167:TOWER_POS]=P[11:green pre]    ;
  70:  PR[168:PLACE_POS]=P[12:green place]    ;
  71:  R[174:color offset]=R[177:green]    ;
  72:  R[177:green]=R[177:green]+1    ;
  73:  JMP LBL[8] ;
  74:   ;
  75:  !placing ;
  76:  LBL[8] ;
  77:L P[13:home] 1250mm/sec CNT50    ;
  78:  R[173:offset]=42*R[174:color offset]    ;
  79:  PR[168,3:PLACE_POS]=PR[168,3:PLACE_POS]+R[173:offset]    ;
  80:L PR[167:TOWER_POS] 1250mm/sec FINE    ;
  81:L PR[168:PLACE_POS] R[178:speed]mm/sec FINE    ;
  82:  RO[1:Close Gripper]=OFF ;
  83:  WAIT   1.00(sec) ;
  84:L PR[167:TOWER_POS] R[178:speed]mm/sec FINE    ;
  85:J P[13:home] 100% FINE    ;
  86:   ;
  87:  JMP LBL[9] ;
  88:  //L P[1:left pre] 500mm/sec FINE    ;
  89:  //L P[2:left grab] 500mm/sec FINE    ;
  90:  //L P[3:center pre] 500mm/sec FINE    ;
  91:  //L P[4:center grab] 500mm/sec FINE    ;
  92:  //L P[5:right pre] 500mm/sec FINE    ;
  93:  //L P[6:right grab] 500mm/sec FINE    ;
  94:  //L P[7:yellow pre] 500mm/sec FINE    ;
  95:  //L P[8:yellow place] 500mm/sec FINE    ;
  96:  //L P[9:red pre] 500mm/sec FINE    ;
  97:  //L P[10:red place] 500mm/sec FINE    ;
  98:  //L P[11:green pre] 500mm/sec FINE    ;
  99:  //L P[12:green place] 500mm/sec FINE    ;
 100:  //L P[14:sing temp] 500mm/sec FINE    ;
 101:   ;
 102:  LBL[9] ;
/POS
P[1:"left pre"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   665.672  mm,	Y =  -162.424  mm,	Z =   -30.709  mm,
	W =  -177.506 deg,	P =   -44.984 deg,	R =    -3.215 deg
};
P[2:"left grab"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   673.275  mm,	Y =  -159.027  mm,	Z =  -151.649  mm,
	W =  -177.106 deg,	P =   -33.046 deg,	R =    -2.637 deg
};
P[3:"center pre"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   665.638  mm,	Y =    16.518  mm,	Z =   -30.787  mm,
	W =  -177.501 deg,	P =   -44.974 deg,	R =    -3.220 deg
};
P[4:"center grab"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   673.263  mm,	Y =    19.263  mm,	Z =  -151.678  mm,
	W =  -177.106 deg,	P =   -33.043 deg,	R =    -2.637 deg
};
P[5:"right pre"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   665.637  mm,	Y =   201.663  mm,	Z =   -30.800  mm,
	W =  -177.503 deg,	P =   -44.974 deg,	R =    -3.218 deg
};
P[6:"right grab"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   673.251  mm,	Y =   198.977  mm,	Z =  -151.698  mm,
	W =  -177.107 deg,	P =   -33.041 deg,	R =    -2.637 deg
};
P[7:"yellow pre"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   533.763  mm,	Y =  -168.209  mm,	Z =     7.199  mm,
	W =  -175.520 deg,	P =   -33.851 deg,	R =    -5.659 deg
};
P[8:"yellow place"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   533.750  mm,	Y =  -168.204  mm,	Z =  -186.960  mm,
	W =  -175.523 deg,	P =   -33.849 deg,	R =    -5.653 deg
};
P[9:"red pre"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   540.043  mm,	Y =    12.605  mm,	Z =   -27.202  mm,
	W =  -179.105 deg,	P =   -28.038 deg,	R =    -2.247 deg
};
P[10:"red place"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   540.046  mm,	Y =    12.627  mm,	Z =  -198.613  mm,
	W =  -178.309 deg,	P =   -27.904 deg,	R =    -2.421 deg
};
P[11:"green pre"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   541.594  mm,	Y =   202.260  mm,	Z =   -18.179  mm,
	W =   179.124 deg,	P =   -29.863 deg,	R =    -2.210 deg
};
P[12:"green place"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   541.569  mm,	Y =   193.248  mm,	Z =  -198.214  mm,
	W =   179.129 deg,	P =   -29.859 deg,	R =    -2.223 deg
};
P[13:"home"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'N U T, 0, 0, 0',
	X =   517.108  mm,	Y =    13.041  mm,	Z =   127.259  mm,
	W =  -176.588 deg,	P =   -26.388 deg,	R =    -4.625 deg
};
P[14:"sing temp"]{
   GP1:
	UF : 0, UT : 1,		CONFIG : 'F U T, 0, 0, 0',
	X =   456.103  mm,	Y =    13.059  mm,	Z =  -195.046  mm,
	W =  -178.101 deg,	P =   -29.740 deg,	R =    -2.491 deg
};
/END

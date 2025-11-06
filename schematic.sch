# File saved with Nlview 7.5.8 2022-09-21 7111 VDI=41 GEI=38 GUI=JA:10.0 threadsafe
# 
# non-default properties - (restore without -noprops)
property -colorscheme classic
property attrcolor #000000
property attrfontsize 8
property autobundle 1
property backgroundcolor #ffffff
property boxcolor0 #000000
property boxcolor1 #000000
property boxcolor2 #000000
property boxinstcolor #000000
property boxpincolor #000000
property buscolor #008000
property closeenough 5
property createnetattrdsp 2048
property decorate 1
property elidetext 40
property fillcolor1 #ffffcc
property fillcolor2 #dfebf8
property fillcolor3 #f0f0f0
property gatecellname 2
property instattrmax 30
property instdrag 15
property instorder 1
property marksize 12
property maxfontsize 12
property maxzoom 5
property netcolor #19b400
property objecthighlight0 #ff00ff
property objecthighlight1 #ffff00
property objecthighlight2 #00ff00
property objecthighlight3 #0095ff
property objecthighlight4 #8000ff
property objecthighlight5 #ffc800
property objecthighlight7 #00ffff
property objecthighlight8 #ff00ff
property objecthighlight9 #ccccff
property objecthighlight10 #0ead00
property objecthighlight11 #cefc00
property objecthighlight12 #9e2dbe
property objecthighlight13 #ba6a29
property objecthighlight14 #fc0188
property objecthighlight15 #02f990
property objecthighlight16 #f1b0fb
property objecthighlight17 #fec004
property objecthighlight18 #149bff
property objecthighlight19 #eb591b
property overlaycolor #19b400
property pbuscolor #000000
property pbusnamecolor #000000
property pinattrmax 20
property pinorder 2
property pinpermute 0
property portcolor #000000
property portnamecolor #000000
property ripindexfontsize 4
property rippercolor #000000
property rubberbandcolor #000000
property rubberbandfontsize 12
property selectattr 0
property selectionappearance 2
property selectioncolor #0000ff
property sheetheight 44
property sheetwidth 68
property showmarks 1
property shownetname 0
property showpagenumbers 1
property showripindex 1
property timelimit 1
#
module new test_env work:test_env:NOFILE -nosplit
load symbol OBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol IBUF hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol BUFG hdi_primitives BUF pin O output pin I input fillcolor 1
load symbol EX work:EX:NOFILE HIERBOX pin q_reg[6] output.right pinBus CO output.right [0:0] pinBus D input.left [18:0] pinBus DI input.left [2:0] pinBus E input.left [0:0] pinBus Q output.right [1:0] pinBus S input.left [3:0] pinBus aluRez1_reg[12]_i_1 input.left [2:0] pinBus aluRez1_reg[12]_i_1_0 input.left [3:0] pinBus aluRez1_reg[19]_i_2_0 output.right [17:0] pinBus aluRez1_reg[19]_i_2_1 input.left [1:0] pinBus aluRez1_reg[4]_i_1 input.left [1:0] pinBus aluRez1_reg[4]_i_1_0 input.left [3:0] pinBus aluRez1_reg[8]_i_1 input.left [3:0] pinBus data1 input.left [15:0] pinBus led_OBUF input.left [2:0] pinBus p_2_out output.right [17:0] pinBus q_reg[12] output.right [3:0] pinBus q_reg[16] output.right [3:0] pinBus q_reg[20] output.right [0:0] pinBus q_reg[2] output.right [2:0] pinBus q_reg[4]_i_2 input.left [4:0] pinBus q_reg[8] output.right [3:0] pinBus sw_IBUF input.left [2:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol IFetch work:IFetch:NOFILE HIERBOX pin CLK input.left pin cat_OBUF[2]_inst_i_1_0 input.left pin cat_OBUF[2]_inst_i_1_1 input.left pin cat_OBUF[2]_inst_i_1_2 input.left pin cat_OBUF[6]_inst_i_2_0 input.left pin cnt_reg[14] output.right pin cnt_reg[15] output.right pin cnt_reg[15]_0 output.right pin sw[0] output.right pin sw[1] output.right pinBus AR input.left [0:0] pinBus CO input.left [0:0] pinBus D output.right [18:0] pinBus DI output.right [2:0] pinBus E output.right [0:0] pinBus Q output.right [4:0] pinBus S output.right [3:0] pinBus aluRez1_reg[0]_i_1_0 input.left [1:0] pinBus an_OBUF input.left [6:0] pinBus cat[2] input.left [0:0] pinBus cat_OBUF output.right [6:0] pinBus cat_OBUF[6]_inst_i_22_0 input.left [15:0] pinBus led_OBUF output.right [9:0] pinBus p_2_out input.left [17:0] pinBus q_reg[12]_0 input.left [3:0] pinBus q_reg[16]_0 input.left [3:0] pinBus q_reg[20]_0 input.left [0:0] pinBus q_reg[31]_0 output.right [17:0] pinBus q_reg[31]_1 input.left [0:0] pinBus q_reg[4]_0 input.left [2:0] pinBus q_reg[5]_0 output.right [4:0] pinBus q_reg[6]_0 output.right [1:0] pinBus q_reg[6]_1 output.right [0:0] pinBus q_reg[6]_2 output.right [1:0] pinBus q_reg[6]_3 output.right [2:0] pinBus q_reg[6]_4 output.right [3:0] pinBus q_reg[6]_5 output.right [3:0] pinBus q_reg[6]_6 output.right [3:0] pinBus q_reg[8]_0 input.left [3:0] pinBus sel input.left [2:0] pinBus sw_IBUF input.left [2:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol MPG work:MPG:NOFILE HIERBOX pin CLK input.left pin bt0_IBUF input.left pinBus Q2_reg_0 output.right [0:0] boxcolor 1 fillcolor 2 minwidth 13%
load symbol SSD1 work:SSD1:NOFILE HIERBOX pin CLK input.left pin cat_OBUF[6]_inst_i_1 input.left pin cat_OBUF[6]_inst_i_1_0 input.left pin cat_OBUF[6]_inst_i_1_1 input.left pin cat_OBUF[6]_inst_i_24_1 input.left pin cat_OBUF[6]_inst_i_4_0 input.left pin cat_OBUF[6]_inst_i_5 input.left pin cnt_reg[14]_0 output.right pin cnt_reg[14]_1 output.right pin cnt_reg[16]_1 output.right pinBus an_OBUF output.right [7:0] pinBus cat_OBUF[6]_inst_i_2 input.left [4:0] pinBus cat_OBUF[6]_inst_i_24_0 input.left [0:0] pinBus cat_OBUF[6]_inst_i_4_1 input.left [1:0] pinBus cat_OBUF[6]_inst_i_5_0 input.left [2:0] pinBus cnt_reg[16]_0 output.right [0:0] pinBus sel output.right [2:0] pinBus sw_IBUF input.left [2:0] boxcolor 1 fillcolor 2 minwidth 13%
load port bt0 input -pg 1 -lvl 0 -x 0 -y 1130
load port bt1 input -pg 1 -lvl 0 -x 0 -y 110
load port clk input -pg 1 -lvl 0 -x 0 -y 1060
load portBus an output [7:0] -attr @name an[7:0] -pg 1 -lvl 7 -x 2930 -y 530
load portBus cat output [6:0] -attr @name cat[6:0] -pg 1 -lvl 7 -x 2930 -y 40
load portBus led output [10:0] -attr @name led[10:0] -pg 1 -lvl 7 -x 2930 -y 1090
load portBus sw input [2:0] -attr @name sw[2:0] -pg 1 -lvl 0 -x 0 -y 1200
load inst an_OBUF[0]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 530
load inst an_OBUF[1]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 600
load inst an_OBUF[2]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 670
load inst an_OBUF[3]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 740
load inst an_OBUF[4]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 810
load inst an_OBUF[5]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 880
load inst an_OBUF[6]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 950
load inst an_OBUF[7]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1020
load inst bt0_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 2 -x 210 -y 1130
load inst bt1_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 3 -x 790 -y 110
load inst cat_OBUF[0]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 40
load inst cat_OBUF[1]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 110
load inst cat_OBUF[2]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 180
load inst cat_OBUF[3]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 250
load inst cat_OBUF[4]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 320
load inst cat_OBUF[5]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 390
load inst cat_OBUF[6]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 460
load inst clk_IBUF_BUFG_inst BUFG hdi_primitives -attr @cell(#000000) BUFG -pg 1 -lvl 2 -x 210 -y 1060
load inst clk_IBUF_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 1 -x 40 -y 1060
load inst execution EX work:EX:NOFILE -autohide -attr @cell(#000000) EX -pinBusAttr CO @name CO -pinBusAttr D @name D[18:0] -pinBusAttr DI @name DI[2:0] -pinBusAttr E @name E -pinBusAttr Q @name Q[1:0] -pinBusAttr S @name S[3:0] -pinBusAttr aluRez1_reg[12]_i_1 @name aluRez1_reg[12]_i_1[2:0] -pinBusAttr aluRez1_reg[12]_i_1_0 @name aluRez1_reg[12]_i_1_0[3:0] -pinBusAttr aluRez1_reg[19]_i_2_0 @name aluRez1_reg[19]_i_2_0[17:0] -pinBusAttr aluRez1_reg[19]_i_2_1 @name aluRez1_reg[19]_i_2_1[1:0] -pinBusAttr aluRez1_reg[4]_i_1 @name aluRez1_reg[4]_i_1[1:0] -pinBusAttr aluRez1_reg[4]_i_1_0 @name aluRez1_reg[4]_i_1_0[3:0] -pinBusAttr aluRez1_reg[8]_i_1 @name aluRez1_reg[8]_i_1[3:0] -pinBusAttr data1 @name data1[15:0] -pinBusAttr led_OBUF @name led_OBUF[2:0] -pinBusAttr p_2_out @name p_2_out[17:0] -pinBusAttr q_reg[12] @name q_reg[12][3:0] -pinBusAttr q_reg[16] @name q_reg[16][3:0] -pinBusAttr q_reg[20] @name q_reg[20] -pinBusAttr q_reg[2] @name q_reg[2][2:0] -pinBusAttr q_reg[4]_i_2 @name q_reg[4]_i_2[4:0] -pinBusAttr q_reg[8] @name q_reg[8][3:0] -pinBusAttr sw_IBUF @name sw_IBUF[2:0] -pg 1 -lvl 3 -x 790 -y 720
load inst ife IFetch work:IFetch:NOFILE -autohide -attr @cell(#000000) IFetch -pinBusAttr AR @name AR -pinBusAttr CO @name CO -pinBusAttr D @name D[18:0] -pinBusAttr DI @name DI[2:0] -pinBusAttr E @name E -pinBusAttr Q @name Q[4:0] -pinBusAttr S @name S[3:0] -pinBusAttr aluRez1_reg[0]_i_1_0 @name aluRez1_reg[0]_i_1_0[1:0] -pinBusAttr an_OBUF @name an_OBUF[6:0] -pinBusAttr cat[2] @name cat[2] -pinBusAttr cat_OBUF @name cat_OBUF[6:0] -pinBusAttr cat_OBUF[6]_inst_i_22_0 @name cat_OBUF[6]_inst_i_22_0[15:0] -pinBusAttr led_OBUF @name led_OBUF[9:0] -pinBusAttr p_2_out @name p_2_out[17:0] -pinBusAttr q_reg[12]_0 @name q_reg[12]_0[3:0] -pinBusAttr q_reg[16]_0 @name q_reg[16]_0[3:0] -pinBusAttr q_reg[20]_0 @name q_reg[20]_0 -pinBusAttr q_reg[31]_0 @name q_reg[31]_0[17:0] -pinBusAttr q_reg[31]_1 @name q_reg[31]_1 -pinBusAttr q_reg[4]_0 @name q_reg[4]_0[2:0] -pinBusAttr q_reg[5]_0 @name q_reg[5]_0[4:0] -pinBusAttr q_reg[6]_0 @name q_reg[6]_0[1:0] -pinBusAttr q_reg[6]_1 @name q_reg[6]_1 -pinBusAttr q_reg[6]_2 @name q_reg[6]_2[1:0] -pinBusAttr q_reg[6]_3 @name q_reg[6]_3[2:0] -pinBusAttr q_reg[6]_4 @name q_reg[6]_4[3:0] -pinBusAttr q_reg[6]_5 @name q_reg[6]_5[3:0] -pinBusAttr q_reg[6]_6 @name q_reg[6]_6[3:0] -pinBusAttr q_reg[8]_0 @name q_reg[8]_0[3:0] -pinBusAttr sel @name sel[2:0] -pinBusAttr sw_IBUF @name sw_IBUF[2:0] -pg 1 -lvl 4 -x 1700 -y 100
load inst led_OBUF[0]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1090
load inst led_OBUF[10]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1810
load inst led_OBUF[1]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1160
load inst led_OBUF[2]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1230
load inst led_OBUF[3]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1320
load inst led_OBUF[4]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1390
load inst led_OBUF[5]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1460
load inst led_OBUF[6]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1530
load inst led_OBUF[7]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1600
load inst led_OBUF[8]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1670
load inst led_OBUF[9]_inst OBUF hdi_primitives -attr @cell(#000000) OBUF -pg 1 -lvl 6 -x 2750 -y 1740
load inst mpg10 MPG work:MPG:NOFILE -autohide -attr @cell(#000000) MPG -pinBusAttr Q2_reg_0 @name Q2_reg_0 -pg 1 -lvl 3 -x 790 -y 1100
load inst sevensegm SSD1 work:SSD1:NOFILE -autohide -attr @cell(#000000) SSD1 -pinBusAttr an_OBUF @name an_OBUF[7:0] -pinBusAttr cat_OBUF[6]_inst_i_2 @name cat_OBUF[6]_inst_i_2[4:0] -pinBusAttr cat_OBUF[6]_inst_i_24_0 @name cat_OBUF[6]_inst_i_24_0 -pinBusAttr cat_OBUF[6]_inst_i_4_1 @name cat_OBUF[6]_inst_i_4_1[1:0] -pinBusAttr cat_OBUF[6]_inst_i_5_0 @name cat_OBUF[6]_inst_i_5_0[2:0] -pinBusAttr cnt_reg[16]_0 @name cnt_reg[16]_0 -pinBusAttr sel @name sel[2:0] -pinBusAttr sw_IBUF @name sw_IBUF[2:0] -pg 1 -lvl 5 -x 2400 -y 380
load inst sw_IBUF[0]_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 2 -x 210 -y 1200
load inst sw_IBUF[1]_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 2 -x 210 -y 1270
load inst sw_IBUF[2]_inst IBUF hdi_primitives -attr @cell(#000000) IBUF -pg 1 -lvl 2 -x 210 -y 1340
load net <const0> -ground -pin led_OBUF[2]_inst I
load net CONV_INTEGER[0] -attr @rip(#000000) Q[0] -pin execution q_reg[4]_i_2[0] -pin ife Q[0]
load net CONV_INTEGER[1] -attr @rip(#000000) Q[1] -pin execution q_reg[4]_i_2[1] -pin ife Q[1]
load net CONV_INTEGER[2] -attr @rip(#000000) Q[2] -pin execution q_reg[4]_i_2[2] -pin ife Q[2]
load net CONV_INTEGER[3] -attr @rip(#000000) Q[3] -pin execution q_reg[4]_i_2[3] -pin ife Q[3]
load net CONV_INTEGER[4] -attr @rip(#000000) Q[4] -pin execution q_reg[4]_i_2[4] -pin ife Q[4]
load net aluCtrl[0] -attr @rip(#000000) Q[0] -pin execution Q[0] -pin ife aluRez1_reg[0]_i_1_0[0]
load net aluCtrl[1] -attr @rip(#000000) Q[1] -pin execution Q[1] -pin ife aluRez1_reg[0]_i_1_0[1]
load net aluRes[0] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[0] -pin execution aluRez1_reg[19]_i_2_0[0] -pin sevensegm cat_OBUF[6]_inst_i_4_1[0]
load net aluRes[10] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[10] -pin execution aluRez1_reg[19]_i_2_0[10] -pin ife cat_OBUF[6]_inst_i_22_0[8]
load net aluRes[11] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[11] -pin execution aluRez1_reg[19]_i_2_0[11] -pin ife cat_OBUF[6]_inst_i_22_0[9]
load net aluRes[12] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[12] -pin execution aluRez1_reg[19]_i_2_0[12] -pin ife cat_OBUF[6]_inst_i_22_0[10]
load net aluRes[13] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[13] -pin execution aluRez1_reg[19]_i_2_0[13] -pin ife cat_OBUF[6]_inst_i_22_0[11]
load net aluRes[14] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[14] -pin execution aluRez1_reg[19]_i_2_0[14] -pin ife cat_OBUF[6]_inst_i_22_0[12]
load net aluRes[15] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[15] -pin execution aluRez1_reg[19]_i_2_0[15] -pin ife cat_OBUF[6]_inst_i_22_0[13]
load net aluRes[16] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[16] -pin execution aluRez1_reg[19]_i_2_0[16] -pin ife cat_OBUF[6]_inst_i_22_0[14]
load net aluRes[17] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[17] -pin execution aluRez1_reg[19]_i_2_0[17] -pin ife cat_OBUF[6]_inst_i_22_0[15]
load net aluRes[1] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[1] -pin execution aluRez1_reg[19]_i_2_0[1] -pin ife cat_OBUF[6]_inst_i_22_0[0]
load net aluRes[2] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[2] -pin execution aluRez1_reg[19]_i_2_0[2] -pin ife cat_OBUF[6]_inst_i_22_0[1]
load net aluRes[3] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[3] -pin execution aluRez1_reg[19]_i_2_0[3] -pin ife cat_OBUF[6]_inst_i_22_0[2]
load net aluRes[4] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[4] -pin execution aluRez1_reg[19]_i_2_0[4] -pin sevensegm cat_OBUF[6]_inst_i_4_1[1]
load net aluRes[5] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[5] -pin execution aluRez1_reg[19]_i_2_0[5] -pin ife cat_OBUF[6]_inst_i_22_0[3]
load net aluRes[6] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[6] -pin execution aluRez1_reg[19]_i_2_0[6] -pin ife cat_OBUF[6]_inst_i_22_0[4]
load net aluRes[7] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[7] -pin execution aluRez1_reg[19]_i_2_0[7] -pin ife cat_OBUF[6]_inst_i_22_0[5]
load net aluRes[8] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[8] -pin execution aluRez1_reg[19]_i_2_0[8] -pin ife cat_OBUF[6]_inst_i_22_0[6]
load net aluRes[9] -attr @rip(#000000) aluRez1_reg[19]_i_2_0[9] -pin execution aluRez1_reg[19]_i_2_0[9] -pin ife cat_OBUF[6]_inst_i_22_0[7]
load net an[0] -attr @rip(#000000) 0 -port an[0] -pin an_OBUF[0]_inst O
load net an[1] -attr @rip(#000000) 1 -port an[1] -pin an_OBUF[1]_inst O
load net an[2] -attr @rip(#000000) 2 -port an[2] -pin an_OBUF[2]_inst O
load net an[3] -attr @rip(#000000) 3 -port an[3] -pin an_OBUF[3]_inst O
load net an[4] -attr @rip(#000000) 4 -port an[4] -pin an_OBUF[4]_inst O
load net an[5] -attr @rip(#000000) 5 -port an[5] -pin an_OBUF[5]_inst O
load net an[6] -attr @rip(#000000) 6 -port an[6] -pin an_OBUF[6]_inst O
load net an[7] -attr @rip(#000000) 7 -port an[7] -pin an_OBUF[7]_inst O
load net an_OBUF[0] -attr @rip(#000000) an_OBUF[0] -pin an_OBUF[0]_inst I -pin ife an_OBUF[0] -pin sevensegm an_OBUF[0]
load net an_OBUF[1] -attr @rip(#000000) an_OBUF[1] -pin an_OBUF[1]_inst I -pin ife an_OBUF[1] -pin sevensegm an_OBUF[1]
load net an_OBUF[2] -attr @rip(#000000) an_OBUF[2] -pin an_OBUF[2]_inst I -pin ife an_OBUF[2] -pin sevensegm an_OBUF[2]
load net an_OBUF[3] -attr @rip(#000000) an_OBUF[3] -pin an_OBUF[3]_inst I -pin ife an_OBUF[3] -pin sevensegm an_OBUF[3]
load net an_OBUF[4] -attr @rip(#000000) an_OBUF[4] -pin an_OBUF[4]_inst I -pin ife an_OBUF[4] -pin sevensegm an_OBUF[4]
load net an_OBUF[5] -attr @rip(#000000) an_OBUF[5] -pin an_OBUF[5]_inst I -pin ife an_OBUF[5] -pin sevensegm an_OBUF[5]
load net an_OBUF[6] -attr @rip(#000000) an_OBUF[6] -pin an_OBUF[6]_inst I -pin ife an_OBUF[6] -pin sevensegm an_OBUF[6]
load net an_OBUF[7] -attr @rip(#000000) an_OBUF[7] -pin an_OBUF[7]_inst I -pin sevensegm an_OBUF[7]
load net bt0 -port bt0 -pin bt0_IBUF_inst I
netloc bt0 1 0 2 NJ 1130 NJ
load net bt0_IBUF -pin bt0_IBUF_inst O -pin mpg10 bt0_IBUF
netloc bt0_IBUF 1 2 1 NJ 1130
load net bt1 -port bt1 -pin bt1_IBUF_inst I
netloc bt1 1 0 3 NJ 110 NJ 110 NJ
load net bt1_IBUF -attr @rip(#000000) 0 -pin bt1_IBUF_inst O -pin ife AR[0]
netloc bt1_IBUF 1 3 1 NJ 110
load net cat[0] -attr @rip(#000000) 0 -port cat[0] -pin cat_OBUF[0]_inst O
load net cat[1] -attr @rip(#000000) 1 -port cat[1] -pin cat_OBUF[1]_inst O
load net cat[2] -attr @rip(#000000) 2 -port cat[2] -pin cat_OBUF[2]_inst O
load net cat[3] -attr @rip(#000000) 3 -port cat[3] -pin cat_OBUF[3]_inst O
load net cat[4] -attr @rip(#000000) 4 -port cat[4] -pin cat_OBUF[4]_inst O
load net cat[5] -attr @rip(#000000) 5 -port cat[5] -pin cat_OBUF[5]_inst O
load net cat[6] -attr @rip(#000000) 6 -port cat[6] -pin cat_OBUF[6]_inst O
load net cat_OBUF[0] -attr @rip(#000000) cat_OBUF[0] -pin cat_OBUF[0]_inst I -pin ife cat_OBUF[0]
load net cat_OBUF[1] -attr @rip(#000000) cat_OBUF[1] -pin cat_OBUF[1]_inst I -pin ife cat_OBUF[1]
load net cat_OBUF[2] -attr @rip(#000000) cat_OBUF[2] -pin cat_OBUF[2]_inst I -pin ife cat_OBUF[2]
load net cat_OBUF[3] -attr @rip(#000000) cat_OBUF[3] -pin cat_OBUF[3]_inst I -pin ife cat_OBUF[3]
load net cat_OBUF[4] -attr @rip(#000000) cat_OBUF[4] -pin cat_OBUF[4]_inst I -pin ife cat_OBUF[4]
load net cat_OBUF[5] -attr @rip(#000000) cat_OBUF[5] -pin cat_OBUF[5]_inst I -pin ife cat_OBUF[5]
load net cat_OBUF[6] -attr @rip(#000000) cat_OBUF[6] -pin cat_OBUF[6]_inst I -pin ife cat_OBUF[6]
load net clk -port clk -pin clk_IBUF_inst I
netloc clk 1 0 1 NJ 1060
load net clk_IBUF -pin clk_IBUF_BUFG_inst I -pin clk_IBUF_inst O
netloc clk_IBUF 1 1 1 NJ 1060
load net clk_IBUF_BUFG -pin clk_IBUF_BUFG_inst O -pin ife CLK -pin mpg10 CLK -pin sevensegm CLK
netloc clk_IBUF_BUFG 1 2 3 450 1190 1200 610 2110J
load net data1[10] -attr @rip(#000000) q_reg[31]_0[8] -pin execution data1[8] -pin ife q_reg[31]_0[8]
load net data1[11] -attr @rip(#000000) q_reg[31]_0[9] -pin execution data1[9] -pin ife q_reg[31]_0[9]
load net data1[12] -attr @rip(#000000) q_reg[31]_0[10] -pin execution data1[10] -pin ife q_reg[31]_0[10]
load net data1[13] -attr @rip(#000000) q_reg[31]_0[11] -pin execution data1[11] -pin ife q_reg[31]_0[11]
load net data1[14] -attr @rip(#000000) q_reg[31]_0[12] -pin execution data1[12] -pin ife q_reg[31]_0[12]
load net data1[15] -attr @rip(#000000) q_reg[31]_0[13] -pin execution data1[13] -pin ife q_reg[31]_0[13]
load net data1[16] -attr @rip(#000000) q_reg[31]_0[14] -pin execution data1[14] -pin ife q_reg[31]_0[14]
load net data1[17] -attr @rip(#000000) q_reg[31]_0[15] -pin execution data1[15] -pin ife q_reg[31]_0[15]
load net data1[25] -attr @rip(#000000) q_reg[31]_0[16] -pin ife q_reg[31]_0[16] -pin sevensegm cat_OBUF[6]_inst_i_5_0[1]
load net data1[29] -attr @rip(#000000) q_reg[31]_0[17] -pin ife q_reg[31]_0[17] -pin sevensegm cat_OBUF[6]_inst_i_5_0[2]
load net data1[2] -attr @rip(#000000) q_reg[31]_0[0] -pin execution data1[0] -pin ife q_reg[31]_0[0]
load net data1[3] -attr @rip(#000000) q_reg[31]_0[1] -pin execution data1[1] -pin ife q_reg[31]_0[1]
load net data1[4] -attr @rip(#000000) q_reg[31]_0[2] -pin execution data1[2] -pin ife q_reg[31]_0[2] -pin sevensegm cat_OBUF[6]_inst_i_5_0[0]
load net data1[5] -attr @rip(#000000) q_reg[31]_0[3] -pin execution data1[3] -pin ife q_reg[31]_0[3]
load net data1[6] -attr @rip(#000000) q_reg[31]_0[4] -pin execution data1[4] -pin ife q_reg[31]_0[4]
load net data1[7] -attr @rip(#000000) q_reg[31]_0[5] -pin execution data1[5] -pin ife q_reg[31]_0[5]
load net data1[8] -attr @rip(#000000) q_reg[31]_0[6] -pin execution data1[6] -pin ife q_reg[31]_0[6]
load net data1[9] -attr @rip(#000000) q_reg[31]_0[7] -pin execution data1[7] -pin ife q_reg[31]_0[7]
load net digits[11] -attr @rip(#000000) q_reg[5]_0[2] -pin ife q_reg[5]_0[2] -pin sevensegm cat_OBUF[6]_inst_i_2[2]
load net digits[19] -attr @rip(#000000) q_reg[5]_0[3] -pin ife q_reg[5]_0[3] -pin sevensegm cat_OBUF[6]_inst_i_2[3]
load net digits[31] -attr @rip(#000000) q_reg[5]_0[4] -pin ife q_reg[5]_0[4] -pin sevensegm cat_OBUF[6]_inst_i_2[4]
load net digits[3] -attr @rip(#000000) q_reg[5]_0[0] -pin ife q_reg[5]_0[0] -pin sevensegm cat_OBUF[6]_inst_i_2[0]
load net digits[8] -attr @rip(#000000) q_reg[5]_0[1] -pin ife q_reg[5]_0[1] -pin sevensegm cat_OBUF[6]_inst_i_2[1]
load net en -attr @rip(#000000) Q2_reg_0[0] -pin ife q_reg[31]_1[0] -pin mpg10 Q2_reg_0[0]
netloc en 1 3 1 1340 450n
load net execution_n_20 -attr @rip(#000000) CO[0] -pin execution CO[0] -pin ife CO[0]
netloc execution_n_20 1 3 1 1040 150n
load net execution_n_21 -pin execution q_reg[6] -pin ife cat_OBUF[6]_inst_i_2_0 -pin sevensegm cat_OBUF[6]_inst_i_24_1
netloc execution_n_21 1 3 2 1120 850 2210
load net execution_n_40 -attr @rip(#000000) q_reg[2][2] -pin execution q_reg[2][2] -pin ife q_reg[4]_0[2]
load net execution_n_41 -attr @rip(#000000) q_reg[2][1] -pin execution q_reg[2][1] -pin ife q_reg[4]_0[1]
load net execution_n_42 -attr @rip(#000000) q_reg[2][0] -pin execution q_reg[2][0] -pin ife q_reg[4]_0[0]
load net execution_n_43 -attr @rip(#000000) q_reg[8][3] -pin execution q_reg[8][3] -pin ife q_reg[8]_0[3]
load net execution_n_44 -attr @rip(#000000) q_reg[8][2] -pin execution q_reg[8][2] -pin ife q_reg[8]_0[2]
load net execution_n_45 -attr @rip(#000000) q_reg[8][1] -pin execution q_reg[8][1] -pin ife q_reg[8]_0[1]
load net execution_n_46 -attr @rip(#000000) q_reg[8][0] -pin execution q_reg[8][0] -pin ife q_reg[8]_0[0]
load net execution_n_47 -attr @rip(#000000) q_reg[16][3] -pin execution q_reg[16][3] -pin ife q_reg[16]_0[3]
load net execution_n_48 -attr @rip(#000000) q_reg[16][2] -pin execution q_reg[16][2] -pin ife q_reg[16]_0[2]
load net execution_n_49 -attr @rip(#000000) q_reg[16][1] -pin execution q_reg[16][1] -pin ife q_reg[16]_0[1]
load net execution_n_50 -attr @rip(#000000) q_reg[16][0] -pin execution q_reg[16][0] -pin ife q_reg[16]_0[0]
load net execution_n_51 -attr @rip(#000000) q_reg[12][3] -pin execution q_reg[12][3] -pin ife q_reg[12]_0[3]
load net execution_n_52 -attr @rip(#000000) q_reg[12][2] -pin execution q_reg[12][2] -pin ife q_reg[12]_0[2]
load net execution_n_53 -attr @rip(#000000) q_reg[12][1] -pin execution q_reg[12][1] -pin ife q_reg[12]_0[1]
load net execution_n_54 -attr @rip(#000000) q_reg[12][0] -pin execution q_reg[12][0] -pin ife q_reg[12]_0[0]
load net execution_n_55 -attr @rip(#000000) q_reg[20][0] -pin execution q_reg[20][0] -pin ife q_reg[20]_0[0]
netloc execution_n_55 1 3 1 1320 430n
load net ife_n_30 -pin ife cnt_reg[14] -pin sevensegm cat_OBUF[6]_inst_i_1
netloc ife_n_30 1 4 1 2210 230n
load net ife_n_36 -attr @rip(#000000) E[0] -pin execution E[0] -pin ife E[0]
netloc ife_n_36 1 2 3 610 1030 NJ 1030 2010
load net ife_n_47 -attr @rip(#000000) q_reg[6]_0[1] -pin execution aluRez1_reg[19]_i_2_1[1] -pin ife q_reg[6]_0[1]
load net ife_n_48 -attr @rip(#000000) q_reg[6]_0[0] -pin execution aluRez1_reg[19]_i_2_1[0] -pin ife q_reg[6]_0[0]
load net ife_n_49 -attr @rip(#000000) D[18] -pin execution D[18] -pin ife D[18]
load net ife_n_50 -attr @rip(#000000) D[17] -pin execution D[17] -pin ife D[17]
load net ife_n_51 -attr @rip(#000000) D[16] -pin execution D[16] -pin ife D[16]
load net ife_n_52 -attr @rip(#000000) D[15] -pin execution D[15] -pin ife D[15]
load net ife_n_53 -attr @rip(#000000) D[14] -pin execution D[14] -pin ife D[14]
load net ife_n_54 -attr @rip(#000000) D[13] -pin execution D[13] -pin ife D[13]
load net ife_n_55 -attr @rip(#000000) D[12] -pin execution D[12] -pin ife D[12]
load net ife_n_56 -attr @rip(#000000) D[11] -pin execution D[11] -pin ife D[11]
load net ife_n_57 -attr @rip(#000000) D[10] -pin execution D[10] -pin ife D[10]
load net ife_n_58 -attr @rip(#000000) D[9] -pin execution D[9] -pin ife D[9]
load net ife_n_59 -attr @rip(#000000) D[8] -pin execution D[8] -pin ife D[8]
load net ife_n_60 -attr @rip(#000000) D[7] -pin execution D[7] -pin ife D[7]
load net ife_n_61 -attr @rip(#000000) D[6] -pin execution D[6] -pin ife D[6]
load net ife_n_62 -attr @rip(#000000) D[5] -pin execution D[5] -pin ife D[5]
load net ife_n_63 -attr @rip(#000000) D[4] -pin execution D[4] -pin ife D[4]
load net ife_n_64 -attr @rip(#000000) D[3] -pin execution D[3] -pin ife D[3]
load net ife_n_65 -attr @rip(#000000) D[2] -pin execution D[2] -pin ife D[2]
load net ife_n_66 -attr @rip(#000000) D[1] -pin execution D[1] -pin ife D[1]
load net ife_n_67 -attr @rip(#000000) D[0] -pin execution D[0] -pin ife D[0]
load net ife_n_68 -pin ife sw[1] -pin sevensegm cat_OBUF[6]_inst_i_5
netloc ife_n_68 1 4 1 2070 510n
load net ife_n_70 -pin ife sw[0] -pin sevensegm cat_OBUF[6]_inst_i_4_0
netloc ife_n_70 1 4 1 N 490
load net ife_n_71 -pin ife cnt_reg[15] -pin sevensegm cat_OBUF[6]_inst_i_1_1
netloc ife_n_71 1 4 1 2190 250n
load net ife_n_72 -pin ife cnt_reg[15]_0 -pin sevensegm cat_OBUF[6]_inst_i_1_0
netloc ife_n_72 1 4 1 2170 270n
load net ife_n_73 -attr @rip(#000000) DI[2] -pin execution DI[2] -pin ife DI[2]
load net ife_n_74 -attr @rip(#000000) DI[1] -pin execution DI[1] -pin ife DI[1]
load net ife_n_75 -attr @rip(#000000) DI[0] -pin execution DI[0] -pin ife DI[0]
load net ife_n_76 -attr @rip(#000000) q_reg[6]_2[1] -pin execution aluRez1_reg[4]_i_1[1] -pin ife q_reg[6]_2[1]
load net ife_n_77 -attr @rip(#000000) q_reg[6]_2[0] -pin execution aluRez1_reg[4]_i_1[0] -pin ife q_reg[6]_2[0]
load net ife_n_78 -attr @rip(#000000) q_reg[6]_3[2] -pin execution aluRez1_reg[12]_i_1[2] -pin ife q_reg[6]_3[2]
load net ife_n_79 -attr @rip(#000000) q_reg[6]_3[1] -pin execution aluRez1_reg[12]_i_1[1] -pin ife q_reg[6]_3[1]
load net ife_n_80 -attr @rip(#000000) q_reg[6]_3[0] -pin execution aluRez1_reg[12]_i_1[0] -pin ife q_reg[6]_3[0]
load net ife_n_81 -attr @rip(#000000) S[3] -pin execution S[3] -pin ife S[3]
load net ife_n_82 -attr @rip(#000000) S[2] -pin execution S[2] -pin ife S[2]
load net ife_n_83 -attr @rip(#000000) S[1] -pin execution S[1] -pin ife S[1]
load net ife_n_84 -attr @rip(#000000) S[0] -pin execution S[0] -pin ife S[0]
load net ife_n_85 -attr @rip(#000000) q_reg[6]_4[3] -pin execution aluRez1_reg[4]_i_1_0[3] -pin ife q_reg[6]_4[3]
load net ife_n_86 -attr @rip(#000000) q_reg[6]_4[2] -pin execution aluRez1_reg[4]_i_1_0[2] -pin ife q_reg[6]_4[2]
load net ife_n_87 -attr @rip(#000000) q_reg[6]_4[1] -pin execution aluRez1_reg[4]_i_1_0[1] -pin ife q_reg[6]_4[1]
load net ife_n_88 -attr @rip(#000000) q_reg[6]_4[0] -pin execution aluRez1_reg[4]_i_1_0[0] -pin ife q_reg[6]_4[0]
load net ife_n_89 -attr @rip(#000000) q_reg[6]_5[3] -pin execution aluRez1_reg[8]_i_1[3] -pin ife q_reg[6]_5[3]
load net ife_n_90 -attr @rip(#000000) q_reg[6]_5[2] -pin execution aluRez1_reg[8]_i_1[2] -pin ife q_reg[6]_5[2]
load net ife_n_91 -attr @rip(#000000) q_reg[6]_5[1] -pin execution aluRez1_reg[8]_i_1[1] -pin ife q_reg[6]_5[1]
load net ife_n_92 -attr @rip(#000000) q_reg[6]_5[0] -pin execution aluRez1_reg[8]_i_1[0] -pin ife q_reg[6]_5[0]
load net ife_n_93 -attr @rip(#000000) q_reg[6]_6[3] -pin execution aluRez1_reg[12]_i_1_0[3] -pin ife q_reg[6]_6[3]
load net ife_n_94 -attr @rip(#000000) q_reg[6]_6[2] -pin execution aluRez1_reg[12]_i_1_0[2] -pin ife q_reg[6]_6[2]
load net ife_n_95 -attr @rip(#000000) q_reg[6]_6[1] -pin execution aluRez1_reg[12]_i_1_0[1] -pin ife q_reg[6]_6[1]
load net ife_n_96 -attr @rip(#000000) q_reg[6]_6[0] -pin execution aluRez1_reg[12]_i_1_0[0] -pin ife q_reg[6]_6[0]
load net instr[29] -attr @rip(#000000) q_reg[6]_1[0] -pin ife q_reg[6]_1[0] -pin sevensegm cat_OBUF[6]_inst_i_24_0[0]
netloc instr[29] 1 4 1 2090 350n
load net led[0] -attr @rip(#000000) 0 -port led[0] -pin led_OBUF[0]_inst O
load net led[10] -attr @rip(#000000) 10 -port led[10] -pin led_OBUF[10]_inst O
load net led[1] -attr @rip(#000000) 1 -port led[1] -pin led_OBUF[1]_inst O
load net led[2] -attr @rip(#000000) 2 -port led[2] -pin led_OBUF[2]_inst O
load net led[3] -attr @rip(#000000) 3 -port led[3] -pin led_OBUF[3]_inst O
load net led[4] -attr @rip(#000000) 4 -port led[4] -pin led_OBUF[4]_inst O
load net led[5] -attr @rip(#000000) 5 -port led[5] -pin led_OBUF[5]_inst O
load net led[6] -attr @rip(#000000) 6 -port led[6] -pin led_OBUF[6]_inst O
load net led[7] -attr @rip(#000000) 7 -port led[7] -pin led_OBUF[7]_inst O
load net led[8] -attr @rip(#000000) 8 -port led[8] -pin led_OBUF[8]_inst O
load net led[9] -attr @rip(#000000) 9 -port led[9] -pin led_OBUF[9]_inst O
load net led_OBUF[0] -attr @rip(#000000) led_OBUF[0] -pin ife led_OBUF[0] -pin led_OBUF[0]_inst I
load net led_OBUF[10] -attr @rip(#000000) led_OBUF[9] -pin execution led_OBUF[2] -pin ife led_OBUF[9] -pin led_OBUF[10]_inst I
load net led_OBUF[1] -attr @rip(#000000) led_OBUF[1] -pin execution led_OBUF[0] -pin ife led_OBUF[1] -pin led_OBUF[1]_inst I
load net led_OBUF[3] -attr @rip(#000000) led_OBUF[2] -pin ife led_OBUF[2] -pin led_OBUF[3]_inst I
load net led_OBUF[4] -attr @rip(#000000) led_OBUF[3] -pin ife led_OBUF[3] -pin led_OBUF[4]_inst I
load net led_OBUF[5] -attr @rip(#000000) led_OBUF[4] -pin ife led_OBUF[4] -pin led_OBUF[5]_inst I
load net led_OBUF[6] -attr @rip(#000000) led_OBUF[5] -pin execution led_OBUF[1] -pin ife led_OBUF[5] -pin led_OBUF[6]_inst I
load net led_OBUF[7] -attr @rip(#000000) led_OBUF[6] -pin ife led_OBUF[6] -pin led_OBUF[7]_inst I
load net led_OBUF[8] -attr @rip(#000000) led_OBUF[7] -pin ife led_OBUF[7] -pin led_OBUF[8]_inst I
load net led_OBUF[9] -attr @rip(#000000) led_OBUF[8] -pin ife led_OBUF[8] -pin led_OBUF[9]_inst I
load net p_2_out[0] -attr @rip(#000000) p_2_out[0] -pin execution p_2_out[0] -pin ife p_2_out[0]
load net p_2_out[10] -attr @rip(#000000) p_2_out[10] -pin execution p_2_out[10] -pin ife p_2_out[10]
load net p_2_out[11] -attr @rip(#000000) p_2_out[11] -pin execution p_2_out[11] -pin ife p_2_out[11]
load net p_2_out[12] -attr @rip(#000000) p_2_out[12] -pin execution p_2_out[12] -pin ife p_2_out[12]
load net p_2_out[13] -attr @rip(#000000) p_2_out[13] -pin execution p_2_out[13] -pin ife p_2_out[13]
load net p_2_out[14] -attr @rip(#000000) p_2_out[14] -pin execution p_2_out[14] -pin ife p_2_out[14]
load net p_2_out[15] -attr @rip(#000000) p_2_out[15] -pin execution p_2_out[15] -pin ife p_2_out[15]
load net p_2_out[16] -attr @rip(#000000) p_2_out[16] -pin execution p_2_out[16] -pin ife p_2_out[16]
load net p_2_out[17] -attr @rip(#000000) p_2_out[17] -pin execution p_2_out[17] -pin ife p_2_out[17]
load net p_2_out[1] -attr @rip(#000000) p_2_out[1] -pin execution p_2_out[1] -pin ife p_2_out[1]
load net p_2_out[2] -attr @rip(#000000) p_2_out[2] -pin execution p_2_out[2] -pin ife p_2_out[2]
load net p_2_out[3] -attr @rip(#000000) p_2_out[3] -pin execution p_2_out[3] -pin ife p_2_out[3]
load net p_2_out[4] -attr @rip(#000000) p_2_out[4] -pin execution p_2_out[4] -pin ife p_2_out[4]
load net p_2_out[5] -attr @rip(#000000) p_2_out[5] -pin execution p_2_out[5] -pin ife p_2_out[5]
load net p_2_out[6] -attr @rip(#000000) p_2_out[6] -pin execution p_2_out[6] -pin ife p_2_out[6]
load net p_2_out[7] -attr @rip(#000000) p_2_out[7] -pin execution p_2_out[7] -pin ife p_2_out[7]
load net p_2_out[8] -attr @rip(#000000) p_2_out[8] -pin execution p_2_out[8] -pin ife p_2_out[8]
load net p_2_out[9] -attr @rip(#000000) p_2_out[9] -pin execution p_2_out[9] -pin ife p_2_out[9]
load net sel0[0] -attr @rip(#000000) cnt_reg[16]_0[0] -pin ife cat[2][0] -pin sevensegm cnt_reg[16]_0[0]
netloc sel0[0] 1 3 3 1460 690 NJ 690 2610
load net sel[0] -attr @rip(#000000) sel[0] -pin ife sel[0] -pin sevensegm sel[0]
load net sel[1] -attr @rip(#000000) sel[1] -pin ife sel[1] -pin sevensegm sel[1]
load net sel[2] -attr @rip(#000000) sel[2] -pin ife sel[2] -pin sevensegm sel[2]
load net sevensegm_n_12 -pin ife cat_OBUF[2]_inst_i_1_1 -pin sevensegm cnt_reg[14]_0
netloc sevensegm_n_12 1 3 3 1500 650 NJ 650 2650
load net sevensegm_n_13 -pin ife cat_OBUF[2]_inst_i_1_2 -pin sevensegm cnt_reg[16]_1
netloc sevensegm_n_13 1 3 3 1440 710 NJ 710 2590
load net sevensegm_n_14 -pin ife cat_OBUF[2]_inst_i_1_0 -pin sevensegm cnt_reg[14]_1
netloc sevensegm_n_14 1 3 3 1480 670 NJ 670 2630
load net sw[0] -attr @rip(#000000) sw[0] -port sw[0] -pin sw_IBUF[0]_inst I
load net sw[1] -attr @rip(#000000) sw[1] -port sw[1] -pin sw_IBUF[1]_inst I
load net sw[2] -attr @rip(#000000) sw[2] -port sw[2] -pin sw_IBUF[2]_inst I
load net sw_IBUF[0] -attr @rip(#000000) 0 -pin execution sw_IBUF[0] -pin ife sw_IBUF[0] -pin sevensegm sw_IBUF[0] -pin sw_IBUF[0]_inst O
load net sw_IBUF[1] -attr @rip(#000000) 1 -pin execution sw_IBUF[1] -pin ife sw_IBUF[1] -pin sevensegm sw_IBUF[1] -pin sw_IBUF[1]_inst O
load net sw_IBUF[2] -attr @rip(#000000) 2 -pin execution sw_IBUF[2] -pin ife sw_IBUF[2] -pin sevensegm sw_IBUF[2] -pin sw_IBUF[2]_inst O
load netBundle @sw 3 sw[2] sw[1] sw[0] -autobundled
netbloc @sw 1 0 2 NJ 1200 170
load netBundle @an 8 an[7] an[6] an[5] an[4] an[3] an[2] an[1] an[0] -autobundled
netbloc @an 1 6 1 2910 530n
load netBundle @cat 7 cat[6] cat[5] cat[4] cat[3] cat[2] cat[1] cat[0] -autobundled
netbloc @cat 1 6 1 2910 40n
load netBundle @led 11 led[10] led[9] led[8] led[7] led[6] led[5] led[4] led[3] led[2] led[1] led[0] -autobundled
netbloc @led 1 6 1 2910 1090n
load netBundle @aluCtrl 2 aluCtrl[1] aluCtrl[0] -autobundled
netbloc @aluCtrl 1 3 1 1100 170n
load netBundle @aluRes 18 aluRes[17] aluRes[16] aluRes[15] aluRes[14] aluRes[13] aluRes[12] aluRes[11] aluRes[10] aluRes[9] aluRes[8] aluRes[7] aluRes[6] aluRes[5] aluRes[4] aluRes[3] aluRes[2] aluRes[1] aluRes[0] -autobundled
netbloc @aluRes 1 3 2 1160 830 2150
load netBundle @p_2_out 18 p_2_out[17] p_2_out[16] p_2_out[15] p_2_out[14] p_2_out[13] p_2_out[12] p_2_out[11] p_2_out[10] p_2_out[9] p_2_out[8] p_2_out[7] p_2_out[6] p_2_out[5] p_2_out[4] p_2_out[3] p_2_out[2] p_2_out[1] p_2_out[0] -autobundled
netbloc @p_2_out 1 3 1 1140 330n
load netBundle @execution_n_ 4 execution_n_51 execution_n_52 execution_n_53 execution_n_54 -autobundled
netbloc @execution_n_ 1 3 1 1280 390n
load netBundle @execution_n__1 4 execution_n_47 execution_n_48 execution_n_49 execution_n_50 -autobundled
netbloc @execution_n__1 1 3 1 1300 410n
load netBundle @execution_n__2 3 execution_n_40 execution_n_41 execution_n_42 -autobundled
netbloc @execution_n__2 1 3 1 1060 350n
load netBundle @execution_n__3 4 execution_n_43 execution_n_44 execution_n_45 execution_n_46 -autobundled
netbloc @execution_n__3 1 3 1 1240 370n
load netBundle @ife_n_ 19 ife_n_49 ife_n_50 ife_n_51 ife_n_52 ife_n_53 ife_n_54 ife_n_55 ife_n_56 ife_n_57 ife_n_58 ife_n_59 ife_n_60 ife_n_61 ife_n_62 ife_n_63 ife_n_64 ife_n_65 ife_n_66 ife_n_67 -autobundled
netbloc @ife_n_ 1 2 3 510 1170 1360J 1070 2030
load netBundle @ife_n__1 3 ife_n_73 ife_n_74 ife_n_75 -autobundled
netbloc @ife_n__1 1 2 3 390 10 NJ 10 1910
load netBundle @CONV_INTEGER 5 CONV_INTEGER[4] CONV_INTEGER[3] CONV_INTEGER[2] CONV_INTEGER[1] CONV_INTEGER[0] -autobundled
netbloc @CONV_INTEGER 1 2 3 410 30 NJ 30 2210
load netBundle @ife_n__2 4 ife_n_81 ife_n_82 ife_n_83 ife_n_84 -autobundled
netbloc @ife_n__2 1 2 3 530 50 NJ 50 1890
load netBundle @cat_OBUF 7 cat_OBUF[6] cat_OBUF[5] cat_OBUF[4] cat_OBUF[3] cat_OBUF[2] cat_OBUF[1] cat_OBUF[0] -autobundled
netbloc @cat_OBUF 1 4 2 N 210 2690
load netBundle @led_OBUF 10 led_OBUF[10] led_OBUF[9] led_OBUF[8] led_OBUF[7] led_OBUF[6] led_OBUF[5] led_OBUF[4] led_OBUF[3] led_OBUF[1] led_OBUF[0] -autobundled
netbloc @led_OBUF 1 2 4 570 1050 NJ 1050 2130 1110 2690
load netBundle @data1 18 data1[29] data1[25] data1[17] data1[16] data1[15] data1[14] data1[13] data1[12] data1[11] data1[10] data1[9] data1[8] data1[7] data1[6] data1[5] data1[4] data1[3] data1[2] -autobundled
netbloc @data1 1 2 3 430 630 1260J 770 2050
load netBundle @digits 5 digits[31] digits[19] digits[11] digits[8] digits[3] -autobundled
netbloc @digits 1 4 1 2150 310n
load netBundle @ife_n__3 2 ife_n_47 ife_n_48 -autobundled
netbloc @ife_n__3 1 2 3 450 550 NJ 550 1970
load netBundle @ife_n__4 2 ife_n_76 ife_n_77 -autobundled
netbloc @ife_n__4 1 2 3 490 570 NJ 570 1930
load netBundle @ife_n__5 3 ife_n_78 ife_n_79 ife_n_80 -autobundled
netbloc @ife_n__5 1 2 3 550 590 NJ 590 1910
load netBundle @ife_n__6 4 ife_n_85 ife_n_86 ife_n_87 ife_n_88 -autobundled
netbloc @ife_n__6 1 2 3 590 610 1080J 750 1950
load netBundle @ife_n__7 4 ife_n_89 ife_n_90 ife_n_91 ife_n_92 -autobundled
netbloc @ife_n__7 1 2 3 570 650 1220J 790 1990
load netBundle @ife_n__8 4 ife_n_93 ife_n_94 ife_n_95 ife_n_96 -autobundled
netbloc @ife_n__8 1 2 3 470 670 1180J 810 1890
load netBundle @an_OBUF 8 an_OBUF[7] an_OBUF[6] an_OBUF[5] an_OBUF[4] an_OBUF[3] an_OBUF[2] an_OBUF[1] an_OBUF[0] -autobundled
netbloc @an_OBUF 1 3 3 1400 1090 NJ 1090 2670
load netBundle @sel 3 sel[2] sel[1] sel[0] -autobundled
netbloc @sel 1 3 3 1420 730 NJ 730 2570
load netBundle @sw_IBUF 3 sw_IBUF[2] sw_IBUF[1] sw_IBUF[0] -autobundled
netbloc @sw_IBUF 1 2 3 410 1210 1380 630 2190J
levelinfo -pg 1 0 40 210 790 1700 2400 2750 2930
pagesize -pg 1 -db -bbox -sgen -100 0 3040 1850
show
zoom 0.281317
scrollpos -197 -115
#
# initialize ictrl to current module test_env work:test_env:NOFILE
ictrl init topinfo |

# Test program

10 P%=&900
20[OPT 0
30 .sei SEI:RTS
40 .cli CL:RTS
50]
60 CALL sei
70 PRINT SQR2
80 CALL cli

# Basic 4

fx2pipe -a > trace.bin

decode6502 --machine=master --phi2= --sync= --mem=fff -ahiys --trigger=a7b5,a015 trace.bin > trace-6502decoder-sqr2.txt

decode6502 --machine=master --phi2= --sync= --mem=00f -q --profile=instr --trigger=a7b5,a015 trace.bin > profile-6502decoder-sqr2.txt

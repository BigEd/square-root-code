Here's the floating point square root routine from the Basic V sources [here](https://gtoal.com/acorn/arm/Basic/).

The version we have the sources for will report itself like this:
```
BBC Basic V version 1.00 (C) Acorn 1987
```
although the nearby binary AB.bin (45328 bytes) contains
```
ARM2 BBC Basic V version 1.00 (C) Acorn 1987
```

The version I can run in B-em on an ARM copro (39864 bytes) reports itself like this:
```
ARM BBC Basic V version 1.00 for ARM Second Processor (C) Acorn 1986
```
A trace from that version is in this directory

Comments are original.

```
;square root of FACC
FSQRT ROUT
 TEQ FACC,#0
 MOVEQ PC,R14 ;square root of zero easy
 TEQ FSIGN,#0
 BMI FSQRTN
 MOV FWACC,#&40000000
 MOVS FACCX,FACCX,LSR #1
 ADC FACCX,FACCX,#&40
 SUBCC FACC,FACC,#&40000000
 SUBCS FACC,FACC,#&80000000 ;adjust for odd exponent
 MOVCC FWSIGN,#&10000000 ;rotating bit
 MOVCS FWSIGN,#&08000000
;for first word's worth of work KNOW only top 32 bits used
05 EOR FWACC,FWACC,FWSIGN ;set bit
 CMP FACC,FWACC ;check if can subtract
 SUBCS FACC,FACC,FWACC ;can subtract
 EORCS FWACC,FWACC,FWSIGN,ASL #1 ;subtracted, so set higher bit
 EOR FWACC,FWACC,FWSIGN ;clear bit
 ADD FACC,FACC,FACC ;double facc
 MOVS FWSIGN,FWSIGN,ROR #1 ;rotate bit
 BPL %05
 MOV FGRD,#0
;repeat above for extra 3 bits worth on double precision
 CMP FACC,FWACC
 CMPEQS FGRD,#&80000000
 BCC %10
 SUBS FGRD,FGRD,#&80000000
 SBC FACC,FACC,FWACC
 EOR FWACC,FWACC,#1
10 ADDS FGRD,FGRD,FGRD
 ADC FACC,FACC,FACC
 MOV FWGRD,#0
 CMP FACC,FWACC
 CMPEQS FGRD,#&40000000
 BCC %20
 SUBS FGRD,FGRD,#&40000000
 SBC FACC,FACC,FWACC
 EOR FWGRD,FWGRD,#&80000000
20 ADDS FGRD,FGRD,FGRD
 ADC FACC,FACC,FACC
 EOR FWGRD,FWGRD,#&20000000
 CMP FACC,FWACC
 CMPEQS FGRD,FWGRD
 BCC %30
 SUBS FGRD,FGRD,FWGRD
 SBC FACC,FACC,FWACC
 EOR FWGRD,FWGRD,#&40000000
30 EOR FWGRD,FWGRD,#&20000000
 ORR FWSIGN,FGRD,FACC,LSL #1 ;zero remainder produced?
 MOVS FGRD,FWGRD,ASL #1
 ADC FACC,FWACC,FWACC
 MOVPL PC,R14
 TEQ FWSIGN,#0
 BICEQ FACC,FACC,#1
 ADDS FACC,FACC,#1
 MOVCS FACC,FACC,RRX
 ADDCS FACCX,FACCX,#1
 MOV PC,R14
```

We now have a trace from B-em, with a Sprow ARM as a co-processor, running AB. It's slightly different code.

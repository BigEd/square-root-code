We are trying two ways to trace and profile code.

With the b2 emulator, the debug build, we can type in X=SQR2, then in
the debug menu select start tracing on RETURN and stop tracing on
OSWORD.  We hit RETURN in the emulator, and then save the debug trace
to file. We can then manually cut down the trace using the start and
end addresses from the disassembly we have so it covers only the
square root routine.

We can process the trace into a profile using a command pipeline like
```
awk '{if($6~/m.$/){$6="               "}print substr($0,0,36)}'|sort|uniq -c |sort -k 3
```

With the 6502Decoder, we hook up our adapter board to a suitable
connector on a BBC Micro or Master, and capture instruction traces by
USB. We then decode the binary trace using 6502Decoder, specifying the
start and end execution addresses as seen in the disassembly.

# Test program for 6502Decoder method

```
10 P%=&900
20[OPT 0
30 .sei SEI:RTS
40 .cli CLI:RTS
50]
60 CALL sei
70 PRINT SQR2
80 CALL cli
```

# Basic 4

```
fx2pipe -a > trace.bin

decode6502 --machine=master --phi2= --sync= --mem=00f -ahiysf --trigger=a7b5,a015 trace.bin > trace-6502decoder-sqr2.txt

decode6502 --machine=master --phi2= --sync= --mem=00f -q --profile=instr --trigger=a7b5,a015 trace.bin > profile-6502decoder-sqr2.txt
```

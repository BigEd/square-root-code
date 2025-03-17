# square-root-code
investigate square root code from Acorn's Basics

In particular, 6502 code found in Basic versions 2, 4 and 4r32, and ARM code found in Basic V, 1987.

This repo is a companion to the stardot thread [Basic's square root algorithm](https://stardot.org.uk/forums/viewtopic.php?t=30662)

Resources:
- b2 emulator in [debug mode](https://github.com/tom-seddon/b2/blob/master/doc/Debug-version.md)
- [basic 2 disassembly](https://archive.org/details/BBCMicroCompendium/page/419/mode/1up) by Jeremy Ruston
- [basic 4 disassembly](https://8bs.com/basic/basic4-a7b5.htm#A7B5) at 8bs
- [basic 4r32 dissassembly](https://github.com/hoglet67/BBCBasic4r32/blob/master/disassembly/Basic432.asm#L7737) by hoglet
- basic V arm code [at gtoal's site](https://gtoal.com/acorn/arm/Basic/)

Preliminary findings:
By timing Basic code we can profile the square root function in three versions of 6502 Basic. Code suggested by Dominic Beesley - subtract the cost of a loop which only assigns from the cost of a loop which does a square root.

```
100 p=PI:e=EXP1:r=p/e:T=TIME
110 FORi=0TO999:x=x:NEXT
120 E=TIME-T
160 T=TIME
170 FORi=0TO999:x=SQRr:NEXT
180 PRINT TIME-T-E
```

9.20s on beeb, basic 2, copyright 1982
2.02s on master 128, os 3.20, basic 4, copyright 1984
1.19s on master 128, os 3.50, basic 4.32, copyright 1988



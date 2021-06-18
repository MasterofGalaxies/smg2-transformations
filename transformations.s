.set false,0
.set true,-1

.set enableIceMario,false

/* ASM insert for creating cloud flower & rock mushroom objects */

.set length,end1-start1
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set playableAreaOffset,playableArea-offset1
.set positiondataOffset,positiondata-offset1
.set cloudpointerOffset,cloudpointer-offset1
.set rockpointerOffset,rockpointer-offset1
.set clouddataOffset,clouddata-offset1
.set rockdataOffset,rockdata-offset1
.set shouldloadformOffset,shouldloadform-offset1
.set formloadlistOffset,formloadlist-offset1
.set loadedformsOffset,loadedforms-offset1

.set loadedformsOffset2,loadedforms-offset10

.int 0xC245C358
.int numlines
start1:
bl 0x04
offset1:
mflr r29
li r5,0
lwz r6,shouldloadformOffset(r29)
loadcheckloop:
addi r5,r5,1
lwz r3,-25980(r13)
lwz r3,36(r3)
lwz r3,300(r3)
lwz r3,16(r3)
li r4,21
rlwinm r4,r4,2,0,29
lwzx r3,r3,r4
addi r4,r5,formloadlistOffset
lbzx r4,r4,r29
cmpwi r4,0
beq- noformoffset
lbzx r3,r3,r4
neg r3,r3
mr r7,r5
bl makemask
and r3,r8,r3
or r6,r3,r6
noformoffset:
cmpwi r5,0xD
blt+ loadcheckloop
lbz r7,playableAreaOffset(r29)
cmpwi r7,3
bne- dontenableall
li r6,-1
dontenableall:
stw r6,loadedformsOffset(r29)
li r3,0
stw r3,cloudpointerOffset(r29)
stw r3,rockpointerOffset(r29)
cmpwi r7,0
beq- gotoend1
li r7,0xC
bl makemask
and. r6,r8,r6
beq- dontcreatecloud
addi r4,r29,positiondataOffset
li r3,1
lis r12,0x8005
ori r12,r12,0x8310
mtctr r12
bctrl
addi r3,r29,clouddataOffset
lis r12,0x8033
ori r12,r12,0xFF30
mtctr r12
bctrl
stw r3,cloudpointerOffset(r29)
addi r4,r1,24
lis r12,0x8004
ori r12,r12,0xAB70
mtctr r12
bctrl
lis r12,0x8005
ori r12,r12,0x8350
mtctr r12
bctrl
dontcreatecloud:
lwz r3,loadedformsOffset(r29)
li r7,0xD
bl makemask
and. r3,r8,r3
beq- gotoend1
addi r4,r29,positiondataOffset
li r3,1
lis r12,0x8005
ori r12,r12,0x8310
mtctr r12
bctrl
addi r3,r29,rockdataOffset
lis r12,0x8033
ori r12,r12,0xF970
mtctr r12
bctrl
stw r3,rockpointerOffset(r29)
addi r4,r1,24
lis r12,0x8004
ori r12,r12,0xAB70
mtctr r12
bctrl
lis r12,0x8005
ori r12,r12,0x8350
mtctr r12
bctrl
gotoend1:
lwz r0,36(r1)
b end1
playableArea:
.byte 0
applyModifiers:
.byte 1
currForm:
.byte 7
applyReset:
.byte 7
shouldloadform:
.int 0x0
loadedforms:
.int 0x0
applylist:
lwz r7,0(r4)
listloop1:
rlwinm. r8,r6,0,31,31
rlwinm r6,r6,31,0,31
beq- skipaddr
lwzx r8,r4,r5
stw r8,0(r7)
dcbst 0,r7
sync
icbi 0,r7
isync
skipaddr:
lwzu r7,0xC(r4)
cmplwi r7,0
bne+ listloop1
blr
makemask:
lis r8,0x8000
cmpwi r7,1
blt- makezero
rlwnm r8,r8,r7,0,31
.if ~enableIceMario
cmpwi r7,3
beq- makezero
blt- no3rotate
rlwinm r8,r8,31,0,31
no3rotate:
.endif
cmpwi r7,0xD
bgt- makezero
cmpwi r7,0xC
blt- noCrotate
rlwinm r8,r8,27,0,31
blr
noCrotate:
cmpwi r7,7
bltlr+
makezero:
li r8,0
blr
advanceformone:
addi r3,r3,1
nextvalidform:
lwz r4,loadedformsOffset2(r30)
cmpwi r3,0xD
ble- dontreset
li r3,1
dontreset:
cmpwi r3,7
beq- skipcheck
mr r7,r3
mflr r9
bl makemask
mtlr r9
and. r8,r8,r4
beq- advanceformone
skipcheck:
blr
have3clouds:
lis r11,0x8030
ori r11,r11,0xAFB0
mtctr r11
bctrl
lis r11,0x8030
ori r11,r11,0xB200
mtctr r11
bctrl
lis r11,0x8030
ori r11,r11,0xAF80
mtctr r11
bctr
positiondata:
.int 0
.int 0
.int 0
.byte 0
clouddata:
.byte 0x83,0x58,0x83
.int 0x73839389
.int 0x5F834183
.int 0x43836583
.int 0x80000000
formloadlist:
.byte 0
.byte 0x1C
.byte 0x1A
.byte 0x1B
.byte 0x18
.byte 0x19
.byte 0x1D
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0
.byte 0x22
.byte 0x23
.byte 0
rockdata:
.byte 0x95
.int 0xCF906783
.int 0x49837583
.int 0x5783465B
.int 0x8AE25D00
cloudpointer:
.int 0
rockpointer:
.int 0

enablerslist:

# rainbow mario enabler
.int 0x803C8644
.int 0x4182007C
.int 0x60000000

# fire mario enabler
.int 0x803C821C
.int 0x41820018
.int 0x60000000

.if enableIceMario
# ice mario enabler
.int 0x803C84F8
.int 0x418200E0
.int 0x60000000
.endif

# bee mario enabler
.int 0x803C8298
.int 0x41820118
.int 0x60000000

# spring mario enabler
.int 0x803C83F8
.int 0x41820098
.int 0x60000000

# boo mario enabler
.int 0x80405BF8
.int 0x4082000C
.int 0x4800000C

# cloud mario enabler
.int 0x803C88F8
.int 0x418200B4
.int 0x60000000

# rock mario enabler
.int 0x803C89F8
.int 0x41820088
.int 0x60000000

.int 0

modifierslist:

# water does not revert transformation
.int 0x80387D70
.int 0xA0830412
.int 0x38800000

.int 0x80387D74
.int 0x2C040000
.int 0xB0830412

.int 0x80387D78
.int 0x4D820020
.int 0x4E800020

# damage does not revert transformation
.int 0x803B952C
.int 0x41820018
.int 0x48000018

# launch star does not revert transformation
.int 0x803CB150
.int 0x40820014
.int 0x48000014

# transformation timer is disabled
.int 0x803CBC9C
.int 0xB01F0700
.int 0x60000000

# no transformation music (rainbow mario)
.int 0x803CB620
.int 0x4BC4FFD1
.int 0x60000000

.int 0x803CB1F0
.int 0x4BC50401
.int 0x60000000

# no transformation music (flying mario)
.int 0x803CB938
.int 0x4BC4F339
.int 0x60000000

# no transformation music (fire mario)
.int 0x803CB838
.int 0x4BC509D9
.int 0x60000000

.int 0x803CB288
.int 0x4BC50F89
.int 0x60000000

.if enableIceMario
# no transformation music (ice mario)
.int 0x803CB86C
.int 0x4BC4FD85
.int 0x60000000
.endif

# infinite bee flight
.int 0x8038D6E0
.int 0xB01D0402
.int 0x60000000

# infinite rock roll
.int 0x8043F020
.int 0x901F0024
.int 0x60000000

# obstacles don't stop rock roll
.int 0x8043EC50
.int 0x4082000C
.int 0x60000000

# always have 3 clouds
have3cloudsaddr:
.int 0x8030AF7C
.int 0x48000035
have3cloudsbranch:
.int 0

.int 0

worldmap1:
.ascii "Worl"
worldmap2:
.ascii "dMap"
fileselect1:
.ascii "File"
fileselect2:
.ascii "Sele"
mariofaceship1:
.ascii "Mari"
mariofaceship2:
.ascii "oFac"
end1:
.int align
.balignl 8,0

/* ASM insert for preventing interaction with created rock mushroom */

.set length,end2-start2
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set rockpointerOffset,rockpointer-offset2

.int 0xC22D2FA8
.int numlines

start2:
bl 0x04
offset2:
mflr r11
lwz r11,rockpointerOffset(r11)
cmplw r3,r11
beq- isrockpointer1
lbz r3,116(r3)
b end2
isrockpointer1:
li r3,1
end2:
.int align
.balignl 8,0

/* ASM insert for preventing interaction with created cloud flower */

.set length,end3-start3
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set cloudpointerOffset,cloudpointer-offset3

.int 0xC230B4C8
.int numlines

start3:
bl 0x04
offset3:
mflr r3
lwz r3,cloudpointerOffset(r3)
cmplw r3,r31
beq- iscloudpointer1
mr r3,r4
subi r0,r3,131
cntlzw r0,r0
rlwinm r3,r0,27,5,31
b end3
iscloudpointer1:
li r3,0
end3:
.int align
.balignl 8,0

/* ASM insert for making created rock mushroom & cloud flower invisible */

.set length,end4-start4
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set cloudpointerOffset,cloudpointer-offset4
.set rockpointerOffset,rockpointer-offset4

.int 0xC2237800
.int numlines

start4:
mflr r4
bl 0x04
offset4:
mflr r12
lwz r0,cloudpointerOffset(r12)
cmplw r0,r3
beq- ispointer1
lwz r0,rockpointerOffset(r12)
cmplw r0,r3
beq- ispointer1
lbz r0,115(r3)
b notpointer1
ispointer1:
li r0,1
notpointer1:
mtlr r4
end4:
.int align
.balignl 8,0

/* ASM insert for making created rock mushroom glow invisible */

.set length,end5-start5
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set rockpointerOffset,rockpointer-offset5

.int 0xC22D4314
.int numlines

start5:
bl 0x04
offset5:
mflr r11
lwz r5,rockpointerOffset(r11)
cmplw r3,r5
beq- end5
lis r11,0x8002
ori r11,r11,0x2BC0
mtctr r11
bctrl
end5:
.int align
.balignl 8,0

/* ASM insert for making created cloud flower glow invisible */

.set length,end6-start6
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set cloudpointerOffset,cloudpointer-offset6

.int 0xC22302DC
.int numlines

start6:
bl 0x04
offset6:
mflr r11
lwz r11,cloudpointerOffset(r11)
addi r11,r11,144
cmplw r11,r30
beq- end6
lis r11,0x8023
ori r11,r11,0x11C0
mtctr r11
bctrl
end6:
.int align
.balignl 8,0

/* ASM insert for making created rock mushroom & cloud flower shadows invisible */

.set length,end7-start7
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set cloudpointerOffset,cloudpointer-offset7
.set rockpointerOffset,rockpointer-offset7

.int 0xC2031538
.int numlines

start7:
stwu r1,-128(r1)
stmw r3,8(r1)
mflr r6
stw r6,132(r1)
bl 0x04
offset7:
mflr r5
lwz r4,cloudpointerOffset(r5)
cmplw r3,r4
beq- ispointer2
lwz r4,rockpointerOffset(r5)
cmplw r3,r4
beq- ispointer2
lbz r0,116(r3)
b notpointer2
ispointer2:
li r0,1
notpointer2:
lwz r6,132(r1)
mtlr r6
lmw r3,8(r1)
addi r1,r1,128
end7:
.int align
.balignl 8,0

/* ASM insert for Rock Mario enabler */

.set length,end8-start8
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set rockpointerOffset,rockpointer-offset8

.int 0xC233A334
.int numlines

start8:
bl 0x4
offset8:
mflr r11
lwz r5,0(r3)
lwz r11,rockpointerOffset(r11)
addi r11,r11,0x100
cmplw r5,r11
bne- gotoend2
lbz r5,0x70(r11)
cmpwi r5,0
beq- gotoend2
li r0,4
li r5,0
stb r5,0x70(r11)
gotoend2:
stb r0,4(r3)
end8:
.int align
.balignl 8,0

/* ASM insert for applying transformation enablers */

.set length,end9-start9
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set playableAreaOffset,playableArea-offset9
.set modifierslistOffset,modifierslist-offset9
.set enablerslistOffset,enablerslist-offset9
.set shouldloadformOffset,shouldloadform-offset9
.set worldmap1Offset,worldmap1-offset9
.set worldmap2Offset,worldmap2-offset9
.set fileselect1Offset,fileselect1-offset9
.set fileselect2Offset,fileselect2-offset9
.set mariofaceship1Offset,mariofaceship1-offset9
.set mariofaceship2Offset,mariofaceship2-offset9

.int 0xC23BFED4
.int numlines

start9:
bl 0x04
offset9:
mflr r31
addi r4,r31,modifierslistOffset
li r5,4
li r6,-1
bl applylist
lwz r4,worldmap1Offset(r31)
lis r30,0x80B0
lwzu r5,0x117C(r30)
cmpw r4,r5
bne- notworldmap1
lwz r4,worldmap2Offset(r31)
lwz r5,4(r30)
cmpw r4,r5
beq- notPlayableArea1
notworldmap1:
lwz r4,fileselect1Offset(r31)
lwz r5,0(r30)
cmpw r4,r5
bne- notfileselect
lwz r4,fileselect2Offset(r31)
lwz r5,4(r30)
cmpw r4,r5
beq- notPlayableArea1
notfileselect:
lwz r4, mariofaceship1Offset(r31)
lwz r5,0(r30)
cmpw r4,r5
bne- notmariofaceship
lwz r4, mariofaceship2Offset(r31)
lwz r5,4(r30)
cmpw r4,r5
beq- ismariofaceship
notmariofaceship:
li r5,1
stb r5,playableAreaOffset(r31)
addi r4,r31,enablerslistOffset
li r5,8
lwz r6,shouldloadformOffset(r31)
bl applylist
b gotoend3
ismariofaceship:
li r5,3
stb r5,playableAreaOffset(r31)
addi r4,r31,enablerslistOffset
li r5,8
li r6,-1
bl applylist
b gotoend3
notPlayableArea1:
li r5,0
stb r5,playableAreaOffset(r31)
addi r4,r31, enablerslistOffset
li r5,4
li r6,-1
bl applylist
gotoend3:
lis r31,0x806C
end9:
.int align
.balignl 8,0

/* ASM insert for applying transformations */

.set length,end10-start10
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.set playableAreaOffset,playableArea-offset10
.set applyModifiersOffset,applyModifiers-offset10
.set currFormOffset,currForm-offset10
.set applyResetOffset,applyReset-offset10
.set rockpointerOffset,rockpointer-offset10
.set have3cloudsOffset,have3clouds-offset10
.set have3cloudsaddrOffset,have3cloudsaddr-offset10
.set have3cloudsbranchOffset,have3cloudsbranch-offset10
.set modifierslistOffset,modifierslist-offset10
.set shouldloadformOffset,shouldloadform-offset10
.set loadedformsOffset,loadedforms-offset10

.int 0xC24CEF30
.int numlines

start10:
lwz r0,8(r31)
stwu r1, -128(r1)
stmw r3, 8(r1)
bl 0x4
offset10:
mflr r30
lbz r3,currFormOffset(r30)
bl nextvalidform
stb r3,currFormOffset(r30)
lbz r6,playableAreaOffset(r30)
rlwinm r4,r0,23,31,31
and. r5,r6,r4
lbz r3, applyResetOffset(r30)
beq- check2button
lwz r4,4(r31)
rlwinm. r4,r4,0,23,23
beq- transform
xori r3,r3,0x10
stb r3,applyResetOffset(r30)
rlwinm. r4,r3,26,0,1
bgt- gotoend4
xori r3,r3,0x20
stb r3,applyResetOffset(r30)
rlwinm. r4,r3,0,26,26
rlwinm r3,r3,0,28,31
bne- noenablertoggle
stb r3,applyResetOffset(r30)
lwz r4,shouldloadformOffset(r30)
mr r7,r3
bl makemask
xor r4,r8,r4
stw r4,shouldloadformOffset(r30)
noenablertoggle:
stb r3,currFormOffset(r30)
lbz r3,applyModifiersOffset(r30)
xori r3,r3,1
stb r3,applyModifiersOffset(r30)
b gotoend4
transform:
rlwinm. r4,r3,28,31,31
beq- noReset1
li r4,7
stb r4,currFormOffset(r30)
stb r4,applyResetOffset(r30)
noReset1:
cmpwi r6,3
bne- noloadcheck
lwz r3,shouldloadformOffset(r30)
lbz r7,currFormOffset(r30)
cmpwi r7,7
beq- noloadcheck
bl makemask
and. r8,r3,r8
beq- gotoend4
noloadcheck:
addi r4,r30,modifierslistOffset
li r5,4
li r6,-1
bl applylist
lbz r3,applyModifiersOffset(r30)
cmpwi r3,0
beq- nomodifiers
lwz r5,have3cloudsaddrOffset(r30)
addi r12,r30,have3cloudsOffset
sub r12,r12,r5
lis r4,0x4800
rlwimi r4,r12,0,6,29
stw r4,have3cloudsbranchOffset(r30)
addi r4,r30,modifierslistOffset
li r5,8
li r6,-1
bl applylist
nomodifiers:
lis r12,0x803E
ori r12,r12,0xDFE0
mtctr r12
bctrl
lwz r3,0x14(r3)
lhz r4,1784(r3)
li r29,0
cmpwi r4,0
bne- revertform
lbz r29,currFormOffset(r30)
revertform:
lwz r4,rockpointerOffset(r30)
cmpwi r4,0
beq- noRockRoll
lwz r5,368(r4)
cmplwi r5,0
bne- noRockRoll
lwz r4,408(r4)
lwz r4,4(r4)
lwz r4,16(r4)
lwz r4,12(r4)
lwz r4,0(r4)
lwz r5,32(r4)
stw r5,36(r4)
noRockRoll:
mr r4,r29
li r5,1
li r6,1
lis r12,0x803B
ori r12,r12,0x93F0
mtctr r12
bctrl
cmpwi r29,0xC
bne- checkRock
lis r12,0x8030
ori r12,r12,0xB200
mtctr r12
bctrl
checkRock:
cmpwi r29,0xD
bne- gotoend4
lwz r3,rockpointerOffset(r30)
lis r12,0x802D
ori r12,r12,0x34F0
mtctr r12
bctrl
b gotoend4
check2button:
rlwinm. r4,r0,0,23,23
beq- gotoend4
rlwinm. r4,r3,28,31,31
beq- noReset2
li r4,7
stb r4,currFormOffset(r30)
noReset2:
lbz r3,currFormOffset(r30)
stb r3,applyResetOffset(r30)
bl advanceformone
stb r3,currFormOffset(r30)
gotoend4:
lmw r3, 8(r1)
addi r1, r1, 128
lwz r0,20(r1)
end10:
.int align
.balignl 8,0

/* ASM insert for fixing Flying Mario crash */

.set length,end11-start11
.set align,(length%8==0)*-0x60000000
.set numlines,(length+4)/8+(length%8==0)*-1

.int 0xC24DC438
.int numlines

start11:
lis r31,0x1FE6
ori r31,r31,0xC82E
cmplw r4,r31
beq- crashFix
.if enableIceMario
cmpwi r4,4
beq- crashFix
.endif
lis r31,0x8001
ori r31,r31,0xC4A0
mtctr r31
bctrl
b end11
crashFix:
li r3,1
end11:
.int align
.balignl 8,0

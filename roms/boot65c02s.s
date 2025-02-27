;
; 65C02S Boot ROM
;
.setcpu		"65c02"

.segment	"STARTUP"

.byte "--[[CABE:65C02S:"

.segment "RODATA"

; TSF Component Data
fslist: .byte 10,10,0,"filesystem",0
umlist: .byte 10,5,0,"drive",0
secread: .byte 10,10,0,"readSector",3,1,0
fsopend: .byte 10,4,0,"open",10,12,0,"65C02S/boot",0
fsopenf: .byte 10,4,0,"open",10,7,0,"65C02S",0
fsclose: .byte 10,5,0,"close"
fsread: .byte 10,4,0,"read",14,0,0,0,0,4,0,1,0

; Messages
greeting: .byte "65C02S Boot ROM",13,10,10
nomem: .byte "No Memory installed"
drives: .byte "Checking drives ...",13,10
fsmsg: .byte 10,"Checking filesystems ...",13,10
bootmsg: .byte "Booting ...",13,10
noboot: .byte "Nothing to boot from",13,10

hexlookup: .byte "0123456789abcdef"

unkcmd: .byte "Unknown Command",13,10

cmdlist:
.asciiz "ls"
.word cmd_ls
.asciiz "list"
.word cmd_list
.asciiz "load"
.word cmd_load
.asciiz "save"
.word cmd_save
.asciiz "run"
.word cmd_run
.asciiz "db"
.word cmd_db
.asciiz "at"
.word cmd_at
.asciiz "fs"
.word cmd_fs
.asciiz ""

.define inval $FF

opcodetbl:
.byte "BRK",$07,"ORA",$09,inval,$00,inval,$07,"TSB",$01,"ORA",$01,"ASL",$01,inval,$07,"PHP",$07,"ORA",$00,"ASL",$07,inval,$07,"TSB",$04,"ORA",$04,"ASL",$04,inval,$07
.byte "BPL",$08,"ORA",$0A,"ORA",$0D,inval,$07,"TRB",$01,"ORA",$02,"ASL",$02,inval,$07,"CLC",$07,"ORA",$06,"INC",$07,inval,$07,"TRB",$04,"ORA",$05,"ASL",$05,inval,$07
.byte "JSR",$04,"AND",$09,inval,$00,inval,$07,"BIT",$01,"AND",$01,"ROL",$01,inval,$07,"PLP",$07,"AND",$00,"ROL",$07,inval,$07,"BIT",$04,"AND",$04,"ROL",$04,inval,$07
.byte "BMI",$08,"AND",$0A,"AND",$0D,inval,$07,"BIT",$02,"AND",$02,"ROL",$02,inval,$07,"SEC",$07,"AND",$06,"DEC",$07,inval,$07,"BIT",$05,"AND",$05,"ROL",$05,inval,$07
.byte "RTI",$07,"EOR",$09,inval,$00,inval,$07,inval,$00,"EOR",$01,"LSR",$01,inval,$07,"PHA",$07,"EOR",$00,"LSR",$07,inval,$07,"JMP",$04,"EOR",$04,"LSR",$04,inval,$07
.byte "BVC",$08,"EOR",$0A,"EOR",$0D,inval,$07,inval,$00,"EOR",$02,"LSR",$02,inval,$07,"CLI",$07,"EOR",$06,"PHY",$07,inval,$07,inval,$07,"EOR",$05,"LSR",$05,inval,$07
.byte "RTS",$07,"ADC",$09,inval,$00,inval,$07,"STZ",$01,"ADC",$01,"ROR",$01,inval,$07,"PLA",$07,"ADC",$00,"ROR",$07,inval,$07,"JMP",$0B,"ADC",$04,"ROR",$04,inval,$07
.byte "BVS",$08,"ADC",$0A,"ADC",$0D,inval,$07,"STZ",$02,"ADC",$02,"ROR",$02,inval,$07,"SEI",$07,"ADC",$06,"PLY",$07,inval,$07,"JMP",$0C,"ADC",$05,"ROR",$05,inval,$07
.byte "BRA",$08,"STA",$09,inval,$00,inval,$07,"STY",$01,"STA",$01,"STX",$01,inval,$07,"DEY",$07,"BIT",$00,"TXA",$07,inval,$07,"STY",$04,"STA",$04,"STX",$04,inval,$07
.byte "BCC",$08,"STA",$0A,"STA",$0D,inval,$07,"STY",$02,"STA",$02,"STX",$03,inval,$07,"TYA",$07,"STA",$06,"TXS",$07,inval,$07,"STZ",$04,"STA",$05,"STZ",$05,inval,$07
.byte "LDY",$00,"LDA",$09,"LDX",$00,inval,$07,"LDY",$01,"LDA",$01,"LDX",$01,inval,$07,"TAY",$07,"LDA",$00,"TAX",$07,inval,$07,"LDY",$04,"LDA",$04,"LDX",$04,inval,$07
.byte "BCS",$08,"LDA",$0A,"LDA",$0D,inval,$07,"LDY",$02,"LDA",$02,"LDX",$03,inval,$07,"CLV",$07,"LDA",$06,"TSX",$07,inval,$07,"LDY",$05,"LDA",$05,"LDX",$06,inval,$07
.byte "CPY",$00,"CMP",$09,inval,$00,inval,$07,"CPY",$01,"CMP",$01,"DEC",$01,inval,$07,"INY",$07,"CMP",$00,"DEX",$07,inval,$07,"CPY",$04,"CMP",$04,"DEC",$04,inval,$07
.byte "BNE",$08,"CMP",$0A,"CMP",$0D,inval,$07,inval,$00,"CMP",$02,"DEC",$02,inval,$07,"CLD",$07,"CMP",$06,"PHX",$07,inval,$07,inval,$07,"CMP",$05,"DEC",$05,inval,$07
.byte "CPX",$00,"SBC",$09,inval,$00,inval,$07,"CPX",$01,"SBC",$01,"INC",$01,inval,$07,"INX",$07,"SBC",$00,"NOP",$07,inval,$07,"CPX",$04,"SBC",$04,"INC",$04,inval,$07
.byte "BEQ",$08,"SBC",$0A,"SBC",$0D,inval,$07,inval,$00,"SBC",$02,"INC",$02,inval,$07,"SED",$07,"SBC",$06,"PLX",$07,inval,$07,inval,$07,"SBC",$05,"INC",$05,inval,$07

length: .byte 2,2,2,2,3,3,3,1,2,2,2,3,3,2,3

format:
.byte "#$__",$00,$00
.byte "#'_'",$00,$00
.byte "$__",$00,$01
.byte "$__,X",$00,$02
.byte "$__,Y",$00,$03
.byte "$____",$00,$04
.byte "$____,X",$00,$05
.byte "$____,Y",$00,$06
.byte "0X__",$00,$08
.byte "-0X__",$00,$08
.byte "($__,X)",$00,$09
.byte "($__),Y",$00,$0a
.byte "($____)",$00,$0b
.byte "($____,X)",$00,$0c
.byte "($__)",$00,$0d
.byte "$__,0X__",$00,$0e
.byte "$__,-0X__",$00,$0e
.byte $00,$07 ; Must be last

.segment "STARTUP"

; ZEROPAGE
; The input is stored at $00 forwards.

; this is the length of the input.
.define inputlen $80
; arguably various forms of temporary.
.define good $81
.define formattype $82
.define addrmode $83

; these 3 make up a runtime codegen buffer for indirect jumps,
;  but indlow/indhigh are also used as temporaries by themselves too.
.define opcode $84
; used in "($__),Y"-form
.define indlow $85
.define indhigh $86

; this is the writing pointer (cursor/current) ; it's used a lot.
; used in "($__),Y"-form
.define curlow $87
.define curhigh $88

.macro dmacopy src, dest, len, mode
	.ifnblank src
		.if .const(src) .and .lobyte(src) = 0
			stz $E041
		.else
			lda #<src
			sta $E041
		.endif
		.if .const(src) .and .hibyte(src) = 0
			stz $E042
		.else
			lda #>src
			sta $E042
		.endif
	.endif
	.ifnblank dest
		.if .const(dest) .and .lobyte(dest) = 0
			stz $E043
		.else
			lda #<dest
			sta $E043
		.endif
		.if .const(dest) .and .hibyte(dest) = 0
			stz $E044
		.else
			lda #>dest
			sta $E044
		.endif
	.endif
	.ifnblank len
		.if .const(len) .and len = 0
			stz $E045
		.else
			lda #<len
			sta $E045
		.endif
	.endif
	.if .const(mode) .and mode = 0
		stz $E040
	.else
		lda #mode
		sta $E040
	.endif
.endmacro

.macro dmaload src, dest, len
	.ifnblank src
		.if .const(src) .and .lobyte(src) = 0
			stz $E041
		.else
			lda #<src
			sta $E041
		.endif
		.if .const(src) .and .hibyte(src) = 0
			stz $E042
		.else
			lda #>src
			sta $E042
		.endif
	.endif
	.ifnblank dest
		.if .const(dest) .and .lobyte(dest) = 0
			stz $E043
		.else
			lda #<dest
			sta $E043
		.endif
		.if .const(dest) .and .hibyte(dest) = 0
			stz $E044
		.else
			lda #>dest
			sta $E044
		.endif
	.endif
	.ifnblank len
		.if .const(len) .and len = 0
			stz $E045
		.else
			lda #<len
			sta $E045
		.endif
	.endif
.endmacro

.define mode_pp $00
.define mode_pu $01
.define mode_up $02
.define mode_uu $03

hexprint:
	; Prints a byte to the screen
	; A - byte to print
	; Clobbers: X
	pha
	phy
	tax
	lsr
	lsr
	lsr
	lsr
	tay
	lda hexlookup,Y
	sta $E003
	txa
	and #$0F
	tay
	lda hexlookup,Y
	sta $E003
	ply
	pla
	rts

crlf:
	lda #$0D
	sta $E003
	lda #$0A
	sta $E003
	rts

uuidprint:
	; Prints a UUID to the screen
	; $00, $01 - Address of UUID
	; Clobbers: A, X (hexprint), Y
	ldy #$00
@loop:
	lda (indlow),Y
	jsr hexprint
	iny
	cpy #$10
	beq @done
	cpy #$04
	beq @dash
	cpy #$06
	beq @dash
	cpy #$08
	beq @dash
	cpy #$0A
	beq @dash
	bra @loop
@dash:
	lda #$2D
	sta $E003
	bra @loop
@done:
	jmp crlf ; JSR/RTS

_readlist:
	; Reads component list to $0200
	; $02 - Bytes to skip for component type
	; Clobbers: A, X, Y, indlow, indhigh
	lda $E011
	sta $03
	stz indlow
	ldy #$00
	lda #$02
	sta indhigh
@loop1:
	lda $E012
	cmp #$00 ; TSF End Tag
	beq @done

	; Read UUID
	ldx #$10
@loop2:
	lda $E012
	sta (indlow),Y
	jsr inc_y
	dex
	cpx #$00
	bne @loop2

	; Drop component name
	ldx $02
@loop3:
	lda $E012
	dex
	cpx #$00
	bne @loop3
	bra @loop1
@done:
	lda #$02
	sta indhigh
	rts

.macro readlist skip
	lda #skip
	sta $02
	jsr _readlist
.endmacro

loaduuid:
	; Load a UUID into the component selector buffer
	; indlow, indhigh - Address to read from
	; Clobbers: A, X, Y, (uuidprint)
	jsr uuidprint
loaduuid2:
	ldy indlow
	stz indlow
	ldx #$10
	lda #$0b ; UUID Tag
	sta $E012
@loop:
	lda (indlow),Y ; UUID Byte loop
	sta $E012
	jsr inc_y
	dex
	cpx #$00
	bne @loop
	sty indlow
	stz $E012 ; End Tag
	stz $E010 ; Map Component
	rts

closehandle:
	; Closes an open file handle
	; $08-$0C - Handle to close
	; Clobbers: A
	dmacopy fsclose, $D001, .sizeof(fsclose), mode_up ; Call close
	dmacopy $0008, , 5, mode_up ; ($0008, $D001, 5, mode_up)
	stz $D001
	stz $D000
	dmacopy , $E012, , mode_up ; ($0008, $E012, 5, mode_up) Destroy value
	stz $E012
	lda #$04
	sta $E010
	rts

loadfile:
	; Reads a file into memory starting at $0200
	stz curlow
	lda #$02
	sta curhigh
	dmacopy fsread, $0001, .sizeof(fsread), mode_uu ; Copy read command
	dmacopy $D001, $0008, 5, mode_pu ; Inject handle
@loop:
	ldx curhigh
	cpx #$D0
	beq @done ; Too much data read
	dmacopy $0001, $D001, .sizeof(fsread), mode_up ; Call "read"
	stz $D000

	lda $D001 ; Check TSF Tag
	cmp #$09 ; Byte array?
	beq :+
	cmp #$0A ; String?
	bne @done ; No more data to read

:	lda $D001 ; Read length
	sta indlow
	lda $D001
	sta indhigh
	ldy #$01 ; Setup Copy Engine
	sty $E041
	lda #$D0
	sta $E042
	clc ; Load address and add at same time
	lda curlow
	sta $E043
	adc indlow
	sta curlow
	lda curhigh
	sta $E044
	adc indhigh
	sta curhigh
	lda indlow
	sta $E045
	lda indhigh
	sta $E046
	sty $E040 ; Execute Copy Engine Command
	bra @loop
@done:
	stz $E046 ; Put high byte of size back to 0
	jmp closehandle ; JSR/RTS

dispboot:
	dmacopy bootmsg, $E003, .sizeof(bootmsg), mode_up
	rts

bootdrive:
	; Checks and boots from a drive
	lda $D000
	cmp #$00
	beq :+
	rts
:	jsr dispboot
	pla ; Remove address from stack
	pla ; We're not returning to havemem
	lda #$01 ; Setup Copy Engine
	sta $E041
	lda #$D0
	sta $E042
	stz $E043
	lda #$02
	sta $E044

	lda $D001 ; Discard tag
	lda $D001
	sta $E045
	lda $D001
	sta $E046

	lda #mode_pu ; Copy
	sta $E040

	stz $E046
	jsr $0200 ; Boot
	jmp fschk

bootfs:
	; Boots from a file
	lda $D000
	cmp #$00
	beq :+
	rts ; No file opened
:	jsr dispboot
	pla ; Remove address from stack
	pla ; We're not returning to fschk
	jsr loadfile
	jsr $0200 ; Boot
	jmp commands

reset:
	; Display boot greeting
	dmacopy greeting, $E003, .sizeof(greeting), mode_up

	; Memory Check
	lda $E018
	cmp #$00
	bne havemem
	lda $E019
	cmp #$00
	bne havemem
	; No Memory Installed
	dmacopy nomem, , .sizeof(nomem), mode_up ; (nomem, $E003, .sizeof(nomem), mode_up)
@loop:	bra @loop

havemem:
	dmacopy drives, , .sizeof(drives), mode_up ; (drives, $E003, .sizeof(drives), mode_up)
	; Look for "drive" components
	dmacopy umlist, $E012, .sizeof(umlist), mode_up
	lda #$03
	sta $E010
	readlist 8 ; Store list to memory

	; Parse list
@loop:
	lda $03
	cmp #$00
	beq fschk ; No "drive" componets left to check
	jsr loaduuid
	dmacopy secread, $D001, .sizeof(secread), mode_up ; Call readSector
	stz $D000
	jsr bootdrive
	dec $03
	bra @loop

fschk:
	dmacopy fsmsg, $E003, .sizeof(fsmsg), mode_up
	; Look for "filesystem" components
	dmacopy fslist, $E012, .sizeof(fslist), mode_up
	lda #$03
	sta $E010
	readlist 13 ; Store list to memory

	; Parse list
@loop:
	lda $03
	cmp #$00
	bne :+
	jmp failboot ; No "filesystem" componets left to check
:	jsr loaduuid
	dmaload , $D001
	dmacopy fsopend, , .sizeof(fsopend), mode_up ; (fsopend, $D001, .sizeof(fsopend), mode_up) open 65C02S/boot
	stz $D000
	jsr bootfs
	dmacopy fsopenf, , .sizeof(fsopenf), mode_up ; (fsopenf, $D001, .sizeof(fsopenf), mode_up) open 65C02S
	stz $D000
	jsr bootfs
	dec $03
	bra @loop

_hex2val:
	; Converts one hexadecimal characters to a value
	lda $00,X
	clc
	sbc #$2f
	cmp #$11
	bcc :+
	sbc #$07
:	dex
	rts

hex2val_a:
	; Converts two hexadecimal characters from $00,X to a value
	;  and stores that value in A.
	; Clobbers: A, the carry flag, good
	; Advances X *backwards* (as this is convenient for little-endian).
	; So for the string "0000", you would want X to start at the last 0 and make 2 calls.
	jsr _hex2val
	; if a non-capital letter is placed in the lower nibble,
	;  then #$20 is OR'd into the result. this isn't great.
	; flush it out completely here (doesn't matter if it happens to the upper nibble)
	and #$0F
	sta good
	jsr _hex2val
	asl
	asl
	asl
	asl
	eor good
	rts

hex2val:
	; Like hex2val_a, but stores to (curlow),Y & advances a Y 'relative-to-opcode' offset
	jsr hex2val_a
	sta (curlow),Y
	iny
	rts

inc_y:
	; Handle page wraps
	iny
	cpy #$00
	bne :+
	inc indhigh
:	rts

failboot:
	dmacopy noboot, $E003, .sizeof(noboot), mode_up

	; Try to select a non tmpfs filesystem
	dmacopy fslist, $E012, .sizeof(fslist), mode_up
	lda #$03
	sta $E010
	readlist 13 ; Store list to memory

@loop:
	lda $03
	cmp #$00
	beq commands
	ldx #$00
	ldy #$00
	stz good
@loop2:
	lda (indlow),Y
	cmp $E110,X
	beq :+
	sty good
	lda indlow
	clc
	adc good
	stx good
	sec
	sbc indlow
	sta indlow
	jsr loaduuid2
	bra commands
:	inx
	jsr inc_y
	cpx #$10
	bne @loop2
	ldx #$00
	dec $03
	bra @loop

commands:
	stz $E001 ; Drop all input
	stz curlow
	lda #$02
	sta curhigh
@setup:	lda #'$'
	sta $E003
	lda curhigh
	jsr hexprint
	lda curlow
	jsr hexprint
	ldx #' '
	stx $E003
	lda #'>'
	sta $E003
	stx $E003
	stz inputlen
@loop:	lda $E000
	cmp #$00
	beq @loop ; No Input
	ldx inputlen
	lda $E001
	cmp #$00 ; Scancode, discard
	bne :+
	lda $E001
	bra @loop
:	cmp #$08 ; Backspace
	bne :+
	cpx #$00
	beq @loop ; No input to delete
	sta $E003
	dec inputlen
	bra @loop
:	cmp #$0D ; Carriage Return
	beq @exec
	cmp #$0A ; Line Feed
	beq @exec
	cpx #$80 ; Character
	beq @loop
	sta $E003
	sta $00,X
	inc inputlen
	bra @loop
@exec:
	jsr crlf
	cpx #$00 ; No Input
	beq @setup
	; @setup for comparing cmd names
	lda #<cmdlist
	sta indlow
	lda #>cmdlist
	sta indhigh
	ldx #$00
	ldy #$00
	stz good
	; Compare against cmd list
@ncloop:
	lda (indlow),Y
	cmp #$00 ; NUL, end of cmd name
	beq @nccheck
	cmp $00,X ; Matches
	beq :+
	smb0 good ; Mark as bad
:	inx
	jsr inc_y
	bra @ncloop
@nccheck:
	jsr inc_y
	cpx #$00 ; No more cmd entries?
	beq @asm
	cmp good ; A = $00
	bne @ncbad
	cpx inputlen
	beq @ncfound
	lda $00,X
	cmp #' '
	beq @ncfound
@ncbad:
	stz good ; Did not match, reset
	ldx #$00
	jsr inc_y ; Skip over address
	jsr inc_y
	bra @ncloop
@ncfound:
	lda #$4C ; JMP $XXXX
	sta opcode
	lda (indlow),Y
	tax
	jsr inc_y
	lda (indlow),Y
	stx indlow
	sta indhigh
	jsr opcode
	jmp @setup
@asm:
	; Assembly code!
	; Uppercase it all
	ldx #$00
@ucloop:
	lda $00,X
	clc
	sbc #$60
	bmi :+
	adc #$40
	sta $00,X
:	inx
	cpx inputlen
	bne @ucloop
	; Setup for comparing format strings
	ldx #$04
	ldy #$00
	stz formattype
	stz good
	lda inputlen
	cmp #$03 ; Three characters?
	bcs :+
	jmp @badcmd
:	beq @amloop
	lda $03
	cmp #$20
	beq @amloop
	jmp @badcmd ; 4th character not a space
	; Identify addressing mode
@amloop:
	lda format,Y
	cmp #$00 ; NUL, end of format string
	beq @amcheck
	cmp #$5F ; Underscore
	beq :+
	cmp $00,X ; Matches
	beq :+
	smb0 good ; Mark as bad
:	inx
	iny
	bra @amloop
@amcheck:
	iny
	cpx #$04 ; No more format entries?
	beq @amfound ; Assume implied
	cmp good ; A = $00
	bne @ambad
	cpx inputlen
	beq @amfound
	bcs @ambad ; Not enough imput
	lda $00,X
	cmp #' '
	beq @amfound
@ambad:
	stz good ; Wrong addressing mode, reset
	ldx #$04
	iny
	inc formattype
	bra @amloop
@amfound:
	lda format,Y
	sta addrmode
	lda #<opcodetbl
	sta indlow
	lda #>opcodetbl
	sta indhigh
	ldy #$00
	ldx #$00
	stz opcode
	stz good
	; Compare opcode names
@oploop:
	lda (indlow),Y
	cmp $00,X
	beq :+
	smb0 good ; Mark as bad
:	inx
	jsr inc_y
	cpx #$03
	beq @opcheck
	cmp #$FF
	beq @opcheck
	bra @oploop
@opcheck:
	lda (indlow),Y
	cmp addrmode
	beq :+
	smb0 good ; Mark as bad
:	lda #$00
	cmp good
	beq @opfound

	stz good ; Wrong opcode, reset
	ldx #$00
	jsr inc_y
	inc opcode
	lda opcode
	cmp #$00 ; Wrapped back to 0
	bne :+
	jmp @badcmd
:	bra @oploop
@opfound:
	ldy #$00
	lda opcode
	sta (curlow),Y ; Write opcode to memory
	iny
	lda formattype
	cmp #$00 ; immediate
	beq @read21
	cmp #$01 ; immediate w/ character
	beq @readchar
	cmp #$02 ; zeropage
	beq @read20
	cmp #$03 ; zp indexed x
	beq @read20
	cmp #$04 ; zp indexed y
	beq @read20
	cmp #$05 ; absolute
	beq @read40
	cmp #$06 ; indexed x
	beq @read40
	cmp #$07 ; indexed y
	beq @read40
	cmp #$08 ; relative
	beq @read21
	cmp #$09 ; relative w/ minus
	beq @relminus
	cmp #$0a ; zp indirect x
	beq @read21
	cmp #$0b ; zp indirect y
	beq @read21
	cmp #$0c ; indirect
	beq @read41
	cmp #$0d ; indirect x
	beq @read41
	cmp #$0e ; zp indirect
	beq @read21
	cmp #$0f ; zp relative
	beq @readzpr
	cmp #$10 ; zp relative minus
	beq @zprminus
	bra @opskip
@readchar:
	ldx #$06
	lda $00,X
	sta (curlow),Y
	bra @opskip
@read20:
	ldx #$06
	jsr hex2val
	bra @opskip
@read21:
	ldx #$07
	jsr hex2val
	bra @opskip
@read40:
	ldx #$08
	jsr hex2val
	jsr hex2val
	bra @opskip
@read41:
	ldx #$09
	jsr hex2val
	jsr hex2val
	bra @opskip
@readzpr:
	ldx #$06
	jsr hex2val
	ldx #$0b
	jsr hex2val
	bra @opskip
@zprminus:
	ldx #$06
	jsr hex2val
	ldx #$0c
	bra :+
@relminus:
	ldx #$08
:	jsr hex2val
	dey
	sec
	lda #$00
	sbc (curlow),Y
	sta (curlow),Y
@opskip:
	ldy addrmode
	ldx length,Y
	ldy curlow
@incloop:
	iny
	cpy #$00
	bne :+
	inc curhigh
:	dex
	cpx #$00
	bne @incloop
	sty curlow
	bra :+
@badcmd:
	dmacopy unkcmd, $E003, .sizeof(unkcmd), mode_up ; (unkcmd, $E003, .sizeof(unkcmd), mode_up)
:	jmp @setup

loadinput:
	; Loads string from input buffer into Component 1
	lda inputlen
	cmp good
	bcs :+
	lda good
:	clc
	sbc good
	inc
	sta $D001
	sta $E045 ; Copy Engine Length
	stz $D001

	lda good ; Setup Copy Engine
	sta $E041
	stz $E042
	lda #$01
	sta $E043
	lda #$D0
	sta $E044
	lda #mode_up ; Copy
	sta $E040
	rts

.segment "RODATA"

listtest: .byte 10,4,0,"list",10
listfail: .byte "Listing failed",13,10

.segment "STARTUP"

; ls [directory]
; list [directory]
cmd_ls:
	lda #$03 ; inputlen
	sta good
	bra :+
cmd_list:
	lda #$05 ; inputlen
	sta good
:	dmacopy listtest, $D001, .sizeof(listtest), mode_up
	jsr loadinput
	stz $D001 ; TSF End Tag
	stz $D000 ; Invoke
	lda $D000
	cmp #$00
	beq :+
	dmacopy listfail, $E003, .sizeof(listfail), mode_up
	rts
:	lda $D001 ; Drop Array Tag
@loop:
	lda $D001
	cmp #$00 ; TSF End Tag
	beq @done
	ldy $D001 ; Length low
	ldx $D001 ; Length high
@readloop:
	cpy #$00
	bne :+
	cpx #$00
	bne :+
	jsr crlf
	bra @loop
:	lda $D001
	sta $E003
	dey
	cpy #$FF
	bne :+
	dex
:	bra @readloop
@done:
	rts

.segment "RODATA"

openfail: .byte "Could not open file",13,10
loadmsg: .byte "Loading file ...",13,10

.segment "STARTUP"

; load <filename>
cmd_load:
	lda inputlen
	cmp #$06
	bcs :+
	rts
:	dmacopy fsopenf, $D001, 8, mode_up ; Copy 10,4,0,"open",10
	lda #$05 ; inputlen
	sta good
	jsr loadinput
	stz $D001 ; TSF End Tag
	stz $D000 ; Invoke
	lda $D000
	cmp #$00
	beq :+
	dmacopy openfail, $E003, .sizeof(openfail), mode_up ; No file opened
	rts
:	dmacopy loadmsg, $E003, .sizeof(loadmsg), mode_up
	jmp loadfile ; JSR/RTS

.segment "RODATA"

savemsg: .byte "Saving file ...",13,10
fswrite: .byte 10,5,0,"write"

.segment "STARTUP"

; save <filename>
cmd_save:
	lda inputlen
	cmp #$06
	bcs :+
	rts
:	dmacopy fsopenf, $D001, 8, mode_up ; Copy 10,4,0,"open",10
	lda #$05 ; inputlen
	sta good
	jsr loadinput
	lda #10
	sta $D001
	lda #1
	sta $D001
	stz $D001
	lda #'w'
	sta $D001
	stz $D001 ; TSF End Tag
	stz $D000 ; Invoke
	lda $D000
	cmp #$00
	beq :+
	dmacopy openfail, $E003, .sizeof(openfail), mode_up ; No file opened
	rts
:	dmacopy savemsg, $E003, .sizeof(savemsg), mode_up
	dmacopy fswrite, $D001, .sizeof(fswrite), mode_up ; Copy write command
	dmacopy $D001, $0008, 5, mode_pu ; Save handle
	dmacopy $0008, $D001, 5, mode_up
	lda #9
	sta $D001
	ldx curlow
	stx $D001
	ldy curhigh
	dey
	dey
	sty $D001
	stz $E041
	lda #$02 ; Setup Copy Engine
	sta $E042
	lda #$01
	sta $E043
	lda #$D0
	sta $E044
	stx $E045
	sty $E046
	lda #mode_up ; Copy
	sta $E040
	stz $E046 ; Put high byte back to zero
	stz $D001 ; TSF End Tag
	stz $D000 ; Invoke
	jmp closehandle ; JSR/RTS

; run
cmd_run:
	stz $E005
	jmp $0200

; db __
cmd_db:
	ldy #$00
	ldx #$04 ; 'db ' plus an additional 1 for hex2val quirks
	jsr hex2val
	; Completed the actual write.
	; Need to adjust curlow/curhigh.
	lda #$01
	clc
	adc curlow
	sta curlow
	; keep carry flag...
	lda #$00
	adc curhigh
	sta curhigh
	rts

; at ____
cmd_at:
	; While using hex2val to overwrite curlow/curhigh would be good,
	;  it destroys curlow/curhigh as hex2val is trying to use it.
	; So take the manual route.
	ldx #$06
	jsr hex2val_a
	sta curlow
	jsr hex2val_a
	sta curhigh
	rts

; fs ________-____-____-____-____________
cmd_fs:
	; the part where the UUID is read is a little 'fun', and it starts here.

	ldx #$03 ; see below:
	; $03 : after 'fs '
	; $04 : inc because it needs to be pointed at the RHS digit
	; $03 : dec due to the placement of @dash
	
	ldy #$00
	; this part is similar to the UUID printer in principle.
@dash:
	inx
@loop:
	jsr hex2val_a
	inx
	inx
	inx
	inx
	; the command buffer is used as the storage, for convenience.
	sta $00,Y
	iny
	; This is the same pattern as in the UUID printer.
	; The question is, if having a separate pattern table would be an improvement...
	cpy #$10
	beq @done
	cpy #$04
	beq @dash
	cpy #$06
	beq @dash
	cpy #$08
	beq @dash
	cpy #$0A
	beq @dash
	bra @loop
@done:
	; the UUID is now written at $00
	lda #$00
	sta indlow
	sta indhigh
	jmp loaduuid ; JSR/RTS

.segment "RODATA"

.byte "]]error",$22,"65C02S architecture required",$22,"--"

.segment "STARTUP"

interrupt_handler:
	rti

.segment	"VECTORS"

.word interrupt_handler
.word reset
.word interrupt_handler


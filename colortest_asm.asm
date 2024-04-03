 movem.l d1-d7/a0-a2,-(a7)	; save registers
 move.l 40(a7),a2		; ptr to copperlist
 move.l 44(a7),d3		; offset
 move.l 48(a7),a1		; ptr to sourceCMAP
 move.l 52(a7),a0		; ptr to targetCMAP
 move.l 56(a7),d2		; colorCount
 move.l 60(a7),d7		; steps
 move.l 64(a7),d6		; step
 lsl.w #$01,d3			; offset*2 (word)
 adda.w d3,a2			; ptr to copperlist+offset
 move.w d2,d3			; colorCount
 sub.w #$1,d3			; colorCount-1
colorloop:
 moveq #$02,d2			; loop for r, g, b
 clr.w d0			; col = 0
 move.w #$08,d5			; shift for red color
loop:
 clr.w d4			; register for color difference
 move.b (a0)+,d4		; target color
 lsr.b #$04,d4			; shift right 4 bit
 move.b (a1)+,d1		; source color
 lsr.b #$04,d1			; shift right 4 bit
 sub.b d1,d4			; target - source
 bpl.s pos			; if positiv -> jump to pos
 neg.b d4			; negate color difference
 mulu.w d6,d4			; (target - source)*step
 divu.w d7,d4			; (target - source)*step/steps
 neg.b d4			; negate result
 bra.s inc			; jump to inc
pos:
 mulu.w d6,d4			; (target - source)*step
 divu.w d7,d4			; (target - source)*step/steps
inc:
 add.b d1,d4			; source + (target - source)*step/steps
 lsl.w d5,d4			; shift left (r = 8, g = 4, b = 0)
 add.w d4,d0			; add to col variable
 sub.b #$04,d5			; prepare for next color shift
 dbf d2,loop			; loop 3 times (r, g, b)
 move.w d0,(a2)			; write col variable to copperlist
 adda.w #$04,a2			; increase copperlist position
 dbf d3,colorloop		; loop colorCount times
 movem.l (a7)+,d1-d7/a0-a2	; restore registers

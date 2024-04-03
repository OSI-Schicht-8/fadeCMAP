void fadeCMAPasm(APTR cpr,UWORD offset,APTR sourceCMAP,APTR targetCMAP,UWORD colorCount,UBYTE steps,UBYTE step)=" movem.l d1-d7/a0-a2,-(a7)\n move.l 40(a7),a2\n  move.l 44(a7),d3\n  move.l 48(a7),a1\n  move.l 52(a7),a0\n move.l 56(a7),d2\n move.l 60(a7),d7\n move.l 64(a7),d6\n lsl.w #$01,d3\n adda.w d3,a2\n move.w d2,d3\n sub.w #$1,d3\ncolorloop:\n moveq #$02,d2\n clr.w d0\n move.w #$08,d5\nloop:\n clr.w d4\n move.b (a0)+,d4\n lsr.b #$04,d4\n move.b (a1)+,d1\n lsr.b #$04,d1\n sub.b d1,d4\n bpl.s pos\n neg.b d4\n mulu.w d6,d4\n divu.w d7,d4\n neg.b d4\n bra.s inc\npos:\n mulu.w d6,d4\n divu.w d7,d4\ninc:\n add.b d1,d4\n lsl.w d5,d4\n add.w d4,d0\n sub.b #$04,d5\n dbf d2,loop\n move.w d0,(a2)\n adda.w #$04,a2\n dbf d3,colorloop\n movem.l (a7)+,d1-d7/a0-a2\n";

int main()
{
	/* example */
	UWORD offset = 4;
	UWORD colorCount = 8;
	UWORD steps = 15;
	UWORD step = 7;
	
	fadeCMAPasm(copperlist, offset, blackCMAP, whiteCMAP, colorCount, steps, step);
}
#include "textflag.h"

#define Big		0x4330000000000000 // 2**52

// func Floor(x float64) float64
TEXT ·Floor(SB),NOSPLIT,$0
	MOVQ	x+0(FP), AX
	MOVQ	$~(1<<63), DX // sign bit mask
	ANDQ	AX,DX // DX = |x|
	SUBQ	$1,DX
	MOVQ    $(Big - 1), CX // if |x| >= 2**52-1 or IsNaN(x) or |x| == 0, return x
	CMPQ	DX,CX
	JAE     isBig_floor
	MOVQ	AX, X0 // X0 = x
	CVTTSD2SQ	X0, AX
	CVTSQ2SD	AX, X1 // X1 = float(int(x))
	CMPSD	X1, X0, 1 // compare LT; X0 = 0xffffffffffffffff or 0
	MOVSD	$(-1.0), X2
	ANDPD	X2, X0 // if x < float(int(x)) {X0 = -1} else {X0 = 0}
	ADDSD	X1, X0
	MOVSD	X0, ret+8(FP)
	RET
isBig_floor:
	MOVQ    AX, ret+8(FP) // return x
	RET

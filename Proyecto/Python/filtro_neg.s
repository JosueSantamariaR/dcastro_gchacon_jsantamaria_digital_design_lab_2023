loop_imag_body:

	ldr r5, [r0]
	add r0, #4
	sub r5, r6, r5

	str r5, [r1]
	add r1, #4
	
	add r3, r3, #1
	cmp r3, r4
	blt loop_imag_body
.data
IMAG:     .word 1, 2, 3, 4, 5, 6, 7, 8, 9
OFFSETS:  .word -16, -12, -8, -4, 0, 4, 8, 12, 16
VECINOS:  .space 36

.text
.global _start
_start:
    ldr r0, =IMAG @ Load the address of IMAG into r0
    mov r1, #3 @ Load the value of SIZE into r1
    mov r2, #12 @ Load the value of ROW_SIZE into r2
	ldr r3, =VECINOS  @ Load the address of VECINOS into r3

loop_imag_ini:
    mov r4, #0  @ contador de loop_imag (loop counter)
    mul r5, r1, r1 @valor máximo de loop_imag (SIZE * SIZE)

loop_imag_body:

    loop_vecinos_ini:
        mov r6, #0  @ contador de for_vecinos (loop counter)
        mov r7, #9  @ valor maximo de for_vecinos (max value of for_vecinos)
        ldr r8, =OFFSETS @ Load the address of OFFSETS into r8

    loop_vecinos_body:
        ldr r9, [r8], #4  @ Load offset from OFFSETS and increment the address
        add r9, r0, r9   @ Calculate vecino = offset + offsets[j]

        ldr r10, =IMAG
        cmp r9, r10
        blt loop_vecinos_sum

        ldr r10, =IMAG
        mov r11, #4
        mul r11, r11, r5
        add r10, r10, r11
        cmp r9, r10
        bge loop_vecinos_sum
		
		ldr r9, [r9]
		str r9, [r3, r6, LSL #2]

    loop_vecinos_sum:
        add r6, r6, #1  @ decremento de contador de for_vecinos
        cmp r6, r7
        blt loop_vecinos_body
        b loop_vecinos_end

    loop_vecinos_end:
        add r0, r0, #4
        adds r4, r4, #1
        cmp r4, r5
        bge loop_imag_end
        b loop_imag_body

loop_imag_end:
    mov r7, #10  @ System call code for exit
    swi 0
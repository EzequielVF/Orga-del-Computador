	.equ SWI_Print_Int, 0x6B
	.equ SWI_Exit, 0x11
	.equ SWI_Print_Str, 0x69
	
	.data
eol:
    .asciz "\n"
	.align

	.text
_start:
	@ r2: contador (x)
	mov r2, #0
loop:
	cmp r2, #10    @ x - 10
	bpl fin_loop   @ si (x - 10 >= 0): saltar a fin_loop
	bl print_r2
	add r2, r2, #1
	b loop

print_r2:
    stmfd sp!, {r0,r1,lr}
	mov r0, #1
	mov r1, r2
	swi SWI_Print_Int
	ldr r1, =eol
    swi SWI_Print_Str          @ Print EOL in register r1 to stdout
	ldmfd sp!, {r0,r1,pc}

fin_loop:
	@ salir del programa
	swi SWI_Exit
	.end

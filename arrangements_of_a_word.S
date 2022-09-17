.intel_syntax noprefix
.global _start
.text

swap_subroutine:
	# swap the idx and r8 character
	mov     al, BYTE PTR [msg+r9]   
 	mov     bl, BYTE PTR [msg+r8]
 	mov     BYTE PTR [msg+r9], bl
	mov     BYTE PTR [msg+r8], al
	ret

# Expects current idx in r9, maxIdx in r10
iter:
	mov		r8, r9			# r8 is our loop variable. Has value of r9
	iter_loop:
	# swap the idx and r8 character
	call	swap_subroutine
	# Iterative Call section. Print the word if idx==maxIdx, else ...
	cmp		r9, r10
	je		print
	# ... else, recursively call this function
	push	r8				# push loop variable
	push	r9				# push current idx variable
	inc		r9				# increment current idx
	call	iter
	pop		r9
	pop		r8
	jmp		swap
	print:	call	printWord
	swap:	call	swap_subroutine
	# repeat loop
	inc		r8
	cmp		r8, r11
	jne		iter_loop
	ret

# print the word. Register repopulation MUST happen with every call
printWord:
	mov		rax, 4						# Stays static for all future print calls
	mov		rbx, 1						# Stays static for all future print calls
	mov		rcx, OFFSET msg				# Stays static for all future print calls
	mov		rdx, 5						# Stays static for all future print calls
	int		0x80
	ret

_start:
	mov     r9,  0						# first arg
	mov		r10, QWORD PTR [maxIdx]		# MaxIdx. Static
	lea		r11, [r10+1]				# MaxIdx. Static
	call	iter

	mov		rax, 1
	mov		rbx, 14 
	int		0x80
	
.data
msg:	.ascii	"ASAD\n"
maxIdx:	.quad	3

; AddTwoSum_64.asm - Chapter 3 example.

ExitProcess proto

.data
	firstval QWORD 2000200020002000h
	secondval QWORD 1111111111111111h
	thirdval QWORD 2222222222222222h
	sum QWORD  0 

.code
main proc
	xor rax,rax
	mov rax,firstval
	add rax,secondval
	add rax,thirdval

	mov   sum,rax

	call  ExitProcess

main endp
end

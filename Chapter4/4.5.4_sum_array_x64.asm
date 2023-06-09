; AddTwoSum_64.asm - Chapter 3 example.

ExitProcess proto
.data
intArray QWORD 1000000000000h,2000000000000h,3000000000000h,4000000000000h

.code
main proc
	mov rdi,OFFSET intArray
	mov rcx,LENGTHOF intArray
	mov rax,0

L1:
	add rax,intArray[rdi]
	add rdi, TYPE intArray
	loop L1

	mov rcx,rax
	call  ExitProcess
main endp
end

; AddTwoSum_64.asm - Chapter 3 example.
ExitProcess PROTO
WriteInt64 PROTO
Crlf PROTO

.code
main PROC
	sub rsp,8
	sub rsp, 20h


	mov rcx,2
	mov rdx,4
	mov r8,8
	mov r9, 16
	call AddFour
	call WriteInt64
	call Crlf

	add rsp, 28
	mov ecx,0
	ret 
main endp

AddFour PROC
	mov rax,rcx
	add rax,rdx
	add rax,r8
	add rax,r9
	ret
AddFour ENDP

end

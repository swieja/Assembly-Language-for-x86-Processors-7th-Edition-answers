INCLUDE Irvine32.inc

.data
sum DWORD 0
sample DWORD 50
array DWORD 10,60,20,33,72,89,45,65,72,18
arraySize = ($ - Array) / TYPE array

; edx = sample
; eax = sum
; esi = index
; ecx = ArraySize
.code
main PROC
	mov eax,0
	mov edx,sample
	mov esi,0
	mov ecx, arraySize

	L1:
		cmp esi,ecx
		jl L2
		jmp L5
	L2:
		cmp array[esi*4],edx
		jg L3
		jmp L4
	L3:
		add eax,array[esi*4]
	L4:
		inc esi
		jmp L1
	L5:
		mov sum,eax

		nop
main ENDP

END main

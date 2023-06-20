# Short Answer
## 1
```asm
	mov al,0D4h
	shr al,1 ; a = 06Ah

	mov al,0D4h
	sar al,1 ; b = 0EAh

	mov al,0D4h
	sar al,4 ; c = 0FDh

	mov al,0D4h
	rol al,1 ; d. = 0A9h
```
## 2
```asm
mov al,0D4h
	ror al,3 ; a. = 09Ah

	mov al,0D4h
	rol al,7 ; b. =  06Ah

	stc

	mov al,0D4h
	rcl al,1 ; c. = 0A9h

	stc

	mov al,0D4h
	rcr al,3 ; d. = 0A3h 
```

## 3
```asm
    mov dx,0
    mov ax,222h
    mov cx,100h
    mul cx
```
222h * 100h = 22200h
DX:AX
0002:2200
dx = 0002h
ax = 2200h

## 4
```asm
    mov ax,63h
    mov bl,10h
    div bl
```
ax = 0306h

## 5 
```asm
    mov eax,123400h
    mov edx,0
    mov ebx,10h
    div ebx
```
eax = 12340h , edx = 0000h

## 6
```asm
    mov ax,4000h
    mov dx,500h
    mov bx,10h
    div bx
```
The result is larger than the max value of 16 bit register so integer overflow error occur.

## 7
```asm
	mov bx,5
	stc
	mov ax,60h
	adc bx,ax
```

BX will be 0066h.

## 8
```asm
    .data
    dividend_hi QWORD 00000108h
    dividend_lo QWORD 33300020h
    divisor QWORD 00000100h
    .code
    mov rdx,dividend_hi
    mov rax,dividend_lo
    div divisor
```
Divisor needs to be bigger than rdx dividend, this is an integer overflow.

## 9
```asm
INCLUDE Irvine32.inc

.data
val1 QWORD 20403004362047A1h
val2 QWORD 055210304A2630B2h
result QWORD 0

.code
main PROC
	mov ecx,8 ; loop counter
	mov esi,0
	clc 
	top:
	mov al,BYTE PTR val1[esi] ; get first number
	sbb al,BYTE PTR val2[esi] ; subtract second
	mov BYTE PTR result[esi],al ; store the result
	inc esi
	loop top

	exit
main ENDP
END main
```

## 10
Hex should be
4 080C 1014 0000
RAX = 0004080C10140000

# Algorithm
## 1
```asm
INCLUDE Irvine32.inc

; Write a sequence of shift instructions that cause AX to be sign-extended into EAX
; In other words, the sign bit of AX is copied into the upper 16 bits of EAX.
; Do not use the CWD instruction.

.code
main PROC
	mov eax,0000FF60h ; eax  = -96

	shl eax,16
	sar eax,16
	; eax = FFFFFF60h
	
	exit
main ENDP
END main
```

## 2
```asm
INCLUDE Irvine32.inc

; Suppose the instruction set contained no rotate instructions. Show how would you use 
; SHR and a conditional jump instruction to rotate the contents of the AL register 1 bit to the right.

.code
main PROC
	shr al,1 ; al = 09, cf = 1 

	jc sethighestbit
	jmp next


sethighestbit:
	or al, 80h
	; mov al, 13h
	; ror al,1 ; al = 89, cf  = 1
	
next:
	exit

	exit
main ENDP
END main
```

## 3
```asm
INCLUDE Irvine32.inc

; Write a logical shift instruction that multiplies the contents of EAX by 16.

.code
main PROC
	mov eax, 4
	shl al,4 ; 4 * 2^4 = 4 * 16 = 64
	; al = 64

	nop
	exit
main ENDP
END main
```

## 4
```asm
INCLUDE Irvine32.inc

; Write a logical shift instruction that divides EBX by 4 

.code
main PROC
	mov ebx, 64
	shr bl,4 ; 64 / 2^4 = 64/16
	; bl = 4

	nop
	exit
main ENDP
END main
```

## 5
```asm
INCLUDE Irvine32.inc

; Write a single rotate instruction that exchanges the high and low halves of the DL register.

.code
main PROC
	mov dl, 48h
	mov al,dl

	rol dl,4
	;????????

	nop
	exit
main ENDP
END main
```

## 6
```asm
INCLUDE Irvine32.inc

; Write a single SHLD instruction that shifts the highest bit of the AX register into the lowest
; bit position of DX and shifts DX one bit to the left.

.code
main PROC
	xor ebx,ebx
	xor eax,eax

	mov ax, 09BA6h
	mov bx, 0AC36h

	shld bx,ax,4

	exit
main ENDP
END main
```

## 7
```asm
INCLUDE Irvine32.inc

; Write a sequence of instructions that shift three memory words to the left by 1 bit position
; Use the following test data: byteArray BYTE 81h,20h,33h

.data
byteArray BYTE 81h,20h,33h

.code
main PROC
	mov ecx, sizeof byteArray
	mov esi,0
	
	L1:
		shl byteArray[esi],1
		inc esi
		loop L1

	nop
	exit
main ENDP
END main
```

## 8
```asm
INCLUDE Irvine32.inc

; Write a sequence of instruction that shift three memory words to the left by 1 bit position
; Use the following test data: wordArray WORD 810Dh, 0C064h,93ABh

.data
wordArray WORD 810Dh, 0C064h,93ABh

.code
main PROC
	mov ecx, lengthof wordArray
	mov esi,0

	L1:
		shl wordArray[esi], 1
		add esi, TYPE wordArray
		loop L1
	
	exit
main ENDP
END main
```

## 9
```asm
INCLUDE Irvine32.inc

; Write instructions that multiply -5 by 3 and store the results in a 16 bit variable val1

.data
val1 word ?

.code
main PROC
	mov ax, -5
	imul ax,3
	mov val1,ax

	nop
	exit
main ENDP
END main
```

## 10
```asm
INCLUDE Irvine32.inc

; Write instructions that divide -276 by 10 and store the result in 16 bit variable val1

.data
val1 word ?

.code
main PROC
	mov ax, -276
	cwd	
	mov bx, +10
	idiv bx
	mov val1,ax

	nop
	exit
main ENDP
END main
```

## 11
```asm
INCLUDE Irvine32.inc

; Implement the following C++ expression in assembly language, using 32 bit unsigned operands
; val1 = (val2 * val3) / (val4 - 3)

.data
val1 DWORD ?
val2 DWORD 5d
val3 DWORD 7d
val4 DWORD 9d

.code
main PROC
	mov eax, val2
	imul eax,val3

	mov ecx, val4
	sub ecx, 3
	xor edx,edx
	div ecx

	mov val1, eax ; val1 = 5 



	nop
	exit
main ENDP
END main
```

## 12
```asm
INCLUDE Irvine32.inc

; Implement the following C++ expression in assembly language, using 32 bit unsigned operands
; val1 = (val2 / val3) * (val1 + val2)

.data
val1 DWORD 111d
val2 DWORD 100d
val3 DWORD 10d
val4 DWORD 9d

.code
main PROC
	xor edx,edx
	mov eax,val2
	mov ebx,val3
	idiv ebx
	push eax

	mov ebx,val1
	sub ebx,val2
	pop eax
	imul ebx
	mov val1,eax

	nop
	exit
main ENDP
END main
```
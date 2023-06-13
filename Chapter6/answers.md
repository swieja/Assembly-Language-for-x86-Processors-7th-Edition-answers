# Short Ansers
## 1
`6B`

## 2
`92`

## 3
`BB`

## 4
`A857`

## 5
`BFAFF69F`

## 6
`50509B64`

## 7
```asm
	mov al,01101111b
	and al, 00101101b ; a. 01101111

	mov al,6Dh
	and al,4Ah ; b. 48

	mov al,00001111b
	or al,61h ; c. 61

	mov al,94h
	xor al,37h ; d. A3
```

## 8
```asm
	mov al,01101111b
	and al,00101101b ; a. 01101111

	mov al,6Dh
	and al,4Ah ; b. 48

	mov al,00001111b
	or al,61h ; c. 6f

	mov al,94h
	xor al,37h ; d. a3

```

## 9
```asm
	mov al,00001111b
	test al,00000010b ; a. CY=0 ZR=0 PL=0e

	mov al,00000110b
	cmp al,00000101b ; b. CY=0 ZR=0 PL=0

	mov al,00000101b
	cmp al,00000111b ; c. CY=1 ZR=0 PL=1, we are subtracting 5 with 7 so the PL = 1
    ; if dst < src 
    ;       CF = 1
```

## 10
JECXZ
## 11
Both JA and JNBE require CF and ZF flag to be cleared.
## 12
```asm
	mov edx,1
	mov eax,7FFFh
	cmp eax,8000h
	jl L1
	mov edx,0
L1:
```
jl will execute because SF<>OF
so edx = 1

## 13
```asm
INCLUDE Irvine32.inc	


.code 
main PROC
	
	mov edx,1
	mov eax, 7FFFh
	cmp eax, 8000h
	jb L1
	mov edx,0
L1:

; JB will execute because CF will be set to 1 after cmp, so edx = 1
; CF gets set to 1 because in cmp dst<src

	exit
main ENDP
END main
```

## 14
```asm
INCLUDE Irvine32.inc	


.code 
main PROC
	
	mov edx,1
	mov eax,7FFFh
	cmp eax,0FFFF8000h
	jl L2
	mov edx,0

L2:
 ; if SF<>OF : jl L2
 ; sf = 0
 ; of = 0
 ; edx = 0
	exit
main ENDP
END main
```
## 15
```asm
INCLUDE Irvine32.inc	


.code 
main PROC
	
	mov eax,-30
	cmp eax,-50
	jg Target
	nop

Target:
	nop
; jg occurs when zf = 0 and sf = OF
; zf will be 0, so will sf = of 
; True
	exit
main ENDP
END main
```
## 16
```asm
INCLUDE Irvine32.inc	


.code 
main PROC
	
	mov eax,-42
	cmp eax,26
	je Target
	nop

Target:
	nop
;  je will execute if ZF = 1, but it won't 
; False
	exit
main ENDP
END main
```
## 17
80h
## 18
808080h
## 19
80808080h

# Algo
## 1 
```asm
INCLUDE Irvine32.inc	

;Write a single instruction that converts an ASCII digit in AL to its corresponding binary
;value. If AL already contains a binary value (00h to 09h), leave it unchanged.

.data
tru byte  "al is a digit",0
fals byte "al is not a digit",0

.code 
main PROC
	
	mov al, 0FFh
	jb not_digit
	sub al,30h
	
	; flag
not_digit:
	mov edx,offset fals
	call WriteString
	call Crlf
	exit


	mov edx,offset tru
	call WriteString 
	call Crlf
	exit
main ENDP
END main
```
## 2 
```asm
INCLUDE Irvine32.inc	

; Write instructions that calculate the parity of a 32-bit memory operand. Hint: Use the for-
; mula presented earlier in this section: B0 XOR B1 XOR B2 XOR B3.

.data
memval DWORD 2045

.code 
main PROC
	mov eax,memval

	xor al, BYTE PTR memval + 1
	xor al, BYTE PTR memval + 2
	xor al, BYTE PTR memval + 3

	exit
main ENDP
END main
```

## 4
```asm
INCLUDE Irvine32.inc	

; Write instructions that jump to label L1 when the unsigned integer in DX is less than or
; equal to the integer in CX.

.data
val1 word -50
val2 word 22

.code 
main PROC
	mov dx, val1
	mov cx, val2
	cmp dx,cx ; sub dx - cx ;  -40 - 39
	jbe L1 ; CY = 0 or ZR = 1 

L1:
	call Crlf
	
	exit
main ENDP
END main
```

## 5
```asm
INCLUDE Irvine32.inc	

; Write instructions that jump to label L2 when the signed integer in AX is greater than the
; integer in CX.

.data
val1 word 120
val2 word -30


.code 
main PROC
	mov ax,50
	mov cx,120
	cmp ax,cx ; ax - cx ; 
	jle L2 ; ZF=1 or SF<>OF

L2:
	call Crlf

	exit
main ENDP
END main
```

## 6
```asm
INCLUDE Irvine32.inc	

; Write instructions that first clear bits 0 and 1 in AL. Then, if the destination operand is equal
; to zero, the code should jump to label L3. Otherwise, it should jump to label L4.

.data


.code 
main PROC
	xor al,al
	cmp al,0
	jz L3
	jnz L4

L3:
	nop ; jump if al = 0
	exit

L4:
	nop ; jump if al != 0
	exit

	exit
main ENDP
END main
```

## 7
```asm
.data
val1 DWORD ? 
X DWORD ? 

.code 
main PROC
	cmp val1, ecx
	jg L1

L1:
	cmp ecx,edx
	jg L2
	jng L3
	jmp next

L2:
	mov X,1
	jmp next
	
L3:
	mov X,2
	jmp next

next:
	exit
main ENDP
```

## 8 
```asm
INCLUDE Irvine32.inc	

; Implement the following pseudocode in assembly language. Use short-circuit evaluation
; and assume that X is a 32-bit variable.
; if( ebx > ecx ) OR ( ebx > val1 )
; 	X = 1
; else
; 	X = 2
; assume we are doing unsigned comparison

.data
val1 DWORD 0FFFFFFFFh
X DWORD ? 

.code 
main PROC

	cmp ebx,ecx
	ja L1
	cmp ebx,val1
	ja L1
	jna L2

L1:
	mov X,1
	jmp next

L2:
	mov X,2
	jmp next

next:
	exit
main ENDP
END main
```

## 9
```asm
INCLUDE Irvine32.inc	

; Implement the following pseudocode in assembly language. Use short-circuit evaluation
; and assume that X is a 32-bit variable.
; if( ebx > ecx AND ebx > edx) OR ( edx > eax )
;	X = 1
; else
;	X = 2
; assume we are doing unsigned comparison

.data
val1 DWORD 0FFFFFFFFh
X DWORD ? 

.code 
main PROC

	cmp ebx,ecx ; ebx > ecx AND 
	ja L1
	jna L2

L1:
	cmp ebx,edx ; AND ebx > edx
	ja L3 ; if the first cmp in the beginning of MAIN proc is true, and the one in L1 was true, we dont need to check OR, so we just jump to statement that moves 1 to X 
	jna L2 ; if either returns FALSE, we jump to edx > eax which is OR 

L2:
	cmp edx,eax ; OR edx > eax
	ja L3 ; if OR returns true, we jump to statement 
	jna L4

L3:
	mov X,1
	jmp next

L4:
	mov X,2
	jmp next

next: 
	nop
	exit
main ENDP
END main
```

## 10
```asm
.data
A DWORD 15
B DWORD 30
N DWORD 15

.code 
main PROC
	mov eax, A 
	mov ebx, B
	mov edx, N

L1:
	cmp edx, 0 ; while N > 0
	jg L2
	jmp next

L2:
	cmp edx,3 ; if N != 3 AND
	je L5
	jmp L3

L3: ; AND (N < A OR N > B)
	cmp edx,eax 
	jng L4
	cmp edx,ebx
	jg L4
	jmp L5
	

L4:
	sub edx,2 ; N = N -2
	jmp L1

L5:
	sub edx,1 ; N = N -1
	jmp L1

next:
	exit

main ENDP
```


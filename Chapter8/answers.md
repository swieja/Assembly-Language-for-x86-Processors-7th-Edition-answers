# Algorithm
## 1
Here is a calling sequence for a procedure named AddThree that adds three doublewords
(assume that the STDCALL calling convention is used):
push 10h
push 20h
push 30h
call AddThree
Draw a picture of the procedure’s stack frame immediately after EBP has been pushed on
the runtime stack.

```asm
main PROC
	
	push 10h
	push 20h
	push 30h
	call AddThree

	exit
main ENDP

AddThree PROC
	push ebp
	mov ebp,esp

	mov ecx, [ebp + 8]
	mov ecx, [ebp + 12]
	mov ecx, [ebp + 16]

	pop ebp 
	ret
AddThree ENDP
```

```
push ebp 
mov ebp,esp

<lower memory address>
ebp
return address
parameter 30h (ebp + 8) 0x0019FF68
parameter 20h (ebp + 12) 0x0019FF6C
parameter 10h (ebp + 16) 0x0019FF70

<higher memory address>
```

## 2 
```asm
INCLUDE Irvine32.inc

; Create a procedure named AddThree that receives three integer parameters and calculates
; and returns their sum in the EAX register

.code
main PROC
	
	push 10d
	push 20d
	push 30d

	call AddThree

	exit
main ENDP
AddThree PROC
	push ebp
	mov ebp,esp
	xor eax,eax

	add eax,[ebp + 8]
	add eax,[ebp + 12]
	add eax,[ebp + 16]

	
	call WriteInt
	call Crlf
	pop ebp
	ret
AddThree ENDP


END main
```

## 3 
Declare a local variable named pArray that is a pointer to an array of doublewords
```asm
LOCAL pArray:PTR DWORD
```

## 4 
Declare a local variable named buffer that is an array of 20 bytes.
```asm
LOCAL buffer[20]:BYTE
```

## 5
Declare a local variable named pwArray that points to a 16-bit unsigned integer
```asm
LOCAL pwArray:PTR WORD 
```

## 6
Declare a local variable named myByte that holds an 8-bit signed integer
```asm
LOCAL myByte:SBYTE
```
## 7
Declare a local variable named myArray that is an array of 20 doublewords
```asm
LOCAL myArray[20]:DWORD
```
## 8
Create a procedure named SetColor that receives two stack parameters: forecolor and back-
color, and calls the SetTextColor procedure from the Irvine32 library.
```asm
INCLUDE Irvine32.inc

; Create a procedure named SetColor that receives two stack parameters: forecolor and back-
; color, and calls the SetTextColor procedure from the Irvine32 library.
.data
someText BYTE "This should be coloured",0
.code
main PROC
	push yellow
	push blue*16
	call SetColor

	exit
main ENDP

SetColor PROC
	push ebp
	mov esp,ebp

	mov eax, [ebp + 8]
	add eax, [ebp + 12]

	call SetTextColor
	
	mov edx,offset someText
	call WriteString

	nop
	pop ebp
    ret
SetColor ENDP
END main
```
## 9
```asm
INCLUDE Irvine32.inc

; Create a procedure named WriteColorChar that receives three stack parameters: char,
; forecolor, and backcolor. It displays a single character, using the color attributes specified in
; forecolor and backcolor.

.data

.code
main PROC
main endp

	push 41h
	push yellow
	push blue*16
	call WriteColorChar

	exit
WriteColorChar PROC
	push ebp
	mov ebp,esp

	mov eax, [ebp+12]
	add eax, [ebp+8]
	call SetTextColor

	mov eax, [ebp+16] 
	call WriteChar

	pop ebp
	ret
WriteColorChar ENDP
END main
```

## 10

```asm
INCLUDE Irvine32.inc

; Write a procedure named DumpMemory that encapsulates the DumpMem procedure in the
; Irvine32 library. Use declared parameters and the USES directive. The following is an
; example of how it should be called: INVOKE DumpMemory, OFFSET array, LENGTHOF
; array, TYPE array.

DumpMemory PROTO offsetArray: DWORD,  lengthArray: DWORD, typeArray: WORD
.data
array WORD 8,9,10,11,0FFFFh

.code
main PROC
	INVOKE DumpMemory	, offset array, lengthof array, type array
	nop
	exit
main ENDP

DumpMemory PROC USES esi ecx ebx, offsetArray: DWORD,  lengthArray: DWORD, typeArray: WORD
	mov esi, offsetArray
	mov ecx, lengthArray
	mov  ebx, DWORD PTR typeArray
	call DumpMem

	ret
DumpMemory ENDP
END main
```
## 11
```asm
INCLUDE Irvine32.inc

; Declare a procedure named MultArray that receives two pointers to arrays of doublewords,
; and a third parameter indicating the number of array elements. Also, create a PROTO dec-
; laration for this procedure.

MultArray PROTO pArray1: PTR DWORD, pArray2: PTR DWORD, arrayLength: DWORD

.data
array1 DWORD 0,1,2,3,4
array2 DWORD 5,6,7,8,9

.code
main PROC
	INVOKE MultArray, offset array1, offset array2, lengthof array1
	
	exit
main ENDP

MultArray PROC USES esi ebx ecx, pArray1: PTR DWORD, pArray2: PTR DWORD, arrayLength: DWORD
		
	mov esi, pArray1
	mov ebx, pArray2
	mov ecx, arrayLength

	push ecx
	L1:
		mov eax, [esi]	
		call WriteInt
		mov eax,','
		call WriteChar
		add esi, type DWORD
		loop L1

	call Crlf
	pop ecx
	L2:
		mov eax, [ebx]
		call WriteInt
		mov eax,','
		call WriteChar
		add ebx, type DWORD
		loop L2


	ret
MultArray ENDP
END main
```
INCLUDE Irvine32.inc	

.data
;Create a procedure named CalcGrade that receives an integer value between 0 and 100, and
;returns a single capital letter in the AL register. Preserve all other register values between calls
;to the procedure. The letter returned by the procedure should be according to the following
;ranges:

;Write a test program that generates 10 random integers between 50 and 100, inclusive. Each
;time an integer is generated, pass it to the CalcGrade procedure. You can test your program
;using a debugger, or if you prefer to use the book’s library, you can display each integer and its
;corresponding letter grade. (The Irvine32 library is required for this solution program because it
;uses the RandomRange procedure.)

TAB = 9
A_grade = 65 
B_grade = 66
C_grade = 67 
D_grade = 68 
F_grade = 70 

.data
score DWORD ?
promptScore BYTE "Score: ",0
promptGrade BYTE "Letter Grade: ",0


.code 
main PROC

	mov ecx,10 ; how many integers we want to generate and run the CalcGrade procedure

	mov edx ,offset promptScore
	call WriteString 
	mov al,TAB
	call WriteChar

	mov edx ,offset promptGrade
	call WriteString 
	call Crlf

L1:
	mov eax,100
	call RandomRange
	cmp eax,50
	jbe L1
	mov score,eax
	call CalcGrade
	LOOP L1

	exit
main ENDP

CalcGrade PROC


L1:
	cmp score, 59
	jna grade_F
	cmp score,69
	jna grade_D
	cmp score,79
	jna grade_C
	cmp score,89
	jna grade_B
	cmp score,100
	jna grade_A
	jmp next

grade_A: 
	mov al,	A_grade
	call print
	jmp next
grade_B: 
	mov al,	B_grade
	call print
	jmp next
grade_C: 
	mov al,	C_grade
	call print
	jmp next
grade_D: 
	mov al,	D_grade
	call print
	jmp next
grade_F: 
	mov al,	F_grade
	call print
	jmp next


next:
	ret
CalcGrade ENDP

print PROC
	call WriteChar 
	mov al, TAB
	call WriteChar 
	call WriteChar 
	mov eax,score
	call WriteInt
	call Crlf
	ret
print ENDP

end main
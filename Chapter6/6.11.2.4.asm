INCLUDE Irvine32.inc

; Using the College Registration example from Section 6.7.3 as a starting point, do the following:
; • Recode the logic using CMP and conditional jump instructions (instead of the .IF and
; .ELSEIF directives).
; • Perform range checking on the credits value; it cannot be less than 1 or greater than 30. If an
; invalid entry is discovered, display an appropriate error message.
; • Prompt the user for the grade average and credits values.
; • Display a message that shows the outcome of the evaluation, such as “The student can regis-
; ter” or “The student cannot register”.
; (The Irvine32 library is required for this solution program.)

.data
TRUE = 1
FALSE = 0
gradeAverage DWORD ? 
credits DWORD ?
okToRegister BYTE ? 
promptGrade BYTE "Please enter the grade : ",0
promptCredits BYTE "Please enter the credits between range 1 and 30: ",0
studentPassed BYTE "This student can register.",0
studentNotPassed BYTE "This student cannot register.",0

.code
main PROC
	mov okToRegister, FALSE

	call getGrade
	call getCredits
	call pass

	exit
main ENDP

getGrade PROC
		
		mov edx, offset promptGrade
		call WriteString
		call ReadInt
		mov gradeAverage, eax
		
		ret
getGrade ENDP

getCredits PROC 
	mov edx, offset promptCredits

next:
	call WriteString
	call ReadInt
	cmp eax,1
	jna next
	cmp eax,30
	ja next
	mov credits,eax


	ret
getCredits ENDP



; promptGrade BYTE "Please enter the grade : ",0
; promptCredits BYTE "Please enter the credits between range 1 and 30: ",0
; studentPassed BYTE "This student can register.",0
; studentNotPassed BYTE "This student cannot register.",0

pass proc

	mov eax,gradeAverage
	mov ebx, credits

	cmp eax, 350
	ja passed
	cmp eax, 250
	ja l_check_grade_credits
	cmp ebx, 12
	JBE passed
	jmp notPassed

l_check_grade_credits:
	cmp ebx,16
	JBE passed
	jmp notPassed

passed:
	mov okToRegister,TRUE
	mov edx, offset studentPassed
	jmp next

notPassed:
	mov edx, offset studentNotPassed
	jmp next
	
next:
	call WriteString
	ret
pass endp	

END main
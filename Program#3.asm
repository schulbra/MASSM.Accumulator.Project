TITLE Project #3     (Program#3.asm)

; Author:Brandon Schultz
; Last Modified: 10-30-19
; OSU email address: bschultz@tmcc.edu
; Course number/section: CS 271 400 Fall 2019
; Project Number: Three                Due Date: 11-3-19
; Description: Contains MASM program that:
; Prompts user to enter a series of negative values that are counted, accumulated and
; displayed until a positive value is entered. Then, the avg of these negative values
; is calculated and displayed to the user. 
; Also contains intro/farwell prompts and methods for obtaining username and input
; validaiton for - and + input values.

INCLUDE Irvine32.inc

; Constant for lower limit (-150) defined.
LOWER_LIMIT = -150

.data

	programmerName					BYTE	"Brandon Schultz ", 0
	programTitle					BYTE	"CS_271 - Negative Numbers Sum and Mean Calculator", 0
	ec_prompt						BYTE    "**ec#1: Lines are numbered and displayed.", 0
	userNamePrompt					BYTE	"Enter a username: ", 0
	userName						BYTE	21 DUP(0)
	userNameSize					DWORD	?
	userNamePromptGreeting			BYTE	"Hello, ", 0
	programInstructionsPrompt		BYTE	"This program obtains the mean value for a sum of numbers between -150 and -1.", 0
	getUserInputValue				BYTE	"Enter individual numbers between -150 and -1 in the prompts below: ", 0
	inputValidationLess150Prompt	BYTE	"Value entered is out of range [ -150, -1 ]. ", 0
	numberEC1String					BYTE	"Enter Number Input # ",0
	semicolonEC2							BYTE	": ",0
	userInputNumberChoice			DWORD	?
	validUserInputNumSum			DWORD	0
	numEntries						DWORD	1
	inputValidationNoNumsPrompt		BYTE	"No input values detected, silly!", 0
	outputTotalNumsInputPrompt1		BYTE	"Total # of Valid Values Entered: ", 0
	ouputTotalNumsInputPrompt2		BYTE	" Numbers.", 0
	sum								BYTE	"Total Valid Inputs: ",0
	mean							BYTE	"Mean of Valid Inputs: ",0
	negativeSign					BYTE	"-",0
	farewellPrompt1					BYTE	"Thanks for playing, ",0
	farewellPrompt2					BYTE	"! Don't forget me.",0

.code
main PROC

	; Displays the program title and programmer’s name.
	 call		programmerIntro	
	 mov		edx, OFFSET ec_prompt
	 call		WriteString
	 call		Crlf
	 call		Crlf

	; Obtains the user’s name, and greets  user.
	 call		getName				
	 call		greetUser			

	; Methods for displaying programs instructions.
	 call		instructionInfoForUser
	 call		Crlf

	; Methods for obtaining user's initial number input,
	; and prompting for additional input values if a - value
	; was previously input.
	 negNumLoop:
	 mov		edx, OFFSET numberEC1String
	 call		WriteString
	 mov		eax, numEntries
	 call		WriteDec
	 mov		edx, OFFSET semicolonEC2
	 call		WriteString
	 call		ReadInt

	; Input Validation to check if input is - or +,
	; then within valid [-1 -150] range.
	 mov		userInputNumberChoice, eax
	 cmp		userInputNumberChoice, 0
	 jge		loopEnd
	 cmp		userInputNumberChoice, LOWER_LIMIT
	 jae		validUserInputNegNum
	 jmp		invalidUserInputUnder150

	; If after validating input and value is in range, +1 to total sum
	; of valid, - input choices. Lead into prompt instructing user for
	; next input.
	 validUserInputNegNum:
	 mov		eax, userInputNumberChoice
	 neg		eax
	 add		validUserInputNumSum, eax
	 inc		numEntries
	 jmp		negNumLoop

	; Invalid user input (< -150) ends loop/program depending
	; on previous (if any) input values.
	 invalidUserInputUnder150:
	 mov		edx, OFFSET inputValidationLess150Prompt
	 call		WriteString
	 call		Crlf
	 jmp		negNumLoop

	; Used in ending loop after displaying to the user the sum of input 
	; items and mean of said items if multiple, valid inputs were entered. 
	; Will also prompt user if no valid input was entered. Calls user "silly".
	; Program then ends.
	 loopEnd:
	 cmp		numEntries, 1
	 je			emptyInput
	 mov		edx, OFFSET outputTotalNumsInputPrompt1
	 call		WriteString
	 mov		eax, numEntries
	 dec		eax
	 call		WriteDec
	 mov		edx, OFFSET ouputTotalNumsInputPrompt2
	 call		WriteString
	 call		Crlf
	 call		displaySum
	 call		displayMean
	 jmp		endProgram
	 mov		edx, OFFSET inputValidationNoNumsPrompt
	 call		WriteString
	 call		Crlf

	 emptyInput:
	 mov		edx, OFFSET inputValidationNoNumsPrompt
	 call		WriteString
	 call		Crlf

	 endProgram:
	 call		bidUserFarewell
	 exit

	main ENDP
	; Introduces programmar to user.
	 programmerIntro PROC USES edx
	 mov		edx, OFFSET programTitle
	 call		WriteString
	 call		Crlf
	 mov		edx, OFFSET programmerName
	 call		WriteString
	 call		Crlf
	 ret
	 programmerIntro ENDP

	; Obtains input for username variable.
	 getName PROC USES eax ecx edx
	 mov		edx, OFFSET userNamePrompt
	 call		WriteString
	 mov		edx, OFFSET userName
	 mov		ecx, SIZEOF	userName
	 call		ReadString
	 mov		userNameSize, eax
	 call		Crlf
	 ret
	 getName ENDP

	; Methods for greeting user by name, then move on to programs directions.
	 greetUser PROC USES edx
	 mov		edx, OFFSET userNamePromptGreeting
	 call		WriteString
	 mov		edx, OFFSET userName
	 call		WriteString
	 call		Crlf
	 call		Crlf
	 ret
	greetUser ENDP

	; Program directions regarding valid/invalid input displayed to user.
	 instructionInfoForUser PROC USES edx
	 mov		edx, OFFSET programInstructionsPrompt
	 call		WriteString
	 call		Crlf
	 mov		edx, OFFSET getUserInputValue
	 call		WriteString
	 call		Crlf
	 ret
	 instructionInfoForUser ENDP

	; Methods for displaying total # of - items entered by user, to user.
	 displaySum PROC USES eax edx
	 mov		edx, OFFSET sum
	 call		WriteString
	 mov		edx, OFFSET negativeSign
	 call		WriteString
	 mov		eax, validUserInputNumSum
	 call		WriteDec
	 call		Crlf
	 ret
	 displaySum ENDP

	; Procedure for displaying mean of valid input nums to user.
	 displayMean PROC USES eax ebx edx 
	 mov		edx, OFFSET mean
	 call		WriteString
	 mov		edx, OFFSET negativeSign
	 call		WriteString
	 dec		numEntries
	 mov		ebx, numEntries
	 xor		edx, edx
	 mov		eax, validUserInputNumSum
	 div		ebx
	 call		WriteDec
	 call		Crlf
	 ret
	 displayMean ENDP

 ; Methods for saying goodbye to user and exiting program.
	 bidUserFarewell PROC USES edx
	 mov		edx, OFFSET farewellPrompt1
	 call		WriteString
	 mov		edx, OFFSET userName
	 call		WriteString
	 mov		edx, OFFSET farewellPrompt2
	 call		WriteString
	 call		Crlf
	 ret
	 bidUserFarewell ENDP

END main

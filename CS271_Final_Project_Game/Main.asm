TITLE Tic Tac Toe

; Link to github code: 
; Tic-Tac-Toe created in MASM x86. 


; Registers used in the program: 	
	;1)	eax, esi, edx, ecx, 
	
; Classification of registers:
	;1) EDX: Used to display text instructions
	
; Procedures:
	;1)	Main Procedure

	
; Problems with game:

INCLUDE Irvine32.inc

.const
	max			DWORD		9		;This is for the loop (mov ECX, max) in restBoard PROC				
	empty		BYTE        " ",0
	letterO     BYTE        "O",0
	letterX     BYTE        "X",0

MAX_SIZE = 9	;Size of array that keeps track of the O/X/Empty spaces on the board

.data
	intro		BYTE		"WELCOME TO TIC TAC TOE",0		;intro text for the game
	board       DWORD       MAX_SIZE	DUP(?)				;This will be the array that will keep track of which spots have O/X/Empty || Empty = 0 || O = 1 || X = 2
	horizontal  BYTE        "|",0
	vertical    BYTE        "-----"


.code
main PROC
	introduction:
		mov EDX, OFFSET intro
		call WriteString
		call crlf
		call resetBoard
		call displayBoard




		exit
main ENDP

resetBoard PROC						;This procedure is responsible of making all values on the board empty(0)
	mov ECX, max					;Make ECX = 9 which how many times loop needs to reiterate to reset the board
	mov ESI, 0						;Start ESI = 0 which is the starting index of the array
	insertZero:						;Loop that makes board[ESI] = 0
		mov board[ESI], 0			;Make board [ESI] = 0
		add ESI, 4					;Make ESI increase to the next index of the array
		loop insertZero				;End of loop
	ret								;Returns back to the main procedure
resetBoard ENDP						;End of resetBoard procedure

displayBoard PROC					;This procedure will display the current values on the tictactoe board
	mov ECX, 3						;Make ECX = 3 which how many times the display loop will run
	mov ESI, 0						;Start ESI = 0 which is the starting index of the array
	display:						;Loop that will print out a row (3 values from the board)
		mov	EAX, board[ESI]			;Make EAX = board[ESI] = 0/1/2
		call convert				;Call covert to print out / /O/X/
		mov EDX, OFFSET horizontal	;Make EDX = '|'
		call WriteString			;Print horizontal bar of the tictactoe board

		add ESI, 4					;Make ESI increase to the next index of the array
		mov EAX, board[ESI]			;Make EAX = board[ESI] = 0/1/2
		call convert				;Call covert to print out / /O/X/
		mov EDX, OFFSET horizontal  ;Make EDX = '|'
		call WriteString			;Print horizontal bar of the tictactoe board

		add ESI, 4					;Make ESI increase to the next index of the array
		mov EAX, board[ESI]			;Make EAX = board[ESI] = 0/1/2
		call convert				;Call covert to print out / /O/X/

		call crlf					;Start on the next command line		
		mov EDX, OFFSET vertical	;Make EDX = '-----'
		call WriteString			;Print vertical bar of the tictactoe board
		call crlf					;Start on the next command line

		add ESI, 4					;Make ESI increase to the next index of the array

		loop display				;End of loop
	ret								;Return to main

displayBoard ENDP

convert PROC						;This procedure will use compare statements to decide what needs printed on the board. If EAX = 0, then ' ' . If EAX = 1, then 'O'. If EAX = 2, then 'X'  
	cmp EAX, 0						;Comparing EAX and 0
	je printEmpty					;If EAX = 0, then jump to printEmpty
	cmp EAX, 1						;Comparing EAX and 1
	je printO						;If EAX = 1, then jump to printO
	cmp EAX, 2						;Comparing EAX and 2
	je printX						;If EAX = 2, then jump to printX
	ret								;Return to displayBoard

	printEmpty:						;Prints ' '
		mov EDX, OFFSET empty		;Make EDX = ' '
		call WriteString			;Print EDX
		ret							;Return to displayBoard

	printO:							;Prints '0'
		mov EDX, OFFSET letterO		;Make EDX = 'O'
		call WriteString			;Print EDX
		ret							;Return to displayBoard

	printX:							;Prints 'X'
		mov EDX, OFFSET letterX		;Make EDX = 'X'
		call WriteString			;Print EDX
		ret							;Return to displayBoard

convert ENDP						;End of covert procedure


END main

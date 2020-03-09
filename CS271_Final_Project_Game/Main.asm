TITLE Tic Tac Toe

; Link to github code: 
; Tic-Tac-Toe created in MASM x86. 


; Registers used in the program: 	
	;1)	eax, esi, edx, ecx, ebx
	
; Classification of registers:
	;1) EDX: Used to display text instructions
	;2) EAX: Used grab data from board[ESI]
	;3) ESI: Used for the index value of board[ESI]
	;4) ECX: Used for loops
	;5) EBX: Used as flag to indicate if user input is valid in main

; Procedures:
	;1)	Main Procedure
	;2) ResetBoard Procedure
	;3) DisplayBoard Procedure
	;4) Convert Procedure

; Problems with game:

INCLUDE Irvine32.inc

.const
	max			DWORD		9		;This is for the loop (mov ECX, max) in restBoard PROC				
	empty		BYTE        " ",0	;Represents an empty spot on the board
	letterO     BYTE        "O",0	;Represents a "O" spot on the board
	letterX     BYTE        "X",0	;Represents a "X" spot on the board
	indexSize   DWORD       4       ;Used to represent 4 bytes/1 index.
	valueZero   DWORD       0		;Used in checkBoard loop to see if board[] has any empty spaces
MAX_SIZE = 9	;Size of array that keeps track of the O/X/Empty spaces on the board

.data
	intro		BYTE		"WELCOME TO TIC TAC TOE",0		;Intro text for the game
	prompt1		BYTE        "Enter a number to choose where you want to mark on the board",0
	prompt2	    BYTE        "TOP-LEFT:0 TOP-MID:1 TOP-RIGHT:2",0
	prompt3	    BYTE        "MID-LEFT:3 MID-MID:4 MID-RIGHT:5",0
	prompt4     BYTE        "BOT-LEFT:6 BOT-MID:7 BOT-RIGHT:8",0
	promptInvalid BYTE      "The number you entered is not a valid input. Enter a new number",0
	board       DWORD       MAX_SIZE	DUP(?)				;This will be the array that will keep track of which spots have O/X/Empty || Empty = 0 || O = 1 || X = 2
	vertical    BYTE        "|",0							;Vertical bar that is part of the board
	horizontal  BYTE        "-----"							;Horizontal bar that is part of the board
	playerChoice DWORD      ?       
	outro       BYTE        "Games is over", 0
.code
main PROC
	introduction:
		mov EDX, OFFSET intro
		call WriteString
		call crlf
		call resetBoard

	prompt:
		mov EDX, OFFSET prompt1
		call WriteString
		call crlf
		mov EDX, OFFSET prompt2
		call WriteString
		call crlf
		mov EDX, OFFSET prompt3
		call WriteString
		call crlf
		mov EDX, OFFSET prompt4
		call WriteString
		call crlf
		call displayBoard

	checkBoard:
		call fullBoard
		cmp EBX, 1
		je ending
	
	userInteraction:
		call ReadInt
		call checkInteger

		cmp EBX, 1					;Comparison EBX == 1. This comparison indicates if the user's input is valid. If EBX = 1, then input is not valid 
		je userInteraction			;Jump back to begining of userInteraction to ask for a new input from user

		call addToBoard
		call displayBoard
		jmp checkBoard
	ending:
		mov EDX, OFFSET outro
		call WriteString
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
		mov EDX, OFFSET vertical	;Make EDX = '|'
		call WriteString			;Print horizontal bar of the tictactoe board

		add ESI, 4					;Make ESI increase to the next index of the array
		mov EAX, board[ESI]			;Make EAX = board[ESI] = 0/1/2
		call convert				;Call covert to print out / /O/X/
		mov EDX, OFFSET vertical    ;Make EDX = '|'
		call WriteString			;Print horizontal bar of the tictactoe board

		add ESI, 4					;Make ESI increase to the next index of the array
		mov EAX, board[ESI]			;Make EAX = board[ESI] = 0/1/2
		call convert				;Call covert to print out / /O/X/

		call crlf					;Start on the next command line		
		mov EDX, OFFSET horizontal	;Make EDX = '-----'
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

checkInteger PROC					;This procedure will determine if the player's input is valid to mark. It will look at board[ESI] at the index of EAX to determine if it is valid
	outOfBounds:                    ;Will check if playerChoice is between [0-8]
		cmp EAX, 0					;Compare EAX < 0
		jl notValid					;If EAX < 0, then jump to notValid
		cmp EAX, 8					;Compare EAX > 8
		jg notValid					;If EAX > 8, then jump to notValid

	moveIndex:						;Will convert input from user to the proper index for board[].(If user input was 2, then will change it to 8 grab from Board[8] also known as index 2)
		mul indexSize				;Make EAX * 400

	checkBoard:						;Will check if board[EAX] has data. If board[EAX] = 1 or 2 (O or X), then jump to notValid
		cmp board[EAX], 1			;Compare board[EAX] == 1
		je notValid					;If board[EAX] = 1, then jump to notValid
		cmp board[EAX], 2			;Compare board[EAX] == 2
		je notValid					;If board[EAX] = 2, then jump to notValid
		jmp isValid					;The input from user is valid, jump to isValid

		
	notValid:						;Will tell user that their input is not vaild and will make EBX = 1 to indicate it is not valid in main
		mov EBX, 1                  ;Make EBX = 1
		mov EDX, OFFSET promptInvalid	;Make EDX = 'The number you entered is not a valid input. Enter a new number'
		call WriteString				;Print promptInvalid
		call crlf						;Start on the next command line
		ret								;Will jump to userInteraction in main 

	isValid:						;Will make EBX = 0 to indicate that the user's input is valid in main
		mov EBX, 0					;Make EBX = 0
		ret							;Will jump to userInteraction in main 
checkInteger ENDP					;End of check Integer procedure

addToBoard PROC						;This procedure will add 1 (also known as O) to board[EAX]. Make sure EAX is the index value and not a spot value (Ex. If user want to input TOP-RIGHT:3, then EAX needs to be 12)
	mov board[EAX], 1				;Makes board[EAX] = 1 (also know as O)
	ret								;return to main
addToBoard ENDP						;End of addToBoardProcedure

fullBoard PROC
	mov EBX, 0
	mov ESI, 0
	mov ECX, max
	
	checkBoard:						;Will go through each index of board[] to see if a spot is empty.
		cmp board[ESI], EBX			;Since 0 represents an empty spot on the board, it will be used to compare if board[ESI] == 0
		je boardNotFull
		add ESI, 4
		loop checkBoard	
		jmp boardIsFull


	boardIsFull:
		mov EBX, 1
		ret
	
	boardNotFull:
		mov EBX, 0
		ret

fullBoard ENDP

END main

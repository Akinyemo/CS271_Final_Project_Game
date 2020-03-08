TITLE Tic Tack Toe

; Link to github code: https://github.com/itzzhammy/Snake_Xenia_Game_Assembely_Language
; Snake game created in MASM x86. 


; Registers used in the program: 	
	;1)	eax, esi, edx, ebx, ecx, 
	
; Classification of registers:
	;1) EDX: Used to display text instructions
	
; Procedures:
	;1)	Main Procedure

	
; Problems with game:

INCLUDE Irvine32.inc

.const
	max			DWORD		3		;This is for the loop (mov ECX, max) in restBoard PROC				



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

resetBoard PROC					;This procedure is responsible of making all values on the board empty(0)
	mov ECX, max				;Will make ECX = 9 which how many times loop needs to reiterate to reset the board
	mov ESI, 0
	insertZero:					;Loop that will make board[ESI] = 0
		mov board[ESI], 0		;Will make board [ESI] = 0
		add ESI, 4				;Will make ESI increase to the next index of the array
		loop insertZero			;End of loop
	ret		
resetBoard ENDP

displayBoard PROC
	mov ECX, max
	mov ESI, 0
	display:
		mov	EAX, board[ESI]
		call WriteDec
		mov EDX, OFFSET horizontal
		call WriteString

		add ESI, 4
		mov EAX, board[ESI]
		call WriteDec
		mov EDX, OFFSET horizontal
		call WriteString

		add ESI, 4
		mov EAX, board[ESI]
		call WriteDec

		call crlf
		mov EDX, OFFSET vertical
		call WriteString
		call crlf

		add ESI, 4

		loop display
	ret
displayBoard ENDP


END main

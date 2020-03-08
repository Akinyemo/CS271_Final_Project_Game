TITLE Tic Tack Toe

; Link to github code: https://github.com/itzzhammy/Snake_Xenia_Game_Assembely_Language
; Snake game created in MASM x86. 


; Registers used in the program: 	
	;1)	eax, esi, edx, ebx, ecx, 
	
; Classification of registers:

	
; Procedures:
	;1)	Main Procedure

	
; Problems with game:

INCLUDE Irvine32.inc

MAX_SIZE = 9	;Size of array that keeps track of the O/X/Empty spaces on the board	
.data
	intro		BYTE		"WELCOME TO TIC TAC TOE",0
	board       DWORD       MAX_SIZE 



.code
main PROC
	




		exit
main ENDP

END main

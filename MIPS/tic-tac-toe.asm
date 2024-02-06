.data
	takeTurn1Text: 	.asciiz "Please take a turn player 1\nThe board looks like this:\n"
	takeTurn2Text: 	.asciiz "Please take a turn player 2\nThe board looks like this:\n"
	promptText:  	.asciiz "Type the position where you want to place your mark! [1-9]\n"
	inputErrorText: 	.asciiz "Incorrect input. Please only type characters from 1 to 9\n"
	win1Text: 	.asciiz "Player 1 won the game!\n"
	win2Text: 	.asciiz "Player 2 won the game!\n"
	drawText: 	.asciiz "This game was draw\n"
	boardLineText:	.asciiz "+-+-+-+\n"
	boardLineEndText:.asciiz "|\n"
	boardSep:	.asciiz "|"
	boardEmpty:	.asciiz " "
	boardX:		.asciiz "X"
	boardO:		.asciiz "O"
	board:		.word 0:9
.text


li $s0, 0	# player_1_turn
la $s1, board 	# board, 0 = unset, 1 = X, 2 = O
li $s2, 0	# winner

loop:
	# check win
	li $t0, 0 # i
	checkHWin:
		bgt $t0, 2, checkVWin
		# check horizontal
		mul $t1, $t0, 12 		# $t1 = i*3*4
		lw $t2, board($t1)		# $t2 = board[$t1]
		lw $t3, board+4($t1)		# $t3 = board[$t1]
		lw $t4, board+8($t1)		# $t4 = board[$t1]
		addi $t0, $t0, 1 		# i++
		bne $t2, 1, check2HWin
		bne $t3, 1, check2HWin
		bne $t4, 1, check2HWin
		li $s2, 1
		j checkWin
		
		check2HWin:
			bne $t2, 2, checkHWin
			bne $t3, 2, checkHWin
			bne $t4, 2, checkHWin
			li $s2, 2
			j checkWin
	checkVWin: li $t0, 0 # i
	checkVWinLoop:
		bgt $t0, 2, checkDWin
		mul $t0, $t0, 4
		lw $t2, board($t0)	# $t2 = board[i]
		lw $t3, board+12($t0)	# $t3 = board[i+3]
		lw $t4, board+24($t0)	# $t4 = board[i+6]
		addi $t0, $t0, 1 # i++	
		bne $t2, 1, check2VWin
		bne $t3, 1, check2VWin
		bne $t4, 1, check2VWin
		li $s2, 1
		j checkWin
		check2VWin:
			bne $t2, 2, checkVWinLoop
			bne $t3, 2, checkVWinLoop
			bne $t4, 2, checkVWinLoop
			li $s2, 2
			j checkWin
	checkDWin:
		lw $t2, 0($s1)	# $t2 = board[0]
		lw $t3, 8($s1)	# $t3 = board[2]
		lw $t4, 16($s1)	# $t4 = board[4]
		lw $t5, 24($s1)	# $t5 = board[6]
		lw $t6, 32($s1)	# $t6 = board[8]
		
		# checkDXWin
		bne $t2, 1, checkDX2Win
		bne $t4, 1, checkDX2Win
		bne $t6, 1, checkDX2Win
		li $s2, 1
		j checkWin
		
		checkDX2Win:
		bne $t3, 1, checkDOWin
		bne $t4, 1, checkDOWin
		bne $t5, 1, checkDOWin
		li $s2, 1
		j checkWin
		
		checkDOWin:
		bne $t2, 2, checkDO2Win
		bne $t4, 2, checkDO2Win
		bne $t6, 2, checkDO2Win
		li $s2, 2
		j checkWin
		
		checkDO2Win:
		bne $t3, 2, checkWin
		bne $t4, 2, checkWin
		bne $t5, 2, checkWin
		li $s2, 2
	checkWin: bne $s2, $zero, loopEnd
	
	# check draw
	li $t2, 1 # isDraw
	li $t0, 0 # i
	
	checkDrawStart:
		bgt $t0, 8, checkDrawEnd 		# if $t0 > 8 goto checkDrawEnd
		mul $t1, $t0, 4
		lw $t1, board($t1) 		# $t1 = board[$t0]
		addi $t0, $t0, 1 		# $t0++
		bne $t1, $zero, checkDrawStart 		# if $t1 != 0 goto checkDrawStart
		li $t2, 0			# $t2 = 0
	checkDrawEnd:
	
	beq $t2, 1, loopEnd

	# write prompt
	li $v0, 4
	bne $s0, $zero, player2Turn
		la $a0, takeTurn1Text
		j printPrompt
	player2Turn:
		la $a0, takeTurn2Text
	printPrompt:
	syscall
	
	#print board
	jal printBoard
		
	li $v0, 4
	la $a0, promptText
	syscall
	
	j getInput
	
	inputError:
		li $v0, 4
		la $a0, inputErrorText
		syscall
	
	# Getting user input
	getInput:
    		li $v0, 5
		syscall
	
		ble $v0, $zero, inputError # if (input <= 0) goto inputError
		bgt $v0, 9, inputError # if (input > 9) goto inputError
	
	subi $t1, $v0, 1 	# index ($t1) = input ($v0) - 1
	mul $t1, $t1, 4
	lw $t2, board($t1)	# $t2 = board[index]
	
	bne $t2, $zero, loop 	# if ($t2 != 0) goto loop
	addi $t0, $s0, 1 	# $t0 = player_1_turn ($s1) + 1
	sw $t0, board($t1)	# board[index] = $t0
	
	xori $s0, $s0, 1
	
	j loop
loopEnd:
# print board
jal printBoard

# print winner
li $v0, 4

beq $s2, 2, player2Win
beq $s2, 0, printDraw
	la $a0, win1Text
	j printWin
player2Win:

	la $a0, win2Text
	j printWin
printDraw:
	la $a0, drawText
printWin:
syscall

# exit
li $v0, 10
syscall

# print board function
printBoard:
	li $t0, 0 # i = 0
	printBoardLoop1:
		bgt $t0, 2, printBoardLoop1End
		li $v0, 4
		la $a0, boardLineText
		syscall
		li $t1, 0 # j = 0
		printBoardLoop2:
			bgt $t1, 2, printBoardLoop2End
			li $v0, 4
			la $a0, boardSep
			syscall
			
			# $t2 = i*3+j
			mul $t2, $t0, 3
			add $t2, $t2, $t1
			mul $t2, $t2, 4
			lw $t3, board($t2) # $t3 = board[i*3+j]
			
			bne $t3, $zero, printBoardX
			li $v0, 4
			la $a0, boardEmpty
			syscall
			j nextPrint
			printBoardX:
			bne $t3, 1, printBoardO
			li $v0, 4
			la $a0, boardX
			syscall
			j nextPrint
			printBoardO:
			bne $t3, 2, nextPrint
			li $v0, 4
			la $a0, boardO
			syscall
			
			nextPrint: addi $t1, $t1, 1 # j++
			j printBoardLoop2
		printBoardLoop2End:
			li $v0, 4
			la $a0, boardLineEndText
			syscall
		addi $t0, $t0, 1 # i++
		j printBoardLoop1
	printBoardLoop1End:
		li $v0, 4
		la $a0, boardLineText
		syscall
	jr $ra
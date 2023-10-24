board = [[0,0,0],[0,0,0],[0,0,0]]
player_1_turn:bool = True

def checkGameWin(b, state: int) -> bool:
	for i in range(0, 3):
		if b[i][0] == state and b[i][1] == state and b[i][2] == state:
			return True
		
		if b[0][i] == state and b[1][i] == state and b[2][i] == state:
			return True
		
	# diagonal1
	if b[0][0] == state and b[1][1] == state and b[2][2] == state:
		return True

	# diagonal2
	if b[2][0] == state and b[1][1] == state and b[0][2] == state:
		return True
		
	return False

def checkDraw(board):
	for a in board:
		if 0 in a:
			return False
	return True

def printBoard(board):
	def b(i,j):
		if board[i][j] == 1:
			return "X"
		elif board[i][j] == -1:
			return "O"
		else:
			return " "
		
	for i in range(0, 3):
		print("+-+-+-+")
		print(f"|{b(i,0)}|{b(i,1)}|{b(i,2)}|")
	print("+-+-+-+")

while (not checkGameWin(board, -1) and not checkGameWin(board, 1)):
	if checkDraw(board):
		printBoard(board)
		print("The game was a draw!")
		break

	print(f"Please take a turn player {1 * (not player_1_turn) + 1}")
	print("The board looks like this:")
	printBoard(board)
	
	index: int = 0
	while True:
		inp = input("Type the position where you want to place your mark! [1-9]")
		if inp.isdigit() and int(inp) in range(1, 10):
			index = int(inp) - 1
			break
		print("Incorrect input. Please only type characters from 1 to 9")
	
	if board[index//3][index%3] == 0:
		board[index//3][index%3] = 1 if player_1_turn else -1
		player_1_turn = not player_1_turn

printBoard(board)
print(f"Player {1 * player_1_turn + 1} won this game!")
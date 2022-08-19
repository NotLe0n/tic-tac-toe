using System;

bool player1Turn = true;
var board = new BoardState[3, 3]; // 3x3 board; 0 = unset; 1 = X; 2 = O;

// main game loop
while (!CheckBoardWin()) {
	if (CheckBoardDraw()) {
		Console.Clear();
		PrintBoard();
		Console.WriteLine("This game was a draw!");
		return;
	}

	Console.Clear();
	Console.WriteLine("Please take a turn player " + (player1Turn ? "1" : "2"));
	Console.WriteLine("The board looks like this:");
	PrintBoard();
	Console.WriteLine("Type the position where you want to place your mark! [1-9]");

	// parse user input
	byte input;
	while (!byte.TryParse(Console.ReadLine(), out input) | input is 0 or > 9) {
		Console.WriteLine("Incorrect input. Please only type characters from 1 to 9");
	}

	input -= 1; // turn 1-9 to 0-8 for use as indicies

	// if the field isn't already occupied
	if (board[input / 3, input % 3] == BoardState.Unset) {
		// set field to correct state depending on who's turn it is
		board[input / 3, input % 3] = player1Turn ? BoardState.X : BoardState.O;

		// other player's turn
		player1Turn = !player1Turn;
	}
}

Console.Clear();
PrintBoard();
Console.WriteLine($"Player {(!player1Turn ? "1" : "2")} won this game!");

/*
	Functions
*/

bool CheckBoardWin()
{
	if (CheckBoardWinHorizontal(BoardState.X) || CheckBoardWinVertical(BoardState.X) || CheckBoardWinDiagonal(BoardState.X)) {
		return true;
	}
	if (CheckBoardWinHorizontal(BoardState.O) || CheckBoardWinVertical(BoardState.O) || CheckBoardWinDiagonal(BoardState.O)) {
		return true;
	}
	return false;
}

bool CheckBoardWinHorizontal(BoardState state)
{
	for (int i = 0; i < 3; i++) {
		if (board[0, i] == state && board[1, i] == state && board[2, i] == state) {
			return true;
		}
	}
	return false;
}

bool CheckBoardWinVertical(BoardState state)
{
	for (int i = 0; i < 3; i++) {
		if (board[i, 0] == state && board[i, 1] == state && board[i, 2] == state) {
			return true;
		}
	}
	return false;
}

bool CheckBoardWinDiagonal(BoardState state)
{
	if (board[0, 0] == state && board[1, 1] == state && board[2, 2] == state) {
		return true;
	}
	if (board[2, 0] == state && board[1, 1] == state && board[0, 2] == state) {
		return true;
	}
	return false;
}

bool CheckBoardDraw()
{
	foreach (var field in board) {
		if (field == BoardState.Unset) {
			return false;
		}
	}
	return true;
}

void PrintBoard()
{
	for (int i = 0; i < 3; i++) {
		Console.WriteLine("+-+-+-+");
		for (int j = 0; j < 3; j++) {
			Console.Write('|');
			switch (board[i, j]) {
				case BoardState.Unset:
					Console.Write(' ');
					break;
				case BoardState.X:
					Console.Write('X');
					break;
				case BoardState.O:
					Console.Write('O');
					break;
			}
		}
		Console.Write('|');
		Console.Write('\n');
	}
	Console.WriteLine("+-+-+-+");
}

/*
	Types
*/

enum BoardState
{
	Unset,
	X,
	O
}
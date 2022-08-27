using System;

namespace TicTacToe;

public class Program
{
	public enum BoardState
	{
		Unset,
		X,
		O
	}

	private static bool player1Turn = true;
	private static BoardState[,] board = new BoardState[3, 3]; // 3x3 board;

	public static void Main(string[] args)
	{
		// main game loop
		while (!CheckBoardWin(BoardState.X) && !CheckBoardWin(BoardState.O)) {
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
	}

	private static bool CheckBoardWin(BoardState state)
	{
		// check horizontal
		for (int i = 0; i < 3; i++) {
			if (board[0, i] == state && board[1, i] == state && board[2, i] == state) {
				return true;
			}
		}

		// check vertical
		for (int i = 0; i < 3; i++) {
			if (board[i, 0] == state && board[i, 1] == state && board[i, 2] == state) {
				return true;
			}
		}

		// check diagonal
		if (board[0, 0] == state && board[1, 1] == state && board[2, 2] == state) {
			return true;
		}
		if (board[2, 0] == state && board[1, 1] == state && board[0, 2] == state) {
			return true;
		}

		return false;
	}

	private static bool CheckBoardDraw()
	{
		foreach (var field in board) {
			if (field == BoardState.Unset) {
				return false;
			}
		}
		return true;
	}

	private static void PrintBoard()
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
}
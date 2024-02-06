package Java;

import java.io.BufferedReader;
import java.io.InputStreamReader;

public class App {
	private enum BoardState {
		Unset,
		X,
		O
	}

	private static boolean player1Turn = true;
	private static BoardState[][] board = new BoardState[3][3];

	public static void main(String[] args) {
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				board[i][j] = BoardState.Unset;
			}
		}

		while (!checkBoardWin(BoardState.X) && !checkBoardWin(BoardState.O)) {
			if (checkBoardDraw()) {
				printBoard();
				System.out.println("This game was a draw!");
				return;
			}

			System.out.println("Please take a turn player " + (player1Turn ? "1" : "2"));
			System.out.println("The board looks like this:");
			printBoard();
			System.out.println("Type the position where you want to place your mark! [1-9]");

			// parse user input

			int input = 0;
			while (input < 1 || input > 9) {
				BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
				try {
					input = Integer.parseInt(reader.readLine());
					if (input < 1 || input > 9) {
						System.out.println("Incorrect input. Please only type characters from 1 to 9");
					}
				} catch (Exception e) {
					System.out.println("Incorrect input. Please only type characters from 1 to 9");
				}
			}

			input -= 1; // turn 1-9 to 0-8 for use as indicies

			// if the field isn't already occupied
			if (board[input / 3][input % 3] == BoardState.Unset) {
				// set field to correct state depending on who's turn it is
				board[input / 3][input % 3] = player1Turn ? BoardState.X : BoardState.O;

				// other player's turn
				player1Turn = !player1Turn;
			}
		}

		printBoard();
		System.out.println("Player " + (!player1Turn ? "1" : "2") + " won this game!");
	}

	private static void printBoard() {
		for (int i = 0; i < 3; i++) {
			System.out.println("+-+-+-+");
			for (int j = 0; j < 3; j++) {
				System.out.print('|');
				switch (board[i][j]) {
					case Unset:
						System.out.print(' ');
						break;
					case X:
						System.out.print('X');
						break;
					case O:
						System.out.print('O');
						break;
				}
			}
			System.out.println('|');
		}
		System.out.println("+-+-+-+");
	}

	private static boolean checkBoardWin(BoardState state) {
		// check horizontal
		for (int i = 0; i < 3; i++) {
			if (board[0][i] == state && board[1][i] == state && board[2][i] == state) {
				return true;
			}
		}

		// check vertical
		for (int i = 0; i < 3; i++) {
			if (board[i][0] == state && board[i][1] == state && board[i][2] == state) {
				return true;
			}
		}

		// check diagonal
		if (board[0][0] == state && board[1][1] == state && board[2][2] == state) {
			return true;
		}
		if (board[2][0] == state && board[1][1] == state && board[0][2] == state) {
			return true;
		}

		return false;
	}

	private static boolean checkBoardDraw() {
		for (int i = 0; i < 3; i++) {
			for (int j = 0; j < 3; j++) {
				if (board[i][j] == BoardState.Unset) {
					return false;
				}
			}
		}

		return true;
	}
}
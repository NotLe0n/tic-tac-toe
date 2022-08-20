#include <iostream>
#include "tic-tac-toe.hpp"

int main() {
	int board[9] = { 0 }; // 0 = unset; 1 = X; 2 = O
	bool player_1_turn = true;

	while (!check_win(board)) {
		if (check_draw(board)) {
			print_board(board);
			std::cout << "This game was draw\n";
			return 0;
		}

		std::cout << "Please take a turn player " << (player_1_turn ? "1" : "2") << "\n";
		std::cout << "The board looks like this:\n";
		print_board(board);
		std::cout << "Type the position where you want to place your mark! [1-9]\n";
		
		// parse user input
		int input;
		while (!(std::cin >> input) || input < 1 || input > 9) {
			std::cout << "Incorrect input. Please only type characters from 1 to 9\n";
			std::cin.clear(); // reset the failbit
			std::cin.ignore(123, '\n');
		}

		int index = input - 1;

		// if the field isn't already occupied
		if (board[index] == 0) {
			// set field to correct state depending on who's turn it is
			board[index] = player_1_turn ? 1 : 2;

			// other player's turn
			player_1_turn = !player_1_turn;
		}
	}

	print_board(board);
	std::cout << "Player " << (!player_1_turn ? "1" : "2") << " won the game!\n";
	return 0;
}

bool check_win(int board[]) {
	// check horizontal
	for (int i = 0; i < 3; i++) {
		// check X
		if (board[0 + i * 3] == 1 && board[1 + i * 3] == 1 && board[2 + i * 3] == 1) {
			return true;
		}

		// check O
		if (board[0 + i * 3] == 2 && board[1 + i * 3] == 2 && board[2 + i * 3] == 2) {
			return true;
		}
	}

	// check vertical
	for (int i = 0; i < 3; i++) {
		// check X
		if (board[i] == 1 && board[i + 3] == 1 && board[i + 6] == 1) {
			return true;
		}

		// check O
		if (board[i] == 2 && board[i + 3] == 2 && board[i + 6] == 2) {
			return true;
		}
	}

	// check diagonal X
	if ((board[0] == 1 && board[4] == 1 && board[8] == 1) 
		|| board[2] == 1 && board[4] == 1 && board[6] == 1) {
		return true;
	}

	// check diagonal O
	if ((board[0] == 2 && board[4] == 2 && board[8] == 2) 
		|| board[2] == 2 && board[4] == 2 && board[6] == 2) {
		return true;
	}

	return false;
}

bool check_draw(int board[]) {
	for (int i = 0; i < 9; i++) {
		if (board[i] == 0) {
			return false;
		}
	}
	
	return true;
}

void print_board(int board[]) {
	for (int i = 0; i < 3; i++) {
		std::cout << "+-+-+-+\n";
		for (int j = 0; j < 3; j++) {
			std::cout << '|';
			if (board[i * 3 + j] == 0) {
				std::cout << ' ';
			}
			else if (board[i * 3 + j] == 1) {
				std::cout << 'X';
			}
			else if (board[i * 3 + j] == 2) {
				std::cout << 'O';
			}
		}
		std::cout << "|\n";
	}
	std::cout << "+-+-+-+\n";
}
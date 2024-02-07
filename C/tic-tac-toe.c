#include "tic-tac-toe.h"
#include "stdio.h"

int board[9];
int player_1_turn = 1;
int main() {
	while (!checkWin(1) && !checkWin(2)) {
		int input;
		if (checkDraw()) {
			printBoard();
			printf("The game was a draw!\n");
			return 0;
		}
		
		printf("\x1B[2J");
		printf("Please take a turn player %d\n", !player_1_turn+1);
		printf("The board looks like this:\n");
		printBoard();
		printf("Type the position where you want to place your mark! [1-9]\n");
		
		while (1) {
			if (scanf("%d", &input) != 1 || input < 1 || input > 9) {
				printf("Incorrect input. Please only type characters from 1 to 9: ");
				while (getchar() != '\n');
				continue;
			}
			break;
		}
		
		input = input - 1;
		printf("%d\n", input);

		if (board[input] == 0) {
			board[input] = player_1_turn ? 1 : 2;
			player_1_turn = !player_1_turn;
		}
	}

	printf("\x1B[2J");
	printBoard();
	printf("Player %d won the game!\n", !player_1_turn);

	return 0;
}

int checkWin(int state) {
	int i;
	for (i = 0; i < 3; i++) {
		if (board[i * 3] == state && board[1 + i * 3] == state && board[2 + i * 3] == state) {
			return 1;
		}
	}
	for (i = 0; i < 3; i++) {
		if (board[i] == state && board[i + 3] == state && board[i + 6] == state) {
			return 1;
		}
	}
	if ((board[0] == state && board[4] == state && board[8] == state) 
		|| (board[2] == state && board[4] == state && board[6] == state)) {
		return 1;
	}
	return 0;
}

int checkDraw() {
	int i;
	for (i = 0; i < 9; i++) {
		if (!board[i]) {
			return 0;
		}
	}
	return 1;
}

void printBoard() {
	int i, j;
	for (i = 0; i < 3; i++) {
		printf("+-+-+-+\n");
		for (j = 0; j < 3; j++) {
			printf("|");
			if (board[i * 3 + j] == 0) {
				printf(" ");
			}
			else if (board[i * 3 + j] == 1) {
				printf("X");
			}
			else if (board[i * 3 + j] == 2) {
				printf("O");
			}
		}
		printf("|\n");
	}
	printf("+-+-+-+\n");
}
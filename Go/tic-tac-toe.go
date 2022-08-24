package main

import (
	"fmt"
)

func main() {
	var board [3][3]int
	player1Turn := true
	for !checkWin(board, 1) && !checkWin(board, 2) {
		if checkDraw(board) {
			printBoard(board)
			fmt.Println("The game was a draw!")
			return
		}

		if player1Turn {
			fmt.Println("Please take a turn player 1")
		} else {
			fmt.Println("Please take a turn player 2")
		}

		fmt.Println("The board looks like this:")
		printBoard(board)
		fmt.Println("Type the position where you want to place your mark! [1-9]")

		index := 0
		for {
			_, err := fmt.Scanf("%d\n", &index) // read stdin and store the read number in index
			// validate input
			if err != nil || index < 1 || index > 9 {
				fmt.Println("Incorrect input. Please only type characters from 1 to 9")
			} else {
				break // exit loop if valid
			}
		}

		index -= 1 // turn 1-9 to 0-8 for use as indicies

		// if the field isn't already occupied
		if board[index/3][index%3] == 0 {
			// set field to correct state depending on who's turn it is
			if player1Turn {
				board[index/3][index%3] = 1
			} else {
				board[index/3][index%3] = 2
			}

			// other player's turn
			player1Turn = !player1Turn
		}
	}

	printBoard(board)
	if !player1Turn {
		fmt.Println("Player 1 won this game!")
	} else {
		fmt.Println("Player 2 won this game!")
	}
}

func checkWin(board [3][3]int, state int) bool {
	// check horizontal
	for i := 0; i < 3; i++ {
		if board[0][i] == state && board[1][i] == state && board[2][i] == state {
			return true
		}
	}

	// check vertical
	for i := 0; i < 3; i++ {
		if board[i][0] == state && board[i][1] == state && board[i][2] == state {
			return true
		}
	}

	// check diagonal
	if board[0][0] == state && board[1][1] == state && board[2][2] == state {
		return true
	}
	if board[2][0] == state && board[1][1] == state && board[0][2] == state {
		return true
	}

	return false
}

func checkDraw(board [3][3]int) bool {
	for i := 0; i < 3; i++ {
		for k := 0; k < 3; k++ {
			if board[i][k] == 0 {
				return false
			}
		}
	}
	return true
}

func printBoard(board [3][3]int) {
	for i := 0; i < 3; i++ {
		fmt.Println("+-+-+-+")
		for j := 0; j < 3; j++ {
			fmt.Printf("%c", '|')
			if board[i][j] == 0 {
				fmt.Printf("%c", ' ')
			} else if board[i][j] == 1 {
				fmt.Printf("%c", 'X')
			} else if board[i][j] == 2 {
				fmt.Printf("%c", 'O')
			}
		}
		fmt.Printf("%c\n", '|')
	}
	fmt.Println("+-+-+-+")
}

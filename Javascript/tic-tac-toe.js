var prompt = require('prompt-sync')();

let board = [0]
for (let i = 0; i < 9; i++) {
	board[i] = 0;
}

let player1Turn = true;

while (!checkGameWin()) {
	if (checkDraw(board)) {
		printBoard(board)
		console.log("This game was draw")
		return 0;
	}

	console.log("Please take a turn player " + (player1Turn ? "1" : "2"))
	console.log("The board looks like this:")
	printBoard(board);

	let input = prompt("Type the position where you want to place your mark! [1-9] ");
	while (Number.isNaN(Number(input)) || input < 1 || input > 9) {
		// check for CTRL-C
		if (input === null) {
			process.exit(0);
		}

		console.log("Incorrect input. Please only type characters from 1 to 9");
		input = prompt("Type the position where you want to place your mark! [1-9] ");
	}

	let index = input - 1;

	// if the field isn't already occupied
	if (board[index] === 0) {
		// set field to correct state depending on who's turn it is
		board[index] = player1Turn ? 1 : 2;

		// other player's turn
		player1Turn = !player1Turn;
	}
}

printBoard(board);
console.log("Player " + (!player1Turn ? "1" : "2") + " won the game!")

function checkGameWin() {
	// check horizontal
	for (let i = 0; i < 3; i++) {
		// check X
		if (board[0 + i * 3] === 1 && board[1 + i * 3] === 1 && board[2 + i * 3] === 1) {
			return true;
		}

		// check O
		if (board[0 + i * 3] === 2 && board[1 + i * 3] === 2 && board[2 + i * 3] === 2) {
			return true;
		}
	}

	// check vertical
	for (let i = 0; i < 3; i++) {
		// check X
		if (board[i] === 1 && board[i + 3] === 1 && board[i + 6] === 1) {
			return true;
		}

		// check O
		if (board[i] === 2 && board[i + 3] === 2 && board[i + 6] === 2) {
			return true;
		}
	}

	// check diagonal X
	if ((board[0] === 1 && board[4] === 1 && board[8] === 1) 
		|| board[2] === 1 && board[4] === 1 && board[6] === 1) {
		return true;
	}

	// check diagonal O
	if ((board[0] === 2 && board[4] === 2 && board[8] === 2) 
		|| board[2] === 2 && board[4] === 2 && board[6] === 2) {
		return true;
	}

	return false;
}

function checkDraw() {
	for (const field of board) {
		if (field === 0) {
			return false;
		}
	}

	return true;
}

function printBoard() {
	for (let i = 0; i < 3; i++) {
		console.log("+-+-+-+");
		let line = ""
		for (let j = 0; j < 3; j++) {
			line += '|';
			if (board[i * 3 + j] === 0) {
				line += ' ';
			}
			else if (board[i * 3 + j] === 1) {
				line += 'X';
			}
			else if (board[i * 3 + j] === 2) {
				line += 'O';
			}
		}
		console.log(line + '|')
	}
	console.log("+-+-+-+");
}
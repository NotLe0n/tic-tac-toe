fn main() {
	let mut board = [0; 9];
	let mut player_1_turn = true;

	while !check_win(board) {
		if check_draw(board) {
			print_board(board);
			println!("This game was a draw!");
			return;
		}

		println!("Please take a turn player {}", (if player_1_turn { "1" } else { "2" }));
		println!("The board looks like this:");
		print_board(board);
		println!("Type the position where you want to place your mark! [1-9]");

		// parse user input
		let mut input: usize = loop {
			let mut buffer = String::new();
			match std::io::stdin().read_line(&mut buffer) {
				Ok(_) => {
					match buffer.trim().parse::<usize>() {
						Ok(x @ 1..=9) => break x,
						_ => println!("Incorrect input. Please only type characters from 1 to 9")
					}
				},
				Err(_) => println!("Incorrect input. Please only type characters from 1 to 9")
			}
		};
		

		input -= 1; // turn 1-9 to 0-8 for use as indicies

		// if the field isn't already occupied
		if board[input] == 0 {
			// set field to correct state depending on who's turn it is
			board[input] = if player_1_turn { 1 } else { 2 };

			// other player's turn
			player_1_turn = !player_1_turn;
		}
	}
	print_board(board);
	println!("Player {} won the game!", if !player_1_turn { "1" } else { "2" });
}

fn print_board(board: [u8; 9]) {
	for i in 0..3 {
		println!("+-+-+-+");
		for j in 0..3 {
			print!("|");
			match board[i * 3 + j] {
				0 => print!(" "),
				1 => print!("X"),
				2 => print!("O"),
				_ => print!("?"),
			}
		}
		println!("|");
	}
	println!("+-+-+-+");
}

fn check_win(board: [u8; 9]) -> bool {
	// check horizontal
	for i in 0..3 {
		// check X
		if board[0 + i * 3] == 1 && board[1 + i * 3] == 1 && board[2 + i * 3] == 1 {
			return true;
		}

		// check O
		if board[0 + i * 3] == 2 && board[1 + i * 3] == 2 && board[2 + i * 3] == 2 {
			return true;
		}
	}

	// check vertical
	for i in 0..3 {
		// check X
		if board[i] == 1 && board[i + 3] == 1 && board[i + 6] == 1 {
			return true;
		}

		// check O
		if board[i] == 2 && board[i + 3] == 2 && board[i + 6] == 2 {
			return true;
		}
	}

	// check diagonal X
	if (board[0] == 1 && board[4] == 1 && board[8] == 1) || board[2] == 1 && board[4] == 1 && board[6] == 1 {
		return true;
	}

	// check diagonal O
	if (board[0] == 2 && board[4] == 2 && board[8] == 2) || board[2] == 2 && board[4] == 2 && board[6] == 2 {
		return true;
	}

	return false;
}

fn check_draw(board: [u8; 9]) -> bool {
	for field in board {
		if field == 0 {
			return false;
		}
	}

	return true;
}
board = zeros(3, 3);
player_1_turn = true;

while all(abs([sum([diag(board), diag(fliplr(board))])'; sum([board; board'], 2)]) ~= 3)
    clc
    if all(board, "all")
        DisplayBoard(board)
        disp("This game was a draw")
    end
    
	fprintf("Please take a turn player %d\n", 1 * ~player_1_turn + 1)
    
    disp("The board looks like this:")
    DisplayBoard(board)
    
    while true
        i = input("Type the position where you want to place your mark! [1-9]: ");
        if ismember(i, 1:9), break, end
    end

    if board(i) == 0
		board(i) = -1 * ~player_1_turn + 1 * player_1_turn;
        player_1_turn = ~player_1_turn;
    end
end

clc
DisplayBoard(board)
fprintf("Player %d won the game!\n", 1 * player_1_turn + 1)

function DisplayBoard(board)
    for x=1:size(board, 2)
        disp("+-+-+-+")
        for y=1:size(board, 1)
            a = board(y, x);
            c = " ";
            if a == 1, c = "X"; elseif a == -1, c = "O"; end
            fprintf("|%s", c)
        end
        fprintf("|\n")
    end
    disp("+-+-+-+")
end




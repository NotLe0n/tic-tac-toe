board = zeros(3, 3);
player_1_turn = true;

while ~CheckWin(board)
    clc
    if all(board, "all")
        DisplayBoard(board)
        disp("This game was a draw")
    end
    
    if player_1_turn, disp("Please take a turn player 1")
    else, disp("Please take a turn player 2"); end
    
    disp("The board looks like this:")
    DisplayBoard(board)
    
    while true
        i = input("Type the position where you want to place your mark! [1-9]: ");
        if i >= 1 && i <= 9, break, end
    end

    if board(i) == 0
        if player_1_turn, board(i) = 1;
        else, board(i) = -1; end
        
        player_1_turn = ~player_1_turn;
    end
end

clc
DisplayBoard(board)
if ~player_1_turn, disp("Player 1 won the game!")
else, disp("Player 2 won the game!"); end

function w=CheckWin(board)
    diag_sum = cat(1, sum(diag(board)), sum(diag(fliplr(board))));

    diag_win = any(abs(diag_sum) == 3);
    row_win = any(abs(sum(board, 1)) == 3);
    col_win = any(abs(sum(board, 2)) == 3);

    w = diag_win || row_win || col_win;
end

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




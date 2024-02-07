board = zeros(3, 3);
player_1_turn = true;

while all(abs([trace(board); trace(fliplr(board)); sum([board; board'], 2)]) ~= 3)
    if all(board, "all")
        DisplayBoard(board)
        disp("This game was a draw")
    end
    
    fprintf("Please take a turn player %d\n", ~player_1_turn + 1)
    
    disp("The board looks like this:")
    DisplayBoard(board)
    
    while true
        i = input("Type the position where you want to place your mark! [1-9]: ");
        if ismember(i, 1:9), break, end
    end

    board(i) = player_1_turn - ~abs(board(i))*~player_1_turn;
    player_1_turn = ~(player_1_turn^(abs(board(i))));
    clc
end

DisplayBoard(board)
fprintf("Player %d won the game!\n", player_1_turn + 1)

function DisplayBoard(board)
    for x=1:size(board, 2)
        disp("+-+-+-+")
        for y=1:size(board, 1)
            chars = ["O", " ", "X"];
            fprintf("|%s", chars(board(y, x)+2))
        end
        fprintf("|\n")
    end
    disp("+-+-+-+")
end
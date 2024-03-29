board = zeros(3, 3);
player_1_turn = true;

while all(abs([trace(board); trace(fliplr(board)); sum([board; board'], 2)]) ~= 3)
    if all(board, "all")
        DisplayBoard(board)
        fprintf("This game was a draw\n")
    end
    
    fprintf("Please take a turn player %d\n", ~player_1_turn + 1)
    fprintf("The board looks like this:\n")
    DisplayBoard(board)
    
    while true
        i = input("Type the position where you want to place your mark! [1-9]: ");
        if ismember(i, 1:9), break, end
        fprintf("Incorrect input. Please only type characters from 1 to 9\n")
    end

    board(i) = player_1_turn - ~abs(board(i))*~player_1_turn;
    player_1_turn = ~(player_1_turn^(abs(board(i))));
    clc
end

DisplayBoard(board)
fprintf("Player %d won the game!\n", player_1_turn + 1)

function DisplayBoard(board)
    for x=1:size(board)
        fprintf("\n+-+-+-+\n|")
        fprintf("%c|", interp1([79, 32, 88], board(:,x)+2))
    end
    fprintf("\n+-+-+-+\n")
end
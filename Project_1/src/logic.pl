
invalidInput(Board, Player, NewBoard, Expected):-
      write('INVALID INPUT: Cell not valid, please try again.\n'), %TODO: melhorar este print
      askCoords(Board, Player, NewBoard, Expected).

%TODO: coluna e linha

workLines(_, _, _, _, _, 10) :-
      fail.

workLines(Board, WX, WY, X, Y, Index):-
      (X == WX);
      (Y == WY);
      (X =:= WX + Index, Y =:= WY + Index);
      (X =:= WX - Index, Y =:= WY - Index);
      (X =:= WX + Index, Y =:= WY - Index);
      (X =:= WX - Index, Y =:= WY + Index);
      Index < 10,
      Index1 is Index +1,
      workLines(Board, WX, WY, X, Y, Index1).


askCoords(Board, Player, NewBoard, Expected) :-
        write('  > Row     '),
        read(RowLetter),
        number(RowLetter, Row),
        write('  > Column '),
        read(Column),
        write('\n'),
        ColumnIndex is Column - 1,
        RowIndex is Row - 1,
        ((getValueFromMatrix(Board, RowIndex, ColumnIndex, Expected),
        replaceInMatrix(Board, RowIndex, ColumnIndex, Player, NewBoard));
        invalidInput(Board, Player, NewBoard, Expected)).

moveWorker(Board, 'Y', NewBoard) :-
        write('\n2. Choose worker current cell.\n'),
        askCoords(Board, empty, NoWorkerBoard, red),
        write('3. Choose worker new cell.\n'),
        askCoords(NoWorkerBoard, red, NewBoard, empty),
        printBoard(NewBoard),
        write('\n4. Choose your cell.\n').

moveWorker(Board, 'N',NewBoard) :-
        NewBoard = Board,
        write('\n2. Choose your cell.\n').

gameLoop(Board1) :-
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBoolX),
      moveWorker(Board1, MoveWorkerBoolX, Board2),
      askCoords(Board2, black, Board3, empty),
      printBoard(Board3),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Do you want to move a worker?(Y/N) '),
      read(MoveWorkerBoolO),
      moveWorker(Board3, MoveWorkerBoolO, Board4),
      askCoords(Board4, white, Board5, empty),
      printBoard(Board5),
      gameLoop(Board5).

addWorkers(InitialBoard, WorkersBoard) :-
      printBoard(InitialBoard),
      write('\n------------------ PLAYER X -------------------\n\n'),
      write('1. Choose worker 1 cell.\n'),
      askCoords(InitialBoard, red, Worker1Board, empty),
      printBoard(Worker1Board),
      write('\n------------------ PLAYER O -------------------\n\n'),
      write('1. Choose worker 2 cell.\n'),
      askCoords(Worker1Board, red, WorkersBoard, empty),
      printBoard(WorkersBoard).

startGame :-
      initialBoard(InitialBoard),
      addWorkers(InitialBoard, WorkersBoard),
      gameLoop(WorkersBoard).

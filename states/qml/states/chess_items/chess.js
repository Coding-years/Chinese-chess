/*
 *This file is enlighten by the samegame of the QT official site
 */

/* This script file handles the game logic */
.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

// The array recording the chesses' color and name map with the positions on the chessboard
// Each value in the array is composed with higher 4 bits indicating the color and lower 4 bits indicating the chess name
// higher 4 bits: 0 - black, 0x1 - red
// lower 4 bits: 1 - rook, 2 - horse, 3 - minister, 4 - guard, 5- general, 6 - cannon, 7 - pawn
// eg: 0x10 + 1 denote a red rook
var init_chesses_map = [1, 2, 3, 4, 5, 4, 3, 2, 1,
                                          0, 0, 0, 0, 0, 0, 0, 0, 0,
                                          0, 6, 0, 0, 0, 0, 0, 6, 0,
                                          7, 0, 7, 0, 7, 0, 7, 0, 7,
                                          0, 0, 0, 0, 0, 0, 0, 0, 0,
                                          0, 0, 0, 0, 0, 0, 0, 0, 0,
                                          0x10 + 7, 0, 0x10 + 7, 0, 0x10 + 7, 0, 0x10 + 7, 0, 0x10 + 7,
                                          0, 0x10 + 6, 0, 0, 0, 0, 0, 0x10 + 6, 0,
                                          0, 0, 0, 0, 0, 0, 0, 0, 0,
                                          0x10 + 1, 0x10 + 2, 0x10 + 3, 0x10 + 4, 0x10 + 5, 0x10 + 4, 0x10 + 3, 0x10 + 2, 0x10 + 1];

var black_chess_name = [ "車", "马", "象", "士", "将", "炮", "卒" ];
var red_chess_name    = [ "車", "马", "相", "仕", "帥", "炮", "兵" ];
//var red_chess_name    = [ "1", "2", "3", "4", "5", "6", "7" ];

var maxRow = 10;
var maxColumn = 9;
var maxIndex = maxRow * maxColumn;
var board = new Array(maxIndex);
var blockSrc = "Chess.qml";
var gameDuration;
var component = Qt.createComponent(blockSrc);
var gameCanvas;
/*
 * Since the chess size is smaller than the block size, and the chess
 * is exactly in the middle of the block, the chess's coordinate of left
 * and up corner must slightly bigger than the coordinate of the
 * blcok and then we should amend it
 */
var coordinate_amend = 0;

var gameMode = "arcade"; //Set in new game, then tweaks behaviour of other functions
var gameOver = false;
var active_side = 0; /* 0: black, 1: red */
var chess_selected = false; /* false: unselected, true: selected */
var waiting_chess_index = -1; /* The index of the chess waiting to move */
var moved_chess_index = 0; /* The index of the chess moved previously */
var black_bound_row = 4;
var red_bound_row = 5;

// Index function used instead of a 2D array
function index(column, row)
{
    return column + row * maxColumn;
}

function index_col(index)
{
    return index % maxColumn;
}

function index_row(index)
{
    return Math.floor(index / maxColumn);
}

function createBlock(column, row, chess_param)
{
    var chess_name_index = (chess_param & 0x0F) - 1;

    console.log(chess_param & 0xF0, chess_param & 0x0F);

    var dynamicObject = component.createObject(gameCanvas,
                           {"chess_color": (chess_param & 0xF0) == 0 ? "black" : "red",
                                                   "color_int": (chess_param & 0xF0) == 0 ? 0 : 1,
                                                                    "name_int": chess_name_index,
                                                                    "x": column*gameCanvas.blockSize + coordinate_amend,
                                                                    "y": -1*gameCanvas.blockSize,
                                                                    "width": gameCanvas.chessSize,
                                                                    "height": gameCanvas.chessSize,
                                                                    "chess_name": (chess_param & 0xF0) == 0 ?
                                                                        black_chess_name[chess_name_index] : red_chess_name[chess_name_index]});
    if (dynamicObject == null){
        console.log("error creating block");
        console.log(component.errorString());
        return false;
    }
    dynamicObject.y = row*gameCanvas.blockSize + coordinate_amend;
    //dynamicObject.spawned = true;

    board[index(column,row)] = dynamicObject;

    return true;
}

function cleanUp()
{
    if (gameCanvas == undefined)
        return;
    // Delete blocks from previous game
    for (var i = 0; i < maxIndex; i++) {
        if (board[i] != null)
            board[i].destroy();
        board[i] = null;
    }
    /*if (puzzleLevel != null){
        puzzleLevel.destroy();
        puzzleLevel = null;
    }*/
    gameCanvas.mode = ""
}

/* Init the chesses in the chessboard */
// Maybe we can use a 'map' matrix to map all the chesses' positions when playing
function startNewGame(gc, mode/* , map */)
{
    gameCanvas = gc;
    if (mode == undefined)
        gameMode = "arcade";
    else
        gameMode = mode;
    gameOver = false;

    //cleanUp();

    gc.gameOver = false;
    gc.mode = gameMode;
    coordinate_amend = (gc.blockSize - gc.chessSize) / 2;
    // Calculate board size
    //maxColumn = Math.floor(gameCanvas.width/gameCanvas.blockSize);
    //maxRow = Math.floor(gameCanvas.height/gameCanvas.blockSize);
    //maxIndex = maxRow * maxColumn;
    //if (gameMode == "arcade") //Needs to be after board sizing
        //getHighScore();


    // Initialize Board
    board = new Array(maxIndex);
    //gameCanvas.score = 0;
    //gameCanvas.score2 = 0;
    //gameCanvas.moves = 0;
    //gameCanvas.curTurn = 1;
    //if (gameMode == "puzzle")
      //  loadMap(map);
    //else//Note that we load them in reverse order for correct visual stacking
    //for (var column = maxColumn - 1; column >= 0; column--)
       // for (var row = maxRow - 1; row >= 0; row--)
    for (var column = 0; column < maxColumn; column++)
        for (var row = 0; row < maxRow; row++)
        {
            if (init_chesses_map[index(column, row)] != 0)
                createBlock(column, row, init_chesses_map[index(column, row)]);
            else
            {
                /* I don't make sure if we need to intialize these blockes to NULL */
            }
        }
    gameDuration = new Date();
}

function handleClick(x, y)
{
    var block_index = index(Math.floor(x / gameCanvas.blockSize), Math.floor(y / gameCanvas.blockSize));
    console.log("handleClick(),", "block_index:", block_index)
    var result = false;

    if (!chess_selected)
    {
        if (board[block_index] == null)
        {
            console.log("coordinate", (block_index % maxColumn), Math.floor(block_index / maxColumn), "has no chess and no chess has been selected, so no action to do");
        }
        else if (board[block_index].color_int != active_side)
        {
            console.log("active side:", active_side, "clicked side:", board[block_index].color_int, "no action");
        }
        else
        {
            console.log("chess", block_index, "is selected");
            waiting_chess_index = block_index;
            chess_selected = true;
            board[moved_chess_index].background_color = "yellow";
            board[block_index].background_color = "green";
        }
    }
    else
    {
        if (board[block_index] != null && board[block_index].color_int == active_side)
        {
            if (block_index != waiting_chess_index)
            {
                console.log("Reselect the waiting chess index to", block_index);
                board[waiting_chess_index].background_color = "yellow";
                waiting_chess_index = block_index;

                board[block_index].background_color = "green";
            }
            else
                console.log("Clicked chess index", block_index, "is equal to waiting chess index, no action");
        }
        else
        {
            /* check if the moving is valid */
            result = check_chess_moving(block_index);

            /* DOIT */
            if (result)
            {
                if (board[block_index] != null)
                    board[block_index].destroy();

                board[block_index] = board[waiting_chess_index];
                board[waiting_chess_index] = null;
                board[block_index].x = (block_index % maxColumn) * gameCanvas.blockSize + coordinate_amend;
                board[block_index].y = Math.floor(block_index / maxColumn) *gameCanvas.blockSize + coordinate_amend;
                board[block_index].background_color = "pink";
                /* update the active side and chess selected status */
                active_side = active_side == 0 ? 1 : 0;
                chess_selected = false;
                moved_chess_index = block_index;
            }
        }
    }
}

function check_rook_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);
    var column_same = true;
    /*var small;
    var big;*/

    if (column == waiting_chess_col)
    {
        if (row != waiting_chess_row)
        {
            return check_line_has_num_chess(row, waiting_chess_row, column_same, 0);
        }
    }
    else if (row == waiting_chess_row)
    {
        return check_line_has_num_chess(column, waiting_chess_col, !column_same, 0);
    }

    /* NOTE: if the checking block is the same block as the waiting chess, it return false as well */
    return false;
}

function check_horse_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);
    console.log("waiting chess:", "column", waiting_chess_col, "row", waiting_chess_row)
    console.log("move to block:", "column", column, "row", row)

    if (Math.abs(column - waiting_chess_col) == 2)
    {
        if (Math.abs(row - waiting_chess_row) == 1
                && board[index((column  + waiting_chess_col) / 2, waiting_chess_row)] == null)
                return true;
        else
            return false;
    }
    else if (Math.abs(column - waiting_chess_col) == 1)
    {
        if (Math.abs(row - waiting_chess_row) == 2
                && board[index(waiting_chess_col, (row + waiting_chess_row) / 2)] == null)
                return true;
        else
            return false;
    }

    return false;
}

function check_minister_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);

    if ((board[waiting_chess_index].color_int == 0 && row <= black_bound_row)
            || (board[waiting_chess_index].color_int == 1 && row >= red_bound_row))
    if (Math.abs(column - waiting_chess_col) == 2 && Math.abs(row - waiting_chess_row) == 2)
    {
        if (board[index((column  + waiting_chess_col) / 2, (row + waiting_chess_row) / 2)] == null)
            return true;
    }

    return false;
}

function check_guard_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);

    if (Math.abs(column - waiting_chess_col) == 1 && Math.abs(row - waiting_chess_row) == 1)
    {
        if (column <= 5 && column >= 3 && (row <= 2 || row >= maxRow - 2 - 1))
            return true;
    }

    return false;
}

function check_general_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);

    if (Math.abs(column - waiting_chess_col) + Math.abs(row - waiting_chess_row) == 1)
    {
        if (column <= 5 && column >= 3 && (row <= 2 || row >= maxRow - 2 - 1))
            return true;
    }

    return false;
}

function check_line_has_num_chess(start, end, column_same, num)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);
    var i = start < end ? start + 1 : end + 1;
    var j = start > end ? start : end;
    var count = 0;

    if (column_same)
    {
        for (; i < j; i++)
        {
            if (board[index(waiting_chess_col, i)] != null)
                ++count;
            console.log("1 count is", count)
            if (count > num)
                return false;
        }
    }
    else
    {
        for (; i < j; i++)
        {
            if (board[index(i, waiting_chess_row)] != null)
                ++count;
            console.log("2 count is", count)
            if (count > num)
                return false;
        }
    }

    if (count == num)
    {
        console.log("3 it is true")
        return true;
    }

    console.log("4 Now the program return false")
    return false;
}

function check_cannon_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);
    var column_same = true;
    var num;

    if (board[index(column, row)] == null)
        num = 0;
    else /* This case we can eat the chess */
        num = 1;

    if (column == waiting_chess_col)
    {
        if (row != waiting_chess_row)
        {
                return check_line_has_num_chess(waiting_chess_row, row, column_same, num);
        }
    }
    else if (row == waiting_chess_row)
    {
            return check_line_has_num_chess(waiting_chess_col, column, !column_same, num);
    }

    /* NOTE: if the checking block is the same block as the waiting chess, it return false as well */
    return false;
}

function check_pawn_moving(column, row)
{
    var waiting_chess_col = index_col(waiting_chess_index);
    var waiting_chess_row = index_row(waiting_chess_index);

    /* Pre quick check */
    if (Math.abs(column - waiting_chess_col) + Math.abs(row - waiting_chess_row) != 1)
        return false;

    if (board[waiting_chess_index].color_int == 0) /* black chess */
    {
        if (row <= black_bound_row)
        {
            if (row > waiting_chess_row)
                return true;
        }
        else if (row >= waiting_chess_row)
            return true;
    }
    else /* red chess */
    {
        if (row >= red_bound_row)
        {
            if (row < waiting_chess_row)
            return true;
        }
        else if (row <= waiting_chess_row)
            return true;
    }

    return false;
}

function check_chess_moving(block_index)
{
    var column = index_col(block_index);
    var row = index_row(block_index);

    // lower 4 bits: 1 - rook, 2 - horse, 3 - minister, 4 - guard, 5- general, 6 - cannon, 7 - pawn
    switch (board[waiting_chess_index].name_int)
    {
    //case black_chess_name[0]:
    //case red_chess_name[0]:
    case 0:
        return check_rook_moving(column, row);
        break;
    //case black_chess_name[1]:
    //case red_chess_name[1]:
    case 1:
        return check_horse_moving(column, row);
        break;
    //case black_chess_name[2]:
    //case red_chess_name[2]:
    case 2:
        return check_minister_moving(column, row);
        break;
    //case black_chess_name[3]:
    //case red_chess_name[3]:
    case 3:
        return check_guard_moving(column, row);
        break;
    //case black_chess_name[4]:
    //case red_chess_name[4]:
    case 4:
        return check_general_moving(column, row);
        break;
    //case black_chess_name[5]:
    //case red_chess_name[5]:
    case 5:
        return check_cannon_moving(column, row);
        break;
    //case black_chess_name[6]:
    //case red_chess_name[6]:
    case 6:
        return check_pawn_moving(column, row);
        break;
    default:
        console.log("Unknown chess name:", board[waiting_chess_index].chess_name);
        break;
    }

    return false;
}





















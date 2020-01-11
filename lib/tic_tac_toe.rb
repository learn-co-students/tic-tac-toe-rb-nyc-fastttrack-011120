WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(input)
  input.to_i - 1
end

def move(board, index, character)
  board[index] = character
end

def position_taken?(board, index)
  if (board[index] == " " || board[index] == "" || board[index] == nil)
    false
  else
    true
  end
end

def valid_move?(board, index)
  if (index >= 0 && index <= 8)
    if !position_taken?(board, index)
      true
    end
  end
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board)) # call #current_player to get character
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each do |space|
    if space == "X" || space == "O"
      turns += 1
    end
  end
  turns
end

def current_player(board)
  turns = turn_count(board)
  if (turns % 2 == 0)
    "X"
  else
    "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combination
    end

    if position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combination
    end
  end

  return false
end

def full?(board)
  board_is_full = board.all? do |space|
    space == "X" || space == "O"
  end
  return board_is_full
end

def draw?(board)
  if won?(board) # BROKEN! If #won? returns an array, return false
    false
  elsif full?(board) # Draw conditions: No win and full board
    true
  else
    false
  end
end

def over?(board)
  if won?(board) || draw?(board) || full?(board)
    true
  else
    false
  end
end

def winner(board)
  win = won?(board)

  if !won?(board)
    return nil
  end

  return board[win[0]]
end

# CODE ABOVE THIS LINE IS WORKING
################################################################################
def play(board)
  puts "Welcome to Tic Tac Toe!"

  until over?(board)
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end


end

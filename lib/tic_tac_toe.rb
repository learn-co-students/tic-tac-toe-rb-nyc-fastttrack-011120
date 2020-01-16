WIN_COMBINATIONS = [[0, 1, 2],[3, 4, 5],[6, 7, 8],[0, 3, 6],[1, 4, 7],[2, 5, 8],[0, 4, 8],[6, 4, 2]]

board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  token = current_player(board)
  if valid_move?(board, index)
    move(board, index, token)
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  counter = 0
  board.each do |token|
    if(token == "X" || token == "O")
      counter += 1 
    end
  end
  return counter
end

def current_player(board)
  if turn_count(board) % 2 == 0 
    return "X"
  else return "O"
  end
end

def won?(board)
  WIN_COMBINATIONS.each do |win_Position|
    if board[win_Position[0]] == "X" &&  board[win_Position[1]] == "X" &&  board[win_Position[2]] == "X"
      return win_Position
    elsif board[win_Position[0]] == "O" &&  board[win_Position[1]] == "O" &&  board[win_Position[2]] == "O"
      return win_Position
    end
  end
  return nil
end


def full?(board)
  counter = 0
  board.each do |possible_Token|
    if possible_Token == "O" || possible_Token == "X"
      counter+=1
    end
  end
  if counter == 9
    return true
  else
    return false
  end
end

def draw?(board)
  !won?(board) && full?(board)
end

def over?(board)
  if won?(board) != nil || draw?(board) == true || full?(board) == true
    return true
  else
    return false
  end
end

def winner(board)
  if won?(board) != nil
    return board[won?(board)[0]]
  else
    return nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cat's Game!"
  end
end
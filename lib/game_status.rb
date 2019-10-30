# Helper Method
def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [6, 4, 2]
  ]

# helper to seperate x pos & y pos into object to compare between win combos.
def turn_arr(board)
  { 
    x: board.each_index.select { |x| board[x] == 'X' },
    o: board.each_index.select { |o| board[o] == 'O' }
  }
end


def won?(board)
  if board.uniq.count <= 1
    return false
  end
  combos = WIN_COMBINATIONS
  turns = turn_arr(board)
  
  check_x = nil
  check_o = nil
  
  combos.each do |c|
    if (c & turns[:x]).length == 3
     check_x = c
     break
    elsif (c & turns[:o]).length == 3
      check_o = c
      break
    end
  end
  
  # easily could add winner('x') / winner('o') to print out winner
  if !check_x.nil?
    return check_x
  elsif !check_o.nil?
    return check_o
  end
  
end

def full?(board)
  board.count { |b| b != " " } >= board.size ? true : false
end
  
def draw?(board)
  
  # return true for draw
  # return false for game won top row
  # return false for game won diagnaly
  # return false for in progress game
  
  return !won?(board) && full?(board) ? true : false
end

def over?(board)

  # return true for draw
  # return true for game won with full board
  # return true for game won with non-full board
  # return false for an in-progress game
  
  if won?(board) or draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  
  # return x winner
  # return o winner
  # return nil for no winner
  
  combos = WIN_COMBINATIONS
  turns = turn_arr(board)
  x = 0
  combos.each do |c|
    if (c & turns[:x]).length == 3
      break 'X'
    elsif (c & turns[:o]).length == 3
      break 'O'
    end
    x += 1
    break nil if combos.count == x
  end
end


# empty board
won?([" ", " ", " ", " ", " ", " ", " ", " ", " "])

# draw | no win
won?(["X", "O", "X", "O", "X", "X", "O", "X", "O"])

# top row win
won?(["X", "X", "X", "O", "O", " ", " ", " ", " "])

# middle row win
won?(["O", "O", " ", "X", "X", "X", " ", " ", " "])

# bottom row win
won?([" ", " ", " ", "O", "O", " ", "X", "X", "X"])

# left column win
won?(["O", " ", "X", "O", " ", "X", "O", " ", " "])

# middle colomn win
won?(["X", "O", " ", "X", "O", " ", " ", "O", " "])

# right column win
won?(["X", " ", "O", "X", " ", "O", " ", " ", "O"])

# left diagnal win
won?(["X", " ", "O", " ", "X", "O", " ", " ", "X"])

# right diagnal win
won?(["X", " ", "O", "X", "O", " ", "O", " ", " "])

#winner(["X", " ", " ", " ", "X", " ", " ", " ", "X"])



class TicTacToe

  WIN_COMBINATIONS =
  [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
   puts "-----------"
   puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
   puts "-----------"
   puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(index)
    input_to_index = index.to_i - 1
    input_to_index
  end

  def move(index, move = "X")
    @board[index] = move
  end

  def position_taken?(index) #return false if position is free
    #position = input_to_index(index)
    @board[index] == 'X' || @board[index] == 'O'
  end

  def valid_move?(index) #if index between 1-9 and not taken
    index.between?(0,8) && !position_taken?(index)
  end

  def turn_count #returns the number of turns that have been played
    @board.count { |turn| turn == 'X' || turn == 'O'}
  end

  def current_player #determine if its X or O player turn (x if even)
      if turn_count.even?
        current_player = "X"
      else
        current_player = "O"
      end
  end

  def turn
    puts "Please enter turn: 1-9"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      player = current_player
      move(index, player)
      display_board
    else
      puts "Please enter turn: 1-9"
      turn
    end
  end

  def won? #return false/nil if no WIN_COMBINATIONS or return WIN_COMBINATIONS if a win
    WIN_COMBINATIONS.each do |winner| #comes out with [0,1,2]

      win_index_1 = winner[0]
      win_index_2 = winner[1]
      win_index_3 = winner[2]

      position_1 = @board[win_index_1] #store board position 0
      position_2 = @board[win_index_2] #store board position 1
      position_3 = @board[win_index_3] #store board position 2

        if position_1 == "X" && position_2 == "X" && position_3 == "X"
          return winner
        elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
          return winner
        end
      end
      false
  end


  def full? #if every position is taken
    @board.all? do |position|
      if position == "X" || position == "O"
        true
      else
        false
      end
    end
  end

  def draw?
    full_board = full?
    won_board = won?

      if won_board == false && full_board == false
        false
      elsif won_board != false
        false
      else
        true
      end
  end

  def over?
    draw? || won?
  end

  def winner
    if won? != false
      win_combo = won?
      win_char = win_combo[0]
      position_win = @board[win_char]
      position_win
    else
      nil
    end
  end

  def play
    turn until over?
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
  end
end

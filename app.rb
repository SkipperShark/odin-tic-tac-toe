# * pseudocode
# display the board to the user
# show the user how to play
# show the user what number to enter (e.g. 1 is the top left most board, 9 is the bottom right)
# 2 means to put a mark on item 2
# * show which player's turn it is (e.g. if player 1, then show "player 1 (X guy)'s' turn, select where you would like to put an X")
# * after the user makes a choice
# * show the board state after choice
# * run some validation
# * dont allow user to put a mark where a mark is already there
# * after the user places a mark, check whether anyone has lost
# * check for draw condition
# * show who won
# * ask if users would like to play again

# Represents the tic tac toe board
class Board
  PLAYER_1_TURN_PROMPT = "Player 1's turn!, enter where you would like to mark an X".freeze
  PLAYER_2_TURN_PROMPT = "Player 2's turn!, enter where you would like to mark an O".freeze
  attr_accessor :board, :mark_types

  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
    @sample_board_position = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ]
    @mark_types = %w[X O x o]
    @victor = nil
  end

  def introduction
    puts "Welcome to tic-tac-toe!\n\nHow to play\n\n"
    puts 'Shown below is how the tic tac toe board is presented (with no marks yet)'
    display(@board)
    puts "\nThe position of each space is represented by a number, as seen below"
    display(@sample_board_position)
    puts "\nUpon the game prompting you for your turn, enter the position you would like to put your mark"
    puts "\nLet's demo how the first round might look like"
    puts "\n#{PLAYER_1_TURN_PROMPT}"
    puts "Player 1's choice : 5\nThe board will then look like;"
    demo_board = Board.new
    demo_board.mark(5, 'X')
    puts "\n#{PLAYER_2_TURN_PROMPT}\nPlayer 2's choice : 9"
    puts "\nThe board will then look like;"
    demo_board.mark(9, 'O')
  end

  def play
    while @victor.nil?

      p1_choice = nil
      until valid_position?(p1_choice)
        puts PLAYER_1_TURN_PROMPT
        p1_choice = gets.chomp
        puts "#{position} is an invalid position!"
      end
      self.victor = 'Player 1'

    end
  end

  def mark(position, mark_type)
    return unless is_valid_position?(position)

    row = get_row_index_by_position(position)
    column = get_col_index_by_position(position)
    board[row][column] = mark_type
    display(@board)
  end

  private

  def valid_position?(position)
    return false unless position.is_a?(Integer)
    return false unless position.positive && position <= 9

    true
  end

  def display(board)
    board.each do |row|
      row.each.with_index do |col, i|
        display_space(col, i)
      end
      print "\n"
    end
  end

  def display_space(space, index)
    print '|'
    empty_space = space.nil? ? true : false
    empty_space ? (print '   ') : (print " #{space} ")
    print '|' if index == 2
  end

  def get_row_index_by_position(position)
    ((position - 1) / 3).to_i
  end

  def get_col_index_by_position(position)
    ((position - 1) % 3).to_i
  end
end

board = Board.new
board.introduction
# board.display
# board.mark(5, 'X')

# def get_row(num)
#   ((num - 1) / 3).to_i
# end

# def get_col(num)
#   ((num - 1) % 3).to_i
# end
# puts "1, row : #{get_row(1)}, col : #{get_col(1)}"
# puts "2, row : #{get_row(2)}, col : #{get_col(2)}"
# puts "3, row : #{get_row(3)}, col : #{get_col(3)}"
# puts "4, row : #{get_row(4)}, col : #{get_col(4)}"
# puts "5, row : #{get_row(5)}, col : #{get_col(5)}"
# puts "6, row : #{get_row(6)}, col : #{get_col(6)}"
# puts "7, row : #{get_row(7)}, col : #{get_col(7)}"
# puts "8, row : #{get_row(8)}, col : #{get_col(8)}"
# puts "9, row : #{get_row(9)}, col : #{get_col(9)}"

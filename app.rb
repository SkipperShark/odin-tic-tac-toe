# * pseudocode
# * display the board to the user
# * show the user how to play
# * show the user what number to enter (e.g. 1 is the top left most board, 9 is the bottom right)
# * 2 means to put a mark on item 2
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
  attr_accessor :board, :mark_types

  @mark_types = %w[X O x o]

  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
    @mark_types = %w[X O x o]
  end

  def display
    @board.each do |row|
      row.each.with_index do |col, i|
        display_space(col, i)
      end
      print "\n"
    end
  end

  def mark(position, mark_type)
    invalid_position = position <= 0 || position > 9
    if invalid_position
      puts "#{position} is an invalid position!"
      return
    end

    valid_mark_type = mark_types.include?(mark_type)
    unless valid_mark_type
      puts "#{mark_type} is an invalid mark type!"
      return
    end

    row = (position / 3).to_i
    column = (position % 3) - 1
    board[row][column] = mark_type
    puts "\n\n"
    display
  end

  private

  def display_space(space, index)
    print '|'
    empty_space = space.nil? ? true : false
    empty_space ? (print '   ') : (print " #{space} ")
    print '|' if index == 2
  end
end

board = Board.new
board.display
board.mark(5, 'X')

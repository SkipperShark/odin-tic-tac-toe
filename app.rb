#* pseudocode
#* display the board to the user
#* show the user how to play
  #* show the user what number to enter (e.g. 1 is the top left most board, 9 is the bottom right)
  #* 2 means to put a mark on item 2
  #* show which player's turn it is (e.g. if player 1, then show "player 1 (X guy)'s' turn, select where you would like to put an X")
#* after the user makes a choice
  #* show the board state after choice
  #* run some validation
  #* dont allow user to put a mark where a mark is already there
  #* after the user places a mark, check whether anyone has lost
  #* check for draw condition
  #* show who won
#* ask if users would like to play again

class Board
  attr_accessor :board
  def initialize
    @board = [
      [nil, nil, nil],
      [nil, nil, nil],
      [nil, nil, nil]
    ]
  end

  def display
    pp @board
    @board.each do |row|
      puts row
      puts row.class
      row.each do |col|
        print "#{col}|"
      end
      print "\n"
    end
  end
end

board = Board.new
board.display

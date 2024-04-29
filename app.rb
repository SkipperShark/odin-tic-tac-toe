# * pseudocode
# display the board to the user
# show the user how to play
# show the user what number to enter (e.g. 1 is the top left most board, 9 is the bottom right)
# 2 means to put a mark on item 2
# show which player's turn it is (e.g. if player 1, then show "player 1 (X guy)'s' turn, select where you would like to put an X")
# after the user makes a choice show the board state after choice
# * run some validation
# dont allow user to put a mark where a mark is already there
# after the user places a mark, check whether anyone has won
#* check who won
# for some reason, the while loop doesnt end when we set the victor to a string
  # it's because we need to use either @victor or self.victor
# * check for draw condition
# * show who won
# * ask if users would like to play again

# Represents the tic tac toe board
class Board
  PLAYER_1_TURN_PROMPT = "Player 1's turn!, enter where you would like to mark an X".freeze
  PLAYER_2_TURN_PROMPT = "Player 2's turn!, enter where you would like to mark an O".freeze
  attr_accessor :board, :mark_types, :victor, :player_1_turn
  attr_reader :num_rows, :num_cols, :num_marks_to_win

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
    @player_1_turn = true
    @num_rows = @board.length
    @num_cols = num_rows
    @num_marks_to_win = num_cols
    # pp @sample_board_position
    # pp @sample_board_position.transpose
    # pp (0...@board.length).collect {|i| @sample_board_position[i][i]}
    # pp (0...@board.length).collect {|i| @sample_board_position.map(&:reverse) [i][i]}
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
    puts "----- End of introduction -----\n\n"
  end

  def play(with_introduction: false)
    introduction if with_introduction == true
    puts "TicTacToe game start\nBoard State"
    display(board)
    begin
      while @victor.nil?

        player_1_turn ? (puts PLAYER_1_TURN_PROMPT) : (puts PLAYER_2_TURN_PROMPT)

        p_choice = nil
        loop do
          p_choice = gets.chomp

          unless valid_position?(p_choice)
            puts "Error : #{p_choice} is an invalid position :( Please try again!\n"
            next
          end

          p_choice = valid_position?(p_choice) ? p_choice.to_i : p_choice

          unless space_empty?(p_choice)
            puts "Error : #{p_choice} already has a mark. Please try again!\n"
            next
          end

          break
        end
        mark(p_choice)
        display(@board)


        # puts "game_end_condition_met : #{check_game_end_condition}"
        # puts "player_1_turn : #{player_1_turn}"

        if check_game_end_condition
          self.victor = player_1_turn ? "player 1 (X)" : "player 2 (O)"
        end

        puts "victor : #{victor}"
        puts "victor.nil : #{victor.nil?}"

        self.player_1_turn = !player_1_turn

      end

      puts "winner : #{victor}"

    rescue Interrupt
      puts "\nGame manually ended"
    end
  end

  def mark(position)
    return unless valid_position?(position)
    mark_type = player_1_turn ? 'X' : 'O'
    row = get_row_index_by_position(position)
    column = get_col_index_by_position(position)
    board[row][column] = mark_type
  end

  private

  def check_game_end_condition

    end_condition = {
      :end_condition_met : false,
      :draw : false
    }

    # check horizontally
    board.each do |row|
      num_same_marks = row.count { |space| space == row.first && !space.nil?}
      end_condition[:end_condition_met] = true if num_same_marks >= num_marks_to_win
      return end_condition
    end

    # check vertically
    board.transpose.each do |row|
      num_same_marks = row.count { |space| space == row.first && !space.nil?}
      end_condition[:end_condition_met] = true if num_same_marks >= num_marks_to_win
      return end_condition
    end

    # check diagonally (top left to bottom right)
    diag_spaces = (0...num_rows).collect{|i| board[i][i]}
      end_condition[:end_condition_met] = true if diag_spaces.count{|space| space == diag_spaces.first && !space.nil?} >= num_marks_to_win
      return end_condition
    end

    # check diagonally (top right to bottom left)
    diag_spaces = (0...num_rows).collect{|i| board.map(&:reverse)[i][i]}
    end_condition[:end_condition_met] = true if diag_spaces.count{|space| space == diag_spaces.first && !space.nil?} >= num_marks_to_win
    return end_condition

    # check for draw condition
    board.each do |row|
      end_condition[:draw] = true if  row.count { |space| space.nil?} == num_rows * num_cols
      return end_condition
    end

  end

  def valid_position?(position)
    return false unless position.to_i.positive? && position.to_i <= 9

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

  def space_empty?(position)
    row = get_row_index_by_position(position)
    column = get_col_index_by_position(position)
    board[row][column].nil?
  end

  def get_row_index_by_position(position)
    ((position - 1) / 3).to_i
  end

  def get_col_index_by_position(position)
    ((position - 1) % 3).to_i
  end
end

board = Board.new
board.play(with_introduction: false)
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

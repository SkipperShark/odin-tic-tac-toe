# frozen_string_literal: true

# Represents the tic tac toe board
class Board
  attr_accessor :board, :victor, :player_1_turn
  attr_reader :num_rows, :num_cols, :num_marks_to_win, :sample_board_position

  def initialize
    setup
  end

  def mark(position, player_1_turn)
    return unless valid_position?(position)

    mark_type = player_1_turn ? 'X' : 'O'
    row = get_row_index_by_position(position)
    column = get_col_index_by_position(position)
    board[row][column] = mark_type
  end

  def display(display_sample_board: false)
    board_to_display = display_sample_board == true ? sample_board_position : board
    board_to_display.each do |row|
      row.each.with_index do |col, i|
        display_space(col, i)
      end
      print "\n"
    end
  end

  def check_game_end_condition
    end_condition = { end_condition_met: false, draw: false }
    if winner_found_horizontally || winner_found_vertically || winner_found_diagonally
      end_condition[:end_condition_met] = true
      return end_condition
    end

    if draw_found
      end_condition[:end_condition_met] = true
      end_condition[:draw] = true

    end
    end_condition
  end

  def valid_position?(position)
    return false unless position.to_i.positive? && position.to_i <= 9

    true
  end

  private

  def winner_found_horizontally
    board.each do |row|
      num_same_marks = row.count { |space| space == row.first && !space.nil? }
      return true if num_same_marks >= num_marks_to_win
    end
  end

  def winner_found_vertically
    board.transpose.each do |row|
      num_same_marks = row.count { |space| space == row.first && !space.nil? }
      return true if num_same_marks >= num_marks_to_win
    end
  end

  def winner_found_diagonally
    # check diagonally (top left to bottom right)
    diag_spaces = (0...num_rows).collect { |i| board[i][i] }
    return true if diag_spaces.count { |space| space == diag_spaces.first && !space.nil? } >= num_marks_to_win

    # check diagonally (top right to bottom left)
    diag_spaces = (0...num_rows).collect { |i| board.map(&:reverse)[i][i] }
    true if diag_spaces.count { |space| space == diag_spaces.first && !space.nil? } >= num_marks_to_win
  end

  def draw_found
    all_spaces_marked_but_no_winner = board.flatten.count { |space| !space.nil? } == num_rows * num_cols
    true if all_spaces_marked_but_no_winner
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

  def setup
    @board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
    @sample_board_position = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @num_rows = @board.length
    @num_cols = num_rows
    @num_marks_to_win = num_cols
  end
end

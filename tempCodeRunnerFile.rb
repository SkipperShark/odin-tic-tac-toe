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
    # pp @sample_board_position
    # pp @sample_board_position.transpose
    pp (0...@board.length).collect {|i| @sample_board_position[i][i]}
    pp (0...@board.length).collect {|i| @sample_board_position.map(&:reverse) [i][i]}
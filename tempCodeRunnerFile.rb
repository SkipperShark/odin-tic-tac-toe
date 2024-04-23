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
    puts @board.length
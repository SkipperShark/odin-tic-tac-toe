# frozen_string_literal: true

require_relative 'board'

# contains logic to play the tic tac toe game
class Game
  PLAYER_1_TURN_PROMPT = "Player 1's turn!, enter where you would like to mark an X"
  PLAYER_2_TURN_PROMPT = "Player 2's turn!, enter where you would like to mark an O"
  attr_accessor :victor, :player_1_turn, :board

  def initialize
    setup
  end

  def introduction
    puts "Welcome to tic-tac-toe!\n\nHow to play\n\n"
    puts 'Shown below is how the tic tac toe board is presented (with no marks yet)'
    board.display
    puts "\nThe position of each space is represented by a number, as seen below"
    board.display(display_sample_board: true)
    puts "\nUpon the game prompting you for your turn, enter the position you would like to put your mark"
    puts "\nLet's demo how the first round might look like"
    puts "\n#{PLAYER_1_TURN_PROMPT}"
    puts "Player 1's choice : 5\nThe board will then look like;"
    demo_board = Board.new
    demo_board.mark(5, player_1_turn: true)
    demo_board.display
    puts "\n#{PLAYER_2_TURN_PROMPT}\nPlayer 2's choice : 9"
    puts "\nThe board will then look like;"
    demo_board.mark(9, player_1_turn: false)
    demo_board.display
    puts "----- End of introduction -----\n\n"
  end

  def play(with_introduction: false)
    introduction if with_introduction == true
    board.display

    puts "TicTacToe game start\nBoard State"
    begin
      while @victor.nil?

        player_1_turn ? (puts PLAYER_1_TURN_PROMPT) : (puts PLAYER_2_TURN_PROMPT)

        p_choice = nil
        loop do
          p_choice = gets.chomp

          unless board.valid_position?(p_choice)
            puts "Error : #{p_choice} is an invalid position :( Please try again!\n"
            next
          end

          p_choice = board.valid_position?(p_choice) ? p_choice.to_i : p_choice

          unless board.space_empty?(p_choice)
            puts "Error : #{p_choice} already has a mark. Please try again!\n"
            next
          end

          break
        end
        board.mark(p_choice, player_1_turn)
        board.display

        game_state = board.check_game_end_condition
        winner_found = game_state[:end_condition_met] == true && game_state[:draw] == false
        self.victor = player_1_turn ? 'player 1 (X)' : 'player 2 (O)' if winner_found

        draw = game_state[:end_condition_met] == true && game_state[:draw] == true
        self.victor = "Noone! It's a draw!" if draw

        self.player_1_turn = !player_1_turn
      end

      puts "winner : #{victor}"

      puts 'Game Ended, would you like to play again? (Y/N)'
      user_input = nil
      until %w[Y,N].include? user_input
        user_input = gets.chomp.upcase

        if user_input == 'Y'
          setup
          play
        elsif user_input == 'N'
          puts 'Game Ended'
          break
        else
          puts "I'm not sure what you mean, please try again"
        end
      end
    rescue Interrupt
      puts "\nGame manually ended"
    end
  end

  def setup
    @victor = nil
    @player_1_turn = true
    @board = Board.new
  end
end

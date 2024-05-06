require_relative "module/get_user_input"
require_relative "game_board"
require_relative "player"
require_relative "game_stats"
require_relative "game_display"

class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]

  include GetUserInput

  attr_reader :game_board, :players, :stats, :display


  def game_error class_name, function_name, error_message
    "#{class_name}.#{function_name}  ERROR: #{error_message}"
  return

  def return_user_input message, multi_entry, user_options
    GetUserInput.return_user_input message, multi_entry, user_options
  end

  def initialize
    @display = GameDisplay.new
    self.display.display_title

    @players = []
    until Player.get_free_players.empty? do
      name = self.return_user_input message, false
      self.players.push Player.new name
    end

    @game_board = GameBoard.new
    @stats = GameStats.new
  end

  def play_turn
    current_player = self.players[0]
    matrix = self.game_board.game_matrix
    self.display.display_board self.game_board
    self.display.display_hud self.players, self.stats

    coordinates = self.return_user_input "#{current_player.name}, your turn!"
    matrix.assign_piece current_player.player, coordinates

    # move the top player (the one whose turn it currently is) last
    @players.push @players.unshift

    matrix.check_winner
  end

  def play_game
    is_quit = nil
    until is_quit do
      is_winner = false
      until is_winner do
        is_winner = self.play_turn
      end
      self.game_board.game_matrix.assign_winner is_winner
      msg = "#{current_player.name}, your turn!"
      is_quit = coordinates = self.return_user_input
    end
  end

  def next_round

  end


end

require_relative "module/get_user_input"
require_relative "module/game_error"
require_relative "game_board"
require_relative "player"
require_relative "game_stats"
require_relative "game_display"
require_relative "game_save"

class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]
  USER_OPTIONS = {
    start: "o",
    quit: "q",
    save: "s",
    load: "l"
  }

  include GetUserInput
  include GameError

  attr_reader :game_board, :players, :stats, :display, :save

  def process_user_option input
    return unless USER_OPTIONS.has_val? input
    command = USER_OPTIONS.key input
    command || false
  end

  def get_current_player
    self.players[0]
  end

  def get_next_player
    self.players[1]
  end

  def return_user_input message, multi_entry, user_options
    GetUserInput.return_user_input message, multi_entry, user_options
  end

  def initialize
    @display = GameDisplay.new
    self.display.display_title

    @players = []
    until Player.get_free_players.empty? do
      msg = "What would you like us to call you this round?"
      name = self.return_user_input msg, false
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
      until @stats.winner do
        @stats.winner = self.play_turn
      end
      self.game_board.game_matrix.assign_winner is_winner
      msg = "#{current_player.name}, your turn!"
      is_quit = coordinates = self.return_user_input
    end
  end

  def next_round

  end


end

require_relative "module/get_user_input"
require_relative "module/game_error"

class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]

  include GetUserInput

  attr_reader :game_board, :players, :stats, :sq_rows, :sq_cols


  def populate_title

  end

  def populate_hud

  end

  def display_screen
    self.game_board.populate_board
    populate_hud

  end

  def get_player_input

  end

  def assign_piece coordinates

  end

  def play_turn
    draw_title
    draw_hud
    draw_board

    player_input = get_player_input
    assign_piece player_input

    check_winner
  end

  def play_again

  end

  def play_game
    is_quit = nil
    until is_quit do
      is_winner = false
      until is_winner do
        is_winner = play_turn
      end
      assign_winner is_winner
      is_quit = play_again
    end
  end

  def next_player
    # move the top player (the one whose turn it currently is) last
    @players.push @players.unshift
  end

  def initialize
    cls_name = "TicTacToe"
    func_name = "initialize"
    begin
      @players = []
      until Player.get_free_players.empty? do
        name = GetUserInput.return_user_input message, false
        self.players.push Player.new name
      end

      @game_board = GameBoard.new
      @stats = {
        score: {x: 0, o: 0}
        turn: {x: 0, o: 0}
        round: 0
        }
    end

  end

  def change_turn

  end

end

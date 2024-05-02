require_relative "../module/get_user_input.rb"

class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]

  include GetUserInput

  attr_reader :game_board, :players, :stats, :sq_rows, :sq_cols


  def self.game_error error_prefix, error_message
    error_prefix + ": " + error_message
  return


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
    err_prefix = "TicTacToe.initialize ERROR"
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


  def check_winner
    is_column_win = self.game_board.check_column
    return is_column_win if is_column_win

    is_row_win = self.game_board.check_row
    return is_row_win if is_row_win

    is_diagonal_win = self.game_board.check_diagonal
    return is_diagonal_win if is_diagonal_win

    false
  end


end

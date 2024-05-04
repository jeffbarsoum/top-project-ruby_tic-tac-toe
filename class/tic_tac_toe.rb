require_relative "module/get_user_input"
require_relative "module/game_error"

class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]

  include GetUserInput

  attr_reader :game_board, :players, :stats, :sq_rows, :sq_cols


  def display_title
    msg_title <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO


    STRING
    puts msg_title
  end

  def display_spacing
    msg_spacing <<-STRING

    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
    puts msg_spacing

  end

  def display_hud
    p1 = self.players[0]
    p2 = self.players[1]
    p1_score = self.stats[:score][p1.player.to_sym]
    p2_score = self.stats[:score][p2.player.to_sym]
    p1_turn = self.stats[:turn][p1.player.to_sym]
    p2_score = self.stats[:turn][p2.player.to_sym]
    rnd = self.stats[:round]

    msg_hud <<-STRING

    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Round ##{rnd}, Turn ##{p1_turn}
    ------------------------------------------------------------------------------------
    #{p1.name}'s Turn:
    ------------------------------------------------------------------------------------
    #{p1.name} (#{p1})                                            #{p2.name} (#{p2})
    ----------------------                                        ----------------------
    score: #{p1_score}                                            score: #{p2_score}
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
    puts msg_hud
  end


  def play_turn
    display_spacing
    self.game_board.display_board
    display_spacing
    display_hud

    player_input = get_player_input
    assign_piece player_input

    # move the top player (the one whose turn it currently is) last
    @players.push @players.unshift

    check_winner
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

  def initialize
    display_title
    @players = []
    until Player.get_free_players.empty? do
      name = GetUserInput.return_user_input message, false
      self.players.push Player.new name
    end

    @game_board = GameBoard.new
    @stats = GameStats.new
  end

end

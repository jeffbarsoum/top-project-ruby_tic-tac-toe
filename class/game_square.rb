require_relative "tic_tac_toe"
require_relative "../module/game_data"

class GameSquare < TicTacToe
  attr_reader :coordinates, :player, :square

  def initialize coordinates, player = nil
    err_prefix = "GameSquare.initialize ERROR"
    begin
      player_id = player.to_sym
      @square = SQUARES[player_id]
      @coordinates = coordinates
      @player = player

      raise BadPlayerError unless SQUARES.key? player_id
      raise BadPixelError unless is_correct_pixel

      self.square
    rescue BadPlayerError
      msg_bad_player_error = "choices are 'x', 'o' or 'nil' (for the game board)"
      puts TicTacToe.game_error err_prefix, msg_bad_player_error
    rescue BadPixelError
      msg_bad_pixel_error <<-STRING
        each entry in the square array represents one pixel, and must be
        exactly one character long
      STRING
      puts TicTacToe.game_error err_prefix, msg_bad_pixel_error
    end
  end

  def is_correct_pixel
    self.square.reduce true do |is_row_one_pixel, pixel_row|
      pixel_row.reduce is_row_one_pixel do |is_one_pixel, pixel|
        break false unless is_one_pixel
        is_one_pixel &&  pixel.length == 1
      end
    end
  end


  def assign_player player
    err_prefix = "GameSquare.assign_square ERROR"
    begin
      raise PlayerAssignError unless @player.nil?
      @player = player
      @square = SQUARES[player.to_sym][:place]
    rescue PlayerAssignError
      msg_player_assigned_error <<-STRING
        square #{coordinates} is already assigned to player #{player}
      STRING
      puts TicTacToe.game_error err_prefix, msg_player_assigned_error
    end
  end

  def assign_win win_type
    err_prefix = "GameSquare.assign_win ERROR"
    begin
      raise WinAssignError if @player.nil?
      @square = SQUARES[self.player.to_sym][win_type.to_sym]
    rescue WinAssignError
      msg_win_assigned_error <<-STRING
        square must be assigned a player before it can be assigned
        a win!
      STRING
      puts TicTacToe.game_error err_prefix, msg_win_assigned_error
    end

  def to_s
    puts self.player
  end

end

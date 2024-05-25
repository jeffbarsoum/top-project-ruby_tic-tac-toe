require_relative "matrix"
require_relative "../module/data"


class Square < Matrix
  include Data

  attr_reader :coordinates, :player, :square


  def error class_name, function_name, error_message
    super class_name, function_name, error_message
  end


  def initialize coordinates, player = nil
    cls_name = "Square"
    func_name = "initialize"
    begin
      player_id = player.to_sym
      @square = SQUARES[player_id]
      @coordinates = coordinates
      @player = player

      raise BadPlayerError unless SQUARES.key? player_id
      raise BadPixelError unless is_correct_pixel
      raise SquareSizeError unless self.is_correct_dim

      self.square
    rescue BadPlayerError
      msg_bad_player_error = "choices are 'x', 'o' or 'nil' (for the game board)"
      puts self.error cls_name, func_name, msg_bad_player_error
    rescue BadPixelError
      msg_bad_pixel_error <<-STRING
        each entry in the square array represents one pixel, and must be
        exactly one character long
      STRING
      puts self.error cls_name, func_name, msg_bad_pixel_error
    rescue SquareSizeError
      msg_square_size_error <<-STRING
        drawn square must be an array containing #{sq_rows} arrays,
        each containing #{sq_cols} string entries
      STRING
      puts self.error cls_name, func_name, msg_square_size_error
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

  def is_correct_dim
    self.square.reduce true do |is_correct_rows, pixel_row|
      break false unless square_array.length == self.sq_rows
      is_correct_rows && pixel_row.length == self.sq_cols
    end
  end


  def assign_player player
    err_prefix = "Square.assign_player ERROR"
    begin
      raise PlayerAssignError unless @player.nil?
      @player = player
      @square = SQUARES[player.to_sym][:place]
    rescue PlayerAssignError
      msg_player_assigned_error <<-STRING
        square #{coordinates} is already assigned to player #{player}
      STRING
      puts self.error err_prefix, msg_player_assigned_error
    end
  end

  def assign_win win_type
    err_prefix = "Square.assign_win ERROR"
    begin
      raise WinAssignError if @player.nil?
      @square = SQUARES[self.player.to_sym][win_type.to_sym]
    rescue WinAssignError
      msg_win_assigned_error <<-STRING
        square must be assigned a player before it can be assigned
        a win!
      STRING
      puts self.error err_prefix, msg_win_assigned_error
    end

  def to_s
    puts self.player
  end

end

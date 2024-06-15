require "matrix"
require "data"
require "error"


class Square < Matrix
  include Data
  include Error

  attr_reader :coordinates, :player, :square


  def initialize coordinates
    cls_name = "Square"
    func_name = "initialize"
    begin
      @player = player.to_sym
      @square = Data.nil_square coordinates[:text]
      @coordinates = coordinates

      raise BadPixelError unless self.is_correct_pixel
      raise SquareSizeError unless self.is_correct_dim

      self.square
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

  def is_assigned
    self.player ? true : false
  end

  def assign_player player
    err_prefix = "Square.assign_player ERROR"
    begin
      raise PlayerAssignError if self.is_assigned
      @player = player
      @square = Data.square player
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
      @square = Data.square self.player, win_type.to_sym
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

  def save
    @game_save[:coordinates] = self.coordinates
    @game_save[:player] = self.player
    @game_save[:square] = self.square
    self.game_save
  end

  def load game_save
    self.game_save = game_save
    @player = game_save[:player]
    @coordinates = game_save[:coordinates]
    @square = game_save[:square]
  end


end

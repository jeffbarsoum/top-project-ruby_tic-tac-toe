require "matrix"
require "data"

class Square
  include DataSquares

  attr_reader :coordinates, :player, :square
  attr_accessor :game_save


  def initialize coordinates
    @player = nil
    @square = self.nil_square coordinates[:text]
    @coordinates = coordinates
    @game_save = {}
  end

  def is_assigned?
    self.player ? true : false
  end

  def assign_player player
    return false if self.is_assigned
    @player = player
    @square = self.square player
  end

  def assign_win win_type
    @square = self.square self.player, win_type
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

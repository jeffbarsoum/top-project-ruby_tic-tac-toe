require 'matrix'
require 'data'

class TicTacToe::Square
  include DataSquares

  attr_reader :coordinates, :player, :square
  attr_accessor :game_save

  def initialize(coordinates)
    @player = nil
    @square = nil_square coordinates[:text]
    @coordinates = coordinates
    @game_save = {}
  end

  def is_assigned?
    player ? true : false
  end

  def assign_player(player)
    return false if is_assigned

    @player = player
    @square = square player
  end

  def assign_win(win_type)
    @square = square player, win_type
  end

  def to_s
    puts player
  end

  def save
    @game_save[:coordinates] = coordinates
    @game_save[:player] = player
    @game_save[:square] = square
    game_save
  end

  def load(game_save)
    self.game_save = game_save
    @player = game_save[:player]
    @coordinates = game_save[:coordinates]
    @square = game_save[:square]
  end
end

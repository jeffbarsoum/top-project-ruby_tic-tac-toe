require 'lib/class/player_computer'

class TicTacToe::PlayerComputer < PlayerComputer
  attr_reader :name, :player, :score

  def initialize(name, player_id)
    @name = name
    @player = player_id
    @score = 0
  end

  def add_score
    self.score += 1
  end

  def to_s
    puts player
  end

  def get_closest_win(player, matrix); end
end
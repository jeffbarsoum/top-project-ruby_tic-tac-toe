class Player
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
end

class GameStats
  def initialize
    @stats[:score] = {x: 0, o: 0}
    @stats[:turn] = {x: 0, o: 0}
    @stats[:round] = 0
  end

  def score
    @stats[:score]
  end

  def turn
    @stats[:turn]
  end

  def round
    @stats[:round]
  end

  def add_stat stat, player = nil
    return @stats[stat.to_sym] += 1 if stat.to_sym == :round
    @stats[stat.to_sym][player.to_sym] += 1
  end
end

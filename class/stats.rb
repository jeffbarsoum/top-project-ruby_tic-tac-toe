class Stats

  attr_reader :stats


  def initialize
    @stats = {}
    @stats[:score] = {x: 0, o: 0, draw: 0}
    @stats[:turn] = {x: 0, o: 0}
    @stats[:round] = 0
    @stats[:winner] = false
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

  def winner
    @stats[:winner]
  end

  def winner = w
    @stats[:winner] = w
  end

  def add_stat stat, data = nil
    return @stats.[stat.to_sym] = data if stat.to_sym == :winner && data.is_a?
    return @stats[stat.to_sym] += 1 if stat.to_sym == :round
    @stats[stat.to_sym][data.to_sym] += 1
  end
end

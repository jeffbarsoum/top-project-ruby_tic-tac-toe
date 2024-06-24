# frozen_string_literal: true

class Stats
  attr_reader :stats

  def initialize
    @stats = {}
    @stats[:score] = { x: 0, o: 0, draw: 0 }
    @stats[:turn] = { x: 0, o: 0 }
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

  def add_score(player)
    @stats[:score][player.to_sym] += 1
  end

  def add_turn(player)
    @stats[:turn][player.to_sym] += 1
  end

  def add_round
    @stats[:round] += 1
  end

  def add_winner(data)
    return @stats[:winner] = data if data.is_a? 'Hash'

    false
  end
end

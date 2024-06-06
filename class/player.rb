require "error"

class Player

  @@free_players = [:x, :o]
  @@chosen_players = []
  @@players = []

  attr_reader :name, :player, :score


  def self.choose_player
    player_index = @@free_players.length > 1 ? Random.rand().round : 0
    choose_player = @@free_players.slice! player_index
    @@chosen_players.push choose_player
    choose_player
  end

  def self.free_players
    @@free_players
  end

  def self.chosen_players
    @@chosen_players
  end

  def self.player_join=p
    @@players.push p
  end

  def get_players index = nil
    return @@players[index] if index
    @@players
  end


  def initialize name
    begin
      raise NoFreePlayerError if @@free_players.empty?

      @name = name
      @player = self.class.choose_player
      @score = 0
      self.class.player_join = self
    rescue NoFreePlayerError
      self.error "All players selected!"
    end
  end

  def add_score
    self.score += 1
  end

  def to_s
    puts self.player
  end

end

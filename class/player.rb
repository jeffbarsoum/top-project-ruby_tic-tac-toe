require_relative "tic_tac_toe"

class Player < TicTacToe
  @@free_players = [:x, :o]
  @@chosen_players = []
  attr_reader :name, :player, :score

  def initialize name
    begin
    rescue NoFreePlayerError
      puts "ERROR: All players selected!"
    else
      raise NoFreePlayerError if @@free_players.empty?

      @name = name
      @player = self.class.choose_player
      @score = 0


      puts "Hello, #{self.name}, you will be '#{self.player}''s"
    end
  end

  def self.choose_player
    player_index = @@free_players.length > 1 ? Random.rand().round : 0
    choose_player = @@free_players.slice! player_index
    @@chosen_players.push choose_player
    choose_player
  end

  def self.get_free_players
    @@free_players
  end

  def self.get_chosen_players
    @@chosen_players
  end

  def add_score
    self.score += 1
  end

  def to_s
    puts self.player
  end

end

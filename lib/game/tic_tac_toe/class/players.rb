require "lib/class/players"

class TicTacToe::Players < Players

  attr_reader :players, :free_players, :chosen_players


  def initialize fsm, player_ids = [:x, :o]
    @free_players = player_ids
    @chosen_players = []
    self.load_players fsm
  end

  def load_players fsm
    until self.free_players.empty? do
      player_id = self.choose_player
      msg = "What would you like us to call you this round?"
      input_state = fsm.input msg
      player = Player.new input_state.user_input, player_id
      @players.push player
      msg = "Hello, #{player.name}, you will be '#{player}''s"
      message_state = self.message msg
    end
  end

  def choose_player
    player_index = self.free_players.length > 1 ? Random.rand().round : 0
    choose_player = @free_players.slice! player_index
    @chosen_players.push choose_player
    choose_player
  end

  def player_join=p
    @players.push p
  end

  def get_players index = nil
    return self.players[index] if index
    self.players
  end

  def get_current_player
    self.get_players 0
  end

  def get_next_player
    self.get_players 1
  end

  def change_player_turn
    self.players.push self.players.shift
  end

end

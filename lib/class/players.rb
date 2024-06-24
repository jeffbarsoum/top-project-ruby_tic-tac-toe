require 'player'

class Players
  attr_reader :players, :free_players, :chosen_players

  def initialize(fsm, player_ids = %i[x o])
    @free_players = player_ids
    @chosen_players = []
    load_players fsm
  end

  def load_players(fsm)
    until free_players.empty?
      player_id = choose_player
      msg = 'What would you like us to call you this round?'
      input_state = fsm.input msg
      player = Player.new input_state.user_input, player_id
      @players.push player
      msg = "Hello, #{player.name}, you will be '#{player}''s"
      message_state = message msg
    end
  end

  def choose_player
    player_index = free_players.length > 1 ? Random.rand.round : 0
    choose_player = @free_players.slice! player_index
    @chosen_players.push choose_player
    choose_player
  end

  def player_join=(p)
    @players.push p
  end

  def get_players(index = nil)
    return players[index] if index

    players
  end

  def get_current_player
    get_players 0
  end

  def get_next_player
    get_players 1
  end

  def change_player_turn
    players.push players.shift
  end
end

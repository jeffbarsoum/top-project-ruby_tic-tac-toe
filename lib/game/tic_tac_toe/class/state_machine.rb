require "variablize"
require "players"
require "matrix"
require "stats"

class GameStateMachine < StateMachine
  attr_reader :state_dir

  # Parent Methods: All finite state machines will use these
  def initialize state_dir = "game_state"
    @state_dir = state_dir
   super state_dir
  end

  def load_state state_file:, **opts
    super state_file, opts
  end

  def get_state offset = 0, cls_skip = []
    super offset, cls_skip
  end

  def run_state_cmd state_file:, **opts
    return super state_file, opts
  end

  def get_state_file_list
    super
  end

  def game_save
    super
  end


  # State Methods: Each method launches a game_state instance
  def back **opts
    self.get_state 1, ["Message", "Input"]
  end

  def play **_opts
    players = Players.new self, [:x, :o]
    matrix = Matrix.new self
    stats = Stats.new
    coordinates = matrix.coordinates
    until stats.winner || coordinates.empty? do
      stats.add_turn players.get_current_player
      opts = {
        matrix: matrix,
        players: players,
        stats: stats
      }
      next_state = self.load_state state_file: __method__, opts
      cmds = next_state.state_opts "state_cmds"
      cmd = next_state.get_next_state
      return cmd if cmds.keys.include? cmd
      stats.add_winner :winner, matrix.assign_piece players.get_current_player, cmd
      players.change_player_turn
    end
    stats.add_stat :round
    if stats.winner
      winner = stats.winner[:player]
      stats.add_score winner
      return :win
    else
      stats.add_score :draw
      return :draw
    end
  end

end

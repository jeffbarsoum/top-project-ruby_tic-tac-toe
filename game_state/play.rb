require "game_state"

class Play < GameState

  attr_reader :cmd


  def state_opts param = nil
    super param
  end

  def state_opts=param, value
    super param, value
  end

  def run_cmd opts
    super opts
  end


  def initialize **opts
    @state_cmds = [
      s: {
        state: "save",
        text: "Save"
      },
      q: {
        state: "quit",
        text: "Quit"
      }
    ]
    @screen_cmds = opts[:matrix].coordinates
    @state_opts = {
      state_name: "title",
      screen: self.display opts[:players], opts[:stats], opts[:matrix]
      players: opts[:players],
      stats: opts[:stats],
      matrix: opts[:matrix],
    }
    super opts
  end

  def display players:, stats:, matrix:
    p1 = players[0]
    p2 = players[1]
    p1_score = stats[:score][p1.player.to_sym]
    p2_score = stats[:score][p2.player.to_sym]
    p1_turn = stats[:turn][p1.player.to_sym]
    p2_score = stats[:turn][p2.player.to_sym]
    rnd = stats[:round]

    msg_hud <<-STRING

    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Round ##{rnd}, Turn ##{p1_turn}
    ------------------------------------------------------------------------------------
    #{p1.name}'s Turn:
    ------------------------------------------------------------------------------------
    #{p1.name} (#{p1})                                            #{p2.name} (#{p2})
    ----------------------                                        ----------------------
    score: #{p1_score}                                            score: #{p2_score}
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
    msg_hud
  end

  def save

  end

  def quit

  end

end

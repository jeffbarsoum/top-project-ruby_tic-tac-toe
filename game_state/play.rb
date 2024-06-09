require "game_state"

class Play < GameState

  attr_reader :cmd


  def state_opts param = nil
    super param
  end

  def state_opts=param, value
    super param, value
  end

  def get_next_state
    super
  end


  def initialize matrix:, players:, stats:
    self.state_opts = "state_cmds", [
      s: {
        state: "save",
        text: "Save"
      },
      q: {
        state: "quit",
        text: "Quit"
      }
    ]
    self.state_opts = "vertical", true
    self.state_opts = "input?", true
    self.state_opts = "any_text?", false

    self.state_opts = "screen_cmds", matrix.coordinates
    self.state_opts = "screen", self.display matrix, players, stats

    self.state_opts = "matrix", matrix
    self.state_opts = "players", players
    self.state_opts = "stats", stats

    super
  end

  def display matrix:, players:, stats:
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

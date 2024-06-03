require "game_state"

class Play < GameState

  attr_reader :opts_in, :opts_out


  def opts param = nil
    super param
  end

  def opts=param, value
    super param, value
  end


  def initialize **opts
    @@opts_in = {
      state: opts[:state] || "play"
      cmds: opts[:cmds] || [:start, :load, :save, :quit],
      vertical: opts[:vertical] || true,
      screen: self.display,
      players: opts[:players]
      stats: opts[:stats]
    }
  end

  def display players: self.opts :players, stats: self.opts :stats
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

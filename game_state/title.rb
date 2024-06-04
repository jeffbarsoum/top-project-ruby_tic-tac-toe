require "game_state"

class Title < GameState

  attr_reader :opts_in, :opts_out


  def opts param = nil
    super param
  end

  def opts=param, value
    super param, value
  end


  def initialize **opts
    @@opts_in = {
      state: opts[:state] || "title"
      cmds: opts[:cmds] || [:start, :load, :save, :quit],
      vertical: opts[:vertical] || true,
      screen: self.display
    }
  end

  def display _args = []
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    STRING
  end

  def start

  end

  def load

  end

  def save

  end

  def quit

  end

end
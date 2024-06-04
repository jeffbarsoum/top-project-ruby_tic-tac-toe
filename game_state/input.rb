require "game_state"

class Input < GameState

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
    super opts
  end

  def display question
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Yerrrrrrrr, question, famo...
    ------------------------------------------------------------------------------------
    #{question}
    ------------------------------------------------------------------------------------
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
  end

  def back

  end

  def quit

  end

end

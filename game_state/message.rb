require "game_state"

class Message < GameState

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

  def display _args = {}
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

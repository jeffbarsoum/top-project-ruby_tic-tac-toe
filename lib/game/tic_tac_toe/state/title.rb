require "game_state"
require "players"

class State::Title < State

  def opts param = nil
    super param
  end

  def opts=param, value
    super param, value
  end

  def get_next_state
    super
  end

  def game_save
    super
  end



  def initialize
    self.opts = :hash, self.cmds.cmd_hash [:play, :load, :quit]
    self.opts = :cmds, self.cmds.user_input_arr [:play, :load, :quit]

    self.opts = :display, self.display
    self.opts = :vertical, true
    self.opts = :input?, false
    self.opts = :any_text?, false

    super
  end

  def display
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    STRING
  end

end

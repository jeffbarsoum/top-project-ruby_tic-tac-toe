require "lib/class/state"

class TicTacToe::State::Message < State

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


  def initialize message:, cmds:, **opts
    self.opts = :hash, self.cmds.cmd_hash cmds || [:back, :quit]
    self.opts = :cmds, self.cmds.user_input_arr cmds || [:back, :quit]

    self.opts = :display, self.display message
    self.opts = :vertical, false
    self.opts = :input?, false
    self.opts = :any_text?, false
    self.opts = :timeout, 3

    super
  end

  def display message
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Yerrrrrrrr...
    ------------------------------------------------------------------------------------
    #{message}
    ------------------------------------------------------------------------------------
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
  end

end

end

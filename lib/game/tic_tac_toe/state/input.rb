require "game_state"

class State::Input < State

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


  def initialize message:, any_text?:, cmds:, **opts
    self.opts = :hash, self.cmds.cmd_hash cmds || [:back, :quit]
    self.opts = :cmds, self.cmds.user_input_arr cmds || [:back, :quit]

    self.opts = :display, self.display message
    self.opts = :vertical, false
    self.opts = :input?, true
    self.opts = :any_text?, any_text?

    super
  end

  def display message
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
    Yerrrrrrrr, question, famo...
    ------------------------------------------------------------------------------------
    #{message}
    ------------------------------------------------------------------------------------
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    STRING
  end

end

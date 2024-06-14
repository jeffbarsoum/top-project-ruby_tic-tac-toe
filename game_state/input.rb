require "game_state"

class Input < GameState

  def state_opts param = nil
    super param
  end

  def state_opts=param, value
    super param, value
  end

  def get_next_state
    super
  end

  def game_save
    super
  end


  def initialize message:, any_text?:, state_cmds:, **opts
    self.state_opts = :state_hash, self.cmds.cmd_hash state_cmds || [:back, :quit]
    self.state_opts = :state_cmds, self.cmds.user_input_arr state_cmds || [:back, :quit]

    self.state_opts = :display, self.display message
    self.state_opts = :vertical, false
    self.state_opts = :input?, true
    self.state_opts = :any_text?, any_text?

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

require "game_state"
require "players"

class Title < GameState

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



  def initialize
    self.state_opts = :state_hash, self.cmds.cmd_hash [:play, :load, :quit]
    self.state_opts = :state_cmds, self.cmds.user_input_arr [:play, :load, :quit]

    self.state_opts = :display, self.display
    self.state_opts = :vertical, true
    self.state_opts = :input?, false
    self.state_opts = :any_text?, false

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

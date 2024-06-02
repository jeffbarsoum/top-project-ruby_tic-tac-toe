require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class State < FiniteStateMachine

  @opts_in = {
    state: :title
    cmds: [:start, :load, :save, :quit],
    vertical: true
  }

  @opts_out = {
    state_file: nil,
    args: [],
    state_cmds: [],
    screen_cmds: [],
    vertical: true
  }

  @@display = Display.new

  attr_reader :opts_in, :opts_out


  include GetUserInput
  include Data


  def opts_in param = nil
    return self.class.opts_in[param.to_sym] if param
    self.class.opts
  end

  def opts_out param = nil
    return self.class.opts_out[param.to_sym] if param
    self.class.opts
  end

  def display_screen
    @@display.screen self.opts_in
  end

  def load_state
    super self.opts_out
  end

  def get_state offset = 0
    super offset
  end

  def run_cmd cmd
    self.send cmd.to_s
  end

  def initialize opts

    self.opts = opts
    self.load_state opts[:state_file], opts[:args], opts[:state_cmds], opts[:screen_cmds]
  end

  def display args
    msg_screen <<-STRING
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO
                                        Tic Tac Toe!
    XXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOOXXXOOO

    Please press a key to choose your option:

    #{self.opts_display choices}

    STRING



end

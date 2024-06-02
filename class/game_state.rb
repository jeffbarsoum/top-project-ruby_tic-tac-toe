require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class GameState

  include GetUserInput
  include Data
  include Display

  @@fsm = FiniteStateMachine.new self.cmd_hash, "game_state"

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

  attr_reader :opts_in, :opts_out


  def self.load_next_state
    @@fsm.load_next_state self.opts_out
  end

  def self.load_state offset = 0
    @@fsm.load_state offset
  end


  def initialize opts
    @opts_in = opts
    user_input = self.screen self.opts_in
  end

  def opts_in param = nil
    return self.class.opts_in[param.to_sym] if param
    self.class.opts
  end

  def opts_out param = nil
    return self.class.opts_out[param.to_sym] if param
    self.class.opts
  end

  def run_cmd cmd
    self.send cmd.to_s
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

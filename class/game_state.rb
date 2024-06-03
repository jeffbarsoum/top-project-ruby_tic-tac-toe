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


  def initialize **opts
    user_input = self.screen self.opts_in
    cmd = self.cmd user_input
    self.run_cmd cmd
  end

  def opts param = nil
    return self.opts_in[param.to_sym] if param
    self.opts_in
  end

  def opts=param, value
    @opts_out[param.to_sym] = value
  end

  def run_cmd cmd
    return self.send cmd.to_s if self.respond_to? cmd
    self.define_method cmd.to_s do { self.class.load_next_state }
    self.send cmd.to_s
  end

  def display args
    msg_screen = "No screen loaded..."
  end

end

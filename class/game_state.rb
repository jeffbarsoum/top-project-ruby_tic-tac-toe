require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class GameState

  include GetUserInput
  include Data
  include Display

  attr_reader :cmd

  @@fsm = FiniteStateMachine.new self.cmd_hash, "game_state"

  @opts = {
    state: :title
    cmds: [:start, :load, :save, :quit],
    vertical: true
  }


  def self.load_next_state opts
    @@fsm.load_next_state opts
  end

  def self.load_state offset = 0
    @@fsm.load_state offset
  end

  def self.opts_out **params
    opts_hash = {
      state_file: params[:state_file] || nil,
      args: params[:args] || [],
      state_cmds: params[:state_cmds] || [],
      screen_cmds: params[:screen_cmds] || [],
      vertical: params[:vertical] || true
    }

    params.reduce opts_hash do | opts, (param, value) |
      opts[param] = value unless opts[param]
      opts
    end
  end


  def initialize **opts
    @opts = opts
    user_input = self.screen opts
    @cmd = self.cmd user_input
  end

  def opts param = nil
    return @opts[param.to_sym] if param
    @opts
  end

  def opts=param, value
    @opts[param.to_sym] = value
  end

  def run_cmd opts
    return self.send self.cmd.to_s if self.respond_to? self.cmd
    self.define_method self.cmd.to_s do { | arg | self.class.load_next_state arg }
    self.send self.cmd, opts
  end

  def display args
    msg_screen = "No screen loaded..."
  end

end

require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class GameState

  include GetUserInput
  include Display
  include Variablize

  attr_reader :state_cmd, :screen_cmd

  @@fsm = FiniteStateMachine.new self.cmd_hash, "game_state"
  @@data = Data.new dir: "data", class_prefix: "Data"


  def self.load_next_state opts
    @@fsm.load_next_state opts
  end

  def self.load_state offset = 0
    @@fsm.load_state offset
  end


  def initialize **opts
    @state_opts = self.data.generate_opts self.state_name, opts
    user_input = self.screen opts
    user_output = self.data.cmd user_input

    case user_output
    when self.state_opts :state_cmds .include user_output
      @state_cmd = user_output
      self.create_cmd
    else
      @screen_cmd = user_output
    end

  end

  def state_name
    self.class.name.reduce "" do | name, letter |
      name += letter if letter == letter.downcase
      name += "_#{letter.downcase}" if letter == letter.upcase
      name
    end
  end

  def fsm
    @@fsm
  end

  def data
    @@data
  end

  def state_opts param = nil
    return @state_opts[param.to_sym] if param
    @opts
  end

  def state_opts=param, value
    @state_opts[param.to_sym] = value
  end

  def create_cmd cmd = self.state_cmd
    return if self.respond_to? cmd
    self.define_method cmd.to_s do { | arg | self.data.generate_opts self.state_name, opts}
  end

  def run_cmd cmd = self.state_cmd
    return false unless cmd
    self.create_cmd unless self.respond_to? cmd
    self.send cmd
  end

  def display args
    msg_screen = "No screen loaded..."
  end

end

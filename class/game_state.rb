require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class GameState

  include GetUserInput
  include Data
  include Display

  attr_reader :state_name, :state_opts, :cmd

  @@fsm = FiniteStateMachine.new self.cmd_hash, "game_state"


  def self.load_next_state opts
    @@fsm.load_next_state opts
  end

  def self.load_state offset = 0
    @@fsm.load_state offset
  end


  def initialize **opts
    @state_opts = self.generate_opts self.state_name, opts
    user_input = self.screen opts
    @cmd = self.cmd user_input
    self.create_cmd
    self.cmd
  end

  def state_name
    self.class.name.reduce "" do | name, letter |
      name += letter if letter == letter.downcase
      name += "_#{letter.downcase}" if letter == letter.upcase
      name
    end
  end

  def state_opts param = nil
    return @opts[param.to_sym] if param
    @opts
  end

  def state_opts=param, value
    @opts[param.to_sym] = value
  end

  def create_cmd
    return if self.respond_to? self.cmd
    self.define_method self.cmd.to_s do { | arg | self.class.load_next_state arg }
  end

  def run_cmd opts
    self.create_cmd unless self.respond_to? self.cmd
    self.send self.cmd, opts
  end

  def display args
    msg_screen = "No screen loaded..."
  end

end

require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class GameState

  include GetUserInput
  include Display
  include Variablize

  attr_reader :state_cmds, :state_opts, :next_state

  @@data = Data.new dir: "data", class_prefix: "Data"

  def initialize
    self.state_opts = "state_name", self.script_name self.class.name
    self.get_next_state
  end

  def get_next_state
    user_input = self.screen self.state_opts
    user_output = self.process_user_input user_input
    @next_state = user_output
  end


  def data
    @@data
  end

  def process_user_input user_input
    self.state_cmds[user_input.to_sym][:state]
  end

  def state_opts param = nil
    return @state_opts[param.to_sym] if param
    @state_opts
  end

  def state_opts=param, value
    @state_opts = {} unless self.state_opts
    @state_opts[param.to_sym] = value
  end

  def display _args
    msg_screen = "No screen loaded..."
  end

end

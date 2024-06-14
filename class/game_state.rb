require "finite_state_machine"
require "display"
require "get_user_input"
require "cmds"

class GameState

  include GetUserInput
  include Display
  include Variablize

  attr_reader :state_opts, :cmds, :game_save

  def initialize
    self.state_opts = :state_name, self.script_name self.class.name
    self.get_next_state
  end

  def get_next_state
    user_input = self.screen self.state_opts
    user_output = self.process_user_input user_input
    self.state_opts = :next_state, user_output
  end

  def state_opts param = nil
    return @state_opts[param] if param
    @state_opts
  end

  def state_opts=param, value
    @state_opts = {} unless self.state_opts
    @state_opts[param] = value
  end

  def display _args
    msg_screen = "No screen loaded..."
  end

  def game_save
    {
      class_name: self.class.name
      state_opts: self.state_opts
    }
  end

end

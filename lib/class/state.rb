require "finite_machine"
require "display"
require "get_user_input"
require "cmds"

class State

  include GetUserInput
  include Display
  include Variablize

  attr_reader :opts, :cmds, :game_save

  def initialize
    self.opts = :name, self.script_name self.class.name
    self.get_next_state
  end

  def get_next_state
    user_input = self.screen self.opts
    user_output = self.process_user_input user_input
    self.opts = :next_state, user_output
  end

  def opts param = nil
    return @opts[param] if param
    @opts
  end

  def opts=param, value
    @opts = {} unless self.opts
    @opts[param] = value
  end

  def display _args
    msg_screen = "No screen loaded..."
  end

  def save
    {
      class: self
      opts: self.opts
    }
  end

  def load game_save
    @game_save = game_save
    @opts = game_save[:opts]
  end

end

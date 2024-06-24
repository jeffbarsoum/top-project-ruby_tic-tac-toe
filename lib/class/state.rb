require 'finite_machine'
require 'display'
require 'get_user_input'
require 'cmds'

class State
  include GetUserInput
  include Display
  include Variablize

  attr_reader :cmds, :game_save

  def initialize
    self.opts = :name, script_name(self.class.name)
    get_next_state
  end

  def next_state
    user_input = screen opts
    user_output = process_user_input user_input
    self.opts = :next_state, user_output
  end

  def opts(param = nil)
    return @opts[param] if param

    @opts
  end

  def opts=(param, value)
    @opts = {} unless opts
    @opts[param] = value
  end

  def display(_args)
    'No screen loaded...'
  end

  def save
    {
      class: self,
      opts: opts
    }
  end

  def load(game_save)
    @game_save = game_save
    @opts = game_save[:opts]
  end
end

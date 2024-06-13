require "finite_state_machine"
require "display"
require "get_user_input"
require "data"

class GameState

  include GetUserInput
  include Display
  include Variablize

  attr_reader :state_opts, :game_save

  @@data = Data.new dir: "data", class_prefix: "Data"

  def initialize
    self.state_opts = "state_name", self.script_name self.class.name
    self.get_next_state
  end

  def get_next_state
    user_input = self.screen self.state_opts
    user_output = self.process_user_input user_input
    self.state_opts = "next_state", user_output
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
    @state_opts[param] = value
  end

  def cmd_arr cmd_hash
    return [] unless cmd_hash.is_a? Hash
    state_hash.reduce [] do |cmd_arr, (input, cmd_hash)|
      cmd_arr.push cmd_hash[:state]
      cmd_arr
  end

  def cmd_hash user_input_arr
    return [] unless cmd_hash.is_a? Hash
    user_input_arr.reduce [] do |cmd_hash, user_input|
      cmd_arr.push cmd_hash[:state]
      cmd_hash
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

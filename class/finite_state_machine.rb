require "error"
require "variablize"

class FiniteStateMachine
  include Error
  include Variablize

  attr_reader :state_dir, :state_files, :states, :classes


  def initialize state_dir = "state"
    @state_dir = state_dir
    @state_files = self.get_state_file_list
    @states = []
    @classes = []
  end

  def load_state state_file:, **opts
    return false unless self.state_files.include? state_file
    require state_file

    cls_name =  self.class_name state_file
    cls = Object.const_get cls_name

    if cls
      self.classes.unshift { cls_name => cls }
      cls_instance = cls.new args, state_cmds, screen_cmds
      self.instances.unshift { cls_name => cls_instance }
    end

    cls_instance
  end

  def get_state offset = 0, cls_skip = []
    until offset > self.states.length - 1 do
      back_state = self.states[offset]
      is_msg = back_state.class == "Message"
      is_input = back_state.class == "Input"
      is_oth_state = !is_msg && !is_input
      is_load = (is_msg && !skip_msg) || (is_input && !skip_input) || is_oth_state
      return back_state if is_load
      offset += 1
      return false if offset > self.states.length - 1
    end
  end

  def get_state_file_list
    Dir "../#{self.state_dir}/" .map do |state_file|
      state_file.basename
    end
  end

end

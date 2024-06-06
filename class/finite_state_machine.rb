require "error"

class FiniteStateMachine
  include Error

  attr_reader :state_dir, :state_files, :states, :classes


  def initialize state_dir = "state"
    @state_dir = state_dir
    @state_files = self.get_state_file_list
    @states = []
    @classes = []
  end

  def load_next_state state_file:, args:, state_cmds:, screen_cmds:
    return false unless self.state_files.include? state_file
    require state_file

    cls_name =  self.get_class_name state_file
    cls = Object.const_get cls_name

    if cls
      self.classes.unshift { cls_name => cls }
      cls_instance = cls.new args, state_cmds, screen_cmds
      self.instances.unshift { cls_name => cls_instance }
    end

    cls_instance
  end

  def load_state offset = 0
    self.states[offset].values.first
  end


  def get_class_name state_file
    begin
      raise FiniteStateMachineError unless self.state_files.include? state_file
      state_file_processed = state_file.replace ".rb", "" .split "_" .map! { |word| word.capitalize } .join "" .to_sym
    rescue FiniteStateMachineError
      msg_fsm_error <<-STRING
      #{state_file} not found in #{self.state_dir} directory!
      state files must be one of the following:
      #{self.state_files.join ", "}
    STRING
      self.error msg_fsm_error
    end
  end

  def get_state_file_list
    Dir "../#{self.state_dir}/"
  end

end

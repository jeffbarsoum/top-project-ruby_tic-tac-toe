require_relative "tic_tac_toe"

class FiniteStateMachine < TicTacToe

  attr_reader :state_dir, :state_files, :states, :classes, :instances


  def error class_name, function_name, error_message
    super class_name, function_name, error_message
  end


  def initialize states, commands, state_dir = "state"
    @state_dir = state_dir
    @state_files = self.get_state_file_list
    @states = []
    @classes = []
    @instances = []
  end

  def load_state state_file, args, state_cmds, screen_cmds
    return false unless self.state_files.include? state_file
    require state_file

    cls_name =  self.parse_state_file state_file
    cls = Object.const_get cls_name

    if cls
      self.classes.unshift { cls_name => cls }
      cls_instance = cls.new args, state_cmds, screen_cmds
      self.instances.unshift { cls_name => cls_instance }
    end

    cls_instance
  end

  def unload_state class_name

  end

  def parse_state_file state_file
    cls_name = "FiniteStateMachine"
    func_name = "parse_state_file"
    begin
      raise FiniteStateMachineError unless self.state_files.include? state_file
      state_file_processed = state_file.replace ".rb", "" .split "_" .map! { |word| word.capitalize } .join "" .to_sym
    rescue FiniteStateMachineError
      msg_fsm_error <<-STRING
      #{state_file} not found in #{self.state_dir} directory!
      state files must be one of the following:
      #{self.state_files.join ", "}
    STRING
      self.error cls_name, func_name, msg_fsm_error
    end
  end

  def get_state_file_list
    Dir "../#{self.state_dir}/"
  end

end

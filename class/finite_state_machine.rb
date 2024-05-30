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

  def load_state state_file, args, state_commands, screen_commands
    return false unless self.state_files.include? state_file
    require state

    state_class_name =  self.parse_state_file state_file
    state_class = Object.const_get state_class_name

    if state_class
      self.classes.unshift { state_class_name => state_class }

      state_class_instance = state_class.new args, state_commands, screen_commands
      self.instances.unshift { state_class_name => state_class_instance }
    end

    return state_class_instance
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

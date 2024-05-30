require_relative "tic_tac_toe"

class FiniteStateMachine < TicTacToe

  attr_reader :state_dir, :state_files, :states, :classes


  def error class_name, function_name, error_message
    super class_name, function_name, error_message
  end


  def initialize states, commands, state_dir = "state"
    @state_dir = state_dir
    @state_files = self.get_state_file_list
    @states = []
    @classes = []
  end

  def load_state state
    load_str = "../#{self.state_dir}/#{state}.rb"
    require_relative "#{load_str}/#{state}.rb"
    return state_files
  end

  def unload_state
    Object.send(:remove_const, self.classes.unshift)
  end

  def parse_state_file state_file
    cls_name = "FiniteStateMachine"
    func_name = "parse_state_file"
    begin
      raise FiniteStateMachineError unless self.state_files.include? state_file
      state_file_processed = state_file.replace ".rb", "" .split "_" .map! { |word| word.capitalize } .join
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

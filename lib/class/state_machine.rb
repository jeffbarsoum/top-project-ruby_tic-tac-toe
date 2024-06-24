require "error"
require "variablize"

class StateMachine
  include Error
  include Variablize

  attr_reader :state_dir, :state_files, :states, :game_save


  def initialize state_dir = "state"
    @state_dir = state_dir
    @state_files = self.get_state_file_list
    @states = []
    @game_save = {}
  end

  def load_state state_file:, **opts
    return false unless self.state_files.include? state_file
    require state_file

    cls_name =  self.class_name state_file
    cls = Object.const_get cls_name

    if cls
      cls_instance = cls.new opts
      @states.unshift { cls_name => cls_instance }
      @states.pop if @states.length > 10
    end

    cls_instance
  end

  def get_state offset = 0, cls_skip = []
    is_skip = false
    back_state = nil
    while is_skip || offset <= self.states.length - 1 do
      back_state = self.states[offset]
      is_skip = cls_skip.include? back_state.class.name
      offset += 1
    end
    return back_state.get_next_state if back_state
    false
  end

  # Load override logic
  def run_state_cmd state_file:, **opts
    # Call the state machine's load function,
    # unless a method for the state file exists here
    return self.load_state state_file, opts unless self.respond_to? state_file
    self.send state_file, opts
  end

  def get_state_file_list
    return @state_files if @state_files
    Dir "../#{self.state_dir}/" .map do |state_file|
      state_file.basename
    end
  end

  def save
    @game_save[:state_dir] = self.state_dir
    @game_save[:state_files] = self.state_files
    @game_save[:states] = []
    self.states.each do |state|
      @game_save[:states].push  state.save
    end
    self.game_save
  end

  def load game_save
    @game_save = game_save
    @state_dir = game_save[:state_dir]
    @state_files = self.get_state_file_list
    @states = []
    @game_save[:states].each do |state|
      inst = state[:class].new state[:state_opts]
      inst.load
      @states.push inst
    end
  end

end
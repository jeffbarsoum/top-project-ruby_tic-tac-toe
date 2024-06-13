require "finite_state_machine"
require "game_save"

require "cmds"
require "opts"
require "board"

class TicTacToe

  include DataBoard


  attr_reader :fsm, :game_opts, :game_save, :top_score
  attr_accessor :matrix, :stats, :players

  def game_save
    data = {
      fsm: self.fsm.game_save,
      game_opts: self.game_opts,
      matrix: self.matrix.game_save,
      players: self.players.game_save,
      stats: self.stats.game_save
    }



  def initialize save_data = false
    @fsm = GameStateMachine.new "game_state"
    @game_opts = {}
    @game_save = Save.new

    self.play_game
  end

  def play_game
    is_quit = false
    state = self.fsm.run_state_cmd :title
    until is_quit do
      next_state = state.get_next_state
      output = state.state_opts :output
      output.each { |opt, value| self.send "#{opt}=".to_sym, value } if output.is_a? Hash
      is_quit = next_state == :quit
      state = self.fsm.run_state_cmd next_state
    end
  end


  ##### MARKED FOR DELETION
  def process_user_option input
    return unless USER_OPTIONS.has_val? input
    command = USER_OPTIONS.key input
    return unless command
    self.send_user_option command
  end

  def send_user_option command
    self.send command
  end

  def load
    save_cnt = self.save.count
    opts_arr = 1..save_cnt.to_a.push get_opts_array self.user_options :quit
    save_choice = self.return_user_input self.display.saves self.save.data, false, opts_arr
    load_data = self.save.data[i + 1] if opt_arr.include?(save_choice.to_i + 1)

    @players = load_data[:data][:players]
    @board = load_data[:data][:board]
    @stats = load_data[:data][:stats]

    self.play_game
  end

  def get_opts_array opts_hash = USER_OPTIONS
    opts_hash.reduce [] do |opt_arr, (opt_name, opt)|
      opt_arr.push opt
      opt_arr
    end
  end

  def user_options command_arr
    command_arr.reduce Hash.new do |opt_hash, opt|
      opt_hash[opt] = USER_OPTIONS[opt] if USER_OPTIONS.include? opt
      opt_hash
    end
  end

end

require "finite_state_machine"
require "game_save"

require "cmds"
require "opts"
require "board"

class Loader::TicTacToe < Loader

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

  def load_game
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

end

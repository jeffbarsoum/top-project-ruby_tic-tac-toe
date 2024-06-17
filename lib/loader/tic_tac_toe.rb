require "finite_state_machine"
require "game_save"

require "cmds"
require "opts"
require "board"

class Loader::TicTacToe < Loader

  include DataBoard


  attr_reader :fsm, :game_opts, :game_save, :top_score
  attr_accessor :matrix, :stats, :players


  def initialize save_data = false
    self.load_state_machine
    self.load_save
    self.load_top_score
    self.load_cmds
    @game_opts = {}

    self.play_game
  end


  def load_players player_ids = [:x, :o]
    @players = Players.new player_ids
    until self.players.free_players.empty? do
      player_id = self.players.choose_player
      msg = "What would you like us to call you this round?"
      input_state = self.fsm.input msg
      player = Player.new input_state.user_input, player_id
      @players.array.push player
      msg = "Hello, #{player.name}, you will be '#{player}''s"
      message_state = self.message msg
    end
    self.load_stats
  end

  def load_state_machine
    @fsm = GameStateMachine.new "#{self.game_dir}/state"
  end

  def load_stats
    @stats = Stats.new
  end

  def load_save
    save_dir = "save/#{game}"
    @save = Save.new save_dir
  end

  def load_top_score
    save_dir = "top_score/#{game}"
    @top_score = Save.new save_dir
  end

  def load_cmds
    @cmds = Cmds.new
  end

  def load_game
    msg <<-STRING
    How big do you want the Tic Tac Toe Board to be?

      The default is 3, so 3 rows and 3 columns, and 3
      in a row wins

      You can go as high as 7:
    STRING
    input_state = self.fsm.input msg
    board_size = input_state.user_input
    @game = Game.new board_size
  end

  def save_game
    data = {
      fsm: self.fsm.game_save,
      game_opts: self.game_opts,
      matrix: self.matrix.game_save,
      players: self.players.game_save,
      stats: self.stats.game_save
    }
    # write code to actually save
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

end

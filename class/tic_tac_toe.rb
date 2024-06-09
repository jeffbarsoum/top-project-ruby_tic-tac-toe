require "finite_state_machine"
require "matrix"
require "player"
require "stats"
require "game_save"

require "title"
require "message"
require "input"

require "cmds"
require "opts"
require "board"

class TicTacToe

  include DataBoard


  attr_reader :fsm, :game_opts, :matrix, :players, :stats, :save


  def initialize save_data = false
    @fsm = FiniteStateMachine.new "game_state"
    @game_opts = {}
    @stats = Stats.new
    @save = GameSave.new
    @players =  []

    self.load_players
    self.load_board_size

    @matrix = Matrix.new self.game_opts[:board_size]

    self.play_game
  end

  def load_players
    until Player.get_free_players.empty? do
      msg = "What would you like us to call you this round?"
      input_state = self.input msg
      player = Player.new input_state.user_input
      @players.push player
      msg = "Hello, #{player.name}, you will be '#{player}''s"
      message_state = self.message msg
    end
  end

  def load_board_size
    msg <<-STRING
    How big do you want the Tic Tac Toe Board to be?

      The default is 3, so 3 rows and 3 columns, and 3
      in a row wins

      You can go as high as 7:
    STRING
    input_state = self.input msg
    @game_opts[:board_size] = input_state.user_input
  end

  def play_game
    is_quit = false
    state = self.title
    until is_quit do
      next_state = state.get_next_state
      is_quit = next_state == :quit
      state = self.send next_state
    end
  end

  def back
    self.fsm.get_state 1, ["Message", "Input"]
  end

  def input
    self.fsm.load_state state_file: __method__.to_s
  end

  def load
    self.fsm.load_state state_file: __method__.to_s
  end

  def message
    self.fsm.load_state state_file: __method__.to_s
  end

  def play
    opts = {
      matrix: self.matrix,
      players: self.players,
      stats: self.stats
    }
    self.fsm.load_state state_file: __method__.to_s, opts
  end

  def save
    self.fsm.load_state state_file: __method__.to_s
  end

  def title
    self.fsm.load_state state_file: __method__.to_s
  end

  def quit
    self.fsm.load_state state_file: __method__.to_s
  end

  def win
    self.fsm.load_state state_file: __method__.to_s
  end



  def process_user_option input
    return unless USER_OPTIONS.has_val? input
    command = USER_OPTIONS.key input
    return unless command
    self.send_user_option command
  end

  def send_user_option command
    self.send command
  end

  def get_current_player
    self.players[0]
  end

  def get_next_player
    self.players[1]
  end

  def start
    @players = []
    until Player.get_free_players.empty? do
      msg = "What would you like us to call you this round?"
      name = self.return_user_input msg, false
      self.players.push Player.new name
    end
    @board = Board.new
    @stats = Stats.new

    self.play_game
  end

  def quit
    @is_quit = true
  end

  def save
    @save.create_save self

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

  def play_turn
    current_player = self.players[0]
    matrix = self.board.matrix
    self.display.board self.board
    self.display.hud self.players, self.stats

    coordinates = self.return_user_input "#{current_player.name}, your turn!"
    matrix.assign_piece current_player.player, coordinates

    # move the top player (the one whose turn it currently is) last
    @players.push @players.unshift

    matrix.check_winner
  end

  def play_game
    until self.is_quit do
      until @stats.winner do
        @stats.winner = self.play_turn
      end
      display_win = self.display.win @stats.winner.player, self.get_opts_array
      user_opt = self.return_user_input display_win, false, self.get_opts_array
      self.board.matrix.assign_winner is_winner
      msg = "#{current_player.name}, your turn!"
      self.is_quit = coordinates = self.return_user_input
    end
  end

end

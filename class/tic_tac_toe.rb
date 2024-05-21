require_relative "module/get_user_input"
require_relative "module/error"
require_relative "board"
require_relative "player"
require_relative "stats"
require_relative "display"
require_relative "save"

class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]
  USER_OPTIONS = {
    start: "o",
    quit: "q",
    save: "s",
    load: "l"
  }

  include GetUserInput
  include Error

  attr_reader :board, :players, :stats, :display, :save, :is_quit


  def initialize save_data = false
    @is_quit = false
    @display = Display.new
    @save = GameSave.new

    opts_hash = self.user_options :start, :load, :quit
    opts = self.get_opts_arrayj opts_hash

    # Display title screen
    title_choice = self.return_user_input self.display.title, false, opts

    # Launch appropriate screen
    self.process_user_option title_choice

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

  def return_user_input message, multi_entry, user_options
    GetUserInput.return_user_input message, multi_entry, user_options
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

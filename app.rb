###############################################################################
## Helper Modules
###############################################################################
module GetUserInput
  # A function to pull input from the user
  # Can choose to print spacing, or get input, either or both
  def get_user_input print_spacing = false, get_input = true

    # an indicator to mark the user's input in the console
    print "--> "

    result = gets.chomp if get_input

    if print_spacing
        print "\n"
        print "########################################################################\n\n"
        print "\n"
    end

    # Only return the result if we got user input (get_input == true)
    result if get_input
  end

  def return_user_input message, multi_entry = false, user_options = [':q']
    user_input = nil
    user_selection = nil
    dictionary = []

    # print the user message
    print message

    # ask for input and push it to the dictionary until user option is entered
    # 'q' is a default, it quits entry
    #  you can change 'q' to something else, but 'quit' is always the first option
    until user_options.include? user_selection do
      user_input = get_user_input
      user_selection = user_input if user_options.include? user_input
      dictionary.push format_val user_input unless user_selection
      break unless multi_entry
    end

    # just printing some spacing
    get_user_input true, false

    # create a hash for the return result
    result = { user_option: user_selection, dictionary: dictionary}

    # return results for processing
    return result[:dictionary].empty? ? result[:user_option] : result
  end
end


###############################################################################
## Classes
###############################################################################
class TicTacToe
  SQUARE_CHOICES = [:x, :o, :nil]

  include GetUserInput

  attr_reader :game_board, :players, :stats, :sq_rows, :sq_cols


  def draw_title

  end

  def draw_hud

  end

  def draw_board

  end

  def get_player_input

  end

  def assign_piece coordinates

  end

  def play_turn
    draw_title
    draw_hud
    draw_board

    player_input = get_player_input
    assign_piece player_input

    check_winner
  end

  def play_again

  end

  def play_game
    is_quit = nil
    until is_quit do
      is_winner = false
      until is_winner do
        is_winner = play_turn
      end
      assign_winner is_winner
      is_quit = play_again
    end
  end

  def next_player
    # move the top player (the one whose turn it currently is) last
    @players.push @players.unshift
  end

  def self.game_error error_prefix, error_message
    error_prefix + ": " + error_message
  return

  def initialize
    err_prefix = "TicTacToe.initialize ERROR"
    begin
      @players = []
      until Player.get_free_players.empty? do
        name = GetUserInput.return_user_input message, false
        self.players.push Player.new name
      end

      @game_board = GameBoard.new
      @stats = {
        score: {x: 0, o: 0}
        turn: {x: 0, o: 0}
        round: 0
        }
    end

  end

  def change_turn

  end


  def check_winner
    is_column_win = self.game_board.check_column
    return is_column_win if is_column_win

    is_row_win = self.game_board.check_row
    return is_row_win if is_row_win

    is_diagonal_win = self.game_board.check_diagonal
    return is_diagonal_win if is_diagonal_win

    false
  end


end

class GameBoard < TicTacToe
  SQUARE_SIZE = [3, 5]
  DEFAULT_BOARD_SIZE = 3
  MAX_BOARD_SIZE = 7
  @@border = { top: "_", side: "|", bottom: "-", corner: "+"}

  attr_reader :board_size, :game_matrix, :game_board, :sq_rows, :sq_cols

  def initialize board_size = DEFAULT_BOARD_SIZE, sq_rows = SQUARE_SIZE[0], sq_cols = SQUARE_SIZE[1]
    err_prefix = "GameBoard.initialize ERROR"
    begin
      msg_ask_game_size <<-STRING
        How big do you want the Tic Tac Toe Board to be?

        The default is 3, so 3 rows and 3 columns, and 3
        in a row wins

        You can go as high as 7:
      STRING
      board_size = GetUserInput.return_user_input msg_ask_game_size, false
      is_size_int = board_size.to_i == board_size.to_i.to_s
      is_size_in_range = board_size.to_i.between?(DEFAULT_BOARD_SIZE, MAX_BOARD_SIZE)

      raise GameSizeError unless is_size_int && is_size_in_range

      @board_size = board_size
      @sq_rows = sq_rows
      @sq_cols = sq_cols

      populate_matrix
      populate_board
      populate_squares
    rescue GameSizeError
      err_message <<-STRING
        game size must be an integer between  #{DEFAULT_BOARD_SIZE} arrays with
        #{MAX_BOARD_SIZE}!
      STRING
      puts self.class.game_error err_prefix, err_message
    end
  end

  def populate_matrix
    err_prefix = "TicTacToe.populate_matrix ERROR"
    begin
      raise GameMatrixError unless self.game_matrix.empty?
      self.board_size.times do |row|
        row_id = row + 1
        row_array = []
        self.board_size.times do |col|
          col_id = 'a'..'z'[col]
          coord = col_id + row_id.to_s
          new_game_square = GameSquare.new coord, self.board_size, self.sq_rows, self.sq_cols
          raise SquareSizeError unless is_correct_dim new_game_square
          row_array.push new_game_square
          self.game_matrix.push row_array
        end
      end
    rescue GameMatrixError
      msg_bad_player_error = "game matrix already has pieces in it!"
      puts self.class.game_error err_prefix, msg_bad_player_error
    rescue SquareSizeError
      msg_square_size_error <<-STRING
        drawn square must be an array containing #{self.sq_rows} arrays,
        each containing #{self.sq_cols} string entries
      STRING
      puts self.class.game_error err_prefix, msg_square_size_error
    end
  end


  def populate_board
    (self.board_size * self.sq_rows).times do |row|
      is_row_border = row == 0 || (row + 1) % self.sq_rows == 0
      is_top_border = row == 0
      is_bottom_border = row == self.board_size * self.sq_rows
      pixel_row = []
      (self.board_size * self.sq_cols).times do |col|

        is_col_border = col == 0 || (col + 1) % self.sq_cols == 0
        #draw borders
        pixel_row.push @@border[:corner] if is_row_border && is_col_border
        pixel_row.push @@border[:top] if is_top_border && !is_col_border
        pixel_row.push @@border[:bottom]if is_bottom_border && !is_col_border
        pixel_row.push @@border[:side] if is_col_border && !is_row_border
        pixel_row.push nil unless is_col_border || is_row_border

        self.game_board.push pixel_row
      end
    end
  end

  def populate_squares
    self.game_matrix.each_with_index do |row, i|
      starting_row = 1 + i * (1 + self.sq_rows)
      ending_row = starting_row + self.sq_rows
      row.each_with_index do |piece, j|
        starting_col = 1 + j * (1 + self.sq_cols)
        ending_col = starting_col + self.sq_cols
        piece.square.each_with_index do |piece_row, k|
          piece_row_id = starting_row + k
          self.game_board[piece_row_id][starting_col, self.sq_rows] = piece_row
        end
      end
    end
  end

  def is_correct_dim game_square
    square_array = game_square.square
    square_array.reduce true do |is_correct_rows, pixel_row|
      break false unless square_array.length == self.sq_rows
      is_correct_rows && pixel_row.length == self.sq_cols
    end
  end

  def check_row
    self.game_matrix.each_with_index do |row, i|
      is_match =  row.uniq.count == 1
      return [row[0], :horizontal] if is_match
    end
    return false
  end

  def check_column
    self.game_matrix.each_with_index do |row, i|
      col_array = []
      self.game_matrix.each_with_index do |col, i|
        col_array.push self.game_matrix[row][col]
      end
      is_match =  col_array.uniq.count == 1
      return [col_array, :vertical] if is_match
    end
    return false
  end

  def check_diagonal
    left_diagonal_array = []
    right_diagonal_array = []
    self.game_matrix.each_with_index do |row, i|

      left_diagonal_array.push self.game_matrix[row][row]
      right_diagonal_array.push self.game_matrix[row][self.game_matrix.length - 1 - row]

    end

    is_left_match =  left_diagonal_array.uniq.count == 1
    return [left_diagonal_array, :left_diagonal] if is_left_match

    is_right_match =  right_diagonal_array.uniq.count == 1
    return [right_diagonal_array, :right_diagonal] if is_right_match

    return false
  end

  def assign_winner win_array
    win_pieces = win_array[0]
    win_type = win_array[1]

    win_pieces.each |piece| do { piece.assign_win win_type }

  end

end

class GameSquare < TicTacToe

  SQUARES = {
    nil: [
      ['', '', '', '', ''],
      ['', self.coordinates[0], '', self.coordinates[1], ''],
      ['', '', '', '', '']
    ]
    x: {
      place: [
        ['x', '', '', '', 'x'],
        ['', '', 'x', '', ''],
        ['x', '', '', '', 'x']
      ],
      win_horizontal: [
        ['x', '', '', '', 'x'],
        ['-', '-', '-', '-', '-'],
        ['x', '', '', '', 'x']
      ],
      win_vertical: [
        ['x', '', '|', '', 'x'],
        ['', '', '|', '', ''],
        ['x', '', '|', '', 'x']
      ],
      win_left_diagonal: [
        ['\\', '', '', '', 'x'],
        ['', '', '\\', '', ''],
        ['x', '', '', '', '\\']
      ],
      win_right_diagonal: [
        ['x', '', '', '', '/'],
        ['', '', '/', '', ''],
        ['/', '', '', '', 'x']
      ]
    }
    o:  {
      place: [
        ['', 'x', 'x', 'x', ''],
        ['x', '', '', '', 'x'],
        ['', 'x', 'x', 'x', '']
      ],
      horizontal: [
        ['', 'x', 'x', 'x', ''],
        ['-', '-', '-', '-', '-'],
        ['', 'x', 'x', 'x', '']
      ],
      vertical: [
        ['', 'x', '|', 'x', ''],
        ['x', '', '|', '', 'x'],
        ['', 'x', '|', 'x', '']
      ],
      left_diagonal: [
        ['\\', 'x', 'x', 'x', ''],
        ['x', '', '\\', '', 'x'],
        ['', 'x', 'x', 'x', '\\']
      ],
      right_diagonal: [
        ['', 'x', 'x', 'x', '/'],
        ['x', '', '/', '', 'x'],
        ['/', 'x', 'x', 'x', '']
      ]
    }
  }

  attr_reader :coordinates, :player, :square

  def initialize coordinates, player = nil
    err_prefix = "GameSquare.initialize ERROR"
    begin
      player_id = player.to_sym
      @square = SQUARES[player_id]
      @coordinates = coordinates
      @player = player

      raise BadPlayerError unless SQUARES.key? player_id
      raise BadPixelError unless is_correct_pixel

      self.square
    rescue BadPlayerError
      msg_bad_player_error = "choices are 'x', 'o' or 'nil' (for the game board)"
      puts TicTacToe.game_error err_prefix, msg_bad_player_error
    rescue BadPixelError
      msg_bad_pixel_error <<-STRING
        each entry in the square array represents one pixel, and must be
        exactly one character long
      STRING
      puts TicTacToe.game_error err_prefix, msg_bad_pixel_error
    end
  end

  def is_correct_pixel
    self.square.reduce true do |is_row_one_pixel, pixel_row|
      pixel_row.reduce is_row_one_pixel do |is_one_pixel, pixel|
        break false unless is_one_pixel
        is_one_pixel &&  pixel.length == 1
      end
    end
  end


  def assign_player player
    err_prefix = "GameSquare.assign_square ERROR"
    begin
      raise PlayerAssignError unless @player.nil?
      @player = player
      @square = SQUARES[player.to_sym][:place]
    rescue PlayerAssignError
      msg_player_assigned_error <<-STRING
        square #{coordinates} is already assigned to player #{player}
      STRING
      puts TicTacToe.game_error err_prefix, msg_player_assigned_error
    end
  end

  def assign_win win_type
    err_prefix = "GameSquare.assign_win ERROR"
    begin
      raise WinAssignError if @player.nil?
      @square = SQUARES[self.player.to_sym][win_type.to_sym]
    rescue WinAssignError
      msg_win_assigned_error <<-STRING
        square must be assigned a player before it can be assigned
        a win!
      STRING
      puts TicTacToe.game_error err_prefix, msg_win_assigned_error
    end

  def to_s
    puts self.player
  end

end

class Player < TicTacToe
  @@free_players = [:x, :o]
  @@chosen_players = []
  attr_reader :name, :player, :score

  def initialize name
    begin
    rescue NoFreePlayerError
      puts "ERROR: All players selected!"
    else
      raise NoFreePlayerError if @@free_players.empty?

      @name = name
      @player = self.class.choose_player
      @score = 0


      puts "Hello, #{self.name}, you will be '#{self.player}''s"
    end
  end

  def self.choose_player
    player_index = @@free_players.length > 1 ? Random.rand().round : 0
    choose_player = @@free_players.slice! player_index
    @@chosen_players.push choose_player
    choose_player
  end

  def self.get_free_players
    @@free_players
  end

  def self.get_chosen_players
    @@chosen_players
  end

  def add_score
    self.score += 1
  end

  def to_s
    puts self.player
  end

end

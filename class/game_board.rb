require_relative "tic_tac_toe"
require_relative "game_matrix"

class GameBoard < TicTacToe
  SQUARE_SIZE = [3, 5]
  DEFAULT_BOARD_SIZE = 3
  MAX_BOARD_SIZE = 7
  @@border = { top: "_", side: "|", bottom: "-", corner: "+"}


  attr_reader :board_size, :game_matrix, :game_board, :sq_rows, :sq_cols

  def game_error class_name, function_name, error_message
    super class_name, function_name, error_message
  end

  def return_user_input message, multi_entry, user_options
    super message, multi_entry, user_options
  end

  def parse_coordinates coordinates
    row_coord = coordinates[0]
    col_coord = coordinates[1]
    board_size = self.board_size
    max_row = (0..9).to_a[board_size - 1]
    max_col = ('a'..'z').to_a[board_size - 1]

    row = (0..9).to_a.find_index row_coord
    col = ('a'..'z').to_a.find_index col_coord

    is_valid_col = ('a'..max_col).to_a.include? col_coord
    is_valid_row = (1..max_row).to_a.include? row_coord

    [row, col] if is_valid_col && is_valid_row
    false
  end


  def initialize sq_rows = SQUARE_SIZE[0], sq_cols = SQUARE_SIZE[1]
    cls_name = "GameBoard"
    func_name = "initialize"
    begin
      msg_ask_game_size <<-STRING
        How big do you want the Tic Tac Toe Board to be?

        The default is 3, so 3 rows and 3 columns, and 3
        in a row wins

        You can go as high as 7:
      STRING
      board_size = self.return_user_input msg_ask_game_size, false
      is_size_int = board_size.to_i == board_size.to_i.to_s
      is_size_in_range = board_size.to_i.between?(DEFAULT_BOARD_SIZE, MAX_BOARD_SIZE)

      raise GameSizeError unless is_size_int && is_size_in_range


      @board_size = board_size
      @sq_rows = sq_rows
      @sq_cols = sq_cols

      @game_matrix = GameMatrix.new self.board_size

      populate_board
      populate_squares
    rescue GameSizeError
      err_message <<-STRING
        game size must be an integer between  #{DEFAULT_BOARD_SIZE} arrays with
        #{MAX_BOARD_SIZE}!
      STRING
      puts self.game_error cls_name, func_name, err_message
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
    matrix = self.game_matrix.game_matrix
    matrix.each_with_index do |row, i|
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



end

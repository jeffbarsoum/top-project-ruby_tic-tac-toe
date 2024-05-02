require_relative "tic_tac_toe"

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

  def display_board
    populate_squares
    self.game_board.reduce '' do |display, pixel_row|
      display += pixel_row.flatten + "\n"
      display
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

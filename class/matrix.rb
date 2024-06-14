require_relative "board"
require_relative "square"

class Matrix < Board
  include DataBoard

  attr_reader :board_size, :matrix, :coordinates


  def initialize fsm
    @board_size = self.load_board_size fsm
    self.populate_matrix self.board_size
  end

  def load_board_size fsm
    msg <<-STRING
    How big do you want the Tic Tac Toe Board to be?

      The default is 3, so 3 rows and 3 columns, and 3
      in a row wins

      You can go as high as 7:
    STRING
    input_state = fsm.input msg
    input_state.user_input
  end

  def populate_matrix board_size
    return self.matrix unless self.matrix.empty?
    board_size.times do |row|
      row_id = row + 1
      row_array = []
      board_size.times do |col|
        col_id = 'a'..'z'[col]
        coord = col_id + row_id.to_s
        @coordinates.push coord
        new_square = Square.new self.parse_coordinates coord
        row_array.push new_square
      end
      @matrix.push row_array
    end
  end

  def empty_matrix
    @matrix = []
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

    return { row: row, col: col, text: coordinates } if is_valid_col && is_valid_row
    false
  end

  def get_piece coordinates
    coord = self.parse_coordinates coordinates
    self.matrix[coord[:row]][coord[:col]]
  end

  def assign_piece player, coordinates
    return false unless self.coordinates.include? coordinates
    self.get_piece coordinates .assign_player player
    @coordinates.delete coordinates

    self.check_matrix player
  end

  def check_win piece_arr, player
    check_arr = piece_arr.map { |piece| piece.player }
    assigned_arr = [check_arr - nil]
    can_win? = assigned_arr.uniq.length == 1 && assigned_arr.first == player
    is_win? = can_win? && check_arr == assigned_arr
    return false unless can_win?
    return true if is_win?
    check_arr.length - assigned_arr.length
  end

  def check_matrix player
    board_data = {}
    for i in 0..self.board_size
      col_arr = []
      diag_left_arr = []
      diag_right_arr = []
      for j in 0..self.board_size
        col_arr.push self.matrix[j][i]
        diag_left_arr.push self.matrix[j][j]
        diag_right_arr.push self.matrix[j][self.board_size - 1 - j]
      end
      board_data[:row][i] = self.check_win self.matrix[i], player
      board_data[:col][i] = self.check_win col_arr, player
      board_data[:diagonal][:left] = self.check_win diag_left_arr, player
      board_data[:diagonal][:right] = self.check_win diag_right_arr, player
    end
    board_data.each do |type, hsh|
      hsh.each do |id, result|
        return { col_type: type, id: id } if result == true
      end
    end
    board_data
  end

end

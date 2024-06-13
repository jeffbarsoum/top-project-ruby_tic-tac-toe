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

    self.assign_winner
  end


  private

  def check_winner
    return self.check_column || self.check_row || self.check_diagonal
  end

  def assign_winner
    win_array = self.check_winner
    return false unless win_array

    win_pieces = win_array[0]
    win_type = win_array[1]

    win_pieces.each |piece| do { piece.assign_win win_type }

    win_array
  end

  def check_row
    self.matrix.each_with_index do |row, i|
      is_match =  row.uniq.count == 1
      return { squares: row[0], player: row[0][0].player, win_type: :horizontal } if is_match
    end
    return false
  end

  def check_column
    self.matrix.each_with_index do |row, i|
      col_array = []
      self.matrix.each_with_index do |col, i|
        col_array.push self.matrix[row][col]
      end
      is_match =  col_array.uniq.count == 1
      return { squares: col_array, player: col_array[0].player, win_type: :vertical } if is_match
    end
    return false
  end

  def check_diagonal
    left_diagonal_array = []
    right_diagonal_array = []

    self.matrix.each_with_index do |row, i|
      left_diagonal_array.push self.matrix[row][row]
      right_diagonal_array.push self.matrix[row][self.matrix.length - 1 - row]
    end

    is_left_match =  left_diagonal_array.uniq.count == 1
    return { squares: left_diagonal_array, player: left_diagonal_array[0].player, win_type: :left_diagonal } if is_left_match

    is_right_match =  right_diagonal_array.uniq.count == 1
    return { squares: right_diagonal_array, player: right_diagonal_array[0].player, win_type: :right_diagonal } if is_right_match

    return false
  end

end

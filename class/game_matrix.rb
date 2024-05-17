require_relative "game_board"
require_relative "game_square"

class GameMatrix < GameBoard

  attr_reader :game_matrix

  def game_error class_name, function_name, error_message
    super class_name, function_name, error_message
  end

  def parse_coordinates coordinates
    super coordinates
  end


  def initialize board_size
    self.populate_matrix board_size
  end

  def populate_matrix board_size
    cls_name = "GameMatrix"
    func_name = "populate_matrix"
    begin
      raise GameMatrixError unless self.game_matrix.empty?
      board_size.times do |row|
        row_id = row + 1
        row_array = []
        board_size.times do |col|
          col_id = 'a'..'z'[col]
          coord = col_id + row_id.to_s
          new_game_square = GameSquare.new coord

          row_array.push new_game_square
          self.game_matrix.push row_array
        end
      end
    rescue GameMatrixError
      msg_bad_player_error = "game matrix already has pieces in it!"
      puts self.game_error cls_name, func_name, msg_bad_player_error

    end
  end

  def empty_matrix
    @game_matrix = []
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

  def check_winner
    is_column_win = self.check_column
    return is_column_win if is_column_win

    is_row_win = self.check_row
    return is_row_win if is_row_win

    is_diagonal_win = self.check_diagonal
    return is_diagonal_win if is_diagonal_win

    false
  end

  def assign_piece player, coordinates
    coord = self.parse_coordinates coordinates
    self.game_matrix[coord[0]][coord[1]].player = player.to_sym
  end

  def assign_winner
    win_array = self.check_winner
    return false unless win_array

    win_pieces = win_array[0]
    win_type = win_array[1]

    win_pieces.each |piece| do { piece.assign_win win_type }
  end

end
require_relative "game_error"

module GameData
  attr_reader :squares

  include GameError


  def initialize
    @squares = {
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
  end

  # if player is nil, piece should be a string of coordinates
  # otherwise, it's a symbol representing the placement type
  def squares piece, player = nil
    cls_name = "GameData"
    func_name = "squares"
    begin
      return self.nil_square piece unless player

      raise GamePieceError unless self.squares.key? piece
      self.squares[piece]
    rescue GamePieceError
      msg_err = "piece must exist in squares hash!"
      puts GameError.game_error cls_name, func_name, msg_err
    end
  end

  def nil_square coordinates
    cls_name = "GameData"
    func_name = "nil_square"
    begin
      unless player
        row_coord = coordinates[0]
        col_coord = coordinates[1]

        is_valid_col = ('a'..'z').to_a.include? col_coord
        is_valid_row = (1..9).to_a.include? row_coord

        raise GamePieceError unless is_valid_col && is_valid_row

        [
          ['', '', '', '', ''],
          ['', col_coord '', row_coord ''],
          ['', '', '', '', '']
        ]
      end
    rescue GamePieceError
      msg_err = "coordinates must be an alphabetic character followed by an integer!"
      puts GameError.game_error cls_name, func_name, msg_err
    end
  end

end
